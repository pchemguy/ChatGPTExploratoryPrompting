## **Chemical Formula Extraction and Validation from PDF**

Execute the following task step-by-step, using the provided PDF content:
1. Extract all chemical formulas found within the PDF.
2. For each extracted formula, identify and extract its directly associated chemical name(s) from the surrounding text, if present.
3. For each formula and its associated name(s), assess their correctness. Flag any formula/name combination that appears to contain errors.
4. For each flagged item: a. Re-verify its extraction accuracy against the source PDF. b. If an extraction error (on your part) is identified, correct the extracted item. c. Re-evaluate the (potentially corrected) item. If the error is resolved by your correction, remove the flag.
5. Create a Markdown table for all items that remain flagged. The table should include:
    - `Flagged Formula / Name(s)`: The item as extracted (and potentially corrected if it was an AI extraction error).
    - `Problem Description`: A clear explanation of the error identified in step 3.
    - `Corrected Version (if applicable)`: State the corrected formula/name if an AI extraction error was fixed in step 4b. If the flagged error is believed to be in the source document, note this (e.g., "Error appears in source").
    - `Reference Location in PDF`: Specific location details (e.g., page number, paragraph, or table).
