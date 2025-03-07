# Q

Help me craft a structured detailed ChatGPT prompt template for reasoning models (O1, O3, Deep Research). The prompt needs to instruct ChatGPT to perform analysis of experimental information and data in an uploaded scientific journal paper / manuscript with primary focus in chemistry as part of an expert peer review.

The specific task consists of several steps:
1. Identify every chemical or physical process/transformation, as well as any experimental technique described in the paper. Make sure to extract processes from the entire manuscript, and supporting information, where applicable. Only extract processes performed in the reported work (the goal is to use identified processes with the reported data to validate the results).
   
   Each process should be labeled with a capital Latin letter prefixed with small "t" (if tZ is insufficient, follow by tAA, tAB...). The labeling letters should be used sequentially and the processes should be labeled in order of mention. For a multistage process, each stage receives a distinct label. ChatGPT would also need to identify when a preciously labeled process is mentioned, in which case it should not receive a new label. If process is physically used more than once, each use gets its own label. Only if previously labeled process is simply discussed later that it should not be relabeled. 

2. Produce reaction like schematics, showing relations between the identified processes/procedures. For example, Synthesis tE was followed by extraction tG, filtration tH, and the product used later in two independent reactions tM and tQ. The main product in each reaction was then studied by NMR (tN and tR respectively). Produce something like
   
   tG -> tH -> tM ->tN
   tG -> tH -> tQ ->tR
   
   Note, this representation is given as an example only. If there is a better schematic representation of this information, suggest it.
3. Identify the key findings
    - After analyzing the manuscript, **highlight** the main outcomes, conclusions, or discoveries reported by the authors.
    - Provide a **concise** bullet-pointed summary of the **key findings** (e.g., major results, evidence supporting those results, any significant implications or novelty).
    - Keep it **minimalist**—focus on the **most important** points, not minor details.
    - For each bullet identify relevant experimental steps from step 1 and draw a reaction-like schematic (workflow diagram), illustrating the bullet.
 ---

# A

## ChatGPT Prompt Template

### Title

**"Expert Peer Review: Processes Extraction, Workflow Schematics, and Key Findings"**

### Role and Context

You are an advanced reasoning model (capable of O1, O3, and deep research reasoning) acting as an expert chemistry reviewer. You have been provided with a scientific manuscript (including any supporting information) describing experimental work in the field of chemistry.

### Primary Task

#### **Step 1: Identify and Label Processes**
1. Parse the entire manuscript to find every **chemical or physical process/transformation** and **experimental technique** that the authors **explicitly performed**.
2. For **multistage** processes, label **each** distinct stage/step separately.
3. Assign **sequential labels** (tA, tB, tC… tZ, tAA, tAB, etc.) in the order they **first appear**.
4. If the **same process** is physically performed again at a later point, assign a **new label**. If only discussed again, **do not** assign a new label (reuse the original).
5. **Ignore** processes that are _only_ cited from the literature and never performed by the authors.
6. Provide a **chronologically ordered list** of these processes, each with:
    - **Label** (e.g., “tA”)
    - **Short descriptive phrase** (e.g., “Distillation,” “Synthesis of Compound X”)
    - **Brief summary** (purpose, conditions, or highlights)
    - **Reference** (manuscript section, figure, table, or page if available)

#### **Step 2: Produce a Workflow or Reaction-Like Schematic**
1. Create a clear, easy-to-follow **diagram** or **flow** **schematic** that shows how these labeled processes **connect**.
2. If an **output** of one process feeds into the next, represent the **sequence** with arrows or another clear notation.
3. Show **branching** if a single intermediate goes into multiple subsequent processes.
4. Feel free to adopt a more **efficient** diagram style if it clarifies the workflow better than simple arrows.

#### **Step 3: Identify the Key Findings**
- **After** analyzing the manuscript, highlight its main outcomes, conclusions, or discoveries.
- Provide a **concise, bullet-pointed** list of these key findings (e.g., major results, evidence, significant implications, or novelty).
- Keep it **minimalist**, focusing on the **most important** points.
- For **each** bullet point:
    1. **Identify** which **experimental steps (from Step 1)** are relevant to that finding.
    2. **Draw a small reaction-like schematic (workflow diagram)** specific to that finding, illustrating how the relevant processes connect in support of the result.

---

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

* ***Step 3** (Key Findings)
    - **Finding 1**: The authors successfully prepared and enriched 17O-labeled water to >90%.
        - Relevant Steps: tA (Evaporation/Distillation), tB (Verification via GC-MS).
        - Schematic (specific to Finding 1):
            `tA → tB (Confirmed 17O enrichment)`
            
    - **Finding 2**: They uncovered an oxygen-exchange reaction of primary alcohols, catalyzed by camphor.
        - Relevant Steps: tC, tD…
        - Schematic (specific to Finding 2):
            `tC (Camphor + EtOH) → T (Exchange) → tD (Product analysis)`
      
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
