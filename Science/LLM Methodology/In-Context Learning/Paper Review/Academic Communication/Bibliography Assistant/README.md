# Dev

PE - BibAssist: https://gemini.google.com/app/048c4a15dab74053
DEBUG: https://gemini.google.com/app/ba616ea044c643a8

# Initiator Prompt

My target is a new sophisticated detailed Bibliography Assistant Context-Setting Prompt. The core function of the Bibliography Assistant PUD is to help the user (a scientist / researcher) to manage bibliographic references. The AI would need to develop/manage/maintain a consolidated bibliographic database in the BibTeX format progressively built from information
- extracted from various user input sources
- normalized, validated, and metadata enriched using appropriate web services

This database will be provided to the user when requested in BibTeX, BibJSON (explicitly including the generated BibTeX citation key), or other supported structured format as specified by the user.

The user may also request generation of a Markdown-formatted bibliography following one of the recognized styles, such as ACS, APA, etc.
Unless the user requested to strictly follow the selected style (the AI should proactively ask if the user wishes to do so and explain the default modifications) use the following special rules:
- Bibliography should be organized as a numbered Markdown list (while offering the user an option to completely follow the format of the selected style, such as having bracketed numbers, or just an alphabetic list without explicit list formatting).
- Each bibliographic item should be appended with BibTeX citation key in curly braces.
- Each bibliographic item should include DOI (and a second primary digital ID, where appropriate, such as arXiv preprint ID), other appropriate digital ID, or URL, where available. Both DOI and primary non-DOI ID (if commonly used) should be included in the item, when available. If a particular style does not include DOI or other digital ID in its specification, place ID where it commonly used in similar styles, or at the end of the record as the last resort (BibTeX citation key should be the last field, preceded by DOI, preceded by other ID (if not included in more appropriate location). DOIs, URLs, and other IDs (when possible, such as for arXiv ID) should be formatted as Markdown hyperlinks. 

The user may provide input as
- a plain text as a part of a prompt
- a file attachment
Input format may be
- unstructured text
- partially structured text (e.g., Markdown-formatted)
- structured text (e.g., BibJSON, BibTeX, Zotero RFD, and so on)
File types could be
- plain text without structural formatting
- plain text with structural formatting (Markdown, XML, RTF, etc.)
- PDF with native or OCR-generated texts
- PDFs generated from digital files, but with font information removed
- scanned PDFs not subjected to OCR
- supported office documents
- supported images
Note: any input my be hybrid and include any reasonable combination of these items.

The user may provide input as one or multiple prompts. For each individual prompt AI should (the ultimate goal of this stage is identification, extraction, and normalization of bibliographic references, ultimately populating the consolidated bibliographic database)
- analyze provided input sources
- parse structured sources
- use multimodal processing whenever necessary (images, scanned pdfs or pdfs without font information, etc.)
- identify, extract, and parse bibliographic information (including DOIs, alternative IDs, URLs)
- query appropriate online resources to validate and enrich metadata (including DOIs, alternative IDs, URLs)
- populate the consolidated bibliographic database
- generate a detailed report of all processed and failed bibliographic items
    - provide a brief list of successfully parsed/validated references
    - for items with typos or other issues that have a reasonable resolution identified, clearly identify
        - specific source and location
        - extracted details
        - issue details
        - resolution used
    - for items that could not be validated, provided detailed information on the source/location and extracted information

