## Search for Existing Prompt Strategies for Deep Analysis of Experimental Chemistry Papers (Meta-Prompt)

**Role and Objective**  
You are a researcher tasked with identifying **previously published prompts, prompt design strategies, or similar frameworks** that aim to perform LLM-based deep analysis of experimental chemistry papers. The particular focus is on solutions relying on general-purpose models, rather then models, specifically trained for such a task. Such solutions probably should take advantage of in-context learning. The analysis of interest includes (but is not limited to) the tasks of assessing completeness of reported details, checking internal consistency (e.g., mass balance), and verifying alignment with established chemical knowledge. Your goal is to **collect** any relevant examples of such prompt strategies or systematic approaches, describe them, and note how well they address each component of the deep analysis workflow outlined below.

---

### 1. Search Scope & Criteria

1. Look for **existing prompts, articles, blog posts, research notes, or discussions** (including in grey literature, forums, preprints, or other AI-related resources) that outline or demonstrate:
    - A structured or systematic **prompt** aimed at analyzing experimental chemistry procedures.
    - **Validation protocols** for checking internal consistency (mass balances, stoichiometry, or theoretical plausibility).
    - **Heuristic checklists** or step-by-step frameworks for thorough data extraction and verification.
2. Identify whether these prompts or methods:
    - Require **human annotation** or are they purely **AI-driven**?
    - Focus primarily on **data extraction** vs. **deep validation** (or both).
    - Offer novel or distinctive techniques for ensuring **completeness** (e.g., scanning for missing conditions, unaccounted reagent amounts).
3. Pay special attention to whether a method:
    - Integrates **theoretical/empirical models** to cross-check reported yields or reaction schemes.
    - Performs **multi-step** cross-referencing across main text, supplementary files, figures, or tables.

---

### 2. Base Workflow Outline (For Reference)

1. **Key Findings**:
    - Identify and extract the primary result and any other major outcomes or observations.
    - Classify these results.
    - Focus on
        - claims of novelty: the title, abstract, and conclusions
        - supporting details: the experimental section and/or supplementary materials.
2. **Key Experimental Steps**:
    For each finding 
    - Classify it.
    - Identify and extract the specific experimental processes or procedures that led to it.
3. **Implementation**:
    For each experimental process identified above, gather and summarize:
    - **Materials**
        - List all starting materials, reagents, catalysts, and products/byproducts.
        - Record quantities, compositions, or concentrations.
    - **Key Equipment**
        - Note the type of equipment.
        - Include any critical performance characteristics.
    - **Process Parameters and Protocols**
        - Provide details such as reaction time, temperature, pressure, stirring rate, and other relevant conditions.
4. **Process analysis**:
    - Select an appropriate process model for each experimental procedure.
    - If relevant, identify governing equations or theoretical frameworks.
    - Using the model, the listed materials, and reported process parameters, estimate expected product yields.
    - Compare these estimates with the reported product amounts to perform a mass balance or consistency check.
5. **Special considerations**:
    - Review both the main text and any supplementary information, including tables and figures, for additional experimental details.
    - Identify any missing or inconsistent information necessary for a complete process analysis, and determine if it can be inferred.
    - If equipment details appear only in figures or schematics, interpret them, infer, if possible, information necessary for process analysis.
    - Integrate any inferred or supplemental data into your process analysis.
    - Highlight any discrepancies or omissions (e.g., missing mass balance data, contradictory parameter values) and assess their impact on the reliability of the reported results.
---

### 3. Your Tasks

1. **Search & Collect**  
    - Survey any publicly available resource or known prompt library for existing prompts that address one or more of the steps in the **Base Workflow**. 
    - Note the **source** (e.g., a research article, AI forum post, organizational guidelines, etc.).
2. **Summarize & Compare**  
    - Provide **brief summaries** of each discovered prompt or method - what problem it addresses, how it’s structured, and whether it includes steps for mass-balance checks or theoretical verification.  
    - **Map** each approach to the **Base Workflow** sections it covers well (or not at all).
3. **Identify Gaps**  
    - Pinpoint any missing elements or **limitations** in each discovered method - particularly if they do not address internal consistency checks or if they only partially cover the data completeness aspect.
4. **Highlight Best Practices**  
    - From your findings, note if there are any **best-practice** suggestions or novel techniques (e.g., specialized ways of referencing reaction equations, verifying stoichiometric balance, or scanning for contradictory parameters).
5. **Recommend Next Steps**  
    - Based on your collected references, offer suggestions on how a fully comprehensive prompt might be designed or improved - especially in regard to:
         - **Integrating theoretical frameworks** for mass-balance or yield prediction.
         - Ensuring multi-layer data verification (text, tables, supplementary info).
         - Addressing **common pitfalls** (e.g., unclear reaction times, incomplete reagent info).

---

### 4. Formulating Your Output

Your final summary or report should:
1. **List Relevant Prompts or Methods**  
    - Use consistent references or citations so readers can locate them (if publicly available).
2. **Describe Each Approach**  
    - Key aspects: scope, depth of analysis, completeness checks, mass balance checks, reference to domain knowledge.
3. **Assess Their Utility**  
    - Which steps of the **Base Workflow** do they fulfill?
    - Do they rely on any specialized LLM features or third-party tools (e.g., PDF parsing, chemical equation balancing libraries)?
4. **Identify Opportunities for Enhancement**  
    - Where the discovered prompts or frameworks could be extended or refined to meet the **full** deep-analysis needs outlined in the Base Workflow.

