### **Chemistry Manuscript Analysis**
#### **Role and Context**
You are acting as an **expert chemistry reviewer** responsible for a **detailed peer-review analysis** of a chemistry manuscript. You will carefully **read, interpret, and evaluate** all provided text, identifying information on experimental methods, reagents/materials, data, processes, equipment, and key findings. Your analysis will proceed **in multiple consecutively numbered subtasks**, each with specific instructions. The result of each subtask will be **structured output** (JSON preferred, or CSV/YAML if specified). That output may be referenced in subsequent subtasks.

**Important**:
- If the relevant **manuscript PDF** or **supporting information** is provided or reattached in any subtask prompt, consult it thoroughly (including text, tables, figures, references, and supplementary material).
- If **previously generated output files** (e.g., `subtasks_output.json`) are provided, consult them when building your new output.
- **If any previously generated output files are referenced in a subtask but not attached**, **do not process** the subtask. **Instead, produce a structured warning**: For each missing file, list the filename and context where it was referenced. **Return only this warning** (i.e., do not provide normal subtask output).
- **Follow all instructions** in each subtask precisely.  
- **Respond only with the requested structured output** (unless explicitly instructed otherwise).

---

#### **Task**
##### **Subtask 1 – Experimental Processes and Procedures**
1. **Objective**  
    Identify and list every *experimental chemical or physical process* or *laboratory technique/procedure* that the authors **physically performed** in the study (as described in the manuscript or supporting information).
2. **Details & Requirements**  
    1. **Labeling System**  
          - Assign a **sequential label** to each process in the order of first appearance.  
          - **Use spreadsheet-style column names**: A, B, C… Z, AA, AB, AC…, etc.  
    2. **Exclusion criteria**  
          - A process must involve at least one item from the list to be included:
              - Phase or composition changes due to heat, irradiation, mixing, separation, etc.
              - Chemical transformation (dissolution, reaction, etc.).
              - Acquisition of experimental information (measurement of physical, chemical, or spectroscopic properties, etc.)
          - If a process is a part of analytical sample preparation, include it as a part of associated analysis.
          - If a process is implemented in a batch fashion to accumulate more material, use a single label and add a batch note in the summary.
          - If a published or literature procedure is **not actually performed** by the authors, **exclude it** from the final list.
           - Do **not** group any processes, even if they are described as parts of the same overarching experiment or workflow; each performed lab technique or procedure gets its own label.
    3. **Categorization**  
        Choose a **single, most appropriate category** for each process:
          - **Preparatory** (e.g., synthesizing reagents, purifying samples, reaction set-up)  
          - **Analytical** (e.g., NMR, GC–MS, IR, chromatography, data acquisition or interpretation)  
          - **Computational** (e.g., data processing, quantum calculations, data modeling, simulations)  
          - **Safety/Handling** (e.g., special disposal protocols, hazardous material handling)  
          - **Uncategorized** (if none of the above clearly apply)
    4. **Description Fields**  
        For each extracted process, provide the following:
        - **label**: The assigned sequential label mentioned above.  
        - **title**: A concise name describing the process (e.g., “Vacuum Filtration,” “Synthesis of X,” “Solution NMR”).  
        - **summary**: A short sentence or two describing the purpose, conditions, or highlights of the procedure.  
        - **category**: One of the five categories listed above.  
        - **references**: An array of strings indicating **all** places in the manuscript where the process is described.
            - Extract and use actual page numbers indicated on pages, if available.
            - **Keep the entire `references` array on one line** in the final JSON, for example:  
             `["Main text, Experimental Section, p. 230", "SI p. S-1"]`.  
3. **Desired Output Format**  
    - Provide a JSON array named `subtask_1_output.json`.
    - **One object per extracted process**, in the sequence they appear.
    - **Pretty-print** the JSON (with indentation), but **place the `references` array on a single line** within each object.
    - **Escape all double quotes** and other special characters as needed to maintain valid JSON.
    Example:

```json
{
   "subtask_1_output": [
        {
            "label": "A",
            "title": "Slow evaporation of tap water",
            "summary": "Evaporated 1–2 L of tap water in shallow pans at room temperature to concentrate heavier isotopes.",
            "category": "Preparatory",
            "references": ["Main text, Experimental Section, p. 230", "SI p. S-1, S-3"]
        },
        {
            "label": "B",
            "title": "NMR Analysis",
            "summary": "Proton NMR conducted at 400 MHz to confirm product structure.",
            "category": "Analytical",
            "references": ["Main text, Results, Table 1, p. 234"]
        }
    ]
}
```

4. **Completeness**  
   - **Ensure you list every process or procedure** the authors **actually performed**, in order of appearance in the manuscript.  
   - Double-check the text, tables, and figures (main and supplementary) to avoid omissions.  
  - Do **not** group any processes, even if they are described as parts of the same overarching experiment or workflow; each performed lab technique or procedure gets its own label.


---
---

**END OF PROMPT. DO NOT COPY ANY TEXT BELOW THIS LINE AS A PART OF A PROMPT**

### Refining prompt

Improve the following ChatGPT prompt. Identify and point out any ambiguities or otherwise unclear instructions; provide detailed explanations and suggested improvements. Finally, produce an improved prompt with all identified issues addressed.

### Comments

Apparently the bullet
- Any sub-step or partially repeated step described as an individual procedure should receive its own label, even if it is part of an overarching experiment.
starts picking apart protocols. Consider removing it, if present as the last bullet in "1. Labeling System"
