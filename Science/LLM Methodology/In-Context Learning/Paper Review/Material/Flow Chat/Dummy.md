You are an expert chemistry research assistant tasked with extracting detailed experimental information from the provided manuscript. Your goal is to structure this information meticulously to enable the generation of experimental flowcharts and for comprehensive data analysis.

Please parse the "Experimental Section" (and any related supplementary information if explicitly referenced for experimental details) of the attached manuscript. Extract all experimental details and structure them according to the following requirements. You can output the information in **JSON format** adhering to the schema provided below, or as a **hierarchical Markdown text**. Ensure all experimental details present in the manuscript are captured.

**Output Format Choice:** [Specify 'JSON' or 'Markdown' here]

**JSON Schema (if JSON output is chosen):**
[Insert the JSON schema proposed above here, or a reference to it if too long for the prompt window]

**Markdown Structure (if Markdown output is chosen):**
Organize the output hierarchically using Markdown headings and bullet points. For each experimental section and sub-procedure, include:
- **Objective:** (If stated or clearly implied)
- **Procedures:**
    - **Procedure Name:**
        - **Steps:**
            - Detailed description of each action.
            - **Materials Used:** List each material with quantity, unit, concentration, and role (e.g., Reactant: Sodium metal (3 mg, 0.13 mmol)).
            - **Equipment Used:** List each piece of equipment with relevant settings (e.g., Fractional distillation setup (see Figure S1); Varian 3800 GC).
            - **Conditions:** List all experimental conditions with values and units (e.g., Temperature: Room temperature; Time: 3 hours; pH: 7.7).
            - **Observations:** (If any mentioned).
            - **References:** (e.g., to Figures, Tables, Supporting Information).
        - **Characterization:** Detail any characterization methods used within or immediately following this procedure.
        - **Yield/Quantification:** (If reported).
- **Overall Outcome/Products for the Section.**
- **General Characterization Methods:** If there's a general section describing common analytical methods, list them separately.

**Key Instructions for Extraction:**
1.  **Completeness:** Extract *all* details. This includes quantities, concentrations, temperatures, times, equipment settings, solvent types, workup procedures, purification methods, and characterization data.
2.  **Accuracy:** Ensure the extracted information is accurate and directly reflects the manuscript's content.
3.  **Hierarchy:** Maintain a logical hierarchy. Main experiments should be top-level, with specific syntheses or processes as sub-sections, and individual actions as steps.
4.  **Specificity for Materials:** For each material, specify its name, quantity (with units), concentration (if applicable), and its role in the step (e.g., reactant, solvent, catalyst, drying agent, buffer component).
5.  **Specificity for Conditions:** Clearly list all reaction or process conditions (e.g., temperature, pressure, pH, duration, atmosphere, stirring speed).
6.  **Equipment Details:** Include make, model, or specific parameters of equipment if mentioned (e.g., "Varian Saturn 2000 ion trap MS", "SPB-5 column").
7.  **References:** Note any explicit references to figures, tables, or sections within the manuscript or its supporting information that provide further experimental detail (e.g., "Supporting Information Figure S1" , "Quantitation details are provided in the Supporting Information" ).
8.  **Implicit Information:** If a standard procedure is implied (e.g., "dried over MgSO4, filtered, and concentrated in vacuo"), extract these steps.
9.  **Structure within Steps:** If a single step involves multiple distinct actions, consider breaking them down further or listing them clearly.

Now, please process the following manuscript content:

[Manuscript Content Here]