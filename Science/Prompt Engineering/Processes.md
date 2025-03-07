# Q

Help me craft a structured detailed ChatGPT prompt template for reasoning models (O1, O3, Deep Research). The prompt needs to instruct ChatGPT to perform analysis of experimental information and data in an uploaded scientific journal paper / manuscript with primary focus in chemistry as part of an expert peer review.

The specific task is to identify every chemical or physical process/transformation, as well as any experimental technique described in the paper. Make sure to extract processes from the entire manuscript, and supporting information, where applicable. Only extract processes performed in the reported work (the goal is to use identified processes with the reported data to validate the results).

Each process should be labeled with a capital Latin letter prefixed with small "t" (if tZ is insufficient, follow by tAA, tAB...). The labeling letters should be used sequentially and the processes should be labeled in order of mention. For a multistage process, each stage receives a distinct label. ChatGPT would also need to identify when a preciously labeled process is mentioned, in which case it should not receive a new label. If process is physically used more than once, each use gets its own label. Only if previously labeled process is simply discussed later that it should not be relabeled. 

---

Let's extend the task. The previously defined task becomes the first step.

The second step is to produce reaction like schematics, showing relations between the identified processes/procedures. For example, Synthesis tE was followed by extraction tG, filtration tH, and the product used later in two independent reactions tM and tQ. The main product in each reaction was then studied by NMR (tN and tR respectively). Produce something like

tG -> tH -> tM ->tN
tG -> tH -> tQ ->tR

Note, this representation is given as an example only. If there is a better schematic representation of this information, suggest it.

---
# A

## ChatGPT Prompt Template

### Title
**"Expert Peer Review: Extraction of Processes & Schematic Representation of Experimental Workflow"**

### Role and Context
You are an advanced reasoning model (capable of O1, O3, and deep research reasoning) acting as an expert chemistry reviewer. You have been provided with a scientific manuscript (including any supporting information) describing experimental work in the field of chemistry.

### Primary Task

#### **Step 1: Identify and Label Processes**
- **Identify** and label every **chemical or physical process/transformation** and **experimental technique** that was **actually performed** in the reported work.  
- For **multistage processes** (e.g., multi-step syntheses, sequential treatments), **each** distinct stage or step should have its **own** label.  
- Use **sequential labels** (tA, tB, tC, … tZ, then tAA, tAB, etc.) in the order they are **first encountered**.  
- If the **same** process is **physically performed again** (e.g., a repeated synthesis, repeated measurement under different conditions), assign a **new** label for that new occurrence.  
- If a process is **only re-mentioned** (no new physical run), **reuse** the original label—do not create a new one.  
- Ignore any processes that are *only* cited from the literature but not actually carried out by the authors.

**Output for Step 1**:  
- Provide a **chronologically ordered list** of processes/techniques.  
- Each item should include:
  1. **Label** (e.g., tA, tB, …).  
  2. A **short descriptive phrase** (e.g., “Distillation,” “NMR Measurement,” “Hydrothermal Synthesis”).  
  3. A **brief summary** of why or how it was performed.  
  4. **Reference** to the relevant manuscript section or page if available.

#### **Step 2: Produce a Workflow or Reaction-Like Schematic**
After labeling all processes, construct a **reaction-like schematic** (or workflow diagram) showing **how the processes relate** to one another. For example:

> - If **Synthesis (tE)** is followed by **Extraction (tG)** and **Filtration (tH)**, and then the **product** is **used** in two different reactions (tM and tQ), you might represent:  
>   ```
>   tE → tG → tH → tM → tN (for NMR analysis)
>                    \
>                     → tQ → tR (for another measurement)
>   ```
> - If you see a better way to visually or textually map the relationships (e.g., a branching workflow, bullet-point hierarchy, or another representation), you are free to suggest and provide that.

This schematic should reflect how the **output** (product or intermediate) of one labeled process **feeds into** the next, or how certain processes lead to **different** branches of experimentation.

**Output for Step 2**:
- A clear, easy-to-follow **diagram** or **flow** (in text form is fine) illustrating the **sequence** or **branching** of labeled processes.  
- If a process leads to multiple subsequent steps, show each branch.  
- If a step ends with a final product or characterization, indicate it clearly (e.g., “Analyzed by NMR (tN)”).

### Example (for Illustration Only)

- **Step 1** (Labeled List):  
  1. tA: “Synthesis of Compound X – Stage 1” (Section 2.1)  
     - Reagent A + Reagent B, reflux for 3 hours.  
  2. tB: “Synthesis of Compound X – Stage 2” (Section 2.1)  
     - Solvent exchange, stirring at room temperature.  
  3. tC: “Purification by Column Chromatography” (Section 2.2).  
  4. tD: “Repeat Synthesis of Compound X” (Section 2.3)  
     - Identical to tA, but physically repeated.  

- **Step 2** (Schematic):

  ```
  tA -> tB -> tC
      \-> tD
  ```

  In this hypothetical example, tD is a repeated run of tA but branched off at an earlier stage.

---

### Complete Prompt Text

**PROMPT (copy/paste to ChatGPT)**

**Role**: You are an advanced reasoning model (capable of O1, O3, and deep research reasoning) acting as an expert chemistry reviewer.

**Context**: You have access to a scientific manuscript in the field of chemistry, including supporting information. Your task is to conduct an in-depth analysis of all experimental information and data, focusing on every **chemical or physical process** and **experimental technique** the authors **explicitly performed**.

**Task Instructions**: 

**Step 1: Identify and Label Processes**
 - Parse the entire manuscript (including supporting information) to find every **chemical or physical process** and **experimental technique** explicitly **performed** by the authors.
 - For **multistage** processes, each **distinct stage** or **separate step** must have its own label.
 - Assign sequential labels: tA, tB, tC, … tZ, then tAA, tAB, etc.
 - If the **same** process is performed multiple times (e.g., repeated synthesis), each new run gets a **new** label. 
 - If a process is mentioned again later **without** a new performance, **reuse** the existing label.
 - Ignore any processes not physically performed in this work (mere references from literature).
 - Produce a **structured, labeled list** (in chronological order) of these processes, each entry with:
    - Label (tA, tB, etc.)
    - Short descriptive phrase
    - Brief summary (why/how performed)
    - Reference to manuscript section/page if possible

**Step 2: Produce a Reaction-Like Schematic or Workflow Diagram**
 1. Based on the labeled list, create a **schematic** (text-based or otherwise) that shows the **flow** or **relationship** between these processes.
 2. For example, if tE leads to tG, which then leads to tH, show this chain clearly.
 3. If an intermediate product is used in two different subsequent processes, show each **branch**.
 4. If you see a better visual or textual approach than simple arrows, propose and present it.

**Final Output**:
 1. **Part A**: Labeled list of all processes (Step 1).
 2. **Part B**: Reaction-like schematic or workflow (Step 2).

**Style**:
 - Present results in a **clearly structured**, itemized format.
 - **Concise but thorough** descriptions suitable for a professional peer review.

**Now, please read and analyze the entire manuscript (main text + supporting information) and produce your labeled list accordingly.**
