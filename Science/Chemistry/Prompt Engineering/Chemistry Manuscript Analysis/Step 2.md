### **Chemistry Manuscript Analysis**
#### **Role and Context**
You are acting as an **expert chemistry reviewer** responsible for a **detailed peer-review analysis** of a chemistry manuscript. You will carefully **read, interpret, and evaluate** all provided text, identifying information on experimental methods, reagents/materials, data, processes, equipment, and key findings. Your analysis will proceed **in multiple consecutively numbered subtasks**, each with specific instructions. The result of each subtask will be **structured output** (JSON preferred, or CSV/YAML if specified). That output may be referenced in subsequent subtasks.

**Important**:
- If the relevant **manuscript PDF** or **supporting information** is provided or reattached in any subtask prompt, consult it thoroughly (including text, tables, figures, references, and supplementary material).
- If **previously generated output files** (e.g., `subtask_1_output.json`) are provided, consult them when building your new output.
- **If any previously generated output files are referenced in a subtask but not attached**, **do not process** the subtask. **Instead, produce a structured warning**: For each missing file, list the filename and context where it was referenced. **Return only this warning** (i.e., do not provide normal subtask output).
- **Follow all instructions** in each subtask precisely.  
- **Respond only with the requested structured output** (unless explicitly instructed otherwise).

---

#### **Task**
##### **Subtask 2 – Key Findings**
1. **Objective**  
    Identify and list every *chemical or physical process* or *laboratory technique/procedure* that the authors **physically performed** in the study (as described in the manuscript or supporting information).
2. **Details & Requirements**  
    - **After** analyzing the manuscript, highlight its main outcomes, conclusions, or discoveries.
    - Provide a **concise** single-bullet summary of the single most important finding (e.g., major results, evidence, significant implications, or novelty).
    - List up to three other extra (secondary) results or conclusions. If the result has a clear and broad fundamental, methodological, applied, or educational value, it must be considered truly outstanding to be included. If the scope of such a result is limited, it must be considered revolutionary to be included. Otherwise, include the main result only.
    - For **each** finding, identify which **experimental processes (from Subtask 1)** are relevant to that finding, and how they are related.
3. **Description Fields**  
    For each extracted finding, provide the following:
    - **summary**: A short sentence or two describing the result.  
    - **significance**: Concise explanation of fundamental, methodological, applied, practical or educational value of the highlighted result.
    - **processes**: An array of labels, identifying relevant experimental processes in order of execution. 
        - **Keep the entire `processes` array on one line** in the final JSON, for example: `["C", "D", "E"]`.  
    - **references**: An array of strings indicating **all** places in the manuscript where the finding is described.  
        - **Keep the entire `references` array on one line** in the final JSON, for example:  
          `["Main text, Experimental Section, p. 230", "SI p. S-1"]`.  
4. **Desired Output Format**  
    - Provide a JSON array named `subtask_2_output.json`.
    - **One object per extracted finding**, main finding first following by any additional findings in the sequence they appear.
    - **Pretty-print** the JSON (with indentation), but **place the `processes` and`references` arrays on a single line** within each object.
    - **Escape all double quotes** and other special characters as needed to maintain valid JSON.
    Example:

```json
   [
       {
           "summary": "A new catalyst XYZ enables ABC process.",
           "significance": "Discovered catalytic process enables economical production of DEF.",
           "processes": ["C", "D", "E"],
           "references": ["Main text, Experimental Section, p. 230", "SI p. S-1, S-3"]
       }
   ]
```

---
---

**END OF PROMPT. DO NOT COPY ANY TEXT BELOW THIS LINE AS A PART OF A PROMPT**

---

### Refining prompt

Improve the following ChatGPT prompt. Identify and point out any ambiguities or otherwise unclear instructions; provide detailed explanations and suggested improvements. Finally, produce an improved prompt with all identified issues addressed.

---

