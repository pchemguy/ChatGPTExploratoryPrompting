## **Multi-Step Prompt for Chemistry Manuscript Analysis**

### **SUB-PROMPT \#1  

### **1. Common Opening Section**

1. **Context**  
   You are tasked with a detailed, stepwise peer-review analysis of a chemistry manuscript. You will read, interpret, and evaluate the entire manuscript - its main text, tables, figures, and supporting information - and extract or validate various pieces of information.

2. **Overall Task**  
   - The overarching goal is to **identify the key results** presented in the manuscript, **evaluate whether the provided experimental data supports these results**, note any **internal contradictions** or **contradictions with established knowledge**, and assess the likelihood or feasibility that these reported results are accurate or achievable.  
   - You will do this through **multiple subtasks** that request specific information or analysis.  
   - Each subtask will be framed in separate sub-prompts, with each sub-prompt potentially containing one or more **consecutive subtasks** (Subtask 1, 2, 3, …, etc.).

3. **Split-Structure & Consecutive Subtasks**  
   - This prompt is part of a multi-step process. Each step is called a **sub-prompt**, containing **one or more subtasks** with *continuously incrementing numbering.*  
   - The output from each sub-prompt is returned in a **structured file** (e.g., JSON, CSV, or YAML).  
   - With each sub-prompt, you may receive:
     - The same manuscript PDF again.  
     - The previously generated output files (e.g., `subtask_1.json`, `subtask_2_4.json`, etc.) for reference.  
   - You should refer to both the **manuscript** (including main text, tables, figures, supporting information) and the **structured outputs** from earlier subtasks, as needed, to complete new subtasks.

4. **Vocabulary Note**  
   - **“Reagent”, “product”, “chemical”, “material”**: Used broadly, covering stoichiometric compounds, catalysts, solvents, mixtures, solutions, or phases referred to as an input or output in any experimental process. Any distinct mixture or specific composition explicitly referred to in the analyzed document is treated as a separate “material.”  
   - **“Experimental process”** (unqualified) refers to any *chemical or physical process/transformation* or *technique/procedure* explicitly performed by the authors (e.g., reaction, mixing, separation, measurement, etc.).  
   - **“Elementary process” or “stage”** refers to a named or distinct step (or group of common operations the paper treats as one unit) such as “acid neutralization,” “filtration,” “spectroscopic measurement,” or “centrifugation”.

---

### **2. Attachment Section**


- **Manuscript.pdf**  
  - The original chemistry paper you will analyze.

---

### **3. Task Section**

> **Subtasks** are listed **sequentially** with their respective *instructions* and desired *output format* (e.g., JSON). Each new **sub-prompt** adds new subtasks with continuing numbering.

Below is the **recommended structure** for each subtask:

---

#### **Subtask N – \[Title/Name of the Subtask\]**
1. **Objective**:  
   - Clearly state what you want ChatGPT to do for this subtask, e.g., *“Extract all elementary processes from the manuscript.”*
2. **Details & Requirements**  
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

*(Repeat this format for each subtask in the current sub-prompt, incrementing Subtask numbering.)*

---

### **4. Expected Output Structure**

Reiterate that ChatGPT should return each subtask’s results separately and in the **specified structured format**. For example:

> *“For each subtask, provide the requested information exactly as JSON.  
> Subtask N output should be in a JSON array named ‘subtask_N_output’.  
> If multiple subtasks exist, separate each subtask’s JSON output clearly, using headings in your response.”*

This ensures the response is **easy to parse** and remains **well-organized**.

