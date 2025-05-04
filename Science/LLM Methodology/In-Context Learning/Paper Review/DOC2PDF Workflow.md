# Workflow for Converting the Source DOC File to PDF

1. Update Zotero references / bibliography.
2. Execute macro generating hyperlinks for in-text citations and DOI hyperlinks in bibliography.
3. Execute macro for generating / updating in-text cross-references.
4. Open the DOC file in Word 2007+ and save it in the DOCX format (this step is necessary, if direct export of PDF from the newer Word creates broken bookmarks).
5. Open DOCX in LibreOffice and save as ODT.
6. Make sure the hidden text is displayed.
7. Use S&R with RegEx to strip the markup (first `\{\{(BMK|LNK): #[0-9A-Za-z_]{1,40}\}\}`, then `\{\{|\}\}`).
8. Check for leftover Markdown markup and em dashes
```
[ ][_*`]
—
```
9. Page formatting in `Format -> Page Style OR Alt-O -> P OR Alt-Shift-P`
10. Hidden text display in `Options -> LibreOffice Writer -> View`
11. Formatting marks / non-printable characters display - `Ctrl-F10`
12. Export as PDF `File -> Export As -> Export as PDF...` (verify initial view and links settings).
13. May need to remove unnecessary bookmarks in the PDF or add custom properties, if desired.
