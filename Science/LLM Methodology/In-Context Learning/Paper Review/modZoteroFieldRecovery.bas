Attribute VB_Name = "modZoteroFieldRecovery"
Option Explicit

'---------------------------------------------------------------------------------------
' Module    : modZoteroFieldRecovery
' Author    : Gemini
' Date      : 16/04/2025
' Version   : 2.3
' Purpose   : Recovers Zotero citation fields (wdFieldAddin) in a selected block of text.
'             It maps existing Zotero citation field results in the document to the
'             original field objects. Then, it finds textual representations of citations
'             (e.g., "[1]", "[2-5]", "[9-14]") within the user's selection and replaces
'             them with the corresponding original Zotero field based on the map.
' Usage     : Select the block of text containing the textual citations first, then run
'             the RecoverZoteroFields macro.
' Notes     : - Handles hyphens (-) and en dashes in citation ranges (using ChrW(8211) internally).
'             - Requires the document to be saved before running.
'             - Assumes Zotero field codes start with "ADDIN ZOTERO_ITEM CSL_CITATION".
'             - Assumes Zotero field results match the pattern ^\[\d+([-,{en dash}\s]+\d+)*\]$.
' Changes   : v1.1 - Replaced literal en dash characters in comments with standard hyphens
'                    or descriptions for non-Unicode editor compatibility.
'           : v1.2 - Removed dependency on Excel Object Library functions (WorksheetFunction.Index,
'                    Evaluate) for building the final summary message. Replaced with VBA loop.
'           : v1.3 - Corrected Selection.Type check to use valid constants (wdSelectionIP,
'                    wdNoSelection) and correct logic, based on WdSelectionType documentation.
'                  - Added debug logging for Range.Find execution in Step 3 (commented out).
'           : v1.4 - Enabled file logging and uncommented debug logs for Range.Find in Step 3.
'           : v1.5 - Modified SetupLogFile to prevent Exit Sub on FSO/File Open errors,
'                    allowing main routine to continue (logging falls back to Debug.Print).
'                  - Added Debug.Print statements within SetupLogFile for tracing.
'           : v1.6 - Corrected ErrorHandler logic to ensure error message box is shown
'                    instead of resuming normal cleanup flow on error.
'           : v1.7 - Added missing Logging Helper Function definitions (SetupLogFile, etc.).
'           : v1.8 - Added granular logging in Step 3 setup to isolate Error 9 source.
'           : v1.9 - Fixed Error 9 by removing initial ReDim arrUnmatched(0 To -1).
'                  - Array is now dimensioned only when first unmatched item is found.
'                  - Removed granular Step 3 setup logging.
'           : v2.0 - Added loop counter and range position logging to Step 3 Find loop
'                    to diagnose potential infinite loop / hang.
'           : v2.1 - Changed Find loop advancement: Set searchRange.Start = newField.Result.End
'                    after successful replacement, instead of just Collapse.
'           : v2.2 - Changed replacement logic in Step 3 to use Select/Copy/Paste
'                    instead of Fields.Add, as requested. Adjusted loop advancement.
'           : v2.3 - Removed invalid check using wdSelectionRange when storing initial selection state.
'---------------------------------------------------------------------------------------
' References: Required for Early Binding (recommended)
'   - Microsoft Word XX.X Object Library
'   - Microsoft VBScript Regular Expressions 5.5
'   - Microsoft Scripting Runtime
'---------------------------------------------------------------------------------------

'--- Constants ---
Private Const ZOTERO_FIELD_MARKER As String = "ADDIN ZOTERO_ITEM CSL_CITATION"
Private Const MAX_FIND_LOOPS As Long = 10000 ' Safety limit for Find loop

'--- Error Numbers ---
Private Const ERR_NO_SELECTION As Long = vbObjectError + 2001
Private Const ERR_MAP_EMPTY As Long = vbObjectError + 2002
Private Const ERR_DOC_NOT_SAVED As Long = vbObjectError + 2003 ' Inherited from logging setup if used
Private Const ERR_INFINITE_LOOP As Long = vbObjectError + 2004 ' Custom error for loop limit
Private Const ERR_COPY_PASTE_FAIL As Long = vbObjectError + 2005 ' Custom error for copy/paste failure

'--- Module Level Variables for Logging ---
Private m_LogFileNum As Integer
Private m_LogFilePath As String
Private m_LoggingEnabled As Boolean


'=======================================================================================
'   PATTERN GENERATING FUNCTIONS
'=======================================================================================

Private Function GetValidationPattern() As String
' Returns the RegExp pattern for validating the Zotero field result text.
' Pattern: ^\[\d+([-,{en dash}\s]+\d+)*\]$
' Handles digits, comma, hyphen, en dash, space within brackets. Anchored start/end.
' Uses ChrW(8211) for en dash for code compatibility.
    GetValidationPattern = "^\[\d+([-," & ChrW(8211) & "\s]+\d+)*\]$"
End Function
'---------------------------------------------------------------------------------------

Private Function GetCitationFindPattern() As String
' Returns the Wildcard pattern for Word's Find to locate citations in the selection.
' Pattern: \[[0-9,-{en dash}]@\]
' Handles digits, comma, hyphen, en dash within brackets. Uses '@' for one or more.
' Uses ChrW(8211) for en dash for code compatibility.
    GetCitationFindPattern = "\[[0-9,-" & ChrW(8211) & "]@\]"
End Function
'---------------------------------------------------------------------------------------

' NOTE: GetComponentPattern function is not needed for this implementation
' as we replace the whole matched citation text based on the dictionary lookup.


'=======================================================================================
'   MAIN PROCEDURE
'=======================================================================================

Public Sub RecoverZoteroFields()
'---------------------------------------------------------------------------------------
' Procedure : RecoverZoteroFields
' Author    : Gemini
' Date      : 16/04/2025
' Purpose   : Finds textual citations in the user's selection and replaces them
'             with original Zotero field codes mapped from the active document using Copy/Paste.
'---------------------------------------------------------------------------------------
    Dim doc As Word.Document
    Dim rngInitialSelection As Word.Range ' User's initial selection
    Dim searchRange As Word.Range       ' Range used for finding citations within initial selection
    Dim fld As Word.Field
    Dim originalField As Word.Field
    ' Dim newField As Word.Field ' No longer needed for Fields.Add
    Dim dictCitationMap As Object ' Late binding for Dictionary
    Dim regExpValidator As Object ' Late binding for RegExp
    Dim arrUnmatched() As String                ' Array to store unmatched citation texts - DO NOT ReDim here
    Dim lngUnmatchedCount As Long
    Dim strResultText As String
    Dim strMatchedText As String
    ' Dim strOriginalCode As String ' No longer needed for Fields.Add
    Dim strMsg As String
    Dim k As Long ' Loop counter for message box
    Dim loopCounter As Long ' Safety counter for Find loop
    Dim currentSelection As Word.Range ' To store selection state before macro changes it

    On Error GoTo ErrorHandler ' Enable error handling for the entire sub

    ' Store current selection state before doing anything else
    ' Handles IP, Range, etc. Gracefully handles wdNoSelection via error trapping.
    Set currentSelection = Nothing ' Initialize
    On Error Resume Next
    Set currentSelection = Selection.Range
    On Error GoTo ErrorHandler ' Restore main handler

    Application.ScreenUpdating = False
    Call SetupLogFile(ActiveDocument) ' Attempt to setup logging

    Set doc = ActiveDocument

    ' 1. Initialization & Pre-checks
    Call LogMessage("Step 1: Initialization and Pre-checks...")
    ' Check if selection type is suitable for processing (must be a range)
    If Selection.Type = wdSelectionIP Or Selection.Type = wdNoSelection Then
        Err.Raise ERR_NO_SELECTION, "RecoverZoteroFields", _
                  "No text range selected. Please select the revised text block containing textual citations first."
    End If
    ' Selection type is okay, store the range for processing
    Set rngInitialSelection = Selection.Range
    Call LogMessage("Selected range starts at: " & rngInitialSelection.Start & ", Ends at: " & rngInitialSelection.End)

    ' 2. Build Original Citation Map
    Call LogMessage("Step 2: Building original citation map...")
    On Error Resume Next ' Temporarily disable error handling for object creation
    Set dictCitationMap = CreateObject("Scripting.Dictionary")
    Set regExpValidator = CreateObject("VBScript.RegExp")
    If Err.Number <> 0 Then
        Call LogMessage("ERROR: Failed to create Dictionary or RegExp object. Check References/Scripting Runtime.") ' Log attempt
        Err.Clear
        On Error GoTo 0 ' Re-enable default error handling
        MsgBox "Could not create required Scripting or RegExp object." & vbCrLf & _
               "Please ensure 'Microsoft Scripting Runtime' and 'Microsoft VBScript Regular Expressions 5.5' are available and enabled.", vbCritical, "Object Creation Error"
        GoTo CleanUp ' Exit gracefully if objects can't be created
    End If
    On Error GoTo ErrorHandler ' Restore main error handler

    With regExpValidator
        .Pattern = GetValidationPattern() ' Use function for pattern
        .Global = False
        .IgnoreCase = False
    End With

    For Each fld In doc.Fields
        If fld.Type = wdFieldAddin Then
            If InStr(1, Trim(fld.Code.Text), ZOTERO_FIELD_MARKER, vbTextCompare) > 0 Then
                On Error Resume Next ' Handle fields that might error on .Result access
                strResultText = Trim(fld.Result.Text)
                If Err.Number = 0 Then ' Check if reading .Result was successful
                    If regExpValidator.Test(strResultText) Then
                        If Not dictCitationMap.Exists(strResultText) Then
                            dictCitationMap.Add Key:=strResultText, Item:=fld
                            Call LogMessage("Mapped: '" & strResultText & "' -> Field Index " & fld.Index)
                        Else
                            Call LogMessage("Duplicate result text found, ignored: '" & strResultText & "'")
                        End If
                    Else
                        Call LogMessage("Field result format invalid, ignored: '" & strResultText & "'")
                    End If
                Else
                    Call LogMessage("Warning: Could not read result for field index " & fld.Index & ". Error: " & Err.Description)
                    Err.Clear
                End If
                On Error GoTo ErrorHandler ' Restore default error handling
            End If
        End If
    Next fld
    Set regExpValidator = Nothing ' Release validator

    If dictCitationMap.Count = 0 Then
        Err.Raise ERR_MAP_EMPTY, "RecoverZoteroFields", _
                  "No valid Zotero citation fields matching the expected format '[#...]' were found in the document body. Cannot proceed."
    End If
    Call LogMessage("Built map with " & dictCitationMap.Count & " unique citation field results.")

    ' 3. Find and Replace Textual Citations in Selection (Iterative Find using Copy/Paste)
    Call LogMessage("Step 3: Finding and replacing textual citations in selection using Copy/Paste...")
    lngUnmatchedCount = 0
    ' ** Removed initial ReDim arrUnmatched(0 To -1) **

    Set searchRange = rngInitialSelection.Duplicate ' Search within the original selection boundaries
    Call LogMessage("  Initial search range: " & searchRange.Start & " - " & searchRange.End)

    Call LogMessage("  Setting up Find object...")
    With searchRange.Find
        Call LogMessage("    Setting Find properties...")
        .ClearFormatting
        .Text = GetCitationFindPattern() ' Use function for wildcard pattern
        .MatchWildcards = True
        .Forward = True
        .Wrap = wdFindStop ' IMPORTANT: Stop search at end of selection range
        .Format = False
        .MatchCase = False
        .MatchWholeWord = False
        .MatchSoundsLike = False
        .MatchAllWordForms = False
        Call LogMessage("    ...Find properties set.")

        Call LogMessage("Attempting Find with pattern: '" & .Text & "' and MatchWildcards=" & .MatchWildcards)

        loopCounter = 0 ' Initialize loop counter
        Do While .Execute
             loopCounter = loopCounter + 1 ' Increment counter
             Call LogMessage("  Loop " & loopCounter & ": Find.Execute returned. Find.Found = " & searchRange.Find.Found & ". Current searchRange.Start = " & searchRange.Start)

             ' *** Safety Check for Infinite Loop ***
             If loopCounter > MAX_FIND_LOOPS Then
                 Err.Raise ERR_INFINITE_LOOP, "RecoverZoteroFields (Find Loop)", _
                           "Processing stopped after exceeding maximum loop limit (" & MAX_FIND_LOOPS & "). Possible infinite loop detected."
             End If

            If .Found Then ' Use .Found check directly on the Find object
                ' Log the found range BEFORE modifying it
                Call LogMessage("  Found potential citation: '" & searchRange.Text & "' at Range(" & searchRange.Start & ", " & searchRange.End & ")")
                strMatchedText = searchRange.Text ' Store before range potentially changes

                If dictCitationMap.Exists(strMatchedText) Then
                    ' Found a match in our map - replace text with original field using Copy/Paste
                    Set originalField = dictCitationMap(strMatchedText)

                    ' *** Start Copy/Paste - wrap in error handling ***
                    On Error Resume Next
                    originalField.Select ' Select the source field
                    If Err.Number <> 0 Then Call LogMessage("ERROR: Failed to Select original field. Error: " & Err.Description): GoTo CopyPasteError

                    Selection.Copy ' Copy the selected field
                    If Err.Number <> 0 Then Call LogMessage("ERROR: Failed to Copy selection. Error: " & Err.Description): GoTo CopyPasteError

                    searchRange.Select ' Select the target textual citation range
                    If Err.Number <> 0 Then Call LogMessage("ERROR: Failed to Select target range. Error: " & Err.Description): GoTo CopyPasteError

                    Selection.Paste ' Paste the field, replacing the text
                    If Err.Number <> 0 Then Call LogMessage("ERROR: Failed to Paste selection. Error: " & Err.Description): GoTo CopyPasteError

                    ' If successful:
                    Call LogMessage("Replaced '" & strMatchedText & "' using Copy/Paste.")
                    ' *** Advance searchRange Start explicitly past the pasted content ***
                    ' Selection object now represents the pasted field
                    searchRange.Start = Selection.End
                    On Error GoTo ErrorHandler ' Restore main error handling
                    GoTo ContinueLoop ' Skip normal collapse, proceed to next loop iteration

CopyPasteError:
                    ' Handle copy/paste error
                    Call LogMessage("ERROR: Failed during Select/Copy/Paste sequence for '" & strMatchedText & "'. Last Error: " & Err.Description)
                    Err.Clear
                    ' Attempt to collapse range to move past the failed item
                    searchRange.Collapse wdCollapseEnd
                    On Error GoTo ErrorHandler ' Restore main error handling
                    ' *** End Copy/Paste ***

                    Set originalField = Nothing

                Else
                    ' Text found by Find doesn't match any key in our map
                    Call LogMessage("Text '" & strMatchedText & "' not found in citation map.")
                    lngUnmatchedCount = lngUnmatchedCount + 1

                    ' Conditionally ReDim array
                    If lngUnmatchedCount = 1 Then
                        ReDim arrUnmatched(0 To 0) ' First item, initial ReDim
                        arrUnmatched(0) = strMatchedText
                    Else
                        On Error Resume Next ' Protect ReDim Preserve just in case
                        ReDim Preserve arrUnmatched(0 To lngUnmatchedCount - 1) ' Subsequent items
                        If Err.Number = 0 Then
                            arrUnmatched(lngUnmatchedCount - 1) = strMatchedText
                        Else
                            Call LogMessage("ERROR: Failed ReDim Preserve on arrUnmatched. Count: " & lngUnmatchedCount & " Error: " & Err.Description)
                            Err.Clear ' Clear ReDim error
                        End If
                        On Error GoTo ErrorHandler ' Restore main error handling
                    End If

                    ' Collapse range to continue search after this unmatched text
                    searchRange.Collapse wdCollapseEnd
                End If

ContinueLoop: ' Label to jump to after successful copy/paste or normal collapse
                Call LogMessage("  After processing/collapse, new searchRange.Start = " & searchRange.Start) ' Log position after collapse/set start

            Else
                Exit Do ' Stop loop if Find.Found is False
            End If
        Loop ' While .Execute
    End With ' searchRange.Find

    ' 4. Reporting & Cleanup
    Call LogMessage("Step 4: Reporting and Cleanup...")
    ' Optional Field Update Step:
    ' If MsgBox("Do you want to update all fields in the document now? (May take time)", vbQuestion + vbYesNo) = vbYes Then
    '    Call LogMessage("Updating all document fields...")
    '    doc.Fields.Update
    '    Call LogMessage("Field update complete.")
    ' End If

CleanUp:
    ' This label is for normal exit OR jump from ErrorHandler AFTER logging/displaying error
    On Error Resume Next ' Ensure final cleanup attempts don't raise new errors
    Application.ScreenUpdating = True
    ' Restore original selection if possible
    If Not currentSelection Is Nothing Then
        currentSelection.Select
    End If
    ' Release objects
    Set dictCitationMap = Nothing
    Set regExpValidator = Nothing ' Should already be Nothing
    Set rngInitialSelection = Nothing
    Set searchRange = Nothing
    Set fld = Nothing
    Set originalField = Nothing
    ' Set newField = Nothing ' Not used
    Set currentSelection = Nothing
    Call CloseLogFile ' Close log file if it was opened

    ' Display Summary Message ONLY if no error occurred (ErrorHandler jumps past this)
    If Err.Number = 0 Then ' Check if we arrived here without an error being active
        If lngUnmatchedCount = 0 Then
            MsgBox "Citation recovery complete. All found textual citations matching original field results were replaced with Zotero fields." & vbCrLf & vbCrLf & _
                   "(Note: Fields may need to be updated manually or via Zotero's 'Refresh' command to show correct numbering/formatting.)", vbInformation, "Recovery Complete"
        Else
            strMsg = "Citation recovery complete, but " & lngUnmatchedCount & " textual citation(s) could not be matched to original Zotero fields:" & vbCrLf & vbCrLf
            ' Limit displayed unmatched items in message box
            Const MAX_ITEMS_IN_MSG As Long = 15
            Dim displayCount As Long
            displayCount = lngUnmatchedCount
            If displayCount > MAX_ITEMS_IN_MSG Then displayCount = MAX_ITEMS_IN_MSG

            ' Build message string using VBA loop
            If IsArrayInitialized(arrUnmatched) Then ' Check if array was ever dimensioned
                For k = 0 To displayCount - 1
                    If k <= UBound(arrUnmatched) Then ' Check array bounds
                         strMsg = strMsg & arrUnmatched(k)
                         If k < displayCount - 1 Then ' Add newline except for the last item shown
                             strMsg = strMsg & vbCrLf
                         End If
                    End If
                Next k
            Else
                strMsg = strMsg & "(Error retrieving list of unmatched items)" ' Handle case where array is still empty despite count > 0
            End If


            If lngUnmatchedCount > MAX_ITEMS_IN_MSG Then
                 strMsg = strMsg & vbCrLf & "... (" & lngUnmatchedCount - MAX_ITEMS_IN_MSG & " more not shown)"
            End If
            strMsg = strMsg & vbCrLf & vbCrLf & "Please review these manually." & vbCrLf & vbCrLf & _
                     "(Note: Fields may need to be updated manually or via Zotero's 'Refresh' command.)"
            MsgBox strMsg, vbExclamation, "Recovery Partially Complete"
        End If
    End If ' End check Err.Number = 0

    On Error GoTo 0 ' Prevent fall-through to ErrorHandler on normal exit
    Exit Sub

    ' 5. Error Handling
ErrorHandler:
    Dim lngErrNum As Long: lngErrNum = Err.Number
    Dim strErrDesc As String: strErrDesc = Err.Description
    Call LogMessage("!!! MACRO ERROR: " & lngErrNum & " - " & strErrDesc & " !!!") ' Log the error

    ' --- Attempt Cleanup within Error Handler ---
    On Error Resume Next ' Prevent error during cleanup hiding original error
    Application.ScreenUpdating = True
     ' Restore original selection if possible
    If Not currentSelection Is Nothing Then
        currentSelection.Select
    End If
   ' Release objects
    Set dictCitationMap = Nothing
    Set regExpValidator = Nothing
    Set rngInitialSelection = Nothing
    Set searchRange = Nothing
    Set fld = Nothing
    Set originalField = Nothing
    ' Set newField = Nothing ' Not used
    Set currentSelection = Nothing
    Call CloseLogFile ' Close log file if it was opened
    On Error GoTo 0 ' Restore default error handling
    ' --- End Cleanup Attempt ---

    ' *** Show the Error Message Box ***
    MsgBox "An unexpected error occurred:" & vbCrLf & vbCrLf & _
           "Error Number: " & lngErrNum & vbCrLf & _
           "Description: " & strErrDesc, vbCritical, "Macro Error"

    ' Exit Sub after showing the error message.
    Exit Sub

End Sub


'=======================================================================================
'   LOGGING HELPER FUNCTIONS (Required if logging enabled)
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
'   HELPER FUNCTIONS (Validation/Orphan check not needed for this task)
'=======================================================================================

Private Function IsArrayInitialized(arr As Variant) As Boolean
'---------------------------------------------------------------------------------------
' Function: IsArrayInitialized
' Purpose: Checks if a dynamic array has been dimensioned (ReDim'd).
' Returns: True if the array has been dimensioned, False otherwise.
'---------------------------------------------------------------------------------------
    On Error Resume Next
    IsArrayInitialized = (LBound(arr) <= UBound(arr))
    On Error GoTo 0
End Function
'---------------------------------------------------------------------------------------

' Note: GetAllReferencedCitationNumbers and FindOrphanCitations are not required
' for this specific recovery task as defined in the prompt. They were part of
' the previous macro's validation step.



