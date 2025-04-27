Attribute VB_Name = "modBibliographyHyperlinker"
'@Folder("Project")
Option Explicit

'---------------------------------------------------------------------------------------
' Module    : modBibliographyHyperlinker
' Author    : Gemini
' Date      : 16/04/2025
' Version   : 3.1
' Purpose   : Creates internal hyperlinks from in-text bibliography citations
'             (e.g., [1], [2, 3], [4-6], [9-14]) to corresponding bibliography entries
'             marked with bookmarks (BIB_1, BIB_2, etc.). Handles hyphen and en dash ranges.
'             Also finds DOI identifiers within a specified range (or the selection, or
'             the whole document) and creates hyperlinks.
' Changes   : v1.1 - Corrected object reference after delete in hyperlink cleanup.
'                  - Adjusted bibliography entry pattern to handle optional leading page break (\f).
'                  - Refined bookmark range calculation to exclude page break.
'           : v1.2 - Corrected object reference after delete in bookmark cleanup, mirroring hyperlink fix.
'           : v1.3 - Revised hyperlink creation logic in CreateCitationHyperlinks to use
'                    Range.Find for locating component text within the citation, improving robustness.
'           : v1.4 - Changed CreateCitationHyperlinks to use an iterative RegExp approach (REVERTED in v1.8).
'           : v1.5 - Replaced Debug.Print with file logging ({DocName}.log in doc path).
'                  - Added SetupLogFile, LogMessage, CloseLogFile helpers.
'                  - Added error handling for unsaved document.
'                  - Added detailed debug logging for bookmark range calculation.
'           : v1.6 - Changed bookmark range definition in CreateBibliographyBookmarks to use
'                    Collapse/MoveStart/MoveEnd method for potentially better reliability.
'           : v1.7 - Removed detailed debug logging for bookmark range calculation.
'           : v1.8 - Reverted hyperlink creation to loop through initial matches (like v1.3).
'                  - Added reading .Text before Range.Find for component text as potential fix.
'           : v1.9 - Step 4 Hyperlink creation now uses iterative Range.Find with wildcards
'                    to locate citations, avoiding reliance on stale RegExp indices.
'                    RegExp still used to parse inner text of found citations.
'           : v2.0 - Added check in CreateCitationHyperlinksIterativeFind to skip processing
'                    citations found within the bibliography range itself. Added loop counter.
'           : v2.1 - Updated citation patterns (Wildcard Find, Component RegExp, Validation RegExp)
'                    to handle en dash in addition to hyphen (-) for ranges.
'           : v2.2 - Replaced literal en dash character in patterns with ChrW(8211).
'                  - Added detailed logging for component parsing/finding.
'           : v2.3 - Replaced literal en dash character in comments/text with hyphen or description.
'           : v2.4 - Replaced Const pattern definitions using ChrW with Private Functions
'                    to avoid VBA compile error ("Constant expression required").
'           : v2.5 - Reorganized module structure: Constants grouped at top.
'           : v2.6 - Removed extra debug logging from hyperlink creation step (Step 4).
'           : v2.7 - Reverted bookmark range definition in CreateBibliographyBookmarks
'                    back to using calculated Start/End positions with ActiveDocument.Range,
'                    to address issue where MoveStart/End covered entire bibliography for item 1.
'           : v2.8 - Added missing constant declarations for MAX_FIND_LOOPS and ERR_INFINITE_LOOP.
'           : v2.9 - Revised bookmark range definition to use Collapse/MoveStart/MoveEnd
'                    followed by explicitly setting .End based on .Start + length.
'           : v3.0 - Revised CreateBibliographyBookmarks to use para.Range.Find
'                    to locate the specific "[#]" text for bookmarking.
'           : v3.1 - Removed detailed debug logging from CreateBibliographyBookmarks.
'---------------------------------------------------------------------------------------
' References:
'   - Microsoft Word XX.X Object Library (where XX.X is your version)
'   - Microsoft VBScript Regular Expressions 5.5
'   - Microsoft Scripting Runtime
'---------------------------------------------------------------------------------------

'--- Constants ---
Private Const BIB_BOOKMARK_PREFIX As String = "BIB_"
Private Const ZOTERO_FIELD_PART1 As String = "ADDIN ZOTERO_BIBL"
Private Const ZOTERO_FIELD_PART2 As String = "CSL_BIBLIOGRAPHY"
' Regular expression to find bibliography entries like "[123]{TAB}"
' Allows for an optional leading form feed (page break) character \f (Chr(12))
Private Const BIB_ENTRY_PATTERN As String = "^\f?\[(\d+)\]" & vbTab
Private Const MAX_FIND_LOOPS As Long = 10000 ' Safety limit for Find loop

Private Const DOI_URL_PREFIX As String = "https://doi.org/"
Private Const DOI_PREFIX_TEXT As String = "DOI:"
Private Const DOI_REGEX_PATTERN As String = "10\.\d{4,}(\.\d+)*/[-._;()/:A-Z0-9]+" ' Pattern for the DOI identifier itself
Private Const TRAILING_PUNCTUATION As String = ".,;)]}" ' Characters to strip from end of found DOI
Private Const MAX_DOI_CHECK_LENGTH As Long = 200 ' How many chars after "DOI:" to check with RegExp

'--- Error Numbers ---
Private Const ERR_BIB_FIELD_NOT_FOUND As Long = vbObjectError + 1001
Private Const ERR_ORPHAN_CITATIONS As Long = vbObjectError + 1002
Private Const ERR_REGEX_ERROR As Long = vbObjectError + 1003
Private Const ERR_DOC_NOT_SAVED As Long = vbObjectError + 1004 ' For file logging
Private Const ERR_INFINITE_LOOP As Long = vbObjectError + 1005 ' Custom error for loop limit


'--- Module Level Variables for Logging ---
Private m_LogFileNum As Integer ' File handle for the log file
Private m_LogFilePath As String ' Full path to the log file
Private m_LoggingEnabled As Boolean ' Flag to indicate if logging is active


'=======================================================================================
'   MAIN PROCEDURE
'=======================================================================================

Public Sub CreateBibliographyHyperlinks()
'---------------------------------------------------------------------------------------
' Procedure : CreateBibliographyHyperlinks
' Author    : Gemini
' Date      : 16/04/2025
' Purpose   : Main routine to orchestrate the bibliography hyperlink creation process.
'             Logs progress and errors to a file named {DocName}.log.
'             Follows the steps outlined in the requirements:
'             1. Setup Logging & Cleanup existing bookmarks/hyperlinks.
'             2. Scan bibliography, create bookmarks, and store their numbers.
'             3. Scan document (using RegExp) for citations for validation only.
'             4. Create hyperlinks iteratively using Range.Find, skipping bibliography section.
'             5. Close Log file.
' Notes     : Uses early binding and requires references to:
'             - Microsoft VBScript Regular Expressions 5.5
'             - Microsoft Scripting Runtime
'---------------------------------------------------------------------------------------
    Dim bibField As Word.Field
    Dim bibRange As Word.Range ' Will hold the bibliography range
    Dim createdBookmarks As Scripting.Dictionary ' Key: Bib number (Long), Value: Bookmark Name (String)
    Dim referencedCitations As Scripting.Dictionary ' Key: Citation number (Long), Value: 1 (just to track existence)
    Dim orphanCitations As Collection
    Dim regExVal As RegExp ' RegExp object for validation scan ONLY
    Dim validationMatches As MatchCollection ' For initial validation scan ONLY
    Dim i As Long
    Dim doc As Word.Document
    Dim citeKey As Variant
    Dim errorDescription As String

    On Error GoTo ErrorHandler
    Application.ScreenUpdating = False
    Set doc = ActiveDocument ' Explicitly use ActiveDocument

    '--- Step 1a: Setup Logging ---
    Call SetupLogFile(doc) ' Attempt to open log file

    Call LogMessage("------------------------------------------------------------")
    Call LogMessage("CreateBibliographyHyperlinks started at " & Format(Now, "yyyy-mm-dd hh:nn:ss"))
    Call LogMessage("Processing document: " & doc.FullName)

    ' Ensure necessary references are available
    ' Test creation of RegExp and Dictionary objects early
    On Error Resume Next ' Temporarily ignore errors for object creation check
    Set regExVal = New RegExp ' Renamed to avoid confusion
    Set createdBookmarks = New Scripting.Dictionary
    Set referencedCitations = New Scripting.Dictionary
    If Err.Number <> 0 Then
        Call LogMessage("ERROR: Required object could not be created. Check References (RegExp, Scripting). Error: " & Err.Description)
        Err.Clear ' Clear error before raising a new one
        On Error GoTo 0 ' Restore default error handling before raising
        Err.Raise Err.Number, "CreateBibliographyHyperlinks (Object Creation)", "Required object could not be created. Check VBA References (Microsoft VBScript Regular Expressions 5.5, Microsoft Scripting Runtime)."
    End If
    On Error GoTo ErrorHandler ' Restore main error handler

    '--- Step 1b: Cleanup ---
    Call LogMessage("Step 1: Cleaning up existing bookmarks and hyperlinks...")
    Call DeleteBibBookmarks(doc)
    Call DeleteBibHyperlinks(doc)
    Call LogMessage("Cleanup complete.")

    '--- Step 2: Bibliography Scanning & Bookmark Creation ---
    Call LogMessage("Step 2: Scanning bibliography and creating bookmarks...")
    ' Find the Zotero bibliography field
    Set bibField = FindZoteroBibliographyField(doc)
    If bibField Is Nothing Then
        errorDescription = "Could not find the Zotero bibliography field containing '" & _
                           ZOTERO_FIELD_PART1 & "' and '" & ZOTERO_FIELD_PART2 & "'."
        Call LogMessage("ERROR: " & errorDescription) ' Log before raising
        Err.Raise ERR_BIB_FIELD_NOT_FOUND, "CreateBibliographyHyperlinks", errorDescription
    End If
    Call LogMessage("Bibliography field found: " & bibField.Code.Text)

    ' Get the range containing the bibliography entries
    Set bibRange = bibField.Result ' Store the bibliography range
    If bibRange Is Nothing Then
        Call LogMessage("Warning: Bibliography field result range is Nothing. No bookmarks created.")
        ' bibRange remains Nothing, hyperlink creation will process whole doc
    Else
        ' Create bookmarks and store numbers
        Set createdBookmarks = CreateBibliographyBookmarks(bibRange)
        Call LogMessage("Created " & createdBookmarks.Count & " bibliography bookmarks.")
        If createdBookmarks.Count = 0 Then
             Call LogMessage("Warning: No bibliography entries matching pattern '" & BIB_ENTRY_PATTERN & "' found. No bookmarks created.")
             ' Decide if this should be an error or proceed
        End If
    End If


    '--- Step 3: Citation Scanning & Validation (Using RegExp - for validation ONLY) ---
    ' Perform ONE initial RegExp scan JUST for validation purposes before modifying the doc
    Call LogMessage("Step 3: Scanning document for citations using RegExp (for validation pre-check)...")
    With regExVal ' Use the validation RegExp object
        .Global = True
        .MultiLine = True
        .IgnoreCase = False
        .Pattern = GetValidationPattern() ' Use function call
    End With

    ' Scan the entire document content for validation
    Set validationMatches = regExVal.Execute(doc.Content.Text) ' Store matches for validation
    Call LogMessage("Found " & validationMatches.Count & " potential citation patterns via RegExp for validation.")

    If validationMatches.Count > 0 Then
        ' Collect all unique citation numbers referenced in the document
        Set referencedCitations = GetAllReferencedCitationNumbers(validationMatches) ' This function still works with RegExp matches
        Call LogMessage("Found " & referencedCitations.Count & " unique referenced citation numbers for validation.")

        ' Validate referenced citations against created bookmarks (Orphan Check)
        Set orphanCitations = FindOrphanCitations(referencedCitations, createdBookmarks)

        If orphanCitations.Count > 0 Then
            errorDescription = "Orphan citation(s) found (cited in text but no matching bibliography entry/bookmark): "
            For i = 1 To orphanCitations.Count
                errorDescription = errorDescription & orphanCitations(i) & IIf(i < orphanCitations.Count, ", ", "")
            Next i
            Call LogMessage("ERROR: " & errorDescription) ' Log before raising
            Err.Raise ERR_ORPHAN_CITATIONS, "CreateBibliographyHyperlinks", errorDescription
        End If
        Call LogMessage("Validation successful: All referenced citations have corresponding bookmarks.")
    Else
        Call LogMessage("No citation patterns found in the document. Skipping hyperlink creation.")
        GoTo ProcedureExit ' Nothing more to do
    End If
    ' Clear validation-only objects
    Set validationMatches = Nothing
    Set referencedCitations = Nothing
    Set orphanCitations = Nothing
    Set regExVal = Nothing ' Clear validation RegExp object


    '--- Step 4: Hyperlink Creation (Iterative Find Approach) ---
    Call LogMessage("Step 4: Creating hyperlinks iteratively using Range.Find...")
    ' Pass the bibliography range to the helper function
    Call CreateCitationHyperlinksIterativeFind(doc, createdBookmarks, bibRange)
    Call LogMessage("Hyperlink creation process complete.")


    '--- Step 5: Create DOI Hyperlinks ---
    Call CreateDOILinksInRange(bibRange)

    MsgBox "Bibliography hyperlinks created successfully! See log file for details:" & vbCrLf & m_LogFilePath, vbInformation

ProcedureExit:
    Call LogMessage("CreateBibliographyHyperlinks finished at " & Format(Now, "yyyy-mm-dd hh:nn:ss"))
    Call LogMessage("------------------------------------------------------------")
    Call CloseLogFile ' Ensure log file is closed on normal exit
    ' Clean up objects
    Set bibField = Nothing
    Set bibRange = Nothing
    Set createdBookmarks = Nothing
    Set referencedCitations = Nothing ' Already cleared after validation
    Set orphanCitations = Nothing   ' Already cleared after validation
    Set regExVal = Nothing          ' Already cleared after validation
    Set validationMatches = Nothing ' Already cleared after validation
    Set doc = Nothing
    Application.ScreenUpdating = True
    Exit Sub

ErrorHandler:
    Dim lngErrNum As Long: lngErrNum = Err.Number
    Dim strErrDesc As String: strErrDesc = Err.Description
    Call LogMessage("!!! MACRO ERROR: " & lngErrNum & " - " & strErrDesc & " !!!") ' Log the error

    ' --- Attempt Cleanup within Error Handler ---
    On Error Resume Next ' Prevent error during cleanup hiding original error
    Application.ScreenUpdating = True
    ' Release objects
    Set bibField = Nothing
    Set bibRange = Nothing
    Set createdBookmarks = Nothing
    Set referencedCitations = Nothing
    Set orphanCitations = Nothing
    Set regExVal = Nothing
    Set validationMatches = Nothing
    Set doc = Nothing
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
'   PATTERN GENERATING FUNCTIONS (Replaced Constants using ChrW)
'=======================================================================================

Private Function GetCitationFindPattern() As String
' Returns the Wildcard pattern for Word's Find to locate citations
' Handles digits, comma, hyphen, en dash, space within brackets
    GetCitationFindPattern = "\[[0-9,-" & ChrW(8211) & " ]@\]"
End Function
'---------------------------------------------------------------------------------------

Private Function GetComponentPattern() As String
' Returns the RegExp pattern to parse components within a citation's inner text (numbers or ranges)
' Handles hyphen (-) or EN DASH (ChrW(8211)) as range separator
    GetComponentPattern = "(\d+)(?:[-" & ChrW(8211) & "](\d+))?"
End Function
'---------------------------------------------------------------------------------------

Private Function GetValidationPattern() As String
' Returns the RegExp pattern for the initial validation scan
' Handles digits, comma, hyphen, en dash, space within brackets
' Note: Hyphen is escaped as \- just in case, though likely not needed within [] here.
    GetValidationPattern = "\[([0-9,\-" & ChrW(8211) & "\s]+?)\]"
End Function
'---------------------------------------------------------------------------------------


'=======================================================================================
'   DOI PROCESSING FUNCTION
'=======================================================================================
Public Sub CreateDOILinksInRange(Optional targetRange As Word.Range = Nothing)
'---------------------------------------------------------------------------------------
' Procedure : CreateDOILinksInRange
' Author    : Gemini
' Date      : 26/04/2025
' Purpose   : Finds DOI identifiers within a specified range (or the selection, or
'             the whole document) and creates hyperlinks.
' Usage     : Call CreateDOILinksInRange, optionally passing a Range object.
'             If no range is passed, it checks the Selection; if Selection is empty,
'             it processes the entire document.
' Notes     : - Handles "DOI:" prefix case-insensitively.
'             - Handles optional space after the colon.
'             - Excludes common trailing punctuation from the DOI link/text.
'             - Skips DOIs that are already part of a hyperlink.
'             - Requires the document to be saved for file logging.
' Arguments : targetRange (Word.Range, Optional): The range to search within.
'---------------------------------------------------------------------------------------
    Dim doc As Word.Document
    Dim rngToProcess As Word.Range      ' The actual range being searched
    Dim searchRange As Word.Range       ' Range used for the Find loop iteration
    Dim rngPotentialDOI As Word.Range   ' Range immediately after "DOI:" to check with RegExp
    Dim linkRange As Word.Range         ' The precise range of the DOI identifier to hyperlink
    Dim regExDOI As RegExp              ' RegExp object to validate DOI pattern
    Dim doiMatch As match               ' RegExp match object
    Dim strDOI As String                ' The extracted DOI identifier string
    Dim strURL As String                ' The final URL for the hyperlink
    Dim doiLength As Long               ' Length of the DOI identifier (after cleanup)
    Dim doiStartPos As Long             ' Starting character position of the DOI identifier
    Dim loopCounter As Long             ' Safety counter for Find loop
    Dim linksCreatedCount As Long       ' Counter for summary
    Dim linksSkippedCount As Long       ' Counter for summary
    Dim strMsg As String                ' For final message box

    On Error GoTo ErrorHandler
    Set doc = ActiveDocument

    Call LogMessage(vbCrLf & "--- Starting CreateDOILinksInRange at " & Now & " ---")

    ' 1. Determine Processing Range (Updated Logic)
    Call LogMessage("Step 1: Determining processing range...")
    If Not targetRange Is Nothing Then
        ' Use the provided range argument
        Set rngToProcess = targetRange
        Call LogMessage("  Processing specified range argument (Start: " & rngToProcess.Start & ", End: " & rngToProcess.End & ")")
    Else
        ' No range argument provided, check selection
        If Selection.Type = wdSelectionIP Or Selection.Type = wdNoSelection Then
            ' Selection is empty or IP, use whole document
            Set rngToProcess = doc.Content
            Call LogMessage("  No range passed and selection empty. Processing entire document.")
        Else
            ' Use the current selection
            Set rngToProcess = Selection.Range
            Call LogMessage("  No range passed. Processing current selection (Start: " & rngToProcess.Start & ", End: " & rngToProcess.End & ")")
        End If
    End If

    If rngToProcess Is Nothing Then
        Call LogMessage("ERROR: Processing range could not be determined.")
        GoTo CleanUp ' Exit if range is invalid
    End If

    ' Initialize counters
    linksCreatedCount = 0
    linksSkippedCount = 0

    ' 2. Setup RegExp
    Call LogMessage("Step 2: Setting up Regular Expression...")
    Set regExDOI = New RegExp
    With regExDOI
        .Pattern = DOI_REGEX_PATTERN
        .IgnoreCase = True
        .Global = False ' Find only the first match after the prefix
    End With
    Call LogMessage("  RegExp Pattern: '" & regExDOI.Pattern & "'")

    ' 3. Iterative Find for Prefix
    Call LogMessage("Step 3: Finding DOI prefixes...")
    Set searchRange = rngToProcess.Duplicate ' Use a copy for searching

    With searchRange.Find
        .ClearFormatting
        .Text = DOI_PREFIX_TEXT
        .MatchCase = False ' Case-insensitive prefix search
        .MatchWildcards = False ' Find literal text
        .Forward = True
        .Wrap = wdFindStop
        .Format = False

        Call LogMessage("  Attempting Find for prefix: '" & .Text & "'")

        loopCounter = 0 ' Initialize loop counter
        Do While .Execute
            loopCounter = loopCounter + 1
            ' Call LogMessage("  Loop " & loopCounter & ": Find.Execute returned. Find.Found = " & searchRange.Find.Found & ". Current searchRange.Start = " & searchRange.Start) ' Optional detailed log

            ' Safety Check for Infinite Loop
            If loopCounter > MAX_FIND_LOOPS Then
                Err.Raise ERR_INFINITE_LOOP, "CreateDOILinksInRange (Find Loop)", _
                          "Processing stopped after exceeding maximum loop limit (" & MAX_FIND_LOOPS & "). Possible infinite loop detected."
            End If

            If .found Then
                Call LogMessage("  Found prefix '" & searchRange.Text & "' at Range(" & searchRange.Start & ", " & searchRange.End & ")")

                ' Check for Optional Space and determine DOI start position
                doiStartPos = searchRange.End ' Default start is immediately after prefix
                If doc.Range(searchRange.End, searchRange.End + 1).Text = " " Then
                    doiStartPos = searchRange.End + 1
                    Call LogMessage("    Optional space found after prefix.")
                End If
                Call LogMessage("    Potential DOI start position: " & doiStartPos)

                ' Define Potential DOI Range to check with RegExp
                Set rngPotentialDOI = doc.Range(Start:=doiStartPos, End:=doiStartPos)
                ' Extend range forward, but don't exceed original processing range or reasonable length
                rngPotentialDOI.End = rngPotentialDOI.Start + MAX_DOI_CHECK_LENGTH
                If rngPotentialDOI.End > rngToProcess.End Then
                    rngPotentialDOI.End = rngToProcess.End
                End If
                ' Also ensure it doesn't cross paragraph boundaries unnecessarily (optional refinement)
                ' If rngPotentialDOI.Paragraphs.Count > 1 Then
                '    rngPotentialDOI.End = rngPotentialDOI.Paragraphs(1).Range.End
                ' End If
                Call LogMessage("    Checking potential DOI range: " & rngPotentialDOI.Start & " - " & rngPotentialDOI.End)


                ' Validate with RegExp
                If regExDOI.Test(rngPotentialDOI.Text) Then
                    Set doiMatch = regExDOI.Execute(rngPotentialDOI.Text)(0)
                    Call LogMessage("    RegExp found potential DOI: '" & doiMatch.Value & "' at index " & doiMatch.FirstIndex & " within potential range.")

                    ' Check if the match starts right after the prefix (and optional space)
                    If doiMatch.FirstIndex = 0 Then
                        strDOI = doiMatch.Value
                        doiLength = Len(strDOI) ' Initial length

                        ' Check/Remove Trailing Punctuation
                        Do While doiLength > 0 And InStr(1, TRAILING_PUNCTUATION, Right$(strDOI, 1), vbBinaryCompare) > 0
                            strDOI = Left$(strDOI, doiLength - 1)
                            doiLength = Len(strDOI)
                            Call LogMessage("      Removed trailing punctuation. Adjusted DOI: '" & strDOI & "'")
                        Loop

                        If doiLength > 0 Then
                            ' Define the precise range for the hyperlink anchor
                            Set linkRange = doc.Range(Start:=doiStartPos, End:=doiStartPos + doiLength)
                            Call LogMessage("      Defined link range: " & linkRange.Start & " - " & linkRange.End & " (Text: '" & linkRange.Text & "')")

                            ' Check for Existing Link
                            If linkRange.Hyperlinks.Count = 0 Then
                                ' Create Hyperlink
                                strURL = DOI_URL_PREFIX & strDOI
                                Call LogMessage("      Creating hyperlink to: " & strURL)
                                On Error Resume Next ' Handle potential errors adding hyperlink
                                doc.Hyperlinks.Add Anchor:=linkRange, Address:=strURL
                                If Err.Number = 0 Then
                                    linksCreatedCount = linksCreatedCount + 1
                                    Call LogMessage("      Hyperlink created successfully.")
                                Else
                                    Call LogMessage("      ERROR creating hyperlink: " & Err.Description)
                                    Err.Clear
                                End If
                                On Error GoTo ErrorHandler ' Restore main handler

                                ' Advance Search Range past the processed DOI
                                searchRange.Start = linkRange.End
                            Else
                                ' DOI is already linked
                                linksSkippedCount = linksSkippedCount + 1
                                Call LogMessage("      Skipped: DOI text is already part of a hyperlink.")
                                ' Advance Search Range past the already linked DOI
                                searchRange.Start = linkRange.End
                            End If
                        Else
                             Call LogMessage("      Skipped: DOI became empty after removing punctuation.")
                             searchRange.Collapse wdCollapseEnd ' Move past prefix
                        End If
                    Else
                        ' RegExp match didn't start immediately after prefix
                        Call LogMessage("    RegExp match found, but not immediately after prefix. Skipping.")
                        searchRange.Collapse wdCollapseEnd ' Move past prefix
                    End If
                Else
                    ' RegExp did not find a valid DOI pattern after the prefix
                    Call LogMessage("    No valid DOI pattern found after prefix.")
                    searchRange.Collapse wdCollapseEnd ' Move past prefix
                End If
            Else
                Exit Do ' Stop loop if Find.Found is False
            End If
        Loop ' While .Execute
    End With ' searchRange.Find

    Call LogMessage("Step 3 finished. Links Created: " & linksCreatedCount & ", Links Skipped: " & linksSkippedCount)
    Set regExDOI = Nothing

    ' 4. Cleanup & Reporting
    Call LogMessage("Step 4: Cleanup and Reporting...")

CleanUp:
    On Error Resume Next ' Ensure final cleanup attempts don't raise new errors
    ' Release objects
    Set doc = Nothing
    Set rngToProcess = Nothing
    Set searchRange = Nothing
    Set rngPotentialDOI = Nothing
    Set linkRange = Nothing
    Set regExDOI = Nothing
    Set doiMatch = Nothing

    ' Display Summary Message ONLY if no error occurred (ErrorHandler jumps past this)
    If Err.Number = 0 Then
        strMsg = "DOI Link processing complete." & vbCrLf & vbCrLf & _
                 "New Hyperlinks Created: " & linksCreatedCount & vbCrLf & _
                 "Existing Links Skipped: " & linksSkippedCount
        MsgBox strMsg, vbInformation, "Processing Summary"
    End If

    Call LogMessage("--- Finished CreateDOILinksInRange at " & Now & " ---")
    On Error GoTo 0
    Exit Sub

    ' 5. Error Handling
ErrorHandler:
    Dim lngErrNum As Long: lngErrNum = Err.Number
    Dim strErrDesc As String: strErrDesc = Err.Description
    Call LogMessage("!!! MACRO ERROR: " & lngErrNum & " - " & strErrDesc & " !!!") ' Log the error

    ' --- Attempt Cleanup within Error Handler ---
    On Error Resume Next ' Prevent error during cleanup hiding original error
    ' Release objects
    Set doc = Nothing
    Set rngToProcess = Nothing
    Set searchRange = Nothing
    Set rngPotentialDOI = Nothing
    Set linkRange = Nothing
    Set regExDOI = Nothing
    Set doiMatch = Nothing
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
'   LOGGING HELPER FUNCTIONS
'=======================================================================================

Private Sub SetupLogFile(ByVal doc As Word.Document)
'---------------------------------------------------------------------------------------
' Procedure : SetupLogFile
' Purpose   : Initializes and opens the log file for writing. Overwrites existing file.
' Arguments : doc - The active Word document.
' Notes     : Requires document to be saved. Uses FileSystemObject.
'             Sets module-level variables m_LogFilePath and m_LogFileNum.
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
'   CORE HELPER FUNCTIONS & PROCEDURES
'=======================================================================================


Private Sub DeleteBibBookmarks(ByVal doc As Word.Document)
'---------------------------------------------------------------------------------------
' Procedure : DeleteBibBookmarks
' Purpose   : Deletes all bookmarks in the document whose names start with BIB_BOOKMARK_PREFIX.
' Arguments : doc - The Word Document object to process.
'---------------------------------------------------------------------------------------
    Dim bm As Word.Bookmark
    Dim i As Long
    Dim bookmarkName As String ' Store name before deleting

    ' Iterate backwards because we are deleting items from the collection
    For i = doc.Bookmarks.Count To 1 Step -1
        Set bm = doc.Bookmarks(i)
        If bm.Name Like BIB_BOOKMARK_PREFIX & "*" Then
            bookmarkName = bm.Name ' Store the name *before* deleting
            bm.Delete             ' Delete the bookmark
            Call LogMessage("Deleted bookmark: " & bookmarkName) ' Log the stored name
        End If
    Next i
    Set bm = Nothing
End Sub
'---------------------------------------------------------------------------------------

Private Sub DeleteBibHyperlinks(ByVal doc As Word.Document)
'---------------------------------------------------------------------------------------
' Procedure : DeleteBibHyperlinks
' Purpose   : Deletes all hyperlinks in the document whose SubAddress starts with BIB_BOOKMARK_PREFIX.
' Arguments : doc - The Word Document object to process.
'---------------------------------------------------------------------------------------
    Dim hl As Word.Hyperlink
    Dim i As Long
    Dim targetAddress As String ' Store address before deleting

    ' Iterate backwards because removing hyperlinks might affect the collection index
    For i = doc.Hyperlinks.Count To 1 Step -1
        Set hl = doc.Hyperlinks(i)
        targetAddress = "" ' Reset for safety
        On Error Resume Next ' Handle cases where SubAddress might be invalid or empty
        targetAddress = hl.SubAddress
        On Error GoTo 0 ' Restore default error handling

        If targetAddress Like BIB_BOOKMARK_PREFIX & "*" Then
            hl.Delete ' Delete the hyperlink first
            Call LogMessage("Deleted hyperlink targeting: " & targetAddress) ' Log stored address
        End If
    Next i
    Set hl = Nothing
End Sub
'---------------------------------------------------------------------------------------

Private Function FindZoteroBibliographyField(ByVal doc As Word.Document) As Word.Field
'---------------------------------------------------------------------------------------
' Function  : FindZoteroBibliographyField
' Purpose   : Finds the first field in the document containing both Zotero identifiers.
' Arguments : doc - The Word Document object to search within.
' Returns   : The found Word.Field object, or Nothing if not found.
'---------------------------------------------------------------------------------------
    Dim fld As Word.Field
    Dim fieldCode As String

    For Each fld In doc.Fields
        fieldCode = fld.Code.Text
        If InStr(1, fieldCode, ZOTERO_FIELD_PART1, vbTextCompare) > 0 And _
           InStr(1, fieldCode, ZOTERO_FIELD_PART2, vbTextCompare) > 0 Then
            Set FindZoteroBibliographyField = fld
            Exit Function ' Return the first match found
        End If
    Next fld

    ' If loop completes without finding the field
    Set FindZoteroBibliographyField = Nothing
End Function
'---------------------------------------------------------------------------------------

Private Function CreateBibliographyBookmarks(ByVal bibRange As Word.Range) As Scripting.Dictionary
'---------------------------------------------------------------------------------------
' Function  : CreateBibliographyBookmarks
' Purpose   : Scans paragraphs within the bibliography range, creates bookmarks
'             for entries matching "^\f?\[#]{TAB}", and returns a dictionary of created bookmarks.
'             Uses para.Range.Find to locate the "[#]" text for bookmarking.
' Arguments : bibRange - The Word.Range object containing the bibliography entries.
' Returns   : A Scripting.Dictionary where Key=Bibliography Number (Long), Value=Bookmark Name (String).
' Requires  : Microsoft VBScript Regular Expressions 5.5, Microsoft Scripting Runtime
'---------------------------------------------------------------------------------------
    Dim para As Word.Paragraph
    Dim regex As RegExp
    Dim matches As MatchCollection
    Dim match As match
    Dim bibNum As Long
    Dim bookmarkName As String
    Dim bookmarkRange As Word.Range ' Range for the bookmark itself ([#])
    Dim findRange As Word.Range     ' Range used for finding within the paragraph
    Dim dictBookmarks As Scripting.Dictionary
    Dim paraText As String
    Dim searchText As String

    Set dictBookmarks = New Scripting.Dictionary
    Set regex = New RegExp

    ' Configure RegExp to find optional \f then "[#]{TAB}" at the start of a line
    ' This is primarily to extract the bibNum reliably.
    With regex
        .Pattern = BIB_ENTRY_PATTERN ' Uses "\f?\[(\d+)\]{TAB}"
        .Global = False
        .MultiLine = False
        .IgnoreCase = False
    End With

    ' Iterate through each paragraph in the bibliography range
    For Each para In bibRange.Paragraphs
        paraText = para.Range.Text ' Get text of the paragraph
        Set matches = regex.Execute(paraText)

        If matches.Count > 0 Then
            Set match = matches(0)
            ' Extract the number (Group 1 of the pattern)
            bibNum = CLng(match.SubMatches(0))
            bookmarkName = BIB_BOOKMARK_PREFIX & bibNum
            searchText = "[" & bibNum & "]" ' Construct exact text to find

            ' *** Define range using para.Range.Find ***
            Set findRange = para.Range.Duplicate ' Search within the paragraph
            Set bookmarkRange = Nothing          ' Reset bookmark range

            With findRange.Find
                .ClearFormatting
                .Text = searchText
                .Forward = True
                .Wrap = wdFindStop
                .Format = False
                .MatchCase = True       ' Exact match for "[#]"
                .MatchWholeWord = False ' Allow finding "[1]" even if attached
                .MatchWildcards = False ' Not using wildcards here
                .MatchSoundsLike = False
                .MatchAllWordForms = False

                If .Execute Then
                    ' If found, the findRange now IS the bookmark range
                    Set bookmarkRange = findRange.Duplicate ' Use a copy
                Else
                    Call LogMessage("Warning: Could not Find text '" & searchText & "' in paragraph starting with: " & Left(paraText, 20) & "... Skipping bookmark " & bookmarkName)
                End If
            End With
            ' *** End Find-based range definition ***


            ' Check if bookmark already exists and range was found
            If Not bookmarkRange Is Nothing Then
                If Not ActiveDocument.Bookmarks.Exists(bookmarkName) Then
                     ' Add the bookmark using the found range
                    ActiveDocument.Bookmarks.Add Name:=bookmarkName, Range:=bookmarkRange
                    ' Store in dictionary if successful
                    If Not dictBookmarks.Exists(bibNum) Then
                        dictBookmarks.Add bibNum, bookmarkName
                        Call LogMessage("Created bookmark: " & bookmarkName & " covering range text: '" & bookmarkRange.Text & "'")
                    Else
                        Call LogMessage("Warning: Duplicate bibliography number found and ignored: " & bibNum)
                    End If
                Else
                     Call LogMessage("Warning: Bookmark '" & bookmarkName & "' unexpectedly already exists. Skipped.")
                End If
            End If ' End If Not bookmarkRange Is Nothing
        End If ' End If matches.Count > 0
    Next para

    Set CreateBibliographyBookmarks = dictBookmarks

    ' Cleanup
    Set para = Nothing
    Set regex = Nothing
    Set matches = Nothing
    Set match = Nothing
    Set bookmarkRange = Nothing
    Set findRange = Nothing
    Set dictBookmarks = Nothing
End Function
'---------------------------------------------------------------------------------------

Private Function GetAllReferencedCitationNumbers(ByVal citationMatches As MatchCollection) As Scripting.Dictionary
'---------------------------------------------------------------------------------------
' Function  : GetAllReferencedCitationNumbers
' Purpose   : Parses all citation strings found by the main regex and returns a
'             dictionary containing all unique citation numbers referenced.
'             Used for the initial validation scan. Handles ranges with hyphen or en dash.
' Arguments : citationMatches - A MatchCollection from executing VALIDATION_CITATION_PATTERN on document content.
' Returns   : A Scripting.Dictionary where Key=Citation Number (Long), Value=1 (indicates presence).
' Requires  : Microsoft VBScript Regular Expressions 5.5, Microsoft Scripting Runtime
'---------------------------------------------------------------------------------------
    Dim dictReferenced As New Scripting.Dictionary
    Dim regExComp As New RegExp ' For parsing components like "1", "2-5", "9-14"
    Dim citationMatch As match
    Dim innerText As String
    Dim componentMatches As MatchCollection
    Dim componentMatch As match
    Dim startNum As Long
    Dim endNum As Long
    Dim i As Long

    ' Configure component regex (now handles hyphen OR en dash)
    With regExComp
        .Global = True
        .Pattern = GetComponentPattern() ' Use function call
    End With

    ' Process each citation found in the document
    For Each citationMatch In citationMatches
        innerText = Trim(citationMatch.SubMatches(0)) ' Get text inside brackets, e.g., "17-19, 23", "9-14"

        ' Find all numbers and ranges within the inner text
        Set componentMatches = regExComp.Execute(innerText)

        For Each componentMatch In componentMatches
            startNum = CLng(componentMatch.SubMatches(0))

            If componentMatch.SubMatches(1) <> "" Then ' It's a range (e.g., 17-19 or 9-14)
                endNum = CLng(componentMatch.SubMatches(1))
                If endNum < startNum Then endNum = startNum ' Handle invalid range like [5-3] as just [5]
                ' Add all numbers in the range to the dictionary
                For i = startNum To endNum
                    If Not dictReferenced.Exists(i) Then dictReferenced.Add i, 1
                Next i
            Else ' It's a single number
                If Not dictReferenced.Exists(startNum) Then dictReferenced.Add startNum, 1
            End If
        Next componentMatch
    Next citationMatch

    Set GetAllReferencedCitationNumbers = dictReferenced

    ' Cleanup
    Set dictReferenced = Nothing
    Set regExComp = Nothing
    Set citationMatch = Nothing
    Set componentMatches = Nothing
    Set componentMatch = Nothing

End Function
'---------------------------------------------------------------------------------------

Private Function FindOrphanCitations(ByVal referencedCitations As Scripting.Dictionary, ByVal createdBookmarks As Scripting.Dictionary) As Collection
'---------------------------------------------------------------------------------------
' Function  : FindOrphanCitations
' Purpose   : Compares referenced citation numbers against created bookmark numbers
'             and returns a collection of orphan numbers (referenced but no bookmark).
' Arguments : referencedCitations - Dictionary of numbers found in citations.
'             createdBookmarks - Dictionary of numbers for which bookmarks were created.
' Returns   : A Collection containing orphan citation numbers (Long). Empty if none found.
'---------------------------------------------------------------------------------------
    Dim orphans As New Collection
    Dim citeKey As Variant

    If referencedCitations Is Nothing Or createdBookmarks Is Nothing Then
        ' Handle potential Nothing dictionaries, though they should be initialized
        Set FindOrphanCitations = orphans
        Exit Function
    End If

    ' Check each referenced citation number
    For Each citeKey In referencedCitations.Keys
        If Not createdBookmarks.Exists(citeKey) Then
            orphans.Add CLng(citeKey) ' Add the orphan number to the collection
        End If
    Next citeKey

    Set FindOrphanCitations = orphans
    Set orphans = Nothing ' Clean up intermediate collection
End Function
'---------------------------------------------------------------------------------------

Private Sub CreateCitationHyperlinksIterativeFind(ByVal doc As Word.Document, ByVal createdBookmarks As Scripting.Dictionary, ByVal bibliographyRange As Word.Range)
'---------------------------------------------------------------------------------------
' Procedure : CreateCitationHyperlinksIterativeFind
' Author    : Gemini
' Date      : 16/04/2025
' Purpose   : Iteratively finds citations using Range.Find with wildcards,
'             parses inner text with RegExp, finds component text with Range.Find,
'             and creates hyperlinks. Skips citations found within the bibliographyRange.
' Arguments : doc - The Word Document object.
'             createdBookmarks - Dictionary of valid bookmark numbers/names.
'             bibliographyRange - The Range object representing the bibliography section (can be Nothing).
' Requires  : Microsoft VBScript Regular Expressions 5.5
' Notes     : Assumes orphan check has already passed. Handles hyphen and en dash ranges.
'---------------------------------------------------------------------------------------
    Dim regExComp As New RegExp         ' For parsing components like "1", "2-5", "9-14"
    Dim componentMatches As MatchCollection
    Dim componentMatch As match
    Dim startNum As Long
    Dim linkRange As Word.Range         ' Range of the component text (e.g., "1" or "17-19") to be linked
    Dim bookmarkTarget As String
    Dim linkText As String              ' Text of the component (e.g., "1" or "17-19")
    Dim searchRange As Word.Range       ' Range used for the main Find loop
    Dim citationContentRange As Word.Range ' Range of the currently found citation "[...]"
    Dim findCompRange As Word.Range     ' Duplicate range for finding component text within citationContentRange
    Dim innerText As String
    Dim isInsideBib As Boolean          ' Flag to check if citation is in bib
    Dim foundComp As Boolean            ' Flag for component find result
    Dim loopCounter As Long             ' Safety counter

    ' Configure component regex (now handles hyphen OR en dash)
    With regExComp
        .Global = True
        .Pattern = GetComponentPattern() ' Use function call
    End With

    ' Initialize search range for the main Find loop
    Set searchRange = doc.Content

    ' Configure Find object for finding citations "[...]" (now includes en dash via ChrW)
    With searchRange.Find
        .ClearFormatting
        .Text = GetCitationFindPattern() ' Use function call
        .Forward = True
        .Wrap = wdFindStop
        .Format = False
        .MatchCase = False ' Case irrelevant for pattern
        .MatchWholeWord = False
        .MatchSoundsLike = False
        .MatchAllWordForms = False
        .MatchWildcards = True ' IMPORTANT: Enable wildcards

        loopCounter = 0 ' Initialize loop counter
        ' Start the iterative Find loop
        Do While .Execute
            loopCounter = loopCounter + 1
            Call LogMessage("  Loop " & loopCounter & ": Find.Execute returned. Find.Found = " & searchRange.Find.found & ". Current searchRange.Start = " & searchRange.Start)

             ' *** Safety Check for Infinite Loop ***
             If loopCounter > MAX_FIND_LOOPS Then
                 Err.Raise ERR_INFINITE_LOOP, "CreateCitationHyperlinksIterativeFind (Find Loop)", _
                           "Processing stopped after exceeding maximum loop limit (" & MAX_FIND_LOOPS & "). Possible infinite loop detected."
             End If

            ' Check if Find actually found something and didn't just stop
            If searchRange.Find.found Then
                ' searchRange now represents the found citation "[...]"
                Set citationContentRange = searchRange.Duplicate ' Work with a copy

                ' --- Check if the found citation is inside the bibliography range ---
                isInsideBib = False ' Reset flag
                If Not bibliographyRange Is Nothing Then
                    ' Use InRange but handle potential errors if ranges are complex/invalid
                    On Error Resume Next
                    isInsideBib = citationContentRange.InRange(bibliographyRange)
                    If Err.Number <> 0 Then
                        Call LogMessage("Warning: Error checking if citation range (" & citationContentRange.Start & "-" & citationContentRange.End & ") is inside bibliography range (" & bibliographyRange.Start & "-" & bibliographyRange.End & "). Error: " & Err.Description & ". Assuming NOT inside.")
                        isInsideBib = False ' Assume not inside if error occurs
                        Err.Clear
                    End If
                    On Error GoTo 0
                End If
                ' --- End check ---

                If isInsideBib Then
                    ' Skip processing this citation
                    Call LogMessage("Skipping citation match within bibliography: """ & citationContentRange.Text & """ found at index " & citationContentRange.Start)
                Else
                    ' Process this citation (it's outside the bibliography)
                    Call LogMessage("Processing citation match: """ & citationContentRange.Text & """ found at index " & citationContentRange.Start)

                    ' Extract inner text (safely handle potential short strings)
                    If Len(citationContentRange.Text) > 2 Then
                        innerText = Mid(citationContentRange.Text, 2, Len(citationContentRange.Text) - 2)
                    Else
                        innerText = "" ' Handle cases like "[]" if found
                    End If
                    ' Call LogMessage("  Inner text: '" & innerText & "'") ' DEBUG Removed v2.6

                    ' Use RegExp to parse components from the inner text string
                    Set componentMatches = regExComp.Execute(innerText)
                    ' Call LogMessage("  Found " & componentMatches.Count & " component(s) in inner text.") ' DEBUG Removed v2.6

                    For Each componentMatch In componentMatches
                        startNum = CLng(componentMatch.SubMatches(0))
                        linkText = componentMatch.Value ' The text to link, e.g., "17-19" or "9-14"
                        ' Call LogMessage("    Parsing component: '" & linkText & "' (StartNum: " & startNum & ")") ' DEBUG Removed v2.6

                        ' Use a duplicate of the citation range for finding the component text
                        Set findCompRange = citationContentRange.Duplicate

                        ' Now search *within* this citation range for the specific component text
                        ' Use Find WITHOUT wildcards here
                        With findCompRange.Find
                             .ClearFormatting
                             .Text = linkText
                             .Forward = True
                             .Wrap = wdFindStop
                             .Format = False
                             .MatchCase = True ' Match exact numbers/ranges
                             .MatchWholeWord = False ' Allow finding "1" in "1, 2"
                             .MatchWildcards = False ' IMPORTANT: Disable wildcards for component search
                             .MatchSoundsLike = False
                             .MatchAllWordForms = False

                             foundComp = .Execute ' Store result

                             ' Call LogMessage("      Find component '" & linkText & "' result: " & foundComp) ' DEBUG Removed v2.6

                             If foundComp Then ' Found the exact text range for the component
                                ' If found, findCompRange object now represents the component range
                                Set linkRange = findCompRange ' Assign the found range

                                ' Get the target bookmark name
                                If createdBookmarks.Exists(startNum) Then
                                    bookmarkTarget = createdBookmarks(startNum)

                                    ' Check if this specific range already has a hyperlink
                                    Dim existingLink As Boolean
                                    existingLink = False
                                    If linkRange.Hyperlinks.Count > 0 Then
                                        If linkRange.Hyperlinks(1).SubAddress = bookmarkTarget Then
                                            existingLink = True
                                        End If
                                    End If

                                    If Not existingLink Then
                                        ' Create the hyperlink
                                        doc.Hyperlinks.Add Anchor:=linkRange, SubAddress:=bookmarkTarget
                                        Call LogMessage("  Created hyperlink for """ & linkText & """ targeting """ & bookmarkTarget & """")
                                    Else
                                         Call LogMessage("  Skipped creating duplicate hyperlink for """ & linkText & """ targeting """ & bookmarkTarget & """")
                                    End If
                                Else
                                    Call LogMessage("  Error: Bookmark for citation number " & startNum & " (text: '" & linkText & "') not found during hyperlink creation phase.")
                                End If
                             Else
                                Call LogMessage("  Warning: Could not locate component text """ & linkText & """ within citation range text: """ & citationContentRange.Text & """. Hyperlink skipped.")
                             End If
                        End With ' End With findCompRange.Find

                    Next componentMatch ' Next component within the citation
                End If ' End If isInsideBib Check

                ' --- IMPORTANT: Collapse the main search range to continue AFTER the found citation ---
                ' (Do this regardless of whether it was skipped or processed)
                searchRange.Collapse wdCollapseEnd
                Call LogMessage("  After Collapse, new searchRange.Start = " & searchRange.Start) ' Log position after collapse/set start


            Else ' .Execute returned True but .Found was False (can happen at end of range)
                 Exit Do ' Stop searching
            End If ' End If .Found
        Loop ' Loop While .Execute
    End With ' End With searchRange.Find

    ' Cleanup
    Set regExComp = Nothing
    Set componentMatches = Nothing
    Set componentMatch = Nothing
    Set linkRange = Nothing
    Set citationContentRange = Nothing
    Set searchRange = Nothing
    Set findCompRange = Nothing

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



