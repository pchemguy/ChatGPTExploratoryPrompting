Attribute VB_Name = "modAutoBookmarkAndLink"
'@Folder("Project")
Option Explicit

'---------------------------------------------------------------------------------------
' Module    : modAutoBookmarkAndLink
' Author    : Gemini
' Date      : 18/04/2025
' Version   : 2.7
' Purpose   : Deletes existing bookmarks and hyperlinks starting with AUTO_ and processes patterns
'             like {{Visible Text}}{{BMK:BookmarkName}} to create bookmarks (Pass 1), and
'             {{LinkText}}{{LNK:TargetName}} to create hyperlinks pointing to
'             AUTO_TargetName bookmarks (Pass 2). Validates formatting and names.
' Usage     : Optionally select text to process, otherwise runs on whole document.
'             Run the ProcessAutoMarkup macro.
' Notes     : - Requires references to "Microsoft Scripting Runtime" and
'               "Microsoft VBScript Regular Expressions 5.5" for early binding.
'             - Uses File Logging ({DocName}.log).
' Changes   : v1.1 - Declared missing loop counter variable 'i'.
'           : v1.2 - Declared missing variable 'displayCount'.
'                  - Moved constant 'MAX_ITEMS_IN_MSG' to module level.
'           : v1.3 - Re-added declaration for strMsg variable per user request.
'           : v1.4 - Fixed Error 9 caused by ReDim arrValidationFailures(0 To -1).
'                  - Switched from Debug.Print to File Logging. Added helper functions.
'           : v1.5 - Corrected wildcard pattern escaping in GetPattern_FindAdjacentBraces
'                    to fix Error 5560 (Invalid Find Pattern).
'           : v1.6 - Corrected wildcard pattern in GetPattern_FindAdjacentBraces to match
'                    exact double braces \{\{ and \}\} instead of single \{*\}.
'           : v1.7 - Modified wildcard pattern again to use capture groups \{\{(*)\}\}
'                    in attempt to resolve persistent Error 5560 in Word XP.
'           : v1.8 - Updated Find wildcard pattern to use [!}]\{1,\} for content matching
'                    as requested, for more precision than (*).
'           : v1.9 - Updated validation logic (Step 3) to check hidden status of
'                    braces vs. text within the first {{...}} part.
'           : v2.0 - Added logic to handle {{LinkText}}{{LNK:TargetName}} patterns
'                    to create hyperlinks alongside {{...}}{{BMK:...}} bookmark creation.
'                  - Refactored validation into helper functions.
'                  - Updated reporting. Renamed main sub.
'           : v2.1 - Added deletion of existing hyperlinks targeting AUTO_* bookmarks in Step 2.
'                  - Updated summary message to include hyperlink deletion count.
'           : v2.2 - Verified declarations for strMsg and rngP1VisibleText are present.
'           : v2.3 - Renamed local variable rngP1VisibleText to rngP1InnerText in
'                    ValidatePatternFormatting function for clarity.
'           : v2.4 - Implemented two-pass system: Create bookmarks (BMK) in Pass 1,
'                    store LNK data, create hyperlinks (LNK) in Pass 2.
'           : v2.5 - Changed definition of bookmark/hyperlink target range to use
'                    rngPart1.Duplicate + MoveStart/MoveEnd instead of calculated offsets.
'           : v2.6 - Reverted definition of bookmark/hyperlink target range back to
'                    using calculated offsets (Start + 2, End - 2) per user confirmation.
'           : v2.7 - Changed Pass 1 LNK storage to use temporary bookmarks instead of Start/End
'                    indices to handle potential document shifts before Pass 2.
'                  - Updated Pass 2 to find anchor via temp bookmark, create link, delete temp bookmark.
'                  - Added cleanup for TEMP_LNK_* bookmarks in Step 2.
'---------------------------------------------------------------------------------------
' References:
'   - Microsoft Word XX.X Object Library
'   - Microsoft VBScript Regular Expressions 5.5
'   - Microsoft Scripting Runtime
'---------------------------------------------------------------------------------------

'--- Constants ---
Private Const BOOKMARK_PREFIX As String = "AUTO_"
Private Const TEMP_LNK_ANCHOR_PREFIX As String = "TEMP_LNK_" ' Prefix for temporary bookmarks
Private Const HIDDEN_BMK_MARKER As String = "{{BMK:"
Private Const HIDDEN_LNK_MARKER As String = "{{LNK:"
Private Const MAX_NAME_LEN As Long = 35 ' Max length for bookmark/link target names
Private Const MAX_FIND_LOOPS As Long = 10000 ' Safety limit for Find loop
Private Const MAX_ITEMS_IN_MSG As Long = 10  ' Max validation failures listed in MsgBox

'--- Error Numbers ---
Private Const ERR_VALIDATION_FAILED As Long = vbObjectError + 3001 ' Custom base for this macro
Private Const ERR_BOOKMARK_EXISTS As Long = vbObjectError + 3002
Private Const ERR_INFINITE_LOOP As Long = vbObjectError + 3003
Private Const ERR_DOC_NOT_SAVED As Long = vbObjectError + 3004 ' For file logging
Private Const ERR_TARGET_BOOKMARK_MISSING As Long = vbObjectError + 3005


'--- Module Level Variables for Logging ---
Private m_LogFileNum As Integer
Private m_LogFilePath As String
Private m_LoggingEnabled As Boolean


'=======================================================================================
'   PATTERN GENERATING / VALIDATION FUNCTIONS
'=======================================================================================

Private Function GetPattern_FindAdjacentBraces() As String
' Returns the Wildcard pattern for Word's Find to locate two adjacent {{...}} blocks.
' Uses [!}]{1,} to match 1 or more non-} characters inside braces.
' Word Wildcard Pattern: \{\{[!}]{1,}\}\}\{\{[!}]]{1,}\}\}
    GetPattern_FindAdjacentBraces = "\{\{[!}]{1,}\}\}\{\{[!}]{1,}\}\}" ' More precise pattern
End Function
'---------------------------------------------------------------------------------------

Private Function GetPattern_ValidateName() As String
' Returns the RegExp pattern for validating the extracted bookmark/link target name.
' Allows alphanumeric and underscore, must start with a letter. Anchored.
    GetPattern_ValidateName = "^[a-zA-Z][a-zA-Z0-9_]*$"
End Function
'---------------------------------------------------------------------------------------

Private Function ValidatePatternFormatting(ByVal rngP1 As Word.Range, ByVal rngP2 As Word.Range, ByRef failureReason As String) As Boolean
'---------------------------------------------------------------------------------------
' Validates the Hidden/Visible formatting of the two parts.
' Part 1: Braces hidden, Text visible (not uniformly hidden).
' Part 2: Entirely hidden.
' Returns True if valid, False otherwise. Sets failureReason string.
'---------------------------------------------------------------------------------------
    Dim rngP1StartBraces As Word.Range
    Dim rngP1EndBraces As Word.Range
    Dim rngP1InnerText As Word.Range ' Renamed from rngP1VisibleText for clarity
    Dim isValid As Boolean
    isValid = False ' Assume invalid initially
    failureReason = ""

    On Error GoTo FormatValidation_Error

    ' Check lengths are sufficient for braces
    If rngP1 Is Nothing Or rngP1.Characters.Count < 4 Or rngP2 Is Nothing Or rngP2.Characters.Count < Len(HIDDEN_BMK_MARKER) + 2 Then ' Use BMK marker length as minimum
        failureReason = "Pattern parts too short to validate formatting."
        GoTo FormatValidation_Exit
    End If

    ' Define sub-ranges of Part 1
    Set rngP1StartBraces = rngP1.Document.Range(rngP1.Start, rngP1.Start + 2)
    Set rngP1EndBraces = rngP1.Document.Range(rngP1.End - 2, rngP1.End)
    Set rngP1InnerText = rngP1.Document.Range(rngP1.Start + 2, rngP1.End - 2)

    ' Perform checks
    If rngP1StartBraces.Font.Hidden <> True Then
        failureReason = "Opening braces {{ of first part are not hidden."
    ElseIf rngP1EndBraces.Font.Hidden <> True Then
        failureReason = "Closing braces }} of first part are not hidden."
    ElseIf rngP1InnerText.Font.Hidden = True Then ' Check if the text *inside* is hidden
        failureReason = "Text inside first part {{...}} is hidden."
    ElseIf rngP2.Font.Hidden <> True Then ' Check if Part 2 IS completely hidden
         failureReason = "Second part {{Marker:...}} is not hidden."
    Else
        isValid = True ' All checks passed
    End If

FormatValidation_Exit:
    ValidatePatternFormatting = isValid
    ' Clean up local ranges
    Set rngP1StartBraces = Nothing
    Set rngP1EndBraces = Nothing
    Set rngP1InnerText = Nothing
    Exit Function

FormatValidation_Error:
    failureReason = "Error during formatting validation: " & Err.Description
    Resume FormatValidation_Exit

End Function
'---------------------------------------------------------------------------------------

Private Function ValidateExtractedName(ByVal nameStr As String, ByVal regExpValidator As RegExp, ByRef failureReason As String) As Boolean
'---------------------------------------------------------------------------------------
' Validates the extracted bookmark or link target name based on rules.
' Returns True if valid, False otherwise. Sets failureReason string.
'---------------------------------------------------------------------------------------
    Dim isValid As Boolean
    isValid = False ' Assume invalid
    failureReason = ""

    If Len(nameStr) = 0 Then
        failureReason = "Bookmark/Link target name is empty."
    ElseIf Len(nameStr) > MAX_NAME_LEN Then
        failureReason = "Name '" & nameStr & "' exceeds max length (" & MAX_NAME_LEN & ")."
    ElseIf Not (nameStr Like "[a-zA-Z]*") Then
        failureReason = "Name '" & nameStr & "' does not start with a letter."
    ElseIf Not regExpValidator.Test(nameStr) Then
        failureReason = "Name '" & nameStr & "' contains invalid characters (only A-Z, a-z, 0-9, _ allowed)."
    Else
        isValid = True ' All checks passed
    End If
    ValidateExtractedName = isValid
End Function
'---------------------------------------------------------------------------------------


'=======================================================================================
'   MAIN PROCEDURE
'=======================================================================================

Public Sub ProcessAutoMarkup() ' Renamed Sub
'---------------------------------------------------------------------------------------
' Procedure : ProcessAutoMarkup
' Author    : Gemini
' Date      : 18/04/2025
' Purpose   : Main routine to delete old AUTO_ bookmarks/hyperlinks and create new ones
'             based on validated {{Visible}}{{BMK/LNK:HiddenName}} patterns.
'             Uses a two-pass approach: Bookmarks first, then Hyperlinks.
'---------------------------------------------------------------------------------------
    Dim doc As Word.Document
    Dim rngSearchScope As Word.Range    ' Range to search (Selection or Document)
    Dim searchRange As Word.Range       ' Range used for the Find loop iteration
    Dim foundRange As Word.Range        ' The specific range found by Find.Execute
    Dim rngPart1 As Word.Range          ' Range for the first {{...}} part (incl. braces)
    Dim rngPart2 As Word.Range          ' Range for the second {{...}} part (incl. braces)
    Dim targetRange As Word.Range       ' Range for the bookmark or hyperlink anchor (inner text of Part1)
    Dim bm As Word.Bookmark
    Dim hl As Word.Hyperlink            ' For hyperlink deletion/checking
    Dim regExpNameValidator As RegExp   ' RegExp for validating bookmark/link target name
    Dim arrValidationFailures() As String ' Array to store validation failure details
    Dim colLnkData As Collection        ' Collection to store data for Pass 2 (Hyperlinks)
    Dim lnkInfo As Variant              ' Array(TempAnchorName, TargetBookmarkName)
    Dim lngDeletedBmCount As Long
    Dim lngDeletedHlCount As Long
    Dim lngBmCreatedCount As Long
    Dim lngLinksCreated As Long
    Dim lngFailureCount As Long
    Dim strFoundText As String
    ' Dim strPart1Text As String        ' Not needed directly
    Dim strPart2Text As String
    Dim strExtractedName As String      ' Generic name extracted
    Dim strNewBookmarkName As String    ' For BMK type
    Dim strTargetBookmark As String     ' For LNK type target bookmark name
    Dim tempAnchorBookmarkName As String ' For LNK type temporary anchor bookmark
    Dim strFailureReason As String
    Dim strMsg As String
    Dim targetAddress As String         ' For reading hyperlink subaddress safely
    Dim markerType As String            ' "BMK" or "LNK"
    Dim splitPos As Long
    Dim loopCounter As Long             ' Safety counter for Find loop
    Dim i As Long                       ' Loop counter for deleting bookmarks/hyperlinks
    Dim k As Long                       ' Loop counter for message box
    Dim displayCount As Long
    Dim existingHl As Hyperlink         ' For checking existing hyperlinks
    Dim isValidFormat As Boolean
    Dim isValidName As Boolean
    ' Dim anchorStart As Long           ' No longer storing indices
    ' Dim anchorEnd As Long             ' No longer storing indices

    On Error GoTo ErrorHandler
    Application.ScreenUpdating = False
    Call SetupLogFile(ActiveDocument) ' Initialize file logging
    Call LogMessage(vbCrLf & "--- Starting ProcessAutoMarkup at " & Now & " ---")

    Set doc = ActiveDocument

    ' 1. Initialization & Scope Definition
    Call LogMessage("Step 1: Initialization and Scope Definition...")
    ' Determine Search Scope
    If Selection.Type = wdSelectionIP Or Selection.Type = wdNoSelection Then
        Set rngSearchScope = doc.Content
        Call LogMessage("  Search Scope: Entire Document")
    Else
        Set rngSearchScope = Selection.Range
        Call LogMessage("  Search Scope: Current Selection (Start: " & rngSearchScope.Start & ", End: " & rngSearchScope.End & ")")
    End If

    ' Initialize counters and collections/arrays
    lngDeletedBmCount = 0
    lngDeletedHlCount = 0
    lngBmCreatedCount = 0
    lngLinksCreated = 0
    lngFailureCount = 0
    Set colLnkData = New Collection
    ' arrValidationFailures is initialized implicitly when first ReDim'd

    ' 2. Delete Existing Items (Hyperlinks first, then Bookmarks)
    Call LogMessage("Step 2: Deleting existing '" & BOOKMARK_PREFIX & "*' and '" & TEMP_LNK_ANCHOR_PREFIX & "*' items...")

    ' Delete Hyperlinks targeting AUTO_ bookmarks
    Call LogMessage("  Deleting existing hyperlinks targeting '" & BOOKMARK_PREFIX & "*' bookmarks...")
    lngDeletedHlCount = 0
    For i = doc.Hyperlinks.Count To 1 Step -1
        Set hl = doc.Hyperlinks(i)
        targetAddress = "" ' Reset for safety
        On Error Resume Next ' Handle cases where SubAddress might be invalid or empty
        targetAddress = hl.SubAddress
        On Error GoTo ErrorHandler ' Restore error handling

        If targetAddress Like BOOKMARK_PREFIX & "*" Then
            Call LogMessage("  Deleting hyperlink from text '" & hl.Range.Text & "' targeting: " & targetAddress)
            hl.Delete ' Delete the hyperlink
            lngDeletedHlCount = lngDeletedHlCount + 1
        End If
    Next i
    Call LogMessage("  Deleted " & lngDeletedHlCount & " existing hyperlinks.")
    Set hl = Nothing

    ' Delete AUTO_ Bookmarks AND TEMP_LNK_ Bookmarks
    Call LogMessage("  Deleting existing '" & BOOKMARK_PREFIX & "*' and '" & TEMP_LNK_ANCHOR_PREFIX & "*' bookmarks...")
    lngDeletedBmCount = 0
    For i = doc.Bookmarks.Count To 1 Step -1
        Set bm = doc.Bookmarks(i)
        If bm.Name Like BOOKMARK_PREFIX & "*" Or bm.Name Like TEMP_LNK_ANCHOR_PREFIX & "*" Then
            Call LogMessage("  Deleting bookmark: " & bm.Name)
            bm.Delete
            lngDeletedBmCount = lngDeletedBmCount + 1
        End If
    Next i
    Call LogMessage("  Deleted " & lngDeletedBmCount & " existing bookmarks.")
    Set bm = Nothing

    ' 3. PASS 1: Find Patterns, Validate, Create Bookmarks, Store Link Data
    Call LogMessage("Step 3 (Pass 1): Finding patterns, validating, creating bookmarks...")
    Set regExpNameValidator = New RegExp
    With regExpNameValidator
        .Pattern = GetPattern_ValidateName() ' Use correct function name
        .Global = False
        .IgnoreCase = False
    End With

    Set searchRange = rngSearchScope.Duplicate ' Use a copy for searching

    With searchRange.Find
        .ClearFormatting
        .Text = GetPattern_FindAdjacentBraces() ' Use function for wildcard pattern
        .MatchWildcards = True
        .Forward = True
        .Wrap = wdFindStop
        .Format = False ' Do not find based on format

        Call LogMessage("  Attempting Find with pattern: '" & .Text & "' and MatchWildcards=" & .MatchWildcards)

        loopCounter = 0 ' Initialize loop counter
        Do While .Execute
            loopCounter = loopCounter + 1
            ' Call LogMessage("  Loop " & loopCounter & ": Find.Execute returned. Find.Found = " & searchRange.Find.Found & ". Current searchRange.Start = " & searchRange.Start) ' Optional detailed log

            ' Safety Check for Infinite Loop
            If loopCounter > MAX_FIND_LOOPS Then
                Err.Raise ERR_INFINITE_LOOP, "ProcessAutoMarkup (Find Loop - Pass 1)", _
                          "Processing stopped after exceeding maximum loop limit (" & MAX_FIND_LOOPS & "). Possible infinite loop detected."
            End If

            If .Found Then
                Set foundRange = searchRange.Duplicate ' Work with a copy of the found range
                strFoundText = foundRange.Text
                Call LogMessage("  Found potential pattern: '" & Left(strFoundText, 50) & "...' at Range(" & foundRange.Start & ", " & foundRange.End & ")")

                ' Reset failure reason for this match
                strFailureReason = ""
                markerType = "" ' Reset marker type
                isValidFormat = False
                isValidName = False

                ' Parse into two parts based on "}}{{"
                splitPos = InStr(1, strFoundText, "}}{{", vbBinaryCompare)

                If splitPos > 0 Then
                    ' Define ranges for each part, including the braces
                    On Error Resume Next ' Handle potential errors defining ranges
                    Set rngPart1 = doc.Range(foundRange.Start, foundRange.Start + splitPos + 1) ' Includes first "}}"
                    Set rngPart2 = doc.Range(rngPart1.End, foundRange.End) ' Starts after first "}}"
                    If Err.Number <> 0 Then
                        strFailureReason = "Error defining sub-ranges from found text. Err: " & Err.Description
                        Err.Clear
                    End If
                    On Error GoTo ErrorHandler ' Restore main handler

                    If strFailureReason = "" Then ' Proceed if ranges were defined
                        strPart2Text = rngPart2.Text

                        ' Check Marker Type and Basic Structure
                        If Left$(strPart2Text, Len(HIDDEN_BMK_MARKER)) = HIDDEN_BMK_MARKER Then
                            markerType = "BMK"
                        ElseIf Left$(strPart2Text, Len(HIDDEN_LNK_MARKER)) = HIDDEN_LNK_MARKER Then
                            markerType = "LNK"
                        Else
                            strFailureReason = "Second part does not start with '" & HIDDEN_BMK_MARKER & "' or '" & HIDDEN_LNK_MARKER & "'."
                        End If

                        If markerType <> "" And Right$(strPart2Text, 2) <> "}}" Then
                            strFailureReason = "Second part does not end with '}}'."
                        End If

                        ' Validate Formatting if structure seems ok so far
                        If strFailureReason = "" Then
                            isValidFormat = ValidatePatternFormatting(rngPart1, rngPart2, strFailureReason)
                            If isValidFormat Then
                                ' Formatting is valid, now extract and validate name
                                If markerType = "BMK" Then
                                     strExtractedName = Mid$(strPart2Text, Len(HIDDEN_BMK_MARKER) + 1, Len(strPart2Text) - Len(HIDDEN_BMK_MARKER) - 2)
                                Else ' markerType = "LNK"
                                     strExtractedName = Mid$(strPart2Text, Len(HIDDEN_LNK_MARKER) + 1, Len(strPart2Text) - Len(HIDDEN_LNK_MARKER) - 2)
                                End If
                                strExtractedName = Trim$(strExtractedName)

                                isValidName = ValidateExtractedName(strExtractedName, regExpNameValidator, strFailureReason)
                                If isValidName Then
                                    ' All Validations Passed! Proceed with action based on type
                                    Call LogMessage("    Validation passed for type '" & markerType & "', name '" & strExtractedName & "'")

                                    ' Define the target range (text inside first braces) using Start/End offsets
                                    Set targetRange = Nothing ' Reset before setting
                                    On Error Resume Next ' Handle potential errors defining range
                                    Set targetRange = doc.Range(rngPart1.Start + 2, rngPart1.End - 2)
                                    If Err.Number <> 0 Then
                                        strFailureReason = "Error defining target range using Start/End offsets. Err: " & Err.Description
                                        Err.Clear
                                    End If
                                    On Error GoTo ErrorHandler

                                    If Not targetRange Is Nothing Then
                                        If markerType = "BMK" Then
                                            ' --- Create Bookmark ---
                                            strNewBookmarkName = BOOKMARK_PREFIX & strExtractedName
                                            If doc.Bookmarks.Exists(strNewBookmarkName) Then
                                                strFailureReason = "Bookmark '" & strNewBookmarkName & "' already exists. Skipped."
                                                Call LogMessage("    " & strFailureReason)
                                            Else
                                                doc.Bookmarks.Add Name:=strNewBookmarkName, Range:=targetRange
                                                lngBmCreatedCount = lngBmCreatedCount + 1
                                                Call LogMessage("    Created bookmark: '" & strNewBookmarkName & "' around text: '" & targetRange.Text & "'")
                                            End If
                                        Else ' markerType = "LNK"
                                            ' --- Store Link Data for Pass 2 using Temp Bookmark ---
                                            strTargetBookmark = BOOKMARK_PREFIX & strExtractedName ' Target AUTO_ bookmark
                                            tempAnchorBookmarkName = TEMP_LNK_ANCHOR_PREFIX & loopCounter ' Unique temp name

                                            ' Add temporary bookmark to anchor range
                                            On Error Resume Next
                                            doc.Bookmarks.Add Name:=tempAnchorBookmarkName, Range:=targetRange
                                            If Err.Number <> 0 Then
                                                 strFailureReason = "Error creating temporary bookmark '" & tempAnchorBookmarkName & "'. Err: " & Err.Description
                                                 Call LogMessage("    " & strFailureReason)
                                                 Err.Clear
                                            Else
                                                 ' Store Temp Anchor Name, Target Bookmark Name
                                                 lnkInfo = Array(tempAnchorBookmarkName, strTargetBookmark)
                                                 colLnkData.Add lnkInfo
                                                 Call LogMessage("    Stored LNK data using temp bookmark '" & tempAnchorBookmarkName & "' for target '" & strTargetBookmark & "'")
                                            End If
                                            On Error GoTo ErrorHandler

                                        End If ' End BMK/LNK action block
                                    Else
                                         strFailureReason = "Failed to define target range for bookmark/link." ' Add failure reason if Start/End failed
                                    End If ' End If Not targetRange Is Nothing
                                End If ' End Name Validation check
                            End If ' End Formatting Validation check
                        End If ' End Structure Check (Marker Start/End)
                    End If ' End Range Definition Check
                Else
                    strFailureReason = "Could not parse found text into two {{...}}{{...}} parts based on '}}{{ separator."
                End If ' End If splitPos > 0

                ' Log failure if any occurred during validation or action (e.g., bookmark exists)
                If strFailureReason <> "" Then
                     Call LogMessage("    Processing FAILED/Skipped: " & strFailureReason)
                     lngFailureCount = lngFailureCount + 1
                     ' *** Conditionally ReDim failure array ***
                     If lngFailureCount = 1 Then
                         ReDim arrValidationFailures(0 To 0)
                     Else
                         On Error Resume Next ' Protect ReDim Preserve just in case
                         ReDim Preserve arrValidationFailures(0 To lngFailureCount - 1)
                         If Err.Number <> 0 Then Call LogMessage("ERROR: Failed ReDim Preserve on arrValidationFailures. Err: " & Err.Description): Err.Clear
                         On Error GoTo ErrorHandler ' Restore main error handling
                     End If
                     ' Assign if ReDim worked (check Err implicitly via On Error structure)
                     If Err.Number = 0 Then arrValidationFailures(lngFailureCount - 1) = strFailureReason & " (Found Text: '" & Left(strFoundText, 30) & "...' at " & foundRange.Start & ")"
                End If

                ' Advance Search Range
                searchRange.Collapse wdCollapseEnd
                ' Call LogMessage("  After processing/collapse, new searchRange.Start = " & searchRange.Start) ' Optional detailed log

            Else
                Exit Do ' Stop loop if Find.Found is False
            End If
        Loop ' While .Execute
    End With ' searchRange.Find

    Call LogMessage("Step 3 (Pass 1) finished.")
    Set regExpNameValidator = Nothing
    Set rngPart1 = Nothing ' Release ranges used in loop
    Set rngPart2 = Nothing
    Set foundRange = Nothing
    Set targetRange = Nothing

    ' 4. PASS 2: Create Hyperlinks from Stored Data
    Call LogMessage("Step 4 (Pass 2): Creating hyperlinks from stored LNK data...")
    If colLnkData.Count > 0 Then
        For Each lnkInfo In colLnkData
            tempAnchorBookmarkName = lnkInfo(0)
            strTargetBookmark = lnkInfo(1)
            strFailureReason = "" ' Reset for each link attempt
            Set targetRange = Nothing ' Reset target range

            ' Find the anchor range using the temporary bookmark
            If doc.Bookmarks.Exists(tempAnchorBookmarkName) Then
                Set targetRange = doc.Bookmarks(tempAnchorBookmarkName).Range

                ' Check if target bookmark exists (essential for hyperlink)
                If Not doc.Bookmarks.Exists(strTargetBookmark) Then
                    strFailureReason = "Target bookmark '" & strTargetBookmark & "' not found. Skipping hyperlink for temp anchor '" & tempAnchorBookmarkName & "'."
                    Call LogMessage("    " & strFailureReason)
                Else
                    ' Check if hyperlink already exists
                    Dim linkExists As Boolean
                    linkExists = False
                    For Each existingHl In targetRange.Hyperlinks
                        If existingHl.SubAddress = strTargetBookmark Then
                            linkExists = True
                            Exit For
                        End If
                    Next existingHl
                    Set existingHl = Nothing

                    If linkExists Then
                        strFailureReason = "Hyperlink to '" & strTargetBookmark & "' already exists for temp anchor '" & tempAnchorBookmarkName & "'. Skipped."
                        Call LogMessage("    " & strFailureReason)
                    Else
                        ' Add the hyperlink
                        On Error Resume Next ' Handle errors adding hyperlink
                        doc.Hyperlinks.Add Anchor:=targetRange, SubAddress:=strTargetBookmark
                        If Err.Number <> 0 Then
                             strFailureReason = "Error adding hyperlink for target '" & strTargetBookmark & "' using temp anchor '" & tempAnchorBookmarkName & "'. Err: " & Err.Description
                             Err.Clear
                        Else
                             lngLinksCreated = lngLinksCreated + 1
                             Call LogMessage("    Created hyperlink on '" & targetRange.Text & "' targeting '" & strTargetBookmark & "'")
                        End If
                        On Error GoTo ErrorHandler ' Restore main error handling
                    End If
                End If

                ' Delete the temporary bookmark whether link succeeded or failed
                On Error Resume Next
                doc.Bookmarks(tempAnchorBookmarkName).Delete
                If Err.Number <> 0 Then
                     Call LogMessage("    Warning: Failed to delete temporary bookmark '" & tempAnchorBookmarkName & "'. Err: " & Err.Description)
                     Err.Clear
                Else
                     Call LogMessage("    Deleted temporary bookmark '" & tempAnchorBookmarkName & "'.")
                End If
                On Error GoTo ErrorHandler

            Else
                 strFailureReason = "Temporary anchor bookmark '" & tempAnchorBookmarkName & "' not found. Cannot create hyperlink."
                 Call LogMessage("    " & strFailureReason)
            End If ' End If temp bookmark exists

            ' Log failure if any occurred during this link creation attempt
            If strFailureReason <> "" Then
                 Call LogMessage("    LNK Processing FAILED/Skipped: " & strFailureReason)
                 lngFailureCount = lngFailureCount + 1
                 ' *** Conditionally ReDim failure array ***
                 If lngFailureCount = 1 Then
                     ReDim arrValidationFailures(0 To 0)
                 Else
                     On Error Resume Next ' Protect ReDim Preserve just in case
                     ReDim Preserve arrValidationFailures(0 To lngFailureCount - 1)
                     If Err.Number <> 0 Then Call LogMessage("ERROR: Failed ReDim Preserve on arrValidationFailures. Err: " & Err.Description): Err.Clear
                     On Error GoTo ErrorHandler ' Restore main error handling
                 End If
                 ' Assign if ReDim worked (check Err implicitly via On Error structure)
                 If Err.Number = 0 Then arrValidationFailures(lngFailureCount - 1) = strFailureReason
            End If
            Set targetRange = Nothing ' Release range for this iteration
        Next lnkInfo
    Else
         Call LogMessage("  No valid LNK patterns found in Pass 1.")
    End If
    Call LogMessage("Step 4 (Pass 2) finished.")


    ' 5. Reporting & Cleanup
    Call LogMessage("Step 5: Reporting and Cleanup...")

CleanUp:
    On Error Resume Next ' Ensure final cleanup attempts don't raise new errors
    Application.ScreenUpdating = True
    ' Release objects
    Set doc = Nothing
    Set rngSearchScope = Nothing
    Set searchRange = Nothing
    Set foundRange = Nothing
    Set rngPart1 = Nothing
    Set rngPart2 = Nothing
    Set targetRange = Nothing
    Set bm = Nothing
    Set regExpNameValidator = Nothing
    Set existingHl = Nothing
    Set colLnkData = Nothing ' Release collection
    Call CloseLogFile ' Close log file if it was opened

    ' Display Summary Message ONLY if no error occurred (ErrorHandler jumps past this)
    If Err.Number = 0 Then
        strMsg = "Markup processing complete." & vbCrLf & vbCrLf & _
                 "Deleted Hyperlinks (targeting " & BOOKMARK_PREFIX & "*): " & lngDeletedHlCount & vbCrLf & _
                 "Deleted Bookmarks (" & BOOKMARK_PREFIX & "* / " & TEMP_LNK_ANCHOR_PREFIX & "*): " & lngDeletedBmCount & vbCrLf & _
                 "New Bookmarks Created: " & lngBmCreatedCount & vbCrLf & _
                 "New Hyperlinks Created: " & lngLinksCreated

        If lngFailureCount > 0 Then
            strMsg = strMsg & vbCrLf & vbCrLf & "Validation Failures/Skipped Items: " & lngFailureCount
            ' Limit displayed items
            displayCount = lngFailureCount
            If displayCount > MAX_ITEMS_IN_MSG Then displayCount = MAX_ITEMS_IN_MSG

            If IsArrayInitialized(arrValidationFailures) Then
                strMsg = strMsg & vbCrLf & "--- Details ---"
                 For k = 0 To displayCount - 1
                     If k <= UBound(arrValidationFailures) Then
                          strMsg = strMsg & vbCrLf & arrValidationFailures(k)
                     End If
                 Next k
                 If lngFailureCount > MAX_ITEMS_IN_MSG Then
                      strMsg = strMsg & vbCrLf & "... (" & lngFailureCount - MAX_ITEMS_IN_MSG & " more not shown)"
                 End If
            End If
            MsgBox strMsg, vbExclamation, "Processing Summary"
        Else
            MsgBox strMsg, vbInformation, "Processing Summary"
        End If
    End If ' End check Err.Number = 0

    Call LogMessage("--- Finished ProcessAutoMarkup at " & Now & " ---")
    On Error GoTo 0
    Exit Sub

    ' 6. Error Handling
ErrorHandler:
    Dim lngErrNum As Long: lngErrNum = Err.Number
    Dim strErrDesc As String: strErrDesc = Err.Description
    Call LogMessage("!!! MACRO ERROR: " & lngErrNum & " - " & strErrDesc & " !!!") ' Log error

    ' --- Attempt Cleanup within Error Handler ---
    On Error Resume Next ' Prevent error during cleanup hiding original error
    Application.ScreenUpdating = True
    ' Release objects
    Set doc = Nothing
    Set rngSearchScope = Nothing
    Set searchRange = Nothing
    Set foundRange = Nothing
    Set rngPart1 = Nothing
    Set rngPart2 = Nothing
    Set targetRange = Nothing
    Set bm = Nothing
    Set regExpNameValidator = Nothing
    Set existingHl = Nothing
    Set colLnkData = Nothing ' Release collection
    Call CloseLogFile ' Close log file if using file logging
    On Error GoTo 0 ' Restore default error handling
    ' --- End Cleanup Attempt ---

    ' Show the Error Message Box
    MsgBox "An unexpected error occurred:" & vbCrLf & vbCrLf & _
           "Error Number: " & lngErrNum & vbCrLf & _
           "Description: " & strErrDesc, vbCritical, "Macro Error"

    ' Exit Sub after showing the error message.
    Exit Sub

End Sub


'=======================================================================================
'   LOGGING HELPER FUNCTIONS (Required for file logging)
'=======================================================================================

Private Sub SetupLogFile(ByVal doc As Word.Document)
'---------------------------------------------------------------------------------------
' Procedure : SetupLogFile
' Purpose   : Initializes and opens the log file for writing. Overwrites existing file.
' Arguments : doc - The active Word document.
' Notes     : Requires document to be saved. Uses FileSystemObject.
'             Sets module-level variables m_LogFilePath and m_LogFileNum.
'             Modified to NOT Exit Sub on FSO/File Open errors.
'---------------------------------------------------------------------------------------
    Dim fso As Object ' FileSystemObject
    Dim docPath As String
    Dim baseName As String

    Debug.Print "SetupLogFile: Attempting to initialize logging..." ' Visible in Immediate Window

    m_LoggingEnabled = False ' Assume failure initially
    m_LogFileNum = 0
    m_LogFilePath = ""

    ' Check if document is saved
    docPath = ""
    On Error Resume Next ' Handle error if document properties not available
    docPath = doc.Path
    On Error GoTo 0
    If docPath = "" Then
        Err.Raise ERR_DOC_NOT_SAVED, "SetupLogFile", _
                  "Document must be saved before logging can be enabled."
        Exit Sub ' Exit if doc not saved - fundamental requirement
    End If
    Debug.Print "SetupLogFile: Document path found: " & docPath

    ' Create FileSystemObject
    Debug.Print "SetupLogFile: Attempting to create FileSystemObject..."
    On Error Resume Next ' Handle FSO creation error (e.g., scripting disabled)
    Set fso = CreateObject("Scripting.FileSystemObject")
    If Err.Number <> 0 Then
        Debug.Print "SetupLogFile: ERROR creating FileSystemObject - " & Err.Description
        MsgBox "Could not create FileSystemObject. Logging to file disabled." & vbCrLf & _
               "Ensure 'Microsoft Scripting Runtime' reference is enabled and scripting is allowed.", vbExclamation
        Set fso = Nothing
        On Error GoTo 0
        GoTo SetupExit ' *** MODIFIED v1.5: Don't Exit Sub, just skip logging setup ***
    End If
    On Error GoTo 0 ' Restore error handling
    Debug.Print "SetupLogFile: FileSystemObject created."

    ' Construct log file path
    baseName = fso.GetBaseName(doc.Name)
    m_LogFilePath = fso.BuildPath(docPath, baseName & ".log")
    Debug.Print "SetupLogFile: Log file path set to: " & m_LogFilePath

    ' Get a free file handle and open the file for output (overwrite)
    Debug.Print "SetupLogFile: Attempting to open log file..."
    On Error Resume Next ' Handle file access errors
    m_LogFileNum = FreeFile
    Open m_LogFilePath For Output As #m_LogFileNum
    If Err.Number <> 0 Then
        Debug.Print "SetupLogFile: ERROR opening log file - " & Err.Description
        m_LogFileNum = 0 ' Reset file number
        MsgBox "Could not open log file for writing:" & vbCrLf & m_LogFilePath & vbCrLf & _
               "Error: " & Err.Description & vbCrLf & _
               "Logging to file disabled.", vbExclamation
        m_LogFilePath = "" ' Clear path as it's unusable
        On Error GoTo 0
        GoTo SetupExit ' *** MODIFIED v1.5: Don't Exit Sub, just skip logging setup ***
    End If
    On Error GoTo 0 ' Restore error handling
    Debug.Print "SetupLogFile: Log file opened successfully (File #" & m_LogFileNum & ")."

    m_LoggingEnabled = True ' Logging is now active
    ' Write header
    Print #m_LogFileNum, "Log File for: " & doc.FullName
    Print #m_LogFileNum, "Macro Run Started: " & Format(Now, "yyyy-mm-dd hh:nn:ss")
    Print #m_LogFileNum, String(70, "-") ' Separator line

SetupExit: ' Label for GoTo statements above
    Set fso = Nothing
    Debug.Print "SetupLogFile: Exiting. LoggingEnabled = " & m_LoggingEnabled
End Sub
'---------------------------------------------------------------------------------------

Private Sub LogMessage(ByVal message As String)
'---------------------------------------------------------------------------------------
' Procedure : LogMessage
' Purpose   : Writes a message to the initialized log file, if enabled.
'             Falls back to Debug.Print if logging is not enabled.
' Arguments : message - The string message to log.
'---------------------------------------------------------------------------------------
    ' Only write if logging was successfully set up
    If m_LoggingEnabled And m_LogFileNum > 0 Then
        On Error Resume Next ' Avoid errors here stopping the macro
        Print #m_LogFileNum, Format(Now, "hh:nn:ss") & " - " & message
        If Err.Number <> 0 Then
            ' Optionally report write error? For now, just ignore.
            Debug.Print "LOGGING ERROR: Could not write to log file. Error: " & Err.Description ' Fallback
        End If
        On Error GoTo 0
    Else
        ' Fallback to immediate window if logging isn't active
        Debug.Print Format(Now, "hh:nn:ss") & " - (NoLogFile) " & message
    End If
End Sub
'---------------------------------------------------------------------------------------

Private Sub CloseLogFile()
'---------------------------------------------------------------------------------------
' Procedure : CloseLogFile
' Purpose   : Closes the log file if it was opened.
'---------------------------------------------------------------------------------------
    If m_LoggingEnabled And m_LogFileNum > 0 Then
        On Error Resume Next ' Avoid errors during close
        Print #m_LogFileNum, String(70, "-") ' Separator line
        Print #m_LogFileNum, "Log File Closed: " & Format(Now, "yyyy-mm-dd hh:nn:ss")
        Close #m_LogFileNum
        m_LogFileNum = 0 ' Reset file number
        m_LoggingEnabled = False ' Disable logging flag
        On Error GoTo 0
    End If
    ' Keep m_LogFilePath so it can be shown in the final message box
End Sub
'---------------------------------------------------------------------------------------


'=======================================================================================
'   HELPER FUNCTIONS
'=======================================================================================

Private Function IsArrayInitialized(arr As Variant) As Boolean
'---------------------------------------------------------------------------------------
' Function: IsArrayInitialized
' Purpose: Checks if a dynamic array has been dimensioned (ReDim'd).
' Returns: True if the array has been dimensioned, False otherwise.
'---------------------------------------------------------------------------------------
' Note: This is a simple check; more robust checks exist but this suffices here.
    On Error Resume Next
    IsArrayInitialized = IsArray(arr) ' Check if it's an array first
    If IsArrayInitialized Then
        IsArrayInitialized = (LBound(arr) <= UBound(arr))
    End If
    On Error GoTo 0
End Function
'---------------------------------------------------------------------------------------



