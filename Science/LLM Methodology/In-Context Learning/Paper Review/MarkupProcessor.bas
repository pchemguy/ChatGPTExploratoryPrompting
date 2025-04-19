Attribute VB_Name = "MarkupProcessor"
'@Folder("Project")
Option Explicit

' ==========================================================================
' Module:      MarkupProcessor
' Author:      [Your Name/Placeholder]
' Date:        2025-04-19
' Purpose:     Processes special plain-text markup in the ActiveDocument
'              to create/update Word Bookmarks and internal Hyperlinks.
'              Handles {{Displayed Text}}{{BMK: #BookmarkName}} and
'              {{Displayed Text}}{{LNK: #BookmarkName}} formats.
' References:  Requires 'Microsoft Scripting Runtime' (for logging)
'              Requires 'Microsoft VBScript Regular Expressions 5.5' (for validation/extraction)
' Version:     1.5 (Fixed duplicate MsgBox and Error 54 on exit/error)
' Host App:    Microsoft Word 2002 (XP) / VBA 6
' ==========================================================================

' --- Constants ---
Private Const MODULE_NAME As String = "MarkupProcessor"
Private Const LOG_FILE_EXT As String = ".log"
Private Const DEBUG_MODE As Boolean = True ' Set to False to disable detailed logging

' Markup Patterns for Word Find (Raw strings, backslashes are literal)
Private Const BMK_FIND_PATTERN As String = "\{\{[!}]@\}\}\{\{BMK: #[A-Za-z][A-Za-z0-9_]@\}\}"
Private Const LNK_FIND_PATTERN As String = "\{\{[!}]@\}\}\{\{LNK: #[A-Za-z][A-Za-z0-9_]@\}\}"
Private Const ABC_FIND_PATTERN As String = "\{\{[!}]@\}\}\{\{[A-Z]{3}:[!}]@\}\}" ' General pattern for cleanup

' RegExp Patterns for VBScript RegExp object (Validation and Extraction)
Private Const BMK_NAME_VALIDATION_PATTERN As String = "^[A-Za-z][A-Za-z0-9_]*$"
Private Const BMK_MAX_LEN As Long = 40
Private Const BMK_EXTRACT_PATTERN As String = "^\{\{([^}]+)\}\}\{\{BMK: #([A-Za-z][A-Za-z0-9_]{0,39})\}\}$"
Private Const LNK_EXTRACT_PATTERN As String = "^\{\{([^}]+)\}\}\{\{LNK: #([A-Za-z][A-Za-z0-9_]{0,39})\}\}$"


' --- Module Level Variables ---
Private g_FSO As Scripting.FileSystemObject ' FileSystemObject for logging
Private g_RegExp As VBScript_RegExp_55.RegExp ' RegExp object for validation/extraction
Private g_LogFilePath As String             ' Full path to the log file
Private g_LogStream As Scripting.TextStream ' Log file text stream
Private g_IssuesFound As Boolean            ' Flag if any processing issues occurred
Private g_BookmarksProcessed As Long        ' Counter for summary
Private g_BookmarksFailed As Long           ' Counter for summary
Private g_HyperlinksProcessed As Long       ' Counter for summary
Private g_HyperlinksFailed As Long          ' Counter for summary
Private g_CleanedItems As Long              ' Counter for summary


' ==========================================================================
' Public Procedures
' ==========================================================================

Public Sub AutoMarkup()
' --------------------------------------------------------------------------
' Purpose:     Main entry point to orchestrate the cleanup, bookmark,
'              and hyperlink processing steps on the ActiveDocument.
' Arguments:   None.
' Returns:     None. Displays a summary message box.
' Requires:    ActiveDocument must be open and saved.
' Notes:       Manages screen updating and shows hidden text during processing.
'              Handles top-level errors. Declarations distributed.
' --------------------------------------------------------------------------
    Dim strProcName As String
    strProcName = MODULE_NAME & ".AutoMarkup"

    ' Reset global status flags and counters
    g_IssuesFound = False
    g_BookmarksProcessed = 0
    g_BookmarksFailed = 0
    g_HyperlinksProcessed = 0
    g_HyperlinksFailed = 0
    g_CleanedItems = 0

    ' Declare variables near first use (moved from top)
    Dim originalScreenUpdating As Boolean
    Dim originalShowHidden As Boolean

    On Error GoTo ErrorHandler

    ' --- Initialization ---
    If Not InitializeLogging() Then GoTo Cleanup ' Exit if logging fails
    If Not InitializeRegExp() Then GoTo Cleanup  ' Exit if RegExp fails

    LogMessage strProcName, "--- Processing Started ---", True

    ' --- Preprocessing ---
    originalScreenUpdating = Application.ScreenUpdating
    originalShowHidden = ActiveWindow.View.ShowHiddenText
    Application.ScreenUpdating = False
    ActiveWindow.View.ShowHiddenText = True ' Required to Find hidden text reliably

    ' --- Processing Steps ---
    PerformCleanupLoop
    PerformBookmarkLoop
    PerformHyperlinkLoop

    ' --- Postprocessing ---
    ' Restore settings before summary/cleanup
    Application.ScreenUpdating = originalScreenUpdating
    originalScreenUpdating = True ' Set flag to prevent handler from resetting again if error occurs after this point
    ActiveWindow.View.ShowHiddenText = originalShowHidden
    originalShowHidden = False ' Set flag

    LogMessage strProcName, "--- Processing Finished ---", True

    ' --- Final Summary (Normal execution path) ---
    ShowSummary

Cleanup:
    ' This label is reached on normal completion OR via GoTo on init failure OR via Exit Sub from handler
    On Error Resume Next ' Prevent errors during final cleanup

    ' Close log file stream if open
    If Not g_LogStream Is Nothing Then
        ' Removed WriteLine before Close to prevent Error 54
        g_LogStream.Close
        Set g_LogStream = Nothing
    End If
    Set g_FSO = Nothing
    Set g_RegExp = Nothing

    ' Ensure screen updating is restored even if init failed
    If Not originalScreenUpdating Then Application.ScreenUpdating = True

    Exit Sub ' Normal exit point

ErrorHandler:
    Dim errorDescription As String ' Declared within error handler scope
    errorDescription = "Runtime Error " & Err.Number & ": " & Err.Description & " in " & strProcName
    LogMessage strProcName, "CRITICAL ERROR: " & errorDescription, True ' Log error regardless of g_LogStream state (will fail silently if not init)
    g_IssuesFound = True ' Mark that issues occurred

    ' Attempt to restore settings if they were changed
    On Error Resume Next ' Prevent error during cleanup itself
    If Not originalScreenUpdating Then Application.ScreenUpdating = True
    If originalShowHidden Then ActiveWindow.View.ShowHiddenText = False ' Restore only if it was set to True
    On Error GoTo 0 ' Restore default error handling

    ' Show summary message indicating an error occurred
    ShowSummary

    ' Exit directly after handling error and showing summary
    GoTo Cleanup ' Go to final object cleanup and exit

End Sub

' ==========================================================================
' Private Helper Procedures & Functions
' ==========================================================================

Private Function InitializeLogging() As Boolean
' --------------------------------------------------------------------------
' Purpose:     Initializes the FileSystemObject and opens the log file stream.
' Arguments:   None.
' Returns:     Boolean: True if successful, False otherwise.
' Notes:       Determines log file path based on ActiveDocument. Document must be saved.
'              Logs initialization status. Declarations at top (used throughout).
' --------------------------------------------------------------------------
    Dim docPath As String
    Dim docName As String
    Dim logBaseName As String
    Dim dtNow As String

    On Error GoTo ErrorHandler
    InitializeLogging = False ' Assume failure

    If ActiveDocument Is Nothing Then
        MsgBox "No active document found.", vbCritical, "Initialization Error"
        Exit Function
    End If

    docPath = ActiveDocument.Path
    If docPath = "" Then
        MsgBox "The document must be saved first to determine the log file location.", vbExclamation, "Initialization Error"
        Exit Function
    End If

    docName = ActiveDocument.Name
    ' Handle potential errors if name has no dot
    On Error Resume Next
    logBaseName = Left(docName, InStrRev(docName, ".") - 1)
    If Err.Number <> 0 Then
        logBaseName = docName ' Use full name if no extension found
        Err.Clear
    End If
    On Error GoTo ErrorHandler ' Restore error handling

    If logBaseName = "" Then logBaseName = docName ' Fallback if Left fails unexpectedly

    g_LogFilePath = docPath & Application.PathSeparator & logBaseName & LOG_FILE_EXT

    ' Create FSO instance
    Set g_FSO = New Scripting.FileSystemObject
    If g_FSO Is Nothing Then
        MsgBox "Could not create FileSystemObject. Ensure 'Microsoft Scripting Runtime' reference is enabled.", vbCritical, "Initialization Error"
        Exit Function
    End If

    ' Open or create the log file for appending
    Set g_LogStream = g_FSO.OpenTextFile(g_LogFilePath, ForAppending, True, TristateUseDefault)
    If g_LogStream Is Nothing Then
        MsgBox "Could not open or create log file: " & g_LogFilePath, vbCritical, "Initialization Error"
        Set g_FSO = Nothing
        Exit Function
    End If

    ' Log initialization success
    dtNow = Format(Now, "yyyy-mm-dd hh:mm:ss")
    g_LogStream.WriteLine "" ' Add separator line
    g_LogStream.WriteLine "=== Log Session Started: " & dtNow & " ==="
    g_LogStream.WriteLine "Document: " & ActiveDocument.FullName
    g_LogStream.WriteLine "Log File: " & g_LogFilePath
    g_LogStream.WriteLine "========================================"

    InitializeLogging = True
    Exit Function

ErrorHandler:
    MsgBox "Error initializing logging: " & Err.Description, vbCritical, "Logging Error"
    If Not g_LogStream Is Nothing Then g_LogStream.Close
    Set g_LogStream = Nothing
    Set g_FSO = Nothing
    InitializeLogging = False
End Function
' --------------------------------------------------------------------------

Private Function InitializeRegExp() As Boolean
' --------------------------------------------------------------------------
' Purpose:     Initializes the VBScript RegExp object.
' Arguments:   None.
' Returns:     Boolean: True if successful, False otherwise.
' --------------------------------------------------------------------------
    On Error GoTo ErrorHandler
    InitializeRegExp = False ' Assume failure

    Set g_RegExp = New VBScript_RegExp_55.RegExp
    If g_RegExp Is Nothing Then
         MsgBox "Could not create RegExp object. Ensure 'Microsoft VBScript Regular Expressions 5.5' reference is enabled.", vbCritical, "Initialization Error"
         Exit Function
    End If

    ' Default settings - pattern will be changed as needed
    g_RegExp.Global = False ' Usually process one match string at a time
    g_RegExp.IgnoreCase = False
    g_RegExp.MultiLine = False

    InitializeRegExp = True
    Exit Function

ErrorHandler:
    MsgBox "Error initializing RegExp object: " & Err.Description, vbCritical, "RegExp Error"
    Set g_RegExp = Nothing
    InitializeRegExp = False
End Function
' --------------------------------------------------------------------------

Private Sub LogMessage(procName As String, message As String, Optional forceLog As Boolean = False)
' --------------------------------------------------------------------------
' Purpose:     Writes a message to the log file if DEBUG_MODE is True or forceLog is True.
' Arguments:   procName: Name of the calling procedure.
'              message: The text message to log.
'              forceLog: If True, logs regardless of DEBUG_MODE setting.
' Returns:     None.
' Notes:       Handles potential errors during logging. Prepends timestamp and proc name.
'              Declarations at top (simple procedure).
' --------------------------------------------------------------------------
    Dim logLine As String
    Dim dtNow As String

    If g_LogStream Is Nothing Then Exit Sub ' Logging not initialized or failed

    If DEBUG_MODE Or forceLog Then
        On Error Resume Next ' Prevent logging errors from stopping the main process
        dtNow = Format(Now, "hh:mm:ss")
        logLine = dtNow & " [" & procName & "] " & message
        g_LogStream.WriteLine logLine
        If Err.Number <> 0 Then
            ' Optionally report logging error itself? For now, just ignore.
            Err.Clear
        End If
        On Error GoTo 0 ' Restore default error handling
    End If
End Sub
' --------------------------------------------------------------------------

Private Sub PerformCleanupLoop()
' --------------------------------------------------------------------------
' Purpose:     Finds all potential markup templates using the generic ABC pattern,
'              logs them, removes existing bookmarks/hyperlinks within them,
'              and formats braces. Does NOT perform name extraction/validation here.
' Arguments:   None.
' Returns:     None. Updates module-level counters. Declarations distributed.
' --------------------------------------------------------------------------
    Dim strProcName As String
    strProcName = MODULE_NAME & ".PerformCleanupLoop"
    LogMessage strProcName, "Starting Cleanup Loop (using generic ABC pattern)...", True
    LogMessage strProcName, "  NOTE: This loop cleans format/existing items but does not validate/extract specific names.", True

    Dim rngDoc As Word.Range ' Declared near use
    Set rngDoc = ActiveDocument.Content

    Dim findObj As Word.Find ' Declared near use
    Set findObj = rngDoc.Find

    Dim found As Boolean ' Declared near use

    With findObj
        .ClearFormatting
        .Text = ABC_FIND_PATTERN ' Use generic pattern
        .Replacement.Text = ""
        .Forward = True
        .Wrap = wdFindStop
        .Format = False
        .MatchCase = False
        .MatchWholeWord = False
        .MatchAllWordForms = False
        .MatchSoundsLike = False
        .MatchWildcards = True

        ' Error handling around the Execute specific to Find pattern errors
        On Error Resume Next
        found = .Execute
        If Err.Number = 5560 Then ' Specific error for invalid Find pattern
            LogMessage strProcName, "CRITICAL ERROR: Invalid Find pattern syntax in ABC_FIND_PATTERN: '" & .Text & "'. Error: " & Err.Description, True
            MsgBox "A critical error occurred executing Find with pattern: " & .Text & vbCrLf & "Error: " & Err.Description & vbCrLf & "Cleanup loop cannot continue.", vbCritical, "Find Pattern Error"
            Err.Clear
            On Error GoTo 0 ' Important to reset error handling
            ' Raise error to trigger main handler and stop execution cleanly
            Err.Raise Number:=vbObjectError + 513, Source:=strProcName, Description:="Invalid Find pattern syntax in ABC_FIND_PATTERN."
        ElseIf Err.Number <> 0 Then
            ' Handle other potential errors during Execute
            LogMessage strProcName, "ERROR during Find.Execute in Cleanup Loop. Error: " & Err.Description, True
            g_IssuesFound = True
            Err.Clear
        End If
        On Error GoTo 0 ' Restore default error handling if no error or handled above

    End With ' findObj setup complete

    ' Declare loop-specific variables just before the loop
    Dim rngFound As Word.Range
    Dim templateText As String
    Dim braceRange As Word.Range
    Dim closeBracePos As Long

    Do While found
        g_CleanedItems = g_CleanedItems + 1
        Set rngFound = rngDoc.Duplicate ' Work with the found range
        templateText = rngFound.Text
        LogMessage strProcName, "Found potential template: " & templateText

        ' Remove existing bookmarks/hyperlinks within the found range
        On Error Resume Next ' Ignore errors if no bookmarks/hyperlinks exist
        If rngFound.Bookmarks.Count > 0 Then
            LogMessage strProcName, "  Removing existing bookmark: " & rngFound.Bookmarks(1).Name
            rngFound.Bookmarks(1).Delete
        End If
        If rngFound.Hyperlinks.Count > 0 Then
            LogMessage strProcName, "  Removing existing hyperlink: " & rngFound.Hyperlinks(1).Address & "|" & rngFound.Hyperlinks(1).SubAddress
            rngFound.Hyperlinks(1).Delete
        End If
        On Error GoTo 0 ' Restore error handling

        ' Format the braces: {{ and }}{{...}}
        ' Format opening braces {{
        Set braceRange = rngFound.Duplicate
        braceRange.End = braceRange.Start + 2 ' Select first two chars {{
        If braceRange.Text = "{{" Then
            braceRange.Font.Hidden = True
            braceRange.Font.Bold = True
        Else
             LogMessage strProcName, "  WARNING: Could not format opening braces for: " & templateText, True
             g_IssuesFound = True
        End If

        ' Format closing part }}{{...}}
        ' Find the position of the first closing brace pair "}}"
        closeBracePos = InStr(1, templateText, "}}")

        If closeBracePos > 0 Then
             Set braceRange = rngFound.Duplicate
             braceRange.Start = braceRange.Start + closeBracePos - 1 ' Start at first } of }}
             ' Check if the range text starts correctly
             If Left(braceRange.Text, 2) = "}}" Then
                braceRange.Font.Hidden = True
                braceRange.Font.Bold = True
             Else
                LogMessage strProcName, "  WARNING: Could not accurately format closing braces part for: " & templateText, True
                g_IssuesFound = True
             End If
        Else
             LogMessage strProcName, "  WARNING: Could not find closing braces '}}' to format for: " & templateText, True
             g_IssuesFound = True
        End If

        ' Collapse range and continue search *after* the found item
        rngDoc.Start = rngFound.End
        ' Re-execute Find within the loop
        With findObj
             ' Add specific error handling for Execute within the loop
             On Error Resume Next
             found = .Execute
             If Err.Number = 5560 Then ' Should not happen if initial check passed, but good practice
                 LogMessage strProcName, "CRITICAL ERROR: Invalid Find pattern syntax encountered mid-loop: '" & .Text & "'. Stopping loop.", True
                 MsgBox "A critical error occurred executing Find mid-loop: " & .Text & vbCrLf & "Error: " & Err.Description & vbCrLf & "Cleanup loop stopped.", vbCritical, "Find Pattern Error"
                 Err.Clear
                 found = False ' Stop the loop
             ElseIf Err.Number <> 0 Then
                 LogMessage strProcName, "ERROR during Find.Execute mid-Cleanup Loop. Error: " & Err.Description, True
                 g_IssuesFound = True
                 Err.Clear ' Attempt to continue
             End If
             On Error GoTo 0 ' Restore default error handling
        End With
    Loop ' While found

    LogMessage strProcName, "Finished Cleanup Loop. Items checked/cleaned: " & g_CleanedItems, True
    Set rngDoc = Nothing
    Set findObj = Nothing
    Set rngFound = Nothing
    Set braceRange = Nothing
End Sub
' --------------------------------------------------------------------------

Private Sub PerformBookmarkLoop()
' --------------------------------------------------------------------------
' Purpose:     Finds bookmark templates, extracts/validates names, checks for
'              existing non-template bookmarks, creates new ones if valid.
' Arguments:   None.
' Returns:     None. Updates module-level counters. Uses ExtractMarkupDetails.
' --------------------------------------------------------------------------
    Dim strProcName As String
    strProcName = MODULE_NAME & ".PerformBookmarkLoop"
    LogMessage strProcName, "Starting Bookmark Processing Loop...", True

    Dim rngDoc As Word.Range ' Declared near use
    Set rngDoc = ActiveDocument.Content

    Dim findObj As Word.Find ' Declared near use
    Set findObj = rngDoc.Find

    Dim found As Boolean ' Declared near use

    With findObj
        .ClearFormatting
        .Text = BMK_FIND_PATTERN ' Use updated pattern for finding
        .Replacement.Text = ""
        .Forward = True
        .Wrap = wdFindStop
        .Format = False
        .MatchCase = False
        .MatchWholeWord = False
        .MatchAllWordForms = False
        .MatchSoundsLike = False
        .MatchWildcards = True

        ' Error handling around the Execute specific to Find pattern errors
        On Error Resume Next
        found = .Execute(Replace:=wdReplaceNone) ' Find only
        If Err.Number = 5560 Then ' Specific error for invalid Find pattern
            LogMessage strProcName, "CRITICAL ERROR: Invalid Find pattern syntax in BMK_FIND_PATTERN: '" & .Text & "'. Error: " & Err.Description, True
            MsgBox "A critical error occurred executing Find with pattern: " & .Text & vbCrLf & "Error: " & Err.Description & vbCrLf & "Bookmark loop cannot continue.", vbCritical, "Find Pattern Error"
            Err.Clear
            On Error GoTo 0 ' Important to reset error handling
            ' Raise error to trigger main handler and stop execution cleanly
            Err.Raise Number:=vbObjectError + 513, Source:=strProcName, Description:="Invalid Find pattern syntax in BMK_FIND_PATTERN."
        ElseIf Err.Number <> 0 Then
            LogMessage strProcName, "ERROR during Find.Execute in Bookmark Loop. Error: " & Err.Description, True
            g_IssuesFound = True
            Err.Clear
        End If
        On Error GoTo 0 ' Restore default error handling

    End With ' findObj setup complete

    ' Declare loop-specific variables just before the loop
    Dim rngFound As Word.Range
    Dim bookmarkName As String
    Dim displayedText As String
    Dim extractionSuccess As Boolean
    Dim isValid As Boolean
    Dim alreadyExists As Boolean
    Dim creationSuccess As Boolean

    Do While found
        Set rngFound = rngDoc.Duplicate ' Work with the found range

        ' Reset variables for this match
        bookmarkName = ""
        displayedText = ""
        extractionSuccess = False
        isValid = False
        alreadyExists = False
        creationSuccess = False

        ' 1. Extract Displayed Text and Name using dedicated function
        extractionSuccess = ExtractMarkupDetails(rngFound, "BMK", displayedText, bookmarkName)

        If Not extractionSuccess Then
            ' Error already logged by ExtractMarkupDetails
            g_IssuesFound = True
            g_BookmarksFailed = g_BookmarksFailed + 1
            GoTo ContinueNextBookmark ' Skip to next find result
        End If

        ' 2. Validate Name Format
        isValid = IsValidBookmarkName(bookmarkName)
        LogMessage strProcName, "  Name Validation: " & IIf(isValid, "Passed", "FAILED")
        If Not isValid Then
            g_IssuesFound = True
            g_BookmarksFailed = g_BookmarksFailed + 1
            GoTo ContinueNextBookmark
        End If

        ' 3. Check if bookmark already exists (non-template clash)
        alreadyExists = ActiveDocument.Bookmarks.Exists(bookmarkName)
        LogMessage strProcName, "  Existing Check: " & IIf(alreadyExists, "Bookmark '" & bookmarkName & "' already exists!", "OK")
        If alreadyExists Then
            LogMessage strProcName, "  Skipping creation due to existing non-template bookmark.", True
            g_IssuesFound = True
            g_BookmarksFailed = g_BookmarksFailed + 1
            GoTo ContinueNextBookmark
        End If

        ' 4. Create Bookmark (only if valid and doesn't exist)
        creationSuccess = CreateBookmarkFromTemplate(rngFound, bookmarkName)
        If creationSuccess Then
            LogMessage strProcName, "  SUCCESS: Created bookmark '" & bookmarkName & "' for text '" & displayedText & "'.", True
            g_BookmarksProcessed = g_BookmarksProcessed + 1
        Else
            ' Failure already logged by CreateBookmarkFromTemplate
            g_IssuesFound = True
            g_BookmarksFailed = g_BookmarksFailed + 1
            ' No GoTo here, failure is logged, loop continues
        End If

ContinueNextBookmark:
        ' Collapse range and continue search *after* the found item
        rngDoc.Start = rngFound.End
        ' Re-execute Find within the loop
        With findObj
             ' Add specific error handling for Execute within the loop
             On Error Resume Next
             found = .Execute(Replace:=wdReplaceNone)
             If Err.Number = 5560 Then ' Should not happen if initial check passed, but good practice
                 LogMessage strProcName, "CRITICAL ERROR: Invalid Find pattern syntax encountered mid-loop: '" & .Text & "'. Stopping loop.", True
                 MsgBox "A critical error occurred executing Find mid-loop: " & .Text & vbCrLf & "Error: " & Err.Description & vbCrLf & "Bookmark loop stopped.", vbCritical, "Find Pattern Error"
                 Err.Clear
                 found = False ' Stop the loop
             ElseIf Err.Number <> 0 Then
                 LogMessage strProcName, "ERROR during Find.Execute mid-Bookmark Loop. Error: " & Err.Description, True
                 g_IssuesFound = True
                 Err.Clear ' Attempt to continue
             End If
             On Error GoTo 0 ' Restore default error handling
        End With
    Loop ' While found

    LogMessage strProcName, "Finished Bookmark Processing Loop. Success: " & g_BookmarksProcessed & ", Failed: " & g_BookmarksFailed, True
    Set rngDoc = Nothing
    Set findObj = Nothing
    Set rngFound = Nothing
End Sub
' --------------------------------------------------------------------------

Private Sub PerformHyperlinkLoop()
' --------------------------------------------------------------------------
' Purpose:     Finds hyperlink templates, extracts/validates target names,
'              checks if target bookmark exists, creates new hyperlinks if valid.
' Arguments:   None.
' Returns:     None. Updates module-level counters. Uses ExtractMarkupDetails.
' --------------------------------------------------------------------------
    Dim strProcName As String
    strProcName = MODULE_NAME & ".PerformHyperlinkLoop"
    LogMessage strProcName, "Starting Hyperlink Processing Loop...", True

    Dim rngDoc As Word.Range ' Declared near use
    Set rngDoc = ActiveDocument.Content

    Dim findObj As Word.Find ' Declared near use
    Set findObj = rngDoc.Find

    Dim found As Boolean ' Declared near use

    With findObj
        .ClearFormatting
        .Text = LNK_FIND_PATTERN ' Use updated pattern for finding
        .Replacement.Text = ""
        .Forward = True
        .Wrap = wdFindStop
        .Format = False
        .MatchCase = False
        .MatchWholeWord = False
        .MatchAllWordForms = False
        .MatchSoundsLike = False
        .MatchWildcards = True

        ' Error handling around the Execute specific to Find pattern errors
        On Error Resume Next
        found = .Execute(Replace:=wdReplaceNone) ' Find only
        If Err.Number = 5560 Then ' Specific error for invalid Find pattern
            LogMessage strProcName, "CRITICAL ERROR: Invalid Find pattern syntax in LNK_FIND_PATTERN: '" & .Text & "'. Error: " & Err.Description, True
            MsgBox "A critical error occurred executing Find with pattern: " & .Text & vbCrLf & "Error: " & Err.Description & vbCrLf & "Hyperlink loop cannot continue.", vbCritical, "Find Pattern Error"
            Err.Clear
            On Error GoTo 0 ' Important to reset error handling
            ' Raise error to trigger main handler and stop execution cleanly
            Err.Raise Number:=vbObjectError + 513, Source:=strProcName, Description:="Invalid Find pattern syntax in LNK_FIND_PATTERN."
        ElseIf Err.Number <> 0 Then
            LogMessage strProcName, "ERROR during Find.Execute in Hyperlink Loop. Error: " & Err.Description, True
            g_IssuesFound = True
            Err.Clear
        End If
        On Error GoTo 0 ' Restore default error handling

    End With ' findObj setup complete

    ' Declare loop-specific variables just before the loop
    Dim rngFound As Word.Range
    Dim targetBookmarkName As String ' Target bookmark name
    Dim displayedText As String
    Dim extractionSuccess As Boolean
    Dim isValid As Boolean
    Dim targetExists As Boolean
    Dim creationSuccess As Boolean

    Do While found
        Set rngFound = rngDoc.Duplicate ' Work with the found range

        ' Reset variables for this match
        targetBookmarkName = ""
        displayedText = ""
        extractionSuccess = False
        isValid = False
        targetExists = False
        creationSuccess = False

        ' 1. Extract Displayed Text and Target Name using dedicated function
        extractionSuccess = ExtractMarkupDetails(rngFound, "LNK", displayedText, targetBookmarkName)

        If Not extractionSuccess Then
             ' Error already logged by ExtractMarkupDetails
            g_IssuesFound = True
            g_HyperlinksFailed = g_HyperlinksFailed + 1
            GoTo ContinueNextHyperlink ' Skip to next find result
        End If

        ' 2. Validate Target Name Format
        isValid = IsValidBookmarkName(targetBookmarkName)
        LogMessage strProcName, "  Target Name Validation: " & IIf(isValid, "Passed", "FAILED")
        If Not isValid Then
            g_IssuesFound = True
            g_HyperlinksFailed = g_HyperlinksFailed + 1
            GoTo ContinueNextHyperlink
        End If

        ' 3. Check if target bookmark EXISTS
        targetExists = ActiveDocument.Bookmarks.Exists(targetBookmarkName)
        LogMessage strProcName, "  Target Exists Check: " & IIf(targetExists, "Target '" & targetBookmarkName & "' found.", "Target '" & targetBookmarkName & "' NOT FOUND!")
        If Not targetExists Then
            LogMessage strProcName, "  Skipping creation due to missing target bookmark.", True
            g_IssuesFound = True
            g_HyperlinksFailed = g_HyperlinksFailed + 1
            GoTo ContinueNextHyperlink
        End If

        ' 4. Create Hyperlink (only if valid and target exists)
        creationSuccess = CreateHyperlinkFromTemplate(rngFound, targetBookmarkName, displayedText)
        If creationSuccess Then
            LogMessage strProcName, "  SUCCESS: Created hyperlink to '" & targetBookmarkName & "' for text '" & displayedText & "'.", True
            g_HyperlinksProcessed = g_HyperlinksProcessed + 1
        Else
            ' Failure already logged by CreateHyperlinkFromTemplate
            g_IssuesFound = True
            g_HyperlinksFailed = g_HyperlinksFailed + 1
            ' No GoTo here, failure is logged, loop continues
        End If

ContinueNextHyperlink:
        ' Collapse range and continue search *after* the found item
        rngDoc.Start = rngFound.End
        ' Re-execute Find within the loop
        With findObj
             ' Add specific error handling for Execute within the loop
             On Error Resume Next
             found = .Execute(Replace:=wdReplaceNone)
             If Err.Number = 5560 Then ' Should not happen if initial check passed, but good practice
                 LogMessage strProcName, "CRITICAL ERROR: Invalid Find pattern syntax encountered mid-loop: '" & .Text & "'. Stopping loop.", True
                 MsgBox "A critical error occurred executing Find mid-loop: " & .Text & vbCrLf & "Error: " & Err.Description & vbCrLf & "Hyperlink loop stopped.", vbCritical, "Find Pattern Error"
                 Err.Clear
                 found = False ' Stop the loop
             ElseIf Err.Number <> 0 Then
                 LogMessage strProcName, "ERROR during Find.Execute mid-Hyperlink Loop. Error: " & Err.Description, True
                 g_IssuesFound = True
                 Err.Clear ' Attempt to continue
             End If
             On Error GoTo 0 ' Restore default error handling
        End With
    Loop ' While found

    LogMessage strProcName, "Finished Hyperlink Processing Loop. Success: " & g_HyperlinksProcessed & ", Failed: " & g_HyperlinksFailed, True
    Set rngDoc = Nothing
    Set findObj = Nothing
    Set rngFound = Nothing
End Sub
' --------------------------------------------------------------------------

Private Function ExtractMarkupDetails(templateRange As Word.Range, markupType As String, ByRef outDisplayedText As String, ByRef outBookmarkName As String) As Boolean
' --------------------------------------------------------------------------
' Purpose:     Extracts Displayed Text and Bookmark Name from a found template range.
' Arguments:   templateRange: The Range object containing the full template text.
'              markupType: String indicating type ("BMK" or "LNK").
'              outDisplayedText: ByRef String to receive the extracted displayed text.
'              outBookmarkName: ByRef String to receive the extracted bookmark name.
' Returns:     Boolean: True on successful extraction, False otherwise.
' Notes:       Uses module-level g_RegExp object. Logs details and errors.
' --------------------------------------------------------------------------
    Dim strProcName As String
    Dim templateText As String
    Dim extractionPattern As String
    Dim matches As Object ' VBScript_RegExp_55.MatchCollection
    Dim match As Object   ' VBScript_RegExp_55.match

    strProcName = MODULE_NAME & ".ExtractMarkupDetails"
    ExtractMarkupDetails = False ' Assume failure
    outDisplayedText = ""
    outBookmarkName = ""

    If g_RegExp Is Nothing Then
        LogMessage strProcName, "ERROR: RegExp object not initialized.", True
        Exit Function
    End If

    templateText = templateRange.Text
    LogMessage strProcName, "Attempting extraction from: " & templateText

    ' Select appropriate extraction pattern
    Select Case UCase$(markupType)
        Case "BMK"
            extractionPattern = BMK_EXTRACT_PATTERN
        Case "LNK"
            extractionPattern = LNK_EXTRACT_PATTERN
        Case Else
            LogMessage strProcName, "ERROR: Invalid markupType specified: " & markupType, True
            Exit Function
    End Select

    ' Configure and execute RegExp
    On Error Resume Next ' Handle potential RegExp errors
    g_RegExp.Pattern = extractionPattern
    Set matches = g_RegExp.Execute(templateText)
    If Err.Number <> 0 Then
         LogMessage strProcName, "ERROR: RegExp execution failed for pattern '" & extractionPattern & "' on text '" & templateText & "'. Error: " & Err.Description, True
         Err.Clear
         On Error GoTo 0
         Exit Function
    End If
    On Error GoTo 0 ' Restore default error handling

    ' Process results
    If matches.Count > 0 Then
        Set match = matches(0)
        If match.SubMatches.Count = 2 Then ' Expect 2 groups: Displayed Text, Name
            outDisplayedText = match.SubMatches(0)
            outBookmarkName = match.SubMatches(1)
            LogMessage strProcName, "  Successfully extracted Text: '" & outDisplayedText & "'"
            LogMessage strProcName, "  Successfully extracted Name: #" & outBookmarkName
            ExtractMarkupDetails = True ' Success
        Else
            LogMessage strProcName, "  ERROR: RegExp extracted wrong number of groups (" & match.SubMatches.Count & ") using pattern '" & extractionPattern & "'.", True
        End If
    Else
        LogMessage strProcName, "  ERROR: RegExp failed to extract from found text using pattern '" & extractionPattern & "'.", True
    End If

    Set matches = Nothing
    Set match = Nothing

End Function
' --------------------------------------------------------------------------

Private Function IsValidBookmarkName(nameToCheck As String) As Boolean
' --------------------------------------------------------------------------
' Purpose:     Validates a bookmark name against Word's naming rules
'              (starts with letter, alphanumeric/underscore, <= 40 chars).
' Arguments:   nameToCheck: The bookmark name string (without '#').
' Returns:     Boolean: True if valid, False otherwise.
' Requires:    g_RegExp object to be initialized.
' --------------------------------------------------------------------------
    Dim strProcName As String ' Declared near use
    strProcName = MODULE_NAME & ".IsValidBookmarkName"
    IsValidBookmarkName = False ' Assume invalid

    If g_RegExp Is Nothing Then
        LogMessage strProcName, "RegExp object not initialized.", True
        Exit Function
    End If

    ' Check length first
    If Len(nameToCheck) = 0 Or Len(nameToCheck) > BMK_MAX_LEN Then
        LogMessage strProcName, "Validation failed for '" & nameToCheck & "': Length (" & Len(nameToCheck) & ") invalid.", True
        Exit Function
    End If

    ' Check pattern using specific validation pattern
    On Error Resume Next ' Handle potential RegExp errors
    g_RegExp.Pattern = BMK_NAME_VALIDATION_PATTERN ' Ensure correct validation pattern
    IsValidBookmarkName = g_RegExp.Test(nameToCheck)
    If Err.Number <> 0 Then
        LogMessage strProcName, "RegExp error during validation for '" & nameToCheck & "': " & Err.Description, True
        IsValidBookmarkName = False
        Err.Clear
    End If
    On Error GoTo 0

    If Not IsValidBookmarkName Then
         LogMessage strProcName, "Validation failed for '" & nameToCheck & "': Pattern mismatch.", True
    End If

End Function
' --------------------------------------------------------------------------

Private Function CreateBookmarkFromTemplate(templateRange As Word.Range, bookmarkName As String) As Boolean
' --------------------------------------------------------------------------
' Purpose:     Creates a Word bookmark encompassing the template range.
' Arguments:   templateRange: The Range object containing the full template text.
'              bookmarkName: The validated name for the bookmark.
' Returns:     Boolean: True on success, False on failure.
' Notes:       Logs success or failure. Assumes name is validated and doesn't exist.
' --------------------------------------------------------------------------
    Dim strProcName As String ' Declared near use
    strProcName = MODULE_NAME & ".CreateBookmarkFromTemplate"
    CreateBookmarkFromTemplate = False ' Assume failure

    On Error GoTo ErrorHandler

    ActiveDocument.Bookmarks.Add Name:=bookmarkName, Range:=templateRange
    CreateBookmarkFromTemplate = True
    Exit Function

ErrorHandler:
    LogMessage strProcName, "Error creating bookmark '" & bookmarkName & "': " & Err.Description, True
    CreateBookmarkFromTemplate = False
End Function
' --------------------------------------------------------------------------

Private Function CreateHyperlinkFromTemplate(templateRange As Word.Range, targetBookmarkName As String, displayedText As String) As Boolean
' --------------------------------------------------------------------------
' Purpose:     Creates a Word hyperlink encompassing the template range,
'              linking to an existing bookmark.
' Arguments:   templateRange: The Range object containing the full template text.
'              targetBookmarkName: The validated name of the target bookmark.
'              displayedText: The text to display for the hyperlink (extracted earlier - currently unused by Add method).
' Returns:     Boolean: True on success, False on failure.
' Notes:       Logs success or failure. Assumes target name is validated and exists.
'              The displayedText argument is logged but not explicitly passed to Hyperlinks.Add
'              as the Anchor range implicitly defines the displayed text.
' --------------------------------------------------------------------------
    Dim strProcName As String ' Declared near use
    strProcName = MODULE_NAME & ".CreateHyperlinkFromTemplate"
    CreateHyperlinkFromTemplate = False ' Assume failure

    On Error GoTo ErrorHandler

    ' Note: TextToDisplay argument can interfere with Anchor range.
    ' We create the link on the range, Word uses the Anchor range's text.
    ActiveDocument.Hyperlinks.Add Anchor:=templateRange, Address:="", SubAddress:= _
        targetBookmarkName

    ' Verify it was created (optional but good)
    If templateRange.Hyperlinks.Count > 0 Then
         If templateRange.Hyperlinks(1).SubAddress = targetBookmarkName Then
              CreateHyperlinkFromTemplate = True
         Else
              LogMessage strProcName, "Hyperlink created but SubAddress mismatch for '" & targetBookmarkName & "'. Expected '" & targetBookmarkName & "', Got '" & templateRange.Hyperlinks(1).SubAddress & "'.", True
              ' Consider deleting the incorrect link? For now, just log.
              ' templateRange.Hyperlinks(1).Delete
         End If
    Else
         LogMessage strProcName, "Hyperlink count is zero after attempting creation for '" & targetBookmarkName & "'.", True
    End If

    If Not CreateHyperlinkFromTemplate Then
         LogMessage strProcName, "Failed to create or verify hyperlink to '" & targetBookmarkName & "'.", True
    End If

    Exit Function

ErrorHandler:
    LogMessage strProcName, "Error creating hyperlink to '" & targetBookmarkName & "': " & Err.Description, True
    CreateHyperlinkFromTemplate = False
End Function
' --------------------------------------------------------------------------

Private Sub ShowSummary()
' --------------------------------------------------------------------------
' Purpose:     Displays a final summary message box to the user.
' Arguments:   None. Uses module-level counters.
' Returns:     None. Declarations at top (simple procedure).
' --------------------------------------------------------------------------
    Dim msg As String
    Dim title As String
    Dim icon As VbMsgBoxStyle

    title = "Markup Processing Complete"
    icon = vbInformation

    msg = "Markup processing finished." & vbCrLf & vbCrLf

    msg = msg & "Bookmarks Processed: " & g_BookmarksProcessed & vbCrLf
    msg = msg & "Bookmark Failures: " & g_BookmarksFailed & vbCrLf & vbCrLf

    msg = msg & "Hyperlinks Processed: " & g_HyperlinksProcessed & vbCrLf
    msg = msg & "Hyperlink Failures: " & g_HyperlinksFailed & vbCrLf & vbCrLf

    msg = msg & "Cleanup Items Checked: " & g_CleanedItems & vbCrLf & vbCrLf

    If g_IssuesFound Or g_BookmarksFailed > 0 Or g_HyperlinksFailed > 0 Then
        msg = msg & "NOTE: Some issues were encountered during processing." & vbCrLf
        icon = vbExclamation
        title = "Markup Processing Complete with Issues"
    Else
        msg = msg & "All operations completed successfully." & vbCrLf
    End If

    msg = msg & "See log file for details:" & vbCrLf & g_LogFilePath

    MsgBox msg, icon, title

End Sub
' --------------------------------------------------------------------------


