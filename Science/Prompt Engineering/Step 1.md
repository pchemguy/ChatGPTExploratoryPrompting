## **Multi-Step Prompt for Chemistry Manuscript Analysis**

### **SUB-PROMPT \#1  

#### **1. Overall Role, Context, Task, and Prompt Design**

1. **Role and Context**  
    You are acting as an **expert chemistry reviewer** tasked with conducting a **detailed peer-review analysis** of a chemistry manuscript. Your will carefully **read, interpret, and evaluate** the entire provided text and extract and/or validate various pieces of information as requested.
2. **Overall Goal**  
    Your overarching objective is to determine whether the manuscript’s **key results** are:  
    - **Justified** by the experimental evidence.  
    - Potentially **invalidated** by internal contradictions.  
    - **Incompatible** with established knowledge, thereby rendering them implausible.  
3. **Prompting Approach & Design**  
    - Following a **hierarchical decomposition** strategy, the overall review will be broken into **discrete subtasks** (numbered consecutively) that will be distributed across multiple (sub-)prompts.
    - Each sub-prompt will focus on a specific component of the review and will elicit a **structured chain-of-thought** for that component.  
    - The output from each sub-prompt is stored in a **structured file** (e.g., JSON, CSV, or YAML) to be used as reference in subsequent steps  ("retrieval augmented generation").  
    - Sub-prompts may include the following **attachments**:
        - The manuscript PDF (re-attached as needed).  
        - Previously generated output files (e.g., `subtask_1.json`, `subtask_2_4.json`).  
    - Consult both the **manuscript** (including main text, tables, figures, and supporting information) and any **structured outputs** from earlier subtasks to fulfill the requirements of each new subtask.  
4. **References for Extracted Information**  
    Whenever you extract specific information, you must include a **clear and unambiguous reference** to the location in the manuscript. Include additional references, if appropriate, e.g.,
    - `Main text “Results”, Table 1, p. 234; SI p. S-3, S-9.`  
    - `Main text “Experimental Section”, first paragraphs, p. 230; SI p. S-1, S-3`
5. **Vocabulary**  
    - **“Experimental process”**  
         - Refers to any *chemical or physical process* or *laboratory technique/procedure* explicitly performed by the authors.  
         - Never combine procedures or processes, even if presented in the manuscript as an integrated process.  
         - Never combine analytical experiments: when an analytical technique is applied to multiple substance, each substance analysis, for which some resulting data is provided is considered a distinct process and cannot be combined with any other processes. When multiple technique are applied to the same compound, each technique should be associated with a distinct process.  
    - **"Reagent", "product", "chemical", "material"**  
         - Include stoichiometric compounds, catalysts, solvents, mixtures, solutions, or phases serving as inputs or outputs of an experimental process.  
         - Any **distinct mixture** or **specified composition** explicitly mentioned in the manuscript is considered its own “material”.

---

#### **2. Attachment Section**

- **Enrichment of H2 17O from Tap Water, Characterization of the Enriched Water, and Properties of Several 17O-Labeled Compounds.pdf**  
    - The original chemistry paper you will analyze.

---

#### **3. Task Section**

##### **Subtask 1 –  Identify and Label Processes**
1. **Objective**:  
    - Extract all experimental processes from the manuscript that the authors **explicitly performed**.
2. **Details & Requirements**  
    - Assign **sequential labels** (At, Bt, Ct… Zt, AAt, ABt, etc.) in the order they **first appear**.
    - If the **same process** is physically performed again at a later point, assign a **new label**. If only referred to again, **do not** assign a new label (reuse the original).
    - **Ignore** processes that are _only_ cited from the literature and never performed by the authors.
    - **Categorize** each extracted process according to **one** of the following categories:
        - **Preparatory** (e.g., setting up a reaction mixture, synthesizing a reagent to use later, purification)
        - **Analytical** (e.g., NMR, GC-MS, IR, data collection or interpretation steps)
        - **Computational** (e.g., quantum chemistry calculations, data modeling, simulation)
        - **Safety/Handling** (e.g., special protocols for hazardous materials, disposal procedures)
        - **Uncategorized** if none of the above categories fits reasonably.
3. **Desired Output Format**  
    Provide a **chronologically ordered list** of these processes, as a JSON array:

```json
[
    {
         "label": "At",
         "description": "Slow evaporation of tap water",
         "summary": "1–2 L of tap water evaporated in shallow pans at room temperature to concentrate heavier isotopes.",
         "category": "Preparatory",
         "references": ["Main text \“Experimental Section\”, first paragraphs, p. 230", "SI p. S-1, S-3"]
    }
]
```

---

#### **4. Expected Output Structure**

- For each subtask, provide the requested information exactly as JSON.
- Subtask N output should be in a JSON array named `subtask_N_output.json`.  
- If multiple subtasks exist, separate each subtask’s JSON output clearly, using headings in your response.
