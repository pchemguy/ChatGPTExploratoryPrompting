Attribute VB_Name = "modAutoBookmarkAndLink"
'@Folder("Project")
Option Explicit

'---------------------------------------------------------------------------------------
' Module    : modMarkupProcessor
' Author    : Gemini
' Date      : 18/04/2025
' Version   : 3.4
' Purpose   : Processes patterns like {{Visible Text}}{{BMK:BookmarkName}} and
'             {{LinkText}}{{LNK:TargetName}} within a document or selection.
'             Validates formatting (hidden braces, visible text, hidden marker) and names.
'             Pass 1: Deletes previous items based on surrounding hidden braces,
'                     then creates new bookmarks defined by BMK patterns.
'             Pass 2: Creates hyperlinks defined by LNK patterns, targeting bookmarks
'                     (typically those created in Pass 1 or existing ones).
'             Temporarily shows hidden text if needed and restores setting on exit.
' Usage     : Optionally select text to process, otherwise runs on whole document.
'             Run the ProcessMarkup macro.
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
'           : v2.8 - Shortened TEMP_LNK_ANCHOR_PREFIX to TMP_ per user request. Renamed TMP_ANCHOR_.
'           : v3.0 - Removed BOOKMARK_PREFIX ("AUTO_"). Bookmarks/links use exact name.
'                  - Changed MAX_NAME_LEN to 40.
'                  - Reworked Step 2 cleanup: Delete bookmarks/hyperlinks only if their
'                    range is surrounded by hidden {{ and }}. Uses new helper function.
'                  - Updated bookmark/hyperlink creation to use non-prefixed names.
'           : v3.1 - Changed Step 3 (Pass 1) finding mechanism from Range.Find with Wildcards
'                    to iterating Paragraphs + VBA RegExp matching, due to Find unreliability.
'           : v3.2 - Refined RegExp pattern to use [^}]+ instead of .*? for content matching.
'           : v3.3 - Added logic to check/store/show hidden text status and restore on exit.
'           : v3.4 - Changed temporary bookmark naming for LNK anchors to use a
'                    sequential counter (TMP_ANCHOR_#) instead of start position for uniqueness.
'---------------------------------------------------------------------------------------
' References:
'   - Microsoft Word XX.X Object Library
'   - Microsoft VBScript Regular Expressions 5.5
'   - Microsoft Scripting Runtime
'---------------------------------------------------------------------------------------

'--- Constants ---
' Private Const BOOKMARK_PREFIX As String = "AUTO_" ' Removed v3.0
Private Const TEMP_ANCHOR_PREFIX As String = "TMP_ANCHOR_" ' Prefix for temporary bookmarks (used for LNK anchors)
Private Const HIDDEN_BMK_MARKER As String = "{{BMK:"
Private Const HIDDEN_LNK_MARKER As String = "{{LNK:"
Private Const MAX_NAME_LEN As Long = 40 ' Max length for bookmark/link target names (Increased v3.0)
' Private Const MAX_FIND_LOOPS As Long = 10000 ' No longer needed for Find loop
Private Const MAX_ITEMS_IN_MSG As Long = 10  ' Max validation failures listed in MsgBox

'--- Error Numbers ---
Private Const ERR_VALIDATION_FAILED As Long = vbObjectError + 3001 ' Custom base for this macro
Private Const ERR_BOOKMARK_EXISTS As Long = vbObjectError + 3002
' Private Const ERR_INFINITE_LOOP As Long = vbObjectError + 3003 ' No longer needed
Private Const ERR_DOC_NOT_SAVED As Long = vbObjectError + 3004 ' For file logging
Private Const ERR_TARGET_BOOKMARK_MISSING As Long = vbObjectError + 3005
Private Const ERR_REGEX_ERROR As Long = vbObjectError + 3006 ' Added for RegExp errors


'--- Module Level Variables for Logging ---
Private m_LogFileNum As Integer
Private m_LogFilePath As String
Private m_LoggingEnabled As Boolean


'=======================================================================================
'   PATTERN GENERATING / VALIDATION FUNCTIONS
'=======================================================================================

Private Function GetPattern_RegExpAdjacentBraces() As String
' Returns the RegExp pattern to find two adjacent {{...}} blocks.
' Uses [^}]+ to match 1 or more non-} characters inside braces.
' RegExp Pattern: \{\{[^}]+\}\}\{\{[^}]+\}\}
    GetPattern_RegExpAdjacentBraces = "\{\{[^}]+\}\}\{\{[^}]+\}\}" ' Refined v3.2
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

Public Sub ProcessMarkup() ' Renamed Sub
'---------------------------------------------------------------------------------------
' Procedure : ProcessMarkup
' Author    : Gemini
' Date      : 18/04/2025
' Purpose   : Main routine to delete old markup bookmarks/hyperlinks (based on
'             surrounding hidden braces) and create new ones based on validated
'             {{Visible}}{{BMK/LNK:HiddenName}} patterns. Uses a two-pass approach.
'---------------------------------------------------------------------------------------
    Dim doc As Word.Document
    Dim rngSearchScope As Word.Range    ' Range to search (Selection or Document)
    ' Dim searchRange As Word.Range       ' No longer needed for Find loop
    Dim para As Word.Paragraph          ' For looping through paragraphs
    Dim paraText As String              ' Text of current paragraph
    Dim regExFinder As RegExp           ' RegExp for finding pattern in paragraph
    Dim foundMatches As MatchCollection ' Matches found by regExFinder
    Dim foundMatch As match             ' Individual match
    Dim matchStart As Long              ' Start position of match within document
    Dim matchEnd As Long                ' End position of match within document
    Dim foundRange As Word.Range        ' Range of the specific match found by RegExp
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
    Dim lngTempBookmarkCounter As Long  ' *** Counter for temporary bookmarks ***
    Dim strFoundText As String
    ' Dim strPart1Text As String        ' Not needed directly
    Dim strPart2Text As String
    Dim strExtractedName As String      ' Generic name extracted
    Dim strNewBookmarkName As String    ' For BMK type (no prefix)
    Dim strTargetBookmark As String     ' For LNK type target bookmark name (no prefix)
    Dim tempAnchorBookmarkName As String ' For LNK type temporary anchor bookmark
    Dim strFailureReason As String
    Dim strMsg As String
    Dim targetAddress As String         ' For reading hyperlink subaddress safely
    Dim markerType As String            ' "BMK" or "LNK"
    Dim splitPos As Long
    ' Dim loopCounter As Long             ' No longer needed for Find loop
    Dim i As Long                       ' Loop counter for deleting bookmarks/hyperlinks
    Dim k As Long                       ' Loop counter for message box
    Dim displayCount As Long
    Dim existingHl As Hyperlink         ' For checking existing hyperlinks
    Dim isValidFormat As Boolean
    Dim isValidName As Boolean
    Dim originalShowHidden As Boolean   ' Store initial hidden text view state

    On Error GoTo ErrorHandler
    Application.ScreenUpdating = False
    Call SetupLogFile(ActiveDocument) ' Initialize file logging
    Call LogMessage(vbCrLf & "--- Starting ProcessMarkup at " & Now & " ---")

    Set doc = ActiveDocument

    ' Store and optionally set ShowHiddenText
    originalShowHidden = ActiveWindow.View.ShowHiddenText
    If Not originalShowHidden Then
        ActiveWindow.View.ShowHiddenText = True
        Call LogMessage("Temporarily enabled ShowHiddenText.")
    End If

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
    lngTempBookmarkCounter = 0 ' *** Initialize temp bookmark counter ***
    Set colLnkData = New Collection
    ' arrValidationFailures is initialized implicitly when first ReDim'd

    ' 2. Delete Existing Items based on surrounding hidden braces
    Call LogMessage("Step 2: Deleting existing bookmarks/hyperlinks surrounded by hidden {{}}...")

    ' Delete Hyperlinks surrounded by {{}}
    Call LogMessage("  Checking existing hyperlinks...")
    lngDeletedHlCount = 0
    For i = doc.Hyperlinks.Count To 1 Step -1
        Set hl = doc.Hyperlinks(i)
        If IsRangeSurroundedByHiddenBraces(hl.Range) Then
             Call LogMessage("  Deleting hyperlink on text '" & hl.Range.Text & "' (surrounded by hidden braces)")
             hl.Delete
             lngDeletedHlCount = lngDeletedHlCount + 1
        End If
    Next i
    Call LogMessage("  Deleted " & lngDeletedHlCount & " existing hyperlinks based on surrounding braces.")
    Set hl = Nothing

    ' Delete Bookmarks surrounded by {{}} (including Temp anchors)
    Call LogMessage("  Checking existing bookmarks...")
    lngDeletedBmCount = 0
    For i = doc.Bookmarks.Count To 1 Step -1
        Set bm = doc.Bookmarks(i)
        ' Also delete leftover Temp bookmarks regardless of braces
        If bm.Name Like TEMP_ANCHOR_PREFIX & "*" Then
             Call LogMessage("  Deleting leftover temporary bookmark: " & bm.Name)
             bm.Delete
             lngDeletedBmCount = lngDeletedBmCount + 1 ' Count as deleted
        ElseIf IsRangeSurroundedByHiddenBraces(bm.Range) Then
             Call LogMessage("  Deleting bookmark '" & bm.Name & "' (surrounded by hidden braces)")
             bm.Delete
             lngDeletedBmCount = lngDeletedBmCount + 1
        End If
    Next i
    Call LogMessage("  Deleted " & lngDeletedBmCount & " existing bookmarks based on surrounding braces or Temp prefix.")
    Set bm = Nothing

    ' 3. PASS 1: Find Patterns (RegExp), Validate, Create Bookmarks, Store Link Data
    Call LogMessage("Step 3 (Pass 1): Finding patterns (RegExp), validating, creating bookmarks...")
    ' Setup RegExp objects
    On Error Resume Next ' Handle potential error creating RegExp object
    Set regExFinder = New RegExp
    Set regExpNameValidator = New RegExp
    If Err.Number <> 0 Then
        Call LogMessage("ERROR: Could not create RegExp object. Check References (Microsoft VBScript Regular Expressions 5.5). Error: " & Err.Description)
        Err.Clear
        GoTo CleanUp ' Exit if RegExp cannot be created
    End If
    On Error GoTo ErrorHandler ' Restore normal error handling

    With regExFinder
        .Pattern = GetPattern_RegExpAdjacentBraces() ' Use RegExp pattern
        .Global = True  ' Find all occurrences in paragraph
        .MultiLine = False
        .IgnoreCase = False
    End With
    With regExpNameValidator
        .Pattern = GetPattern_ValidateName()
        .Global = False
        .IgnoreCase = False
    End With

    ' Loop through paragraphs in the search scope
    For Each para In rngSearchScope.Paragraphs
        paraText = para.Range.Text
        Set foundMatches = regExFinder.Execute(paraText)

        If foundMatches.Count > 0 Then
             Call LogMessage("  Found " & foundMatches.Count & " potential pattern(s) in paragraph starting at " & para.Range.Start)
        End If

        For Each foundMatch In foundMatches
            strFoundText = foundMatch.Value
            matchStart = para.Range.Start + foundMatch.FirstIndex
            matchEnd = matchStart + foundMatch.Length
            Set foundRange = doc.Range(matchStart, matchEnd)

            Call LogMessage("    Processing potential pattern: '" & Left(strFoundText, 50) & "...' at Range(" & foundRange.Start & ", " & foundRange.End & ")")

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
                                Call LogMessage("      Validation passed for type '" & markerType & "', name '" & strExtractedName & "'")

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
                                        ' --- Create Bookmark (No Prefix) ---
                                        strNewBookmarkName = strExtractedName ' Use exact name
                                        If doc.Bookmarks.Exists(strNewBookmarkName) Then
                                            strFailureReason = "Bookmark '" & strNewBookmarkName & "' already exists. Skipped."
                                            Call LogMessage("      " & strFailureReason)
                                        Else
                                            doc.Bookmarks.Add Name:=strNewBookmarkName, Range:=targetRange
                                            lngBmCreatedCount = lngBmCreatedCount + 1
                                            Call LogMessage("      Created bookmark: '" & strNewBookmarkName & "' around text: '" & targetRange.Text & "'")
                                        End If
                                    Else ' markerType = "LNK"
                                        ' --- Store Link Data for Pass 2 using Temp Bookmark ---
                                        strTargetBookmark = strExtractedName ' Target name (No Prefix)
                                        ' Create unique temp name using counter
                                        lngTempBookmarkCounter = lngTempBookmarkCounter + 1 ' *** Increment counter ***
                                        tempAnchorBookmarkName = TEMP_ANCHOR_PREFIX & lngTempBookmarkCounter ' *** Use counter ***
                                        ' Add temporary bookmark to anchor range
                                        On Error Resume Next
                                        ' Delete if somehow exists from prior failed run
                                        If doc.Bookmarks.Exists(tempAnchorBookmarkName) Then doc.Bookmarks(tempAnchorBookmarkName).Delete
                                        doc.Bookmarks.Add Name:=tempAnchorBookmarkName, Range:=targetRange
                                        If Err.Number <> 0 Then
                                             strFailureReason = "Error creating temporary bookmark '" & tempAnchorBookmarkName & "'. Err: " & Err.Description
                                             Call LogMessage("      " & strFailureReason)
                                             Err.Clear
                                        Else
                                             ' Store Temp Anchor Name, Target Bookmark Name
                                             lnkInfo = Array(tempAnchorBookmarkName, strTargetBookmark)
                                             colLnkData.Add lnkInfo
                                             Call LogMessage("      Stored LNK data using temp bookmark '" & tempAnchorBookmarkName & "' for target '" & strTargetBookmark & "'")
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
            ' Release ranges for this match
            Set rngPart1 = Nothing
            Set rngPart2 = Nothing
            Set foundRange = Nothing
            Set targetRange = Nothing
        Next foundMatch ' Next match in paragraph
        Set foundMatches = Nothing
    Next para ' Next paragraph

    Call LogMessage("Step 3 (Pass 1) finished.")
    Set regExFinder = Nothing
    Set regExpNameValidator = Nothing

    ' 4. PASS 2: Create Hyperlinks from Stored Data
    Call LogMessage("Step 4 (Pass 2): Creating hyperlinks from stored LNK data...")
    If colLnkData.Count > 0 Then
        For Each lnkInfo In colLnkData
            tempAnchorBookmarkName = lnkInfo(0)
            strTargetBookmark = lnkInfo(1) ' Target name has no prefix
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
    ' Restore original hidden text view state IF it was changed
    If Not originalShowHidden Then
        If ActiveWindow.View.ShowHiddenText <> originalShowHidden Then
            ActiveWindow.View.ShowHiddenText = originalShowHidden
            Call LogMessage("Restored original ShowHiddenText state (False).")
        End If
    End If
    Application.ScreenUpdating = True
    ' Release objects
    Set doc = Nothing
    Set rngSearchScope = Nothing
    ' Set searchRange = Nothing ' Not used in this version
    Set para = Nothing
    Set regExFinder = Nothing
    Set foundMatches = Nothing
    Set foundMatch = Nothing
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
                 "Deleted Hyperlinks (Surrounded by {{}}): " & lngDeletedHlCount & vbCrLf & _
                 "Deleted Bookmarks (Surrounded by {{}} or Temp): " & lngDeletedBmCount & vbCrLf & _
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

    Call LogMessage("--- Finished ProcessMarkup at " & Now & " ---")
    On Error GoTo 0
    Exit Sub

    ' 6. Error Handling
ErrorHandler:
    Dim lngErrNum As Long: lngErrNum = Err.Number
    Dim strErrDesc As String: strErrDesc = Err.Description
    Call LogMessage("!!! MACRO ERROR: " & lngErrNum & " - " & strErrDesc & " !!!") ' Log error

    ' --- Attempt Cleanup within Error Handler ---
    On Error Resume Next ' Prevent error during cleanup hiding original error
     ' Restore original hidden text view state IF it was changed
    If Not originalShowHidden Then
        If ActiveWindow.View.ShowHiddenText <> originalShowHidden Then
            ActiveWindow.View.ShowHiddenText = originalShowHidden
            Call LogMessage("Restored original ShowHiddenText state (False) after error.")
        End If
    End If
    Application.ScreenUpdating = True
    ' Release objects
    Set doc = Nothing
    Set rngSearchScope = Nothing
    ' Set searchRange = Nothing ' Not used in this version
    Set para = Nothing
    Set regExFinder = Nothing
    Set foundMatches = Nothing
    Set foundMatch = Nothing
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

Private Function IsRangeSurroundedByHiddenBraces(rng As Word.Range) As Boolean
'---------------------------------------------------------------------------------------
' Function: IsRangeSurroundedByHiddenBraces
' Purpose: Checks if the two characters immediately before and after a given range
'          are "{{" and "}}" respectively, AND if those brace characters are hidden.
' Returns: True if surrounded by hidden braces, False otherwise.
' Notes:   Handles potential errors near document boundaries.
'---------------------------------------------------------------------------------------
    Dim rngBefore As Word.Range
    Dim rngAfter As Word.Range
    Dim isSurrounded As Boolean
    isSurrounded = False ' Default

    On Error GoTo CheckBraces_Error

    ' Check if range is too close to document start or end
    If rng Is Nothing Then GoTo CheckBraces_Exit
    If rng.Start < 2 Then GoTo CheckBraces_Exit
    If rng.End > rng.Document.Content.End - 2 Then GoTo CheckBraces_Exit

    ' Define ranges for braces
    Set rngBefore = rng.Document.Range(rng.Start - 2, rng.Start)
    Set rngAfter = rng.Document.Range(rng.End, rng.End + 2)

    ' Perform checks
    If rngBefore.Text = "{{" And rngBefore.Font.Hidden = True Then
        If rngAfter.Text = "}}" And rngAfter.Font.Hidden = True Then
            isSurrounded = True
        End If
    End If

CheckBraces_Exit:
    IsRangeSurroundedByHiddenBraces = isSurrounded
    Set rngBefore = Nothing
    Set rngAfter = Nothing
    Exit Function

CheckBraces_Error:
    Call LogMessage("Error in IsRangeSurroundedByHiddenBraces for range (" & rng.Start & "," & rng.End & "): " & Err.Description)
    Resume CheckBraces_Exit ' Return False on error

End Function
'---------------------------------------------------------------------------------------


