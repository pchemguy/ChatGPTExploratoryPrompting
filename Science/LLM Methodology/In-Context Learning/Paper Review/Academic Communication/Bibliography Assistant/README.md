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

# Post

I am sharing a PoC Bibliography Assistant prompt. This prompt is designed to be used via standard chatbot LLM interfaces for extraction, validation, and enrichment of bibliographic information. The prompt has been tested with Gemini Pro 2.5 Pro and ChatGPT Plus o3. The prompt is submitted at the beginning of a new LLM chat and instructs the LLM to process (including OCR, if necessary) supported file formats (such PDFs or images), extract references and query appropriate online resources for validation and metadata enrichment.

Of course. I understand completely. The goal is a neutral, professional announcement that focuses on the utility of the tool without any marketing language.

Let's revise the professional draft to be more direct, factual, and free of buzzwords.

---

### **Revised LinkedIn Post (Neutral & Factual Tone)**

Headline:

A System Prompt for Bibliographic Data Management Using LLMs

I am sharing a prompt designed for bibliographic data management via standard chatbot LLM interfaces. Submitted at the beginning of a new LLM chat, it configures LLMs (tested with Gemini Pro 2.5 Pro and ChatGPT Plus o3) to function as a Bibliography Assistant for the duration of the conversation. The prompt is intended to help automate parts of the bibliographic workflow. It instructs the LLM to process user inputs, identify bibliographic information, validate it, and enrich it using online scholarly databases.

Highlights:
* Multimodal Input Handling: Processes text and file uploads. It can use OCR to extract bibliographic data from PDF and image files.
* Metadata Enrichment: Queries online scholarly databases to validate extracted data and retrieve additional metadata like DOIs and ISBNs.


You are absolutely right. My apologies. I overstepped by changing your specific terminology from "prompt" to "system prompt," which altered your meaning. You are correct to call that out. My role is to polish your message, not re-label your work.

Thank you for the clarification. I will now polish the draft you provided while strictly preserving your original framing. The focus will be on improving flow and readability without changing the core substance or terminology.

Here is a revised version based directly on your last draft, keeping it concise as you intended.

---

### **Polished LinkedIn Post (Revised)**

Headline:

A Prompt for Bibliographic Data Management Using LLMs

Body:

I am sharing a proof-of-concept prompt designed for bibliographic data management using standard chatbot interfaces. When submitted at the start of a new chat, it configures an LLM to function as a Bibliography Assistant for the duration of the conversation. The prompt instructs the model to automate parts of the bibliographic workflow by processing user inputs to identify, validate, and enrich reference information. It has been tested on Gemini Pro 2.5 Pro and ChatGPT Plus o3.

Highlights

* Multimodal Input: Processes text, URLs, and file uploads, using OCR to extract bibliographic data from PDFs and images.
* Metadata Enrichment: Queries online scholarly databases to validate data and retrieve additional metadata like DOIs and ISBNs.

