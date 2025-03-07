# Q

Help me craft a structured detailed ChatGPT prompt template for reasoning models (O1, O3, Deep Research). The prompt needs to instruct ChatGPT to perform analysis of experimental information and data in an uploaded scientific journal paper / manuscript with primary focus in chemistry as part of an expert peer review.

The specific task consists of several steps:
1. Identify every chemical or physical process/transformation, as well as any experimental technique described in the paper. Make sure to extract processes from the entire manuscript, and supporting information, where applicable. Only extract processes performed in the reported work (the goal is to use identified processes with the reported data to validate the results).
   
   Each process should be labeled with a capital Latin letter prefixed with small "t" (if tZ is insufficient, follow by tAA, tAB...). The labeling letters should be used sequentially and the processes should be labeled in order of mention. For a multistage process, each stage receives a distinct label. ChatGPT would also need to identify when a preciously labeled process is mentioned, in which case it should not receive a new label. If process is physically used more than once, each use gets its own label. Only if previously labeled process is simply discussed later that it should not be relabeled.
   
   Categorize each identified elementary process as preparatory, analytical, or computational. Only apply one of these categories, if it reasonably suits the step within its associated context. If none of the three categories fit well, consider two additional categories: physical/mechanical manipulation and safety/handling. Finally, label the process as uncategorized, if no category suits well.

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

Let's amend step 3 task. Identify the most important finding (one bullet only), supplementing it with relevant experimental steps from step 1 and a reaction-like schematic (workflow diagram) as before. Additionally, highlight a maximum of top three extra results (not including the main one) in a similar fashion. You should only include a particular result if its fundamental, methodological, applied, or educational significance is clearly demonstrated by the authors or would be clear to an expert in the field.


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
    2. Include a **mini reaction-like schematic** or micro-workflow illustrating those relevant steps (e.g., “Et → Gt → Ht → Product”).

---

### Example (for Illustration Only)

- **Step 1** (Labeled List):  
  1. At: “Synthesis of Compound X – Stage 1” (Section 2.1)  
     - Reagent A + Reagent B, reflux for 3 hours.  
  2. Bt: “Synthesis of Compound X – Stage 2” (Section 2.1)  
     - Solvent exchange, stirring at room temperature.  
  3. Ct: “Purification by Column Chromatography” (Section 2.2).  
  4. Dt: “Repeat Synthesis of Compound X” (Section 2.3)  
     - Identical to At, but physically repeated.  

- **Step 2** (Schematic):
```
  At -> Bt -> Ct
      \-> Dt
```
    In this hypothetical example, Dt is a repeated run of At but branched off at an earlier stage.

* **Step 3** (Key Findings)
    - **Finding 1**: The authors successfully prepared and enriched 17O-labeled water to >90%.
        - Relevant Steps: At (Evaporation/Distillation), Bt (Verification via GC-MS).
        - Schematic (specific to Finding 1):
            `At → Bt (Confirmed 17O enrichment)`
            
    - **Finding 2**: They uncovered an oxygen-exchange reaction of primary alcohols, catalyzed by camphor.
        - Relevant Steps: Ct, Dt…
        - Schematic (specific to Finding 2):
            `Ct (Camphor + EtOH) → Tt (Exchange) → Dt (Product analysis)`
      
---

### Complete Prompt Text

**PROMPT (copy/paste to ChatGPT)**

**Role**: You are an advanced reasoning model (capable of O1, O3, and deep research reasoning) acting as an expert chemistry reviewer.

**Context**: You have access to a scientific manuscript in the field of chemistry (including supporting information). Your task is to conduct an in-depth analysis of all experimental information and data, focusing on every **chemical or physical process** and **experimental technique** the authors **explicitly performed** with the following objectives:
1. **Identify and label** each **physically performed** experimental step (chemical/physical/analytical).
2. **Create a workflow** or **reaction-like diagram** that maps how these labeled steps are interconnected.
3. **Highlight the key findings** of the manuscript in **bullet-point** form, linking each bullet to **relevant experimental steps** and providing a **small schematic** that illustrates the workflow of those steps.

**Task Instructions**: 

**Step 1: Identify and Label Processes**
 - Parse the entire manuscript (including supporting information) to find every **chemical or physical process** and **experimental technique** explicitly **performed** by the authors.
 - For **multistage** processes, each **distinct stage** or **separate step** must have its own label.
 - You are not allowed to combine any stages or processes. Each manipulation or process having a distinct name and meaning must have a distinct label.
 - Assign sequential labels: At, Bt, Ct, … Zt, then AAt, ABt, etc.
 - If the **same** process is performed multiple times (e.g., repeated synthesis), each new run gets a **new** label. 
 - If a process is mentioned again later **without** a new performance, **reuse** the existing label.
 - Ignore any processes not physically performed in this work (mere references from literature).
 - **Categorize** each process as **Preparatory**, **Analytical**, **Computational**, or **Uncategorized**, whichever **best** applies.
 - Produce a **structured, labeled list** (in chronological order) of these processes, each entry with (do not combine any bullets):
    - Label (At, Bt, etc.)
    - Short descriptive phrase
    - Brief summary (why/how performed)
    - Category
    - Reference to manuscript section/page if possible

**Step 2: Produce a Reaction-Like Schematic or Workflow Diagram**
 1. Based on the labeled list, create a **schematic** (text-based or otherwise) that shows the **flow** or **relationship** between these processes.
 2. For example, if Et leads to Gt, which then leads to Ht, show this chain clearly.
 3. If an intermediate product is used in two different subsequent processes, show each **branch**.
 4. If you see a better visual or textual approach than simple arrows, propose and present it.

**Step 3: Key Findings**
- Summarize the main results or conclusions of the study as concise bullet points (maximum of 3).
- Include a simple diagram or flow (like a mini reaction scheme) that shows how those steps interact to produce the result.

**Style**:
 - Present results in a **clearly structured**, itemized format.
 - **Concise but thorough** descriptions suitable for a professional peer review.
 - Focus on essential steps, outcomes, and their relationships.

**Now, please read and analyze the entire manuscript (main text + supporting information) and produce requested information accordingly.**
