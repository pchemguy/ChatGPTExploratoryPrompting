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

3. Highlight the key finding
    - After analyzing the manuscript, **identify** the main outcomes, conclusions, or discoveries reported by the authors (e.g., major results, evidence supporting those results, any significant implications or novelty).
    - Provide a **concise** single-bullet summary of the single most important finding.
    - Include a **reaction-like schematic** (workflow diagram) illustrating illustrating how processes labeled in step 1 combine to produce/confirm the finding.
    - List up to three other extra (secondary) results or conclusions, **but only** those that are demonstrably **significant** (fundamental, methodological, applied, or educational value).
    - If any significant secondary results are identified and listed, also include a brief **mini-schematic** or flow illustrating how processes labeled in step 1 combine to produce/confirm the finding.
 
4. Stage analysis
    Create a structured list with process details for each stage contributed to the main findings. For each such stage add the following bullets:
    1. classify stage as
        - essential (if omitted, achieving the final result would most likely be impossible),
        - refining (probably improves purity, yield, or some other characteristic; if omitted, the final result should likely be still achievable, even if with inferior value of the characteristics targeted by the stage). or
        - verifying (such as analytical measurements).
    2. list all
        - catalysts used
        - relevant process conditions (temperature, pressure, stirring, etc.)
        - key/essential starting compounds (for example, if acetic acid is prepared from acetic aldehyde, aldehyde is the key compound, but specific oxidizer is usually less important, unless the finding uses a specific non-conventional oxidizer to somehow improve the oxidation process or perhaps a conventional oxidizer with a particular additional catalyst or some other non-conventional conditions, such as a combination of KMnO4 with Potassium-ion matching crown ether).
        - key/essential products (for example, when synthesizing m-nitrochlorobenzene from chlorobenzene, m-nitrochlorobenzene is the key product, but dinitro byproducts are probably non-essential, unless a special focus is given to those, such as in the case where the process specifically focuses on achieving maximum suppression of dinitro byproducts). 
        - non-trivial byproducts, such as byproducts that affect the yield of the key product or are important for modeling the underlying process and predicting/estimating/validating the key result (for example, when basic KMnO4 is used as an oxidizer, MnO2 and water are usually trivial byproducts; when synthesizing m-nitrochlorobenzene from chlorobenzene, o- and p- isomers are also important, as their generation directly affects the yield of the target compound.).
        - relevant equipment apparatus, noting any essential quantitative/qualitative characteristics or classification essential for performing the process or likely affecting the result (for example, general purpose microscopes used in academic labs are usually inferior then specialized high-end systems used in industrial semiconductor facilities; smaller scale benchtop apparatus employed in an academic lab may have certain advantages and disadvantage when compared to full-scale industrial analog.) 
    Treat reagents/products in a wide sense, even if the process does not involve a chemical process directly. For example, when preparing a mixture or, conversely, performing mixture or composite system separation, the mixture, individual components and any isolated phases/portions should be considered as reagents/products as appropriate.

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
- Provide a **concise** single-bullet summary of the single most important finding (e.g., major results, evidence, significant implications, or novelty).
- List up to three other extra (secondary) results or conclusions, **but only** those that are demonstrably **significant** (fundamental, methodological, applied, or educational value).
- For **each** bullet point (the main one and secondary, if any):
    1. **Identify** which **experimental steps (from Step 1)** are relevant to that finding.
    2. Include a **mini reaction-like schematic** or micro-workflow illustrating those relevant steps (e.g., “Et → Gt → Ht → Product”).

#### **Step 4: Detailed Stage Analysis for Main Findings**
For each **stage** (i.e., relevant process from Step 1) that **directly contributes** to the **main** or **additional** findings identified in Step 3, provide a **structured list** of details:  
1. **Stage Classification**
    - **Essential**: If omitting it would **likely make** the final result impossible to achieve.
    - **Refining**: If omitting it would still produce the main product/findings, albeit with lower purity, yield, or other suboptimal parameters.
    - **Verifying**: Such as analytical measurements.
2. **Catalysts Used**
    - List any **catalysts** and briefly note their role (if no catalysts, note “None”).
3. **Relevant Process Conditions**
    - E.g., temperature, pressure, stirring rate, pH, time, or any special apparatus or environment.
4. **Key/Essential Starting Compounds**
    - E.g., any **critical** reagent or substrate required to form the main product or drive the main mechanism.
    - Omit generic items (like a routine base if it’s standard) **unless** it plays a unique or non-conventional role.
5. **Key/Essential Products**
    - List the **main product(s)** relevant to the finding.
    - Provide short clarifications if needed (e.g., “target compound,” “final reaction intermediate”).
6. **Non-trivial Byproducts**
    - If a byproduct is relevant to yield, mechanism, or verifying the result, list it.
    - Omit trivial or inconsequential byproducts unless the manuscript specifically discusses them as important.
7. **Relevant Equipment or Apparatus**
    - Key equipment or apparatus used. Make special emphasis on equipment used for stages classified as essential and verifying. After this list is compiled, reread the manuscript to see if additional important details may be extracted from the main text, supporting information or figures. 
    - Highlight key performance characteristics and any **essential features** or specs that strongly influence the underlying process and outcome (e.g., high-resolution microscope vs. general-purpose, industrial-scale vs. bench-scale). Include relevant numeric values whenever possible. Consider if sufficient information is explicitly provided in the manuscript, with particular focus on information necessary for analysis of the key process and performing estimation/prediction/validation of the produced results. Whenever possible, attempt to infer approximate values/ranges for any missing crucial characteristics and explain the logic used.
    - Briefly **note** how these characteristics impact the process or result.

_(Note: “Reagents” and “products” apply broadly, even to non-chemical processes like mixing, separation, or forming/isolating phases.)_

---

Let's remove the "7. **Relevant Equipment or Apparatus**" section from Step 4.

Define Step 5.

Consider the following components contributing to the essential stages from step 4 assigned to the single most important finding in step 3: 
- Chemical and physical processes, including any relevant conditions (temperature, pressure, timings, pH, etc.).  
- Equipment, including all key characteristics that determine performance of such equipment.  
- Reagents or catalysts used, including any specific properties defined (purity, phase, composition, special activation, specific surface area, and so on).

**Ultimate goal**: Establishing whether the key outcomes of the stages under considerations could be explained/predicted/verified quantitatively, semi-quantitatively, or qualitatively based on described equipment involved, reagents or catalysts used, specific process conditions employed
**Task**: Identifying information necessary 


for predicting key outcomes of the stages under considerations, be it particular reaction pathways, unexpected 


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

* **Step 4 (Detailed Stage Analysis)**
    - **Stage tA**: Fractional Distillation
        - **Classification**: Essential (no enriched water otherwise).
        - **Catalysts**: None.
        - **Process Conditions**: Distillation column, atmospheric pressure, ~95–99 °C.
        - **Key Starting Compound**: Partially enriched tap water.
        - **Key Product**: Concentrated 17O-labeled water.
        - **Non-trivial Byproducts**: None.
        - **Relevant Equipment**: Standard lab-scale fractional distillation apparatus, 10-cm Vigreux column, suitable for small-volume processes. (Industrial-scale might reach higher throughput but could differ in yield/purity.)
    - **Stage tB**: NMR Verification
        - **Classification**: Analytical (confirms the enrichment).
        - **Catalysts**: None.
        - **Process Conditions**: ~25 °C, 600 MHz spectrometer.
        - **Key Starting Compound**: Distillate from tA.
        - **Key Product**: NMR data confirming the 17O fraction.
        - **Non-trivial Byproducts**: None.
        - **Relevant Equipment**: High-field (600 MHz) NMR spectrometer with advanced pulse sequences. A lower-field instrument might give lower resolution of the isotopic signals.

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
 - For **multistage** processes, each **distinct stage** must have its own label.
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
- Present
    - The **most important** finding (one bullet);
    - If there can be identified other major results, list up to three extra bullets. Only include extra results if such results possess demonstrably **significant** value. If the scope of such a result is limited, it must be considered revolutionary to be included. If the result has a clear and broad fundamental, methodological, applied, or educational value, it must be considered truly outstanding to be included. Otherwise, include the main result only.
- For **each** listed bullet:
    1. **Identify** which **experimental stages (from Step 1)** are relevant to that finding.
    2. Include a **mini reaction-like schematic** or micro-workflow illustrating those relevant stages (e.g., “Et → Gt → Ht → Product”).
    3. If possible, provide a concise explanation of fundamental, methodological, applied, practical or educational value of the highlighted result.

**Step 4**: For each **stage** (i.e., relevant process from Step 1) that **directly contributes** to the **main** or **additional** findings identified in Step 3, provide a **structured list** of details:  
1. **Stage Classification**
    - **Essential**: If omitting it would **likely make** the final result impossible to achieve.
    - **Refining**: If omitting it would still produce the main product/findings, albeit with lower purity, yield, or other suboptimal parameters.
    - **Verifying**: Such as analytical measurements.
2. **Catalysts Used**
    - List any **catalysts** and briefly note their role (if no catalysts, note “None”).
3. **Relevant Process Conditions**
    - E.g., temperature, pressure, stirring rate, pH, time, or any special apparatus or environment.
4. **Key/Essential Starting Compounds**
    - E.g., any **critical** reagent or substrate required to form the main product or drive the main mechanism.
    - Omit generic items (like a routine base if it’s standard) **unless** it plays a unique or non-conventional role.
5. **Key/Essential Products**
    - List the **main product(s)** relevant to the finding.
    - Provide short clarifications if needed (e.g., “target compound,” “final reaction intermediate”).
6. **Non-trivial Byproducts**
    - If a byproduct is relevant to yield, mechanism, or verifying the result, list it.
    - Omit trivial or inconsequential byproducts unless the manuscript specifically discusses them as important.
7. **Relevant Equipment or Apparatus**
    - Key equipment or apparatus used. Make special emphasis on equipment used for stages classified as essential and verifying. After this list is compiled, reread the manuscript to see if additional important details may be extracted from the main text, supporting information or figures. 
    - Highlight key performance characteristics and any **essential features** or specs that strongly influence the underlying process and outcome (e.g., high-resolution microscope vs. general-purpose, industrial-scale vs. bench-scale). Include relevant numeric values whenever possible. Consider if sufficient information is explicitly provided in the manuscript, with particular focus on information necessary for analysis of the key process and performing estimation/prediction/validation of the produced results. Whenever possible, attempt to infer approximate values/ranges for any missing crucial characteristics and explain the logic used.
    - Briefly **note** how these characteristics impact the process or result.

_(Note: “Reagents” and “products” apply broadly, even to non-chemical processes like mixing, separation, or forming/isolating phases.)_

**Style**:
 - Present results in a **clearly structured**, itemized format.
 - **Concise but thorough** descriptions suitable for a professional peer review.
 - Focus on essential steps, outcomes, and their relationships.

**Now, please read and analyze the entire manuscript (main text + supporting information) and produce requested information accordingly.**

---
