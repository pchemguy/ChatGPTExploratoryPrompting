# Q

Help me craft a structured detailed ChatGPT prompt template for reasoning models (O1, O3, Deep Research). The prompt needs to instruct ChatGPT to perform analysis of experimental information and data in an uploaded scientific journal paper / manuscript with primary focus in chemistry as part of an expert peer review.

The specific task is to identify every chemical or physical process/transformation, as well as any experimental technique described in the paper. Make sure to extract processes from the entire manuscript, and supporting information, where applicable. Only extract processes performed in the reported work (the goal is to use identified processes with the reported data to validate the results).

Each process should be labeled with a capital Latin letter prefixed with small "t" (if tZ is insufficient, follow by tAA, tAB...). The labeling letters should be used sequentially and the processes should be labeled in order of mention. For a multistage process, each stage receives a distinct label. ChatGPT would also need to identify when a preciously labeled process is mentioned, in which case it should not receive a new label. If process is physically used more than once, each use gets its own label. Only if previously labeled process is simply discussed later that it should not be relabeled. 

---

Let's extend the task. The previously defined task becomes the first step. The second step is to produce reaction like schematics, showing relations between the process. For example, Synthesis tE was followed by extraction tG, and the product used later in two independent reactions t

---
# A

## ChatGPT Prompt Template

### Title
**"Expert Peer Review: Chemistry Processes and Techniques Extraction"**

### Role and Context
You are an advanced reasoning model (capable of O1, O3, and deep research reasoning) acting as an expert chemistry reviewer. You have been provided with a scientific manuscript (including any supporting information) describing experimental work in the field of chemistry.

### Primary Task
Identify and label every **chemical or physical process/transformation**, as well as every **experimental technique**, actually **performed** in the reported work. The goal is to use these identified processes—along with corresponding data—to assess the consistency and validity of the authors’ results.

### Task Instructions
- Use **sequential labels** (tA, tB, tC, … up to tZ, then tAA, tAB, etc.) for every **physically performed** process in the order they first appear.  
- **Multistage Processes**: If a single overarching experiment includes multiple **distinct stages** (e.g., separate steps of a synthesis or sequential treatments), **each stage** of that experiment should be labeled individually.  
- If the **same** process is physically performed again (under new or repeated conditions), it receives a **new** label.  
- If the manuscript **only references** a previously mentioned process (no additional physical run), **do not** assign a new label—reuse the original label.  
- Ignore processes that are *only* cited from background literature (i.e., not physically carried out by the authors).

### What to Identify
- **All** chemical and physical transformations **carried out by the authors**.  
- **All** experimental techniques (instrumental methods, analytical procedures, etc.) **actually used** in the reported work.

### What to Ignore
- Processes that are *only* cited from external references or background literature and **not** physically performed.  
- Speculative processes not actually carried out in this study.

### Output Format
1. Provide a structured, **chronologically ordered** list of the identified processes/techniques.  
2. For each entry:
   - The **assigned label** (e.g., “tA,” “tB,” “tC,” “tAA”).  
   - A **short descriptive phrase** or name (e.g., “Distillation,” “NMR Measurement,” “Hydrothermal Synthesis”).  
   - A **brief summary** of how or why it was performed in the work.  
   - A **reference** to where it appears if possible (e.g., section, figure, table, or page).

### Example (for Illustration)

```
List of Identified Processes and Techniques

1. tA: Synthesis of Compound X – Stage 1
   - Performed in Section 2.1. The authors combined Reagent A with Reagent B and heated under reflux.

2. tB: Synthesis of Compound X – Stage 2
   - Immediately follows tA. The authors performed a solvent exchange and continued stirring at room temperature.

3. tC: Purification by Column Chromatography
   - Described in Section 2.2. Used silica gel with a 7:3 hexane/ethyl acetate eluent.

4. tD: Repeat Synthesis of Compound X – Stage 1
   - Same procedure as tA but physically executed again in Section 2.3, so it receives a new label.

5. tB (repeated mention)
   - Discussed in Section 3.2, but not performed anew, so no new label is assigned.
```

*(Note: This is an illustrative example only; actual manuscript content may vary.)*

---

### Complete Prompt Text

**PROMPT (copy/paste to ChatGPT)**

 **Role**: You are an advanced reasoning model (capable of O1, O3, and deep research reasoning) acting as an expert chemistry reviewer.

 **Context**: You have access to a scientific manuscript in the field of chemistry, including supporting information. Your task is to conduct an in-depth analysis of all experimental information and data, focusing on every **chemical or physical process** and **experimental technique** the authors **explicitly performed**.

 **Task Instructions**: 
 - Label all **physically performed** processes in chronological order using tA, tB, tC, … tZ, then tAA, tAB, etc.  
 - For **multistage** processes, **each** distinct stage or step gets its **own** label.  
 - If the **same** process is performed again (new or repeated conditions), it receives a **new** label.  
 - If the manuscript **only references** a previously mentioned process without a new run, **do not** assign a new label—reuse the original label.  
 - Ignore processes that are *only* mentioned from external sources and not actually conducted by the authors.

 **Objectives**:
 1. Identify all relevant experimental steps (processes, transformations, techniques) the authors physically carried out.
 2. Exclude references to processes not physically performed (e.g., purely cited from the literature).
 3. Label each **new** instance of a physically performed process in **order they appear** using tA, tB, … tZ, tAA, tAB, etc.
 4. Reuse labels only if a process is merely discussed again without a new performance.

**Output Requirements**:
 - Provide a **sequential, labeled list** of processes/techniques in the order they appear.  
 - Each labeled entry should include:
   1. Label (e.g., “tA”).
   2. Short descriptive phrase (e.g., “Distillation,” “NMR Spectroscopy”).
   3. Brief summary explaining its purpose/use, and any significant details (e.g., reagents, conditions).
   4. Reference to the manuscript’s section, page, figure, or table if available.

**Style**:
 - Present results in a **clearly structured**, itemized format.
 - **Concise but thorough** descriptions suitable for a professional peer review.

**Now, please read and analyze the entire manuscript (main text + supporting information) and produce your labeled list accordingly.**
