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
         - May include multiple fundamental lab operations if the manuscript treats them as a single, uninterrupted stage (e.g., “the precipitate was isolated by vacuum filtration, washed with methanol, dried, and then sublimed”).  
         - Should not combine separate procedures that the manuscript differentiates or quantifies individually (e.g., “the precipitate obtained after drying (5.6 g) was purified by sublimation” would be treated as two processes, as the mass after drying is specified).  
    - **"Reagent", "product", "chemical", "material"**  
         - Include stoichiometric compounds, catalysts, solvents, mixtures, solutions, or phases serving as inputs or outputs of an experimental process.  
         - Any **distinct mixture** or **specified composition** explicitly mentioned in the manuscript is considered its own “material”.

---

#### **2. Attachment Section**

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

#### **3. Task Section**

> **Subtasks** are listed **sequentially** with their respective *instructions* and desired *output format* (e.g., JSON). Each new **sub-prompt** adds new subtasks with continuing numbering.

Below is the **recommended structure** for each subtask:

---

##### **Subtask N – {Title/Name of the Subtask}**
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

#### **4. Expected Output Structure**

Reiterate that ChatGPT should return each subtask’s results separately and in the **specified structured format**. For example:

> *“For each subtask, provide the requested information exactly as JSON.  
> Subtask N output should be in a JSON array named ‘subtask_N_output’.  
> If multiple subtasks exist, separate each subtask’s JSON output clearly, using headings in your response.”*

This ensures the response is **easy to parse** and remains **well-organized**.

---

## **Example of a Complete Sub-Prompt**

Below is a hypothetical example of a **Sub-Prompt #2** referencing prior outputs and focusing on the main goal of consistency checking:

```
SUB-PROMPT #2

1. Common Opening Section

   You are ChatGPT, an advanced large language model acting as an expert chemistry reviewer ...
   (Repeat standard text describing the overall task: to identify key results and check consistency, contradictions, or feasibility …)

2. Attachment Section

   - Manuscript.pdf: The original paper.
   - subtask_1.json:
     - Output from Subtask 1 – “Extraction of elementary processes.”

3. Task Section

   Subtask 2 – “Identify & Validate Key Findings”
   1. Objective:
      - Identify all major conclusions or key findings reported in the manuscript.
      - Assess whether the reported experimental details (from subtask_1.json and the manuscript) support these findings or indicate any inconsistencies.
      - Determine if each finding aligns with typical/established knowledge in the field.
      - Flag any finding that appears implausible or contradictory based on the data or known standards.
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

## **Checklist for Using This Template**

1. **Keep numbering consistent:** If you have five subtasks total across multiple prompts, be sure not to reset the subtask count in later prompts.  
2. **Repeat the “Common Opening Section”** each time, so ChatGPT always has context about its role and the overarching goal.  
3. **List all attachments** every time, clarifying what each file contains.  
4. **Specify each subtask** with:
   - A name/title.  
   - An objective (the question or action you need from ChatGPT).  
   - Detailed instructions/requirements.  
   - **Exact** output formatting instructions.  
5. Emphasize the importance of checking for **internal inconsistencies**, references to **established knowledge**, and whether the **reported results are feasible** or potentially **impossible**.  
6. **Require a structured file format** (e.g., JSON or CSV) for each subtask’s output.

By following this **structured multi-step template**, you will guide ChatGPT to methodically gather, validate, and synthesize information from the manuscript—ultimately helping you assess whether the paper’s claims are valid, contradictory, or questionable.