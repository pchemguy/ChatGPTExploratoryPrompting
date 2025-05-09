## **Chemical Formula Extraction and Validation from PDF**

Execute the following task step-by-step:
1. Extract chemical formulas of each and every chemical species containing at least two elements EXACTLY as they appear in the attached PDF.
2. For each extracted chemical formula generate associated name.
3. Convert each generated name to generated chemical formula.
4. For each generated chemical formula, determine if it matches previously extracted formula.



5. For each extracted formula, extract every directly associated chemical name included in the text, if any.
6. For each extracted formula and any associated names use the following algorithm to verify correctness:
    1. If there are any extracted names:
        1. Use these names to generate the corresponding chemical formula. DO NOT COPY extracted formula.
7. Create a Markdown table that should include every 
    - `Extracted Formula:` **exactly as extracted from text**.
    - `Extracted Names:` **exactly as extracted from text**.
    - `Generated Formula`
    - `Validation:`
        - Green checkmark if generated and extracted formulas match.
        - Red cross, if  generated and extracted formulas do not match.
        - Blank, if no formula has been generated.



## **Chemical Formula Extraction and Validation from PDF**

Execute the following task step-by-step:
1. Extract each and every chemical formula from the attached PDF.
2. For each extracted formula, extract every directly associated chemical name included in the text, if any.
3. For each extracted formula and any associated names use the following algorithm to verify correctness:
    1. If there are any extracted names:
        1. Use these names to generate the corresponding chemical formula. DO NOT COPY extracted formula.
        2. 
4. For each extracted formula and associated names, consider if the chemical formula and associated names are correct and flag every formula/names combination that contains any errors.
5. Create a Markdown table that should include every flagged formula/names, clear description of any problems, corrected version, and clear reference location of the flagged items.


## **Chemical Formula Extraction and Validation from PDF**

  

Execute the following task step-by-step:
1. Scan entire document, including figures, and extract each and every chemical formula containing at least two elements from the attached PDF EXACTLY as it appears in text or in figures.
2. For each extracted formula, extract every directly associated chemical name included in the text, if any.
3. For each extracted formula and associated names, consider if the chemical formula EXACTLY as it appears in text and associated names are correct and match; flag every formula/names combination that contains any errors.
4. Create a Markdown table that should include every flagged formula/names, clear description of any problems, corrected version, and clear reference location of the flagged items.



Execute the following task step-by-step:
1. Scan entire document, including figures, and extract each and every chemical formula containing at least two elements from the attached PDF EXACTLY as it appears in text or in figures.
2. For each extracted formula, extract every directly associated chemical name included in the text, if any.
3. For each extracted name generate associated chemical formula. **Do not use formula found in the documented!**
4. Compare each generated and extracted formula (ignore isotopic labels) and flag all mismatched pairs.

5. For each extracted formula and associated names, consider if the chemical formula EXACTLY as it appears in text and associated names are correct and match; flag every formula/names combination that contains any errors.
6. Create a Markdown table that should include every formula from `Point 1`, names names from `Point 2`, clear description of any problems (or empty cell if no problem has been identified), corrected formula (green check mark if no problem has been identified), and clear  location reference.


## Chats

https://gemini.google.com/app/da2c372e442f898c
