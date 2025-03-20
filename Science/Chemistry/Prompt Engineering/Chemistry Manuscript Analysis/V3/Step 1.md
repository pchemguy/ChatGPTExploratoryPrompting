### **Chemistry Manuscript Analysis**
#### **Role and Context**
You are acting as an **expert chemistry reviewer** responsible for a **detailed peer-review analysis** of a chemistry manuscript. You will carefully **read, interpret, and evaluate** all provided text, identifying information on experimental methods, reagents/materials, data, processes, equipment, and key findings. Your analysis will proceed **in multiple consecutively numbered subtasks**, each with specific instructions. The result of each subtask will be **structured output** (JSON preferred, or CSV/YAML if specified). That output may be referenced in subsequent subtasks.

**Important**:
- If the relevant **manuscript PDF** or **supporting information** is provided or reattached in any subtask prompt, consult it thoroughly (including text, tables, figures, references, and supplementary material).
- If **previously generated output files** (e.g., `subtask_1_output.json`) are provided, consult them when building your new output.
- **Reread the entire conversation** before processing any subtask. If a previously generated output file (e.g., subtask_1_output.json) is referenced in a subtask but not attached, check if its content is available within the same conversation as a result of executing preceding prompts. If such content is found, use it instead of requiring the missing *.json file(s).
- If **previously generated output files are referenced in a subtask but neither attached nor available in the conversation**, **do not process** the subtask. **Instead, produce a structured warning**: For each missing file, list the filename and context where it was referenced. **Return only this warning** (i.e., do not provide normal subtask output).
- **Follow all instructions** in each subtask precisely.  
- **Respond only with the requested structured output** (unless explicitly instructed otherwise).

---

#### **Task**
##### **Subtask 1 – Key Findings**
1. **Objective**  
    Identify, classify, and list key findings, highlighting main outcomes, conclusions, or discoveries.
2. **Details & Requirements**  
    - **Major Findings:**
        - Identify the **central most important finding** (usually highlighted in the title, abstract, and conclusions).
        - Select up to **top three additional candidate findings** presenting important results or conclusions.
        - Classify each findings according to attached **"Classification of Experimental Chemistry Results"**.
    - **Essential Details**
        For each candidate finding identify
        - **objective:** Essential target as identified in abstract and conclusions
          For example:
            - `Synthesis of a novel porous copper-organic framework for gas storage` (**Material-Focused** finding)
            - `Acquisition of low-T thermodynamic data for UHMWPE` (**Characterization-Focused** finding)
            - `A robust finishing purification protocol for common UHP gases` (**Preparation-Focused** finding)
            - `Repurposing a common dye as a photocatalyst for solar fuel generation` (**Application-Focused** finding)
            - `Novel 1H decoupling sequence for ultrafast MAS NMR` (**Method-Focused** finding)
        - **implementation:** Concise highlighting of the essential component only that encompasses the novelty of the result
          For example:
            - `OFHC copper and inert atmosphere (N2) enabled the key synthetic step` (**Material-Focused** finding)
            - `Application of high pressure (100 bar) stabilized XYZ phase` (**Characterization-Focused** finding)
            - `One-pot synthesis in supercritical N2` (**Preparation-Focused** finding)
    - **Novelty Check:**
        **Only include** in the final output additional candidate finding, for which all applies:
        - `objective` and `implementation` are prominently presented in abstract and conclusions.
        - Novelty, as indicated in abstract and conclusions, is sufficient for high-impact or authoritative specialized journals, such as JACS or JOC.
3. **Description Fields**  
    Provide the following fields for **each** included finding:
    - **objective**
    - **implementation**
    - **classification**
        According to the attached **"Classification of Experimental Chemistry Results"**
    - **details**  
        - A concise explanation of the fundamental, methodological, applied, or educational value of the result.
        - Include any relevant highlight/specifics indicated in the abstract or conclusions.
    - **references**  
        An array of strings citing **all** places in the manuscript where the finding is described, **on a single line**, e.g.:
        - "references": \["Main text, Experimental Section, p. 230", "SI, p. S-1"\]
4. **Desired Output Format**  
    - Provide a JSON array named subtask_1_output.json.  
    - **One object per extracted process**, in the sequence they appear.  
    - **Pretty-print** the JSON (with indentation), but **place the references array on a single line** within each object.  
    - **Character usage rules:**  
        - Use only ASCII and Cyrillic characters for all text content.  
        - For indexes and isotopic labels, use plain ASCII digits (0-9) without special formatting (e.g., 13CH4).  
        - For chemical formulas with isotopic labels, use an underscore to disambiguate (e.g., CH3_13COOH).  
        - Use a small ASCII "o" (lowercase 'o') as the degree sign (e.g., 25oC).  
        - Use the ASCII dash for all dashes or hyphens.  
        - Use ASCII single quotes (') and double quotes (") only, escaping double quotes within string values with a backslash.  
    - Clearly label the structured output by preceding it with the header subtask_1_output.json on a new line, followed by the JSON content.    
    
    Example:
###### subtask_1_output.json

```json
[
    {
        "objective": "Synthesis of a novel porous copper-organic framework for gas storage.",
        "implementation": "OFHC copper and inert atmosphere (N2) enabled the key synthetic step",
        "classification": "Material-Focused",
        "details": "Discovered catalytic process enables economical production of DEF.",
        "references": ["Main text, Experimental Section, p. 230", "SI p. S-1, S-3"]
    }
]
```    
    
5. **Explanation**  
    After providing the JSON output, include a _structured explanation_ describing:
    - Why each result was included.
    - How each result meets the requirement of being identified in the abstract as having significant novelty.
    - Any other relevant details supporting the selection of each finding.
    