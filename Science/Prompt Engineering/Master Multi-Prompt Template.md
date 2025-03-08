# Q

Help me craft a structured detailed ChatGPT prompt template for reasoning models (O1, O3, Deep Research). The prompt needs to instruct ChatGPT to perform analysis of experimental information and data in an uploaded scientific paper manuscript in the field of chemistry as part of an expert peer review. The paper will be provided as a pdf attachment. ChatGPT will need to read, interpret, and analyze the entire manuscript (the main text, tables, figures, and supporting information where applicable) to identify, extract, and structure various information according to the described task. The ultimate goal of this analysis is to identify the key results presented in the manuscript and decide whether such results are supported by / consistent with provided experimental details, whether there any internal contradictions or contradictions with established knowledge in the field or if there are strong evidences that the reported results are likely impossible to achieve.

The primary task, in turn, will be structured and split into several successive consecutively numbered subtasks. Each subtask will request certain information to be extracted and returned as a structured file (JSON, Yaml, CSV, etc.). Later subtasks will may refer to both the original paper and to information returned by any earlier subtasks.

The whole prompt will be split into several sub-prompts. Each such sub-prompt will include a common opening section describing the context, role, the overall task, and the split structure of the prompt. Each sub-prompt Task section will include one or several subtasks with continuously running numbering. The output of previously executed sub-prompts referred to in the current prompts will be attached along with the paper (e.g., output of sub-prompt describing subtasks 2,3, and 4 may be attached as `subtask_2_4.json`). The "Attachment" section should be included before the Task section and will provide description of attachments, e.g.:

- **subtask_1.json**: output of
    - Subtask 1 - "Extraction of elementary processes"
- **subtask_2_4.json**: output of
    - Subtask 2 - "Extraction of key findings"
    - Subtask 3 - "Extraction of chemicals"
    - Subtask 4 - "Extraction of equipment used"

The common opening section should also include a vocabulary note.
1. The terms "reagent", "product", "chemical" (collectively referred to as "material") are used broadly and should be applicable not only to stoichiometric compounds and chemical reactions, but also to processes not involving chemical reactions, such as mixing, separation, dissolution, or forming/isolating phases, etc., and any non-stoichiometric materials, homogeneous/heterogeneous solutions, or mixtures explicitly treated in the paper as a reagent (input to a particular process), product (output of a particular process), or catalyst. Further, if, for example, a mixture or a solution of a particular composition is described as an input to or output from a certain process, such a mixture or solution should be treated as a distinct material for the purpose of paper analysis, especially if composition is one of the central subjects of the paper.
2. The term "experimental process" without further qualification will refer to any chemical or physical process/transformation or experimental technique/procedure that the authors explicitly performed. Further, an "elementary process" or "stage" will refer to a manipulation or process having a distinct name and meaning, involving common operations and referred to in the paper. Such a stage may be a process involving a chemical reaction, such as "neutralization of excess acid", spectroscopic measurement, or various chemical laboratory operations. A stage may still include multiple common operations, but such stage will still be considered as "elementary", if rereferred in the paper as a whole.

# A

Below is a **multi-step prompt template** you can use with ChatGPT (in O1, O3, or Deep Research mode) to guide it through a detailed, expert-level peer review of a chemistry manuscript—ultimately focusing on **whether the key findings are consistent with the experimental details provided**, if there are **internal contradictions**, or if there is **any indication the reported results might be impossible** given established knowledge.

---

## Template: Multi-Step Prompt for Chemistry Manuscript Analysis

### **SUB-PROMPT \#X**  

> *(Replace **X** with the sub-prompt number; for example, “SUB-PROMPT #1” for the first interaction, “SUB-PROMPT #2” for the next, etc.)*  

---

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
   - In subsequent sub-prompts, you may receive:
     - The same manuscript PDF again (labeled “**Manuscript.pdf**” or similar).  
     - The previously generated output files (e.g., `subtask_1.json`, `subtask_2_4.json`, etc.) for reference.  
   - You should refer to both the **manuscript** (including main text, tables, figures, supporting information) and the **structured outputs** from earlier subtasks, as needed, to complete new subtasks.

4. **Vocabulary Note**  
   - **“Reagent”, “product”, “chemical”, “material”**: Used broadly, covering stoichiometric compounds, catalysts, solvents, mixtures, solutions, or phases referred to as an input or output in any experimental process. Any distinct mixture or specific composition explicitly referred to in the analyzed document is treated as a separate “material.”  
   - **“Experimental process”** (unqualified) refers to any *chemical or physical process/transformation* or *technique/procedure* explicitly performed by the authors (e.g., reaction, mixing, separation, measurement, etc.).  
   - **“Elementary process” or “stage”** refers to a named or distinct step (or group of common operations the paper treats as one unit) such as “acid neutralization,” “filtration,” “spectroscopic measurement,” or “centrifugation”.

---

### **2. Attachment Section**

*(Use this section to list and briefly describe attachments. One attachment is always the manuscript PDF. Additional attachments could be previously completed subtasks’ outputs. For example…)*

- **Manuscript.pdf**  
  - The original chemistry paper you will analyze.

- **subtask_1.json** (if relevant)  
  - Output from Subtask 1 – e.g., “Extraction of experimental processes.”

- **subtask_2_4.json** (if relevant)  
  - Output from Subtask 2 – “Extraction of key findings.”  
  - Output from Subtask 3 – “Extraction of chemicals.”  
  - Output from Subtask 4 – “Extraction of equipment used.”  

*(Add as many attachments as needed, including references to prior subtask outputs.)*

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
3. **Desired Output Format**:  
   - Specify exactly how the output must be structured. For example, *JSON*, *CSV*, or *YAML*.  
   - For JSON, you might require a top-level array of objects, each containing consistent fields like `id`, `name`, `description`, `references`, etc.  

*(Repeat the Subtask template for each subtask in this sub-prompt, incrementing the subtask number.)*
   - Provide guidance on how to handle or format references to the paper’s text, figures, or supplementary data.  

---

### **4. Expected Output Structure**  

To finalize the sub-prompt, restate that the response **must** be given in the structure and format specified for each subtask. For instance:

> *“For each subtask, provide the requested information exactly as JSON.  
> Subtask N output should be in a JSON array named ‘subtask_N_output’.  
> If multiple subtasks exist, separate each subtask’s JSON output clearly, using headings in your response.”*

This ensures ChatGPT’s output is well-organized and easy to parse or reuse.

---

## **Putting It All Together: Example**

Below is a hypothetical example (not covering every possible subtask) showing how your **Sub-Prompt #2** might look, referencing a previous `subtask_1.json`:

```
SUB-PROMPT #2

1. Common Opening Section

   You are ChatGPT, an advanced large language model ...
   (Same text describing your context, overall task, note about the sub-prompt structure, vocabulary note, etc.)

2. Attachment Section

   - Manuscript.pdf: The original chemistry paper.
   - subtask_1.json:
     - Output from Subtask 1: “Extraction of elementary processes.”

3. Task Section

   Subtask 2 – “Extraction of Key Findings”
   1. Objective:
      Extract and list all major conclusions or key findings the authors explicitly state in the manuscript. 
   2. Details & Requirements:
      - Include direct quotes from the paper if possible.
      - Summarize or paraphrase the authors' wording to ensure clarity.
      - Reference the paper's sections or page numbers if provided.
   3. Desired Output Format: JSON array named "subtask_2_output", where each element is:
      ```json
      {
        "finding_id": "<string>",
        "finding_text": "<string>",
        "source_reference": "<page_or_section_number>"
      }
      ```

   Subtask 3 – “Extraction of Chemicals”
   1. Objective:
      Identify all reagents, products, and distinct materials involved in the reported experimental stages.
   2. Details & Requirements:
      - Use the vocabulary note: any mixture or solution described as an input or output is a distinct material.
      - Provide composition details if described.
   3. Desired Output Format: JSON array named "subtask_3_output", where each element is:
      ```json
      {
        "chemical_id": "<string>",
        "chemical_name": "<string>",
        "composition_or_purity": "<string_if_available>",
        "role_in_experiment": "<string> e.g., reagent, solvent, product, catalyst"
      }
      ```

   Subtask 4 – “Extraction of Equipment Used”
   1. Objective:
      List all equipment, instruments, and apparatus mentioned.
   2. Details & Requirements:
      - Include brand/model if provided.
      - Provide references to the text or figure where the equipment usage is mentioned.
   3. Desired Output Format: JSON array named "subtask_4_output", where each element is:
      ```json
      {
        "equipment_id": "<string>",
        "equipment_name": "<string>",
        "model_or_brand": "<string_if_provided>",
        "usage_reference": "<page_or_section_number>"
      }
      ```

(End of SUB-PROMPT #2)
```

---

### **Usage Notes**

- **Sub-Prompt #1** might only have one subtask (e.g., “Extract all elementary processes”).  
- **Sub-Prompt #2** might contain subtasks 2, 3, 4 as in the example, and so forth.  
- Continue this pattern for as many sub-prompts as needed.  
- Always attach any relevant previous output files.  
- Always restate the desired *JSON/CSV/YAML structure* so ChatGPT knows exactly how to format each subtask’s output.

---

## **Final Checklist**

1. **Keep numbering consistent** across sub-prompts.  
2. **Re-include the common opening section** in every sub-prompt so ChatGPT always has the context.  
3. **List attachments** in every sub-prompt—this is crucial for referencing the original manuscript and any prior subtask outputs.  
4. **Clearly define each subtask** with:
   - A short name or title.  
   - A clear objective.  
   - Detailed requirements.  
   - A precise output format (with example).  
5. **Instruct ChatGPT** to output data *only* in the specified structured format whenever a subtask demands it, so it can be easily parsed or reviewed.  

By following this template, you ensure each sub-prompt is self-contained yet sequentially linked, giving ChatGPT everything it needs for thorough, stepwise manuscript analysis and review.