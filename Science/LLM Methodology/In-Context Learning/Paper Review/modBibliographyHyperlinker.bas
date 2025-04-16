Attribute VB_Name = "modBibliographyHyperlinker"
'@Folder("Project")
Option Explicit

'---------------------------------------------------------------------------------------
' Module    : modBibliographyHyperlinker
' Author    : Gemini
' Date      : 16/04/2025
' Version   : 2.6
' Purpose   : Creates internal hyperlinks from in-text bibliography citations
'             (e.g., [1], [2, 3], [4-6], [9-14]) to corresponding bibliography entries
'             marked with bookmarks (BIB_1, BIB_2, etc.). Handles hyphen and en dash ranges.
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
'                    citations found within the bibliography range itself.
'           : v2.1 - Updated citation patterns (Wildcard Find, Component RegExp, Validation RegExp)
'                    to handle en dash in addition to hyphen (-) for ranges.
'           : v2.2 - Replaced literal en dash character in patterns with ChrW(8211).
'                  - Added detailed logging for component parsing/finding.
'           : v2.3 - Replaced literal en dash character in comments/text with hyphen or description.
'           : v2.4 - Replaced Const pattern definitions using ChrW with Private Functions
'                    to avoid VBA compile error ("Constant expression required").
'           : v2.5 - Reorganized module structure: Constants grouped at top.
'           : v2.6 - Removed extra debug logging from hyperlink creation step (Step 4).
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

'--- Error Numbers ---
Private Const ERR_BIB_FIELD_NOT_FOUND As Long = vbObjectError + 1001
Private Const ERR_ORPHAN_CITATIONS As Long = vbObjectError + 1002
Private Const ERR_REGEX_ERROR As Long = vbObjectError + 1003
Private Const ERR_DOC_NOT_SAVED As Long = vbObjectError + 1004 ' For file logging


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
        Err.Raise Err.Number, "CreateBibliographyHyperlinks (Object Creation)", "Required object could not be created. Check VBA References (Microsoft VBScript Regular Expressions 5.5, Microsoft Scripting Runtime)."
    End If
    On Error GoTo ErrorHandler ' Restore error handling

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
    Exit Sub

ErrorHandler:
    Dim ErrMsg As String
    ErrMsg = "Error " & Err.Number & " (" & Err.Description & ") in module " & Err.Source & "."
    Call LogMessage("!!! MACRO ERROR: " & ErrMsg & " !!!") ' Log the error
    Call LogMessage("CreateBibliographyHyperlinks finished with ERROR at " & Format(Now, "yyyy-mm-dd hh:nn:ss"))
    Call LogMessage("------------------------------------------------------------")
    MsgBox ErrMsg, vbCritical, "Macro Error"
    ' Ensure log file is closed even if an error occurred
    On Error Resume Next ' Prevent error in cleanup from hiding original error
    Call CloseLogFile
    On Error GoTo 0
    ' Perform any necessary cleanup specific to the error handler if needed
    GoTo ProcedureExit ' Exit after handling error (log file already closed)

End Sub


'=======================================================================================
'   PATTERN GENERATING FUNCTIONS (Replaced Constants using ChrW)
'=======================================================================================

Private Function GetCitationFindPattern() As String
' Returns the Wildcard pattern for Word's Find to locate citations
' Handles digits, comma, hyphen, en dash within brackets
    GetCitationFindPattern = "\[[0-9,-" & ChrW(8211) & "]@\]"
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

    m_LoggingEnabled = False ' Assume failure initially
    m_LogFileNum = 0

    ' Check if document is saved
    docPath = ""
    On Error Resume Next ' Handle error if document properties not available
    docPath = doc.Path
    On Error GoTo 0
    If docPath = "" Then
        Err.Raise ERR_DOC_NOT_SAVED, "SetupLogFile", _
                  "Document must be saved before logging can be enabled."
        Exit Sub ' Should not be reached due to Err.Raise
    End If

    ' Create FileSystemObject
    On Error Resume Next ' Handle FSO creation error (e.g., scripting disabled)
    Set fso = CreateObject("Scripting.FileSystemObject")
    If Err.Number <> 0 Then
        MsgBox "Could not create FileSystemObject. Logging to file disabled." & vbCrLf & _
               "Ensure 'Microsoft Scripting Runtime' reference is enabled and scripting is allowed.", vbExclamation
        Exit Sub ' Cannot proceed with file logging
    End If
    On Error GoTo 0 ' Restore error handling

    ' Construct log file path
    baseName = fso.GetBaseName(doc.Name)
    m_LogFilePath = fso.BuildPath(docPath, baseName & ".log")

    ' Get a free file handle and open the file for output (overwrite)
    On Error Resume Next ' Handle file access errors
    m_LogFileNum = FreeFile
    Open m_LogFilePath For Output As #m_LogFileNum
    If Err.Number <> 0 Then
        m_LogFileNum = 0 ' Reset file number
        MsgBox "Could not open log file for writing:" & vbCrLf & m_LogFilePath & vbCrLf & _
               "Error: " & Err.Description & vbCrLf & _
               "Logging to file disabled.", vbExclamation
        m_LogFilePath = ""
        Exit Sub ' Cannot proceed with file logging
    End If
    On Error GoTo 0 ' Restore error handling

    m_LoggingEnabled = True ' Logging is now active
    ' Write header
    Print #m_LogFileNum, "Log File for: " & doc.FullName
    Print #m_LogFileNum, "Macro Run Started: " & Format(Now, "yyyy-mm-dd hh:nn:ss")
    Print #m_LogFileNum, String(70, "-") ' Separator line

    Set fso = Nothing
End Sub
'---------------------------------------------------------------------------------------

Private Sub LogMessage(ByVal message As String)
'---------------------------------------------------------------------------------------
' Procedure : LogMessage
' Purpose   : Writes a message to the initialized log file, if enabled.
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
        Debug.Print message
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
'             Uses Collapse/MoveStart/MoveEnd to define bookmark range.
' Arguments : bibRange - The Word.Range object containing the bibliography entries.
' Returns   : A Scripting.Dictionary where Key=Bibliography Number (Long), Value=Bookmark Name (String).
' Requires  : Microsoft VBScript Regular Expressions 5.5, Microsoft Scripting Runtime
'---------------------------------------------------------------------------------------
    Dim para As Word.Paragraph
    Dim regEx As RegExp
    Dim matches As MatchCollection
    Dim match As match
    Dim bibNum As Long
    Dim bookmarkName As String
    Dim bookmarkRange As Word.Range
    Dim dictBookmarks As Scripting.Dictionary
    Dim paraText As String
    Dim matchText As String
    Dim bracketPos As Long
    Dim numLen As Integer
    Dim offsetToBracket As Long ' Characters from para start to '['

    Set dictBookmarks = New Scripting.Dictionary
    Set regEx = New RegExp

    ' Configure RegExp to find optional \f then "[#]{TAB}" at the start of a line
    With regEx
        .Pattern = BIB_ENTRY_PATTERN ' Uses "\f?\[(\d+)\]{TAB}"
        .Global = False ' Only find the first match per paragraph
        .MultiLine = False ' Check start of paragraph text
        .IgnoreCase = False
    End With

    ' Iterate through each paragraph in the bibliography range
    For Each para In bibRange.Paragraphs
        paraText = para.Range.Text ' Get text of the paragraph
        Set matches = regEx.Execute(paraText)

        If matches.Count > 0 Then
            Set match = matches(0)
            ' Extract the number (Group 1 of the pattern)
            bibNum = CLng(match.SubMatches(0))
            bookmarkName = BIB_BOOKMARK_PREFIX & bibNum
            matchText = match.Value ' Full matched text, e.g. "\f[7]\t" or "[7]\t"

            ' Find the starting position of '[' within the matched text
            bracketPos = InStr(1, matchText, "[")

            If bracketPos > 0 Then
                ' Calculate offset needed to move start point
                numLen = Len(match.SubMatches(0))
                offsetToBracket = match.FirstIndex + bracketPos - 1

                ' *** Define range using Collapse/MoveStart/MoveEnd ***
                Set bookmarkRange = para.Range.Duplicate ' Work on a copy
                bookmarkRange.Collapse wdCollapseStart     ' Go to start of paragraph
                bookmarkRange.MoveStart Unit:=wdCharacter, Count:=offsetToBracket ' Move start to '['
                bookmarkRange.MoveEnd Unit:=wdCharacter, Count:=numLen + 2       ' Move end past ']'
                ' *** End new range definition ***

            Else
                 Call LogMessage("Warning: Could not find '[' in matched text '" & matchText & "' for bibNum " & bibNum & ". Skipping bookmark.")
                 GoTo NextPara ' Skip to next paragraph if pattern match is unexpected
            End If

            ' Check if bookmark already exists (shouldn't due to cleanup, but good practice)
            If Not ActiveDocument.Bookmarks.Exists(bookmarkName) Then
                 ' Add the bookmark using the range defined by MoveStart/MoveEnd
                ActiveDocument.Bookmarks.Add Name:=bookmarkName, Range:=bookmarkRange
                ' Store in dictionary if successful
                If Not dictBookmarks.Exists(bibNum) Then
                    dictBookmarks.Add bibNum, bookmarkName
                    ' Log the actual text covered by the final range
                    Call LogMessage("Created bookmark: " & bookmarkName & " covering range text: '" & bookmarkRange.Text & "'")
                Else
                    Call LogMessage("Warning: Duplicate bibliography number found and ignored: " & bibNum)
                End If
            Else
                 Call LogMessage("Warning: Bookmark '" & bookmarkName & "' unexpectedly already exists. Skipped.")
            End If
        End If
NextPara:
    Next para

    Set CreateBibliographyBookmarks = dictBookmarks

    ' Cleanup
    Set para = Nothing
    Set regEx = Nothing
    Set matches = Nothing
    Set match = Nothing
    Set bookmarkRange = Nothing
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

        ' Start the iterative Find loop
        Do While .Execute
            ' Check if Find actually found something and didn't just stop
            If searchRange.Find.Found Then
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

