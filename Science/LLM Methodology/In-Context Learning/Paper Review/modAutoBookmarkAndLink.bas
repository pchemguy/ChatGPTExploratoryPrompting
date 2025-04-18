Attribute VB_Name = "modAutoBookmarkAndLink"
'@Folder("Project")
'@Folder("Project")
Option Explicit

' !!! IMPORTANT FOR EARLY BINDING !!!
' You MUST enable the reference: Tools > References... > Microsoft VBScript Regular Expressions 5.5
' before running this code.
'
' =========================================================================
' Main Macro: Finds patterns, removes hyperlinks/bookmarks, calls helper
' =========================================================================
Sub ProcessMarkup()

    ' Declare variables to store the original states
    Dim originalScreenUpdateState As Boolean
    Dim originalHiddenTextState As Boolean
    Dim activeDocWindow As Window ' Use Window object for view properties
    ' Note: findRange declaration moved closer to its first usage below

    ' --- Counters for Summary ---
    Dim bmkSuccessCount As Long
    Dim bmkFailureCount As Long
    Dim lnkSuccessCount As Long
    Dim lnkFailureCount As Long

    ' Initialize Counters
    bmkSuccessCount = 0
    bmkFailureCount = 0
    lnkSuccessCount = 0
    lnkFailureCount = 0


    ' --- Setup and State Storage ---

    ' Set up error handling to ensure cleanup always runs
    ' Note: User previously modified error handling. Review if needed.
    On Error GoTo CleanupErrorHandler ' Restored basic error jump for robustness

    ' Check if there is an active window to work with
    If Application.Windows.Count = 0 Then
        MsgBox "No active document window found. Cannot proceed.", vbExclamation
        Exit Sub ' Exit if no document is open/active
    End If
    Set activeDocWindow = ActiveWindow

    ' Store the current states
    originalScreenUpdateState = Application.ScreenUpdating
    originalHiddenTextState = activeDocWindow.View.ShowHiddenText
    Debug.Print "Original States - ScreenUpdating: " & originalScreenUpdateState & ", ShowHiddenText: " & originalHiddenTextState ' Optional: For debugging

    ' --- Apply Desired States ---
    Application.ScreenUpdating = False ' Turn off screen updates for speed
    activeDocWindow.View.ShowHiddenText = True ' Make hidden text visible
    Debug.Print "Applied States - ScreenUpdating: False, ShowHiddenText: True" ' Optional: For debugging

    ' >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ' >>>                                                         <<<
    ' >>>    MAIN CODE LOGIC STARTS HERE                          <<<
    ' >>>                                                         <<<
    ' >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    ' --- Declare Pattern Variables ---
    Const BMK_PATTERN As String = "\{\{[!}]{1,}\}\}\{\{BMK:[!}]{1,}\}\}"
    Const LNK_PATTERN As String = "\{\{[!}]{1,}\}\}\{\{LNK:[!}]{1,}\}\}"

    ' --- Declare Range variable here, just before first loop ---
    Dim findRange As Range

    ' --- Loop 1: Find LNK_PATTERN (Forward), remove Hyperlinks ---

    Set findRange = ActiveDocument.Content ' Set range for first loop
    findRange.Find.ClearFormatting         ' Clear settings
    findRange.Find.Replacement.ClearFormatting

    Dim hLink As Hyperlink ' Declare variable just before the loop
    With findRange.Find ' Configure Find for Hyperlinks
        .Text = LNK_PATTERN
        .MatchWildcards = True
        .Forward = True
        .Wrap = wdFindStop
        .Format = False
        .MatchCase = False
        .MatchWholeWord = False

        Do While .Execute = True ' Find LNK_PATTERN match
            For Each hLink In findRange.Hyperlinks
                hLink.Delete
            Next hLink
            findRange.Collapse wdCollapseEnd
        Loop
    End With
    Debug.Print "Finished Pass 1 (search for LNK_PATTERN, removing hyperlinks)."


    ' --- Loop 2: Find BMK_PATTERN (Forward), remove Bookmarks ---

    Set findRange = ActiveDocument.Content ' Reset range
    findRange.Find.ClearFormatting         ' Clear settings
    findRange.Find.Replacement.ClearFormatting

    Dim bmk As Bookmark
    With findRange.Find ' Configure Find for Bookmarks
        .Text = BMK_PATTERN
        .MatchWildcards = True
        .Forward = True
        .Wrap = wdFindStop
        .Format = False
        .MatchCase = False
        .MatchWholeWord = False

        Do While .Execute = True ' Find BMK_PATTERN match
            For Each bmk In findRange.Bookmarks
                bmk.Delete ' Delete the current bookmark
            Next bmk
            findRange.Collapse wdCollapseEnd
        Loop
    End With
    Debug.Print "Finished Pass 2 (search for BMK_PATTERN, removing bookmarks)."


    ' --- Loop 3: Find BMK_PATTERN (Forward), Call Helper Sub ---

    Set findRange = ActiveDocument.Content ' IMPORTANT: Reset range for third loop
    findRange.Find.ClearFormatting         ' Clear settings
    findRange.Find.Replacement.ClearFormatting

    ' Configure Find for BMK_PATTERN again, this time for processing
    With findRange.Find
        .Text = BMK_PATTERN       ' Use the bookmark pattern
        .MatchWildcards = True    ' Enable pattern matching
        .Forward = True
        .Wrap = wdFindStop
        .Format = False
        .MatchCase = False
        .MatchWholeWord = False

        ' Execute Find repeatedly
        Do While .Execute = True
            ' Match found, findRange covers the text matching BMK_PATTERN.
            ' Call the helper subroutine, passing the found range and counters.
            ProcessBMK findRange, bmkSuccessCount, bmkFailureCount ' Pass counters
            findRange.Collapse wdCollapseEnd
        Loop ' Continue searching for BMK_PATTERN
    End With ' End of With findRange.Find for processing Bookmarks

    Debug.Print "Finished Pass 3 (search for BMK_PATTERN, calling ProcessBMK)."


    ' --- Loop 4: Find LNK_PATTERN (Forward), Call ProcessLNK to create Hyperlinks ---
    Set findRange = ActiveDocument.Content ' IMPORTANT: Reset range for fourth loop
    findRange.Find.ClearFormatting         ' Clear settings
    findRange.Find.Replacement.ClearFormatting

    ' Configure Find for LNK_PATTERN again, this time for creating hyperlinks
    With findRange.Find
        .Text = LNK_PATTERN       ' Use the link pattern
        .MatchWildcards = True    ' Enable pattern matching
        .Forward = True
        .Wrap = wdFindStop
        .Format = False
        .MatchCase = False
        .MatchWholeWord = False

        ' Execute Find repeatedly
        Do While .Execute = True
            ' Match found, findRange covers the text matching LNK_PATTERN.
            ' Call the helper subroutine to potentially create a hyperlink.
            ProcessLNK findRange, lnkSuccessCount, lnkFailureCount ' Pass counters
            findRange.Collapse wdCollapseEnd
        Loop ' Continue searching for LNK_PATTERN
    End With ' End of With findRange.Find for processing Links
    Debug.Print "Finished Pass 4 (search for LNK_PATTERN, calling ProcessLNK)."

    ' --- End of Main Logic ---

    ' --- Show Summary Message ---
    Dim summaryMsg As String
    summaryMsg = "Processing Complete." & vbCrLf & vbCrLf & _
                 "Bookmarks Created: " & bmkSuccessCount & vbCrLf & _
                 "Hyperlinks Created: " & lnkSuccessCount & vbCrLf & vbCrLf

    If bmkFailureCount > 0 Or lnkFailureCount > 0 Then
        summaryMsg = summaryMsg & "WARNING: Failures occurred!" & vbCrLf
        If bmkFailureCount > 0 Then
             summaryMsg = summaryMsg & "- Bookmark creation failures: " & bmkFailureCount & vbCrLf
        End If
        If lnkFailureCount > 0 Then
             summaryMsg = summaryMsg & "- Hyperlink creation failures: " & lnkFailureCount & vbCrLf
        End If
        summaryMsg = summaryMsg & vbCrLf & "(Check Immediate Window for details if Debug.Print is enabled)"
        MsgBox summaryMsg, vbExclamation, "Processing Summary with Failures"
    Else
        summaryMsg = summaryMsg & "No creation failures reported."
        MsgBox summaryMsg, vbInformation, "Processing Summary"
    End If

    GoTo Cleanup ' Added GoTo to skip error handler if execution was successful

CleanupErrorHandler:
    ' This section is reached if an error occurs during the main logic
    MsgBox "An error occurred during macro execution:" & vbCrLf & vbCrLf & _
           "Error Number: " & Err.Number & vbCrLf & _
           "Description: " & Err.Description & vbCrLf & vbCrLf & _
           "Attempting to restore original settings...", vbCritical, "Macro Error"
    ' Fall through to Cleanup after showing error message

Cleanup:
    ' --- Restore Original States ---
    ' This code runs either after successful execution OR after an error
    On Error Resume Next ' Prevent errors during cleanup from stopping restoration

    If Not activeDocWindow Is Nothing Then
        activeDocWindow.View.ShowHiddenText = originalHiddenTextState
    End If
    Application.ScreenUpdating = originalScreenUpdateState

    Debug.Print "Restored States - ScreenUpdating: " & Application.ScreenUpdating & ", ShowHiddenText: " & activeDocWindow.View.ShowHiddenText ' Optional: For debugging

    ' Clean up object variables
    Set findRange = Nothing
    Set activeDocWindow = Nothing
    Set hLink = Nothing ' Ensure cleanup
    Set bmk = Nothing   ' Ensure cleanup

    On Error GoTo 0 ' Reset error handling to default
    ' Removed Exit Sub from here, allows falling through from error handler

End Sub ' End of ProcessMarkup


' =========================================================================
' Helper Subroutine to process ranges found by the third loop
' Extracts potential bookmark name from range text, validates it,
' and adds bookmark if valid. Updates counters.
' =========================================================================
Sub ProcessBMK(matchedRange As Range, ByRef successCount As Long, ByRef failureCount As Long) ' Added counters
    ' This sub receives the Range object that matched the BMK_PATTERN in Loop 3.

    Dim rawText As String
    Dim strippedText As String
    Dim potentialName As String
    Dim isValid As Boolean
    Dim regex As RegExp ' Use specific type for Early Binding
    Dim delimiterPos As Long ' To store position of delimiter
    Const DELIMITER As String = "}}{{BMK:" ' Define delimiter as constant

    ' Basic error handling within helper
    On Error GoTo ProcessBMK_Error

    ' --- 1. Get Text from the matched range ---
    rawText = matchedRange.Text
    Debug.Print "ProcessBMK received raw text: '" & rawText & "'"

    ' --- 2. Strip last two characters ---
    strippedText = Left$(rawText, Len(rawText) - 2) ' Assumes Len >= 2 based on pattern

    ' --- 3. Extract potential name ---
    potentialName = "" ' Initialize potential name
    delimiterPos = InStr(1, strippedText, DELIMITER, vbBinaryCompare)
    potentialName = Trim$(Mid$(strippedText, delimiterPos + Len(DELIMITER)))
    Debug.Print "  -> Potential Name after find/mid/trim: '" & potentialName & "'"

    ' --- 5. Validation Checks ---
    isValid = True
    If Len(potentialName) = 0 Then isValid = False
    If isValid And Len(potentialName) > 40 Then isValid = False

    ' Check structure using Regular Expression
    If isValid Then
        Set regex = New RegExp
        With regex
            .Pattern = "^[A-Za-z][A-Za-z0-9_]*$"
            .Global = False
            .IgnoreCase = False
        End With
        If Not regex.Test(potentialName) Then isValid = False
    End If
    If Not isValid Then Debug.Print "  -> Validation Failed for potential bookmark name: '" & potentialName & "'"

    ' --- 7. Create Bookmark if all checks passed ---
    If isValid Then
        Debug.Print "  -> Validation Passed for name: '" & potentialName & "'"
        On Error Resume Next ' Need this to check if Delete fails (bmk doesn't exist)
        ActiveDocument.Bookmarks(potentialName).Delete ' Attempt to delete existing
        On Error GoTo ProcessBMK_Error ' Restore proper error handling

        ' Add the new bookmark
        ActiveDocument.Bookmarks.Add Name:=potentialName, Range:=matchedRange
        If Err.Number = 0 Then ' Check if Add method succeeded
             Debug.Print "  -> Successfully added bookmark: '" & potentialName & "'"
             successCount = successCount + 1 ' Increment success counter
        Else
             Debug.Print "  -> FAILED to add bookmark: '" & potentialName & "'. Error: " & Err.Description
             failureCount = failureCount + 1 ' Increment failure counter
             Err.Clear ' Clear error after handling
        End If
    Else
         Debug.Print "  -> Skipping bookmark creation due to validation failure."
         ' Do not count validation failures as creation failures
    End If

ProcessBMK_Exit:
    On Error GoTo 0 ' Reset error handling
    Set regex = Nothing ' Ensure regex object is cleaned up on exit
    Exit Sub ' Normal exit

ProcessBMK_Error:
    ' Basic error reporting
    Debug.Print "  -> An error occurred in ProcessBMK! Error: " & Err.Number & " - " & Err.Description & " (Name: '" & potentialName & "')"
    failureCount = failureCount + 1 ' Count errors during processing as failures
    Resume ProcessBMK_Exit ' Go to cleanup/exit point

End Sub ' End of ProcessBMK
' =========================================================================


' =========================================================================
' Helper Subroutine to process ranges found by Loop 4 (LNK_PATTERN)
' Extracts potential bookmark name from range text, validates it,
' checks if bookmark exists, and adds hyperlink if valid and exists. Updates counters.
' =========================================================================
Sub ProcessLNK(matchedRange As Range, ByRef successCount As Long, ByRef failureCount As Long) ' Added counters
    ' This sub receives the Range object that matched the LNK_PATTERN in Loop 4.

    Dim rawText As String
    Dim strippedText As String
    Dim potentialBookmarkName As String ' Name of the target bookmark
    Dim isNameValid As Boolean
    Dim bookmarkExists As Boolean
    Dim regex As RegExp ' Use specific type for Early Binding
    Dim delimiterPos As Long
    Const DELIMITER As String = "}}{{LNK:"

    ' Basic error handling within helper
    On Error GoTo ProcessLNK_Error

    ' --- 1. Get Text from the matched range ---
    rawText = matchedRange.Text
    Debug.Print "ProcessLNK received raw text: '" & rawText & "'"

    ' --- 2. Strip last two characters ---
    strippedText = Left$(rawText, Len(rawText) - 2) ' Assumes Len >= 2 based on pattern

    ' --- 3. Find delimiter and extract potential bookmark name ---
    potentialBookmarkName = "" ' Initialize
    delimiterPos = InStr(1, strippedText, DELIMITER, vbBinaryCompare)
    potentialBookmarkName = Trim$(Mid$(strippedText, delimiterPos + Len(DELIMITER)))
    Debug.Print "  -> Potential Target Bookmark Name: '" & potentialBookmarkName & "'"

    ' --- 4. Validation Checks (same rules as bookmark names) ---
    isNameValid = True
    If Len(potentialBookmarkName) = 0 Then isNameValid = False
    If isNameValid And Len(potentialBookmarkName) > 40 Then isNameValid = False

    ' Check structure using Regular Expression
    If isNameValid Then
        Set regex = New RegExp
        With regex
            .Pattern = "^[A-Za-z][A-Za-z0-9_]*$"
            .Global = False
            .IgnoreCase = False
        End With
        If Not regex.Test(potentialBookmarkName) Then isNameValid = False
    End If
    If Not isNameValid Then Debug.Print "  -> Validation Failed for potential bookmark name: '" & potentialBookmarkName & "'"


    ' --- 5. Check if target bookmark exists ---
    bookmarkExists = False ' Assume not found
    If isNameValid Then
        If ActiveDocument.Bookmarks.Exists(potentialBookmarkName) Then
            bookmarkExists = True
            Debug.Print "  -> Target bookmark '" & potentialBookmarkName & "' exists."
        Else
            Debug.Print "  -> Target bookmark '" & potentialBookmarkName & "' does NOT exist. Cannot create hyperlink."
        End If
    End If

    ' --- 6. Create Hyperlink if name valid AND bookmark exists ---
    If isNameValid And bookmarkExists Then
        Debug.Print "  -> Validation Passed & Bookmark Exists. Creating hyperlink for: '" & potentialBookmarkName & "'"
        On Error Resume Next ' Handle potential errors during hyperlink creation
        ActiveDocument.Hyperlinks.Add Anchor:=matchedRange, Address:="", SubAddress:=potentialBookmarkName
        If Err.Number = 0 Then
            Debug.Print "  -> Successfully added hyperlink to bookmark: '" & potentialBookmarkName & "'"
            successCount = successCount + 1 ' Increment success counter
        Else
            Debug.Print "  -> FAILED to add hyperlink to bookmark: '" & potentialBookmarkName & "'. Error: " & Err.Description
            failureCount = failureCount + 1 ' Increment failure counter
            Err.Clear ' Clear error after handling
        End If
        On Error GoTo ProcessLNK_Error ' Restore default error handling for this sub
    Else
        Debug.Print "  -> Skipping hyperlink creation."
         ' Do not count validation/existence failures as creation failures
    End If

ProcessLNK_Exit:
    On Error GoTo 0
    Set regex = Nothing ' Cleanup regex object
    Exit Sub
ProcessLNK_Error:
    Debug.Print "  -> An error occurred in ProcessLNK! Error: " & Err.Number & " - " & Err.Description & " (Name: '" & potentialBookmarkName & "')"
    failureCount = failureCount + 1 ' Count errors during processing as failures
    Resume ProcessLNK_Exit
End Sub ' End of ProcessLNK
' =========================================================================



