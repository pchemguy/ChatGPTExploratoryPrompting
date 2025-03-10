### **Chemistry Manuscript Analysis**
#### **Role and Context**
You are acting as an **expert chemistry reviewer** tasked with conducting a **detailed peer-review analysis** of a chemistry manuscript. Your will carefully **read, interpret, and evaluate** the entire provided text, identifying all relevant information related to experimental methods, reagents/materials, data, processes, equipment, and key findings. You will do this in a stepwise fashion across multiple consecutively numbered subtasks, each time providing specific information requested in the Task section. The output from each subtask is produced as a **structured file** (e.g., JSON, CSV, or YAML) and may be referenced in subsequent subtasks. Each prompt will include
- Description of one or several subtasks.
- The manuscript PDF (re-attached as needed).
- Supporting information, if available (may be included with the manuscript file or attached as separate files).
- Previously generated output files (e.g., `subtask_1_output.json`).  

Consult both the **manuscript** (including main text, tables, figures, and supporting information) and any **structured output files** from earlier subtasks to fulfill the requirements of each new subtask. All the instructions laid out in the prompt below are critical; follow them exactly in your reasoning and in your final structured output.

#### **Task**
##### **Subtask 1 -  Experimental Processes and Procedures**
1. **Objective**:  
    Extract any *chemical or physical processes* or *laboratory techniques/procedures* explicitly performed by the authors.  
2. **Details & Requirements**  
    - **Label**
        - Assign **sequential labels** (At, Bt, Ct… Zt, AAt, ABt, etc.) to each extracted process in the order they **first appear**.
         - Do not group or merge any procedures/processes/steps, even if presented in the manuscript as an integrated process.  
         - If the **same process** is physically performed again at a later point, assign a **new label**. If only discussed again, **do not** assign a new label (reuse the original).
         - **Ignore** processes that are _only_ cited from the literature and never performed by the authors.
    - **Categorize**
        Assign the most suitable category to each extracted process:
        - **Preparatory** (e.g., setting up a reaction mixture, synthesizing a reagent, purification)
        - **Analytical** (e.g., NMR, GC-MS, IR, data collection or interpretation steps)
        - **Computational** (e.g., quantum chemistry calculations, data modeling, simulation)
        - **Safety/Handling** (e.g., special protocols for hazardous materials, disposal procedures)
        - **Uncategorized** if none of the above categories fits reasonably.
    - **Describe**
        - "title" - a concise description, identifying the nature of the process (e.g., "Vacuum Filtration", "Solution NMR", "Synthesis of X").
        - "summary" - purpose, conditions, or highlights.
    - **Reference**
        Include a clear and unambiguous reference to the location in the manuscript. Include additional references, if appropriate, e.g.,
        - `Main text "Results", Table 1, p. 234; SI p. S-3, S-9.`  
        - `Main text "Experimental Section", first paragraphs, p. 230; SI p. S-1, S-3`
3. **Desired Output Format**  
    Provide an ordered list of these processes as a JSON array (`subtask_1_output.json`):

```json
[
    {
         "label": "At",
         "title": "Slow evaporation of tap water",
         "summary": "1–2 L of tap water evaporated in shallow pans at room temperature to concentrate heavier isotopes.",
         "category": "Preparatory",
         "references": ["Main text \“Experimental Section\”, first paragraphs, p. 230", "SI p. S-1, S-3"]
    }
]
```

