Attribute VB_Name = "modAutoBookmark"
'@Folder("Project")
Option Explicit

'---------------------------------------------------------------------------------------
' Module    : modAutoBookmark
' Author    : Gemini
' Date      : 18/04/2025
' Version   : 1.9
' Purpose   : Deletes existing bookmarks starting with AUTO_ and creates new ones
'             based on {{Visible Text}}{{BMK:BookmarkName}} patterns found in the
'             document or selection, where the first {{ & }} are hidden, the text
'             between them is visible, and the second part is entirely hidden.
' Usage     : Optionally select text to process, otherwise runs on whole document.
'             Run the CreateAutoBookmarks macro.
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
'---------------------------------------------------------------------------------------
' References:
'   - Microsoft Word XX.X Object Library
'   - Microsoft VBScript Regular Expressions 5.5
'   - Microsoft Scripting Runtime
'---------------------------------------------------------------------------------------

'--- Constants ---
Private Const BOOKMARK_PREFIX As String = "AUTO_"
Private Const HIDDEN_PART_MARKER As String = "{{BMK:"
Private Const MAX_BOOKMARK_NAME_LEN As Long = 35
Private Const MAX_FIND_LOOPS As Long = 10000 ' Safety limit for Find loop
Private Const MAX_ITEMS_IN_MSG As Long = 10  ' Max validation failures listed in MsgBox

'--- Error Numbers ---
Private Const ERR_VALIDATION_FAILED As Long = vbObjectError + 3001 ' Custom base for this macro
Private Const ERR_BOOKMARK_EXISTS As Long = vbObjectError + 3002
Private Const ERR_INFINITE_LOOP As Long = vbObjectError + 3003
Private Const ERR_DOC_NOT_SAVED As Long = vbObjectError + 3004 ' For file logging


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

Private Function GetPattern_ValidateBookmarkName() As String
' Returns the RegExp pattern for validating the extracted bookmark name.
' Allows alphanumeric and underscore, must start with a letter. Anchored.
    GetPattern_ValidateBookmarkName = "^[a-zA-Z][a-zA-Z0-9_]*$"
End Function
'---------------------------------------------------------------------------------------


'=======================================================================================
'   MAIN PROCEDURE
'=======================================================================================

Public Sub CreateAutoBookmarks()
'---------------------------------------------------------------------------------------
' Procedure : CreateAutoBookmarks
' Author    : Gemini
' Date      : 18/04/2025
' Purpose   : Main routine to delete old AUTO_ bookmarks and create new ones
'             based on validated {{Visible}}{{BMK:HiddenName}} patterns.
'---------------------------------------------------------------------------------------
    Dim doc As Word.Document
    Dim rngSearchScope As Word.Range    ' Range to search (Selection or Document)
    Dim searchRange As Word.Range       ' Range used for the Find loop iteration
    Dim foundRange As Word.Range        ' The specific range found by Find.Execute
    Dim rngPart1 As Word.Range          ' Range for the first {{...}} part (incl. braces)
    Dim rngPart2 As Word.Range          ' Range for the second {{...}} part (incl. braces)
    Dim rngPart1StartBraces As Word.Range ' Range for first {{
    Dim rngPart1EndBraces As Word.Range   ' Range for first }}
    Dim rngPart1VisibleText As Word.Range ' Range for text inside first {{...}}
    Dim bookmarkTargetRange As Word.Range ' Range for the actual bookmark (inner text of Part1)
    Dim bm As Word.Bookmark
    Dim regExpNameValidator As RegExp   ' RegExp for validating bookmark name
    Dim arrValidationFailures() As String ' Array to store validation failure details
    Dim lngDeletedCount As Long
    Dim lngCreatedCount As Long
    Dim lngFailureCount As Long
    Dim strFoundText As String
    ' Dim strPart1Text As String ' Text property not needed directly
    Dim strPart2Text As String
    Dim strBookmarkName As String
    Dim strFullBookmarkName As String
    Dim strFailureReason As String
    Dim strMsg As String                ' Declaration for summary message string
    Dim splitPos As Long
    Dim loopCounter As Long             ' Safety counter for Find loop
    Dim i As Long                       ' Loop counter for deleting bookmarks
    Dim k As Long                       ' Loop counter for message box
    Dim displayCount As Long            ' Loop counter/limit for message box

    On Error GoTo ErrorHandler
    Application.ScreenUpdating = False
    Call SetupLogFile(ActiveDocument) ' Initialize file logging
    Call LogMessage(vbCrLf & "--- Starting CreateAutoBookmarks at " & Now & " ---")

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

    ' Initialize counters and failure array
    lngDeletedCount = 0
    lngCreatedCount = 0
    lngFailureCount = 0
    ' ** Removed ReDim arrValidationFailures(0 To -1) to fix Error 9 **

    ' 2. Delete Existing Bookmarks
    Call LogMessage("Step 2: Deleting existing '" & BOOKMARK_PREFIX & "*' bookmarks...")
    For i = doc.Bookmarks.Count To 1 Step -1
        Set bm = doc.Bookmarks(i)
        If bm.Name Like BOOKMARK_PREFIX & "*" Then
            Call LogMessage("  Deleting bookmark: " & bm.Name)
            bm.Delete
            lngDeletedCount = lngDeletedCount + 1
        End If
    Next i
    Call LogMessage("  Deleted " & lngDeletedCount & " existing bookmarks.")
    Set bm = Nothing

    ' 3. Find Patterns & Validate (Iterative Find)
    Call LogMessage("Step 3: Finding and validating patterns...")
    Set regExpNameValidator = New RegExp
    With regExpNameValidator
        .Pattern = GetPattern_ValidateBookmarkName()
        .Global = False ' Only need to test the whole name string once
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
                Err.Raise ERR_INFINITE_LOOP, "CreateAutoBookmarks (Find Loop)", _
                          "Processing stopped after exceeding maximum loop limit (" & MAX_FIND_LOOPS & "). Possible infinite loop detected."
            End If

            If .Found Then
                Set foundRange = searchRange.Duplicate ' Work with a copy of the found range
                strFoundText = foundRange.Text
                Call LogMessage("  Found potential pattern: '" & Left(strFoundText, 50) & "...' at Range(" & foundRange.Start & ", " & foundRange.End & ")")

                ' Reset failure reason for this match
                strFailureReason = ""

                ' Parse into two parts based on "}}{{"
                splitPos = InStr(1, strFoundText, "}}{{", vbBinaryCompare) ' Use binary compare for exact match

                If splitPos > 0 Then
                    ' Define ranges for each part, including the braces
                    On Error Resume Next ' Handle potential errors defining ranges
                    Set rngPart1 = doc.Range(foundRange.Start, foundRange.Start + splitPos + 1) ' Includes first "}}"
                    Set rngPart2 = doc.Range(rngPart1.End, foundRange.End) ' Starts after first "}}"
                    If Err.Number <> 0 Then
                        strFailureReason = "Error defining sub-ranges from found text. Err: " & Err.Description
                        Err.Clear
                    Else
                        ' Define sub-ranges for validation if Part1/Part2 were set
                        Set rngPart1StartBraces = doc.Range(rngPart1.Start, rngPart1.Start + 2)
                        Set rngPart1EndBraces = doc.Range(rngPart1.End - 2, rngPart1.End)
                        Set rngPart1VisibleText = doc.Range(rngPart1.Start + 2, rngPart1.End - 2)
                        If Err.Number <> 0 Then ' Check if defining sub-sub-ranges failed
                           strFailureReason = "Error defining sub-ranges within Part 1. Err: " & Err.Description
                           Err.Clear
                        End If
                    End If
                    On Error GoTo ErrorHandler ' Restore main handler

                    If strFailureReason = "" Then ' Proceed if ranges were defined
                        ' strPart1Text = rngPart1.Text ' Not needed directly
                        strPart2Text = rngPart2.Text

                        ' Validate Formatting & Structure (Updated Logic)
                        If rngPart1StartBraces.Font.Hidden <> True Then
                            strFailureReason = "Opening braces {{ of first part are not hidden."
                        ElseIf rngPart1EndBraces.Font.Hidden <> True Then
                            strFailureReason = "Closing braces }} of first part are not hidden."
                        ElseIf rngPart1VisibleText.Font.Hidden = True Then ' Check if the text *inside* is hidden
                            strFailureReason = "Text inside first part {{...}} is hidden."
                        ElseIf rngPart2.Font.Hidden <> True Then ' Check if Part 2 IS completely hidden
                             strFailureReason = "Second part {{BMK:...}} is not hidden."
                        ' Check if Part 2 starts correctly
                        ElseIf Left$(strPart2Text, Len(HIDDEN_PART_MARKER)) <> HIDDEN_PART_MARKER Then
                             strFailureReason = "Second part does not start with '" & HIDDEN_PART_MARKER & "'."
                        ' Check if Part 2 ends correctly
                        ElseIf Right$(strPart2Text, 2) <> "}}" Then
                             strFailureReason = "Second part does not end with '}}'."
                        End If

                        If strFailureReason = "" Then
                            ' Extract and Validate Bookmark Name
                            strBookmarkName = Mid$(strPart2Text, Len(HIDDEN_PART_MARKER) + 1, Len(strPart2Text) - Len(HIDDEN_PART_MARKER) - 2)
                            strBookmarkName = Trim$(strBookmarkName)

                            If Len(strBookmarkName) = 0 Then
                                strFailureReason = "Bookmark name inside {{BMK:...}} is empty."
                            ElseIf Len(strBookmarkName) > MAX_BOOKMARK_NAME_LEN Then
                                strFailureReason = "Bookmark name '" & strBookmarkName & "' exceeds max length (" & MAX_BOOKMARK_NAME_LEN & ")."
                            ElseIf Not (strBookmarkName Like "[a-zA-Z]*") Then
                                strFailureReason = "Bookmark name '" & strBookmarkName & "' does not start with a letter."
                            ElseIf Not regExpNameValidator.Test(strBookmarkName) Then
                                strFailureReason = "Bookmark name '" & strBookmarkName & "' contains invalid characters (only A-Z, a-z, 0-9, _ allowed)."
                            End If

                            If strFailureReason = "" Then
                                ' 4. Create New Bookmark (All Validations Passed)
                                strFullBookmarkName = BOOKMARK_PREFIX & strBookmarkName
                                Call LogMessage("    Validation passed for: " & strFullBookmarkName)

                                If doc.Bookmarks.Exists(strFullBookmarkName) Then
                                    strFailureReason = "Bookmark '" & strFullBookmarkName & "' already exists. Skipped."
                                    Call LogMessage("    " & strFailureReason)
                                    ' Log this as a failure/skip for the report
                                    lngFailureCount = lngFailureCount + 1
                                    ' *** Conditionally ReDim failure array ***
                                    If lngFailureCount = 1 Then ReDim arrValidationFailures(0 To 0) Else ReDim Preserve arrValidationFailures(0 To lngFailureCount - 1)
                                    If Err.Number = 0 Then arrValidationFailures(lngFailureCount - 1) = strFailureReason & " (Found Text: '" & Left(strFoundText, 30) & "...')" Else Err.Clear ' Handle potential ReDim error
                                Else
                                    ' Define the specific range for the bookmark (text inside first braces)
                                    Set bookmarkTargetRange = rngPart1VisibleText ' Use the already defined range
                                    doc.Bookmarks.Add Name:=strFullBookmarkName, Range:=bookmarkTargetRange
                                    lngCreatedCount = lngCreatedCount + 1
                                    Call LogMessage("    Created bookmark: '" & strFullBookmarkName & "' around text: '" & bookmarkTargetRange.Text & "'")
                                End If
                            End If ' End Bookmark Name Validation Check
                        End If ' End Formatting & Structure Validation Check
                    End If ' End Range Definition Check
                Else
                    strFailureReason = "Could not parse found text into two {{...}}{{...}} parts based on '}}{{ separator."
                End If ' End If splitPos > 0

                ' Log failure if any occurred during validation
                If strFailureReason <> "" Then
                     Call LogMessage("    Validation FAILED: " & strFailureReason)
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

    Call LogMessage("Step 3 finished.")
    Set regExpNameValidator = Nothing

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
    Set rngPart1StartBraces = Nothing ' Release new ranges
    Set rngPart1EndBraces = Nothing
    Set rngPart1VisibleText = Nothing
    Set bookmarkTargetRange = Nothing
    Set bm = Nothing
    Set regExpNameValidator = Nothing
    Call CloseLogFile ' Close log file if it was opened

    ' Display Summary Message ONLY if no error occurred (ErrorHandler jumps past this)
    If Err.Number = 0 Then
        strMsg = "Bookmark processing complete." & vbCrLf & vbCrLf & _
                 "Deleted Bookmarks (" & BOOKMARK_PREFIX & "*): " & lngDeletedCount & vbCrLf & _
                 "New Bookmarks Created: " & lngCreatedCount

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

    Call LogMessage("--- Finished CreateAutoBookmarks at " & Now & " ---")
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
    Set rngPart1StartBraces = Nothing ' Release new ranges
    Set rngPart1EndBraces = Nothing
    Set rngPart1VisibleText = Nothing
    Set bookmarkTargetRange = Nothing
    Set bm = Nothing
    Set regExpNameValidator = Nothing
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



