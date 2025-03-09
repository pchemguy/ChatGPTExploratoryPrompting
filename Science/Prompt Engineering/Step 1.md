## **Multi-Step Prompt for Chemistry Manuscript Analysis**

### **SUB-PROMPT \#1  

### **1. Overall Role, Context, Task, and Prompt Design**

1. **Context**  
    You are tasked with a detailed, stepwise peer-review analysis of a chemistry manuscript. You will read, interpret, and evaluate the entire manuscript - its main text, tables, figures, and supporting information - and extract or validate various pieces of information.
2. **Overall Task**  
    - The overarching goal is to **identify the key results** presented in the manuscript, **evaluate whether the provided experimental data supports these results**, note any **internal contradictions** or **contradictions with established knowledge**, and assess the likelihood or feasibility that these reported results are accurate or achievable.  
    - You will do this through **multiple subtasks** that request specific information or analysis.  
    - Each subtask will be framed in separate sub-prompts, with each sub-prompt potentially containing one or more **consecutive subtasks** (Subtask 1, 2, 3, …, etc.).
3. **Prompting Approach and Design**  
    - Selected approach employs a multi-stage approach based on **hierarchical sub-prompt decomposition**. The task is broken into discrete subtasks, each described in a dedicated sub-prompt. Each sub-prompt elicits a structured **chain-of-thought** for a specific component of the overall task (e.g., extracting experimental details, identifying contradictions) according to included subtask-specific detailed instructions and a predefined output format. The outputs of each sub-prompt are then used as reference points in subsequent prompts where necessary, implementing a simplified version of **retrieval augmented generation**.
    - Each **sub-prompt** contains **one or more subtasks** with *continuously incrementing numbering.*  
    - The output from each sub-prompt is returned in a **structured file** (e.g., JSON, CSV, or YAML).  
    - In sub-prompts, you may receive as attachments:
         - The same manuscript PDF.  
         - Any previously generated output files (e.g., `subtask_1.json`, `subtask_2_4.json`, etc.) for reference.  
    - You should refer to both the **manuscript** (including main text, tables, figures, supporting information) and the **structured outputs** from earlier subtasks, as needed, to complete new subtasks.
4. **Vocabulary Note**  
    - **“Reagent”, “product”, “chemical”, “material”**: Used broadly, covering stoichiometric compounds, catalysts, solvents, mixtures, solutions, or phases referred to as an input or output in any experimental process. Any distinct mixture or specific composition explicitly referred to in the analyzed document is treated as a separate “material.”  
    - **“Experimental process”** (unqualified) refers to any *chemical or physical process/transformation* or *laboratory technique/procedure* explicitly performed by the authors (e.g., reaction, mixing, separation, measurement, etc.).  
    - **“Elementary process” or “stage”** refers to a named or distinct step (or group of common primitive lab operations the paper treats as one unit) such as “acid neutralization,” “filtration,” “spectroscopic measurement,” or “centrifugation”.

---

### **2. Attachment Section**

- **Enrichment of H2 17O from Tap Water, Characterization of the Enriched Water, and Properties of Several 17O-Labeled Compounds.pdf**  
    - The original chemistry paper you will analyze.

---

### **3. Task Section**

#### **Subtask 1 –  Identify and Label Processes**
1. **Objective**:  
   - Extract all elementary processes from the manuscript that the authors **explicitly performed**.
1. **Details & Requirements**  
   - 
   - Provide any specific instructions about what to capture, how to interpret certain details, or how to structure the response. For instance:  
     - *“List each process with a unique identifier.”*  
     - *“Include references to the corresponding sections/figure numbers in the paper if available.”*
   - Provide guidance on how to handle or format references to the paper’s text, figures, or supplementary data.  
3. **Desired Output Format**  
   - Specify the exact structure you want (e.g., JSON, CSV, YAML).  
   - For JSON, you might define the fields each item should include. For instance:
     ```json
     [
       {
         "finding_id": "<string>",
         "finding_text": "<string>",
         "supporting_evidence": "<text_citation_or_summary>",
         "potential_contradictions": "<text_if_any>",
         "feasibility_comment": "<opinion_on_whether_data_supports_the_finding_or_if_it_contradicts_established_knowledge>",
         "references_in_manuscript": ["<section_or_page_numbers>"]
       }
     ]
     ```


1. Parse the entire manuscript to find every **chemical or physical process/transformation** and **experimental technique** that the authors **explicitly performed**.
2. For **multistage** processes, label **each** distinct stage/step separately.
3. Assign **sequential labels** (At, Bt, Ct… Zt, AAt, ABt, etc.) in the order they **first appear**.
4. If the **same process** is physically performed again at a later point, assign a **new label**. If only discussed again, **do not** assign a new label (reuse the original).
5. **Ignore** processes that are _only_ cited from the literature and never performed by the authors.
6. **Categorize** each labeled process according to **one** of the following categories, if **appropriate**:
    - **Preparatory** (e.g., setting up a reaction mixture, synthesizing a reagent to use later, purification)
    - **Analytical** (e.g., NMR, GC-MS, IR, data collection or interpretation steps)
    - **Computational** (e.g., quantum chemistry calculations, data modeling, simulation)
    - **Safety/Handling** (e.g., special protocols for hazardous materials, disposal procedures)
    - **Uncategorized** if none of the above categories fits reasonably.
7. Provide a **chronologically ordered list** of these processes, each with (do not combine any bullets):
    - **Label** (e.g., “At”)
    - **Short descriptive phrase** (e.g., “Distillation,” “Synthesis of Compound X”)
    - **Brief summary** (purpose, conditions, or highlights)
    - **Category** from the above list
    - **Reference** (manuscript section, figure, table, or page if available)




---

### **4. Expected Output Structure**

- For each subtask, provide the requested information exactly as JSON.
- Subtask N output should be in a JSON array named `subtask_N_output.json`.  
- If multiple subtasks exist, separate each subtask’s JSON output clearly, using headings in your response.
