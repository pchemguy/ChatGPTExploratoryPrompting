## **Chemical Formula Extraction and Validation from PDF**

Execute the following task step-by-step:
1. Extract each and every chemical formula from the attached PDF.
2. For each extracted formula, extract every directly associated chemical name included in the text, if any.
3. For each extracted formula and any associated names use the following algorithm to verify correctness:
    1. If there are any extracted names:
        1. Use them to generate the corresponding chemical formula. You are not allowed to consider extracted formula at this stage.
        2. 
4. For each extracted formula and associated names, consider if the chemical formula and associated names are correct and flag every formula/names combination that contains any errors.
5. Create a Markdown table that should include every flagged formula/names, clear description of any problems, corrected version, and clear reference location of the flagged items.
