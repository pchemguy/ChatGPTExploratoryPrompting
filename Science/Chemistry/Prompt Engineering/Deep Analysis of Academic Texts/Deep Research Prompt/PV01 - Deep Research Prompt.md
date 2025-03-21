## Meta-Prompt: Search for Existing Prompt Strategies for Deep Analysis of Experimental Chemistry Papers

**Role and Objective**  
You are a researcher tasked with identifying **previously published prompts, prompt design strategies, or similar frameworks** that aim to perform LLM-based deep analysis of experimental chemistry papers. The analysis of interest includes (but is not limited to) the tasks of assessing completeness of reported details, checking internal consistency (e.g., mass balance), and verifying alignment with established chemical knowledge. Your goal is to **collect** any relevant examples of such prompt strategies or systematic approaches, describe them, and note how well they address each component of the deep analysis workflow outlined below.

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

Use the following steps as a **benchmark** to evaluate how well any discovered method or prompt addresses deep analysis:
1. **Key Findings**  
   - Identifying primary and secondary claims, especially novelty.

2. **Key Experimental Steps**  
   - Mapping each claim to the specific experimental procedures.

3. **Implementation**  
   - Detailed breakdown of materials, equipment, and process parameters.

4. **Process Analysis**  
   - Selecting relevant models or equations, performing consistency and mass balance checks.

5. **Special Considerations**  
   - Looking for missing data, cross-referencing main text vs. supplementary material, and highlighting inconsistencies or omissions.

---

### 3. Your Tasks

1. **Search & Collect**  
   - Survey any publicly available resource or known prompt library for existing prompts that address one or more of the steps in the **Base Workflow**.  
   - Note the **source** (e.g., a research article, AI forum post, organizational guidelines, etc.).

2. **Summarize & Compare**  
   - Provide **brief summaries** of each discovered prompt or method—what problem it addresses, how it’s structured, and whether it includes steps for mass-balance checks or theoretical verification.  
   - **Map** each approach to the **Base Workflow** sections it covers well (or not at all).

3. **Identify Gaps**  
   - Pinpoint any missing elements or **limitations** in each discovered method—particularly if they do not address internal consistency checks or if they only partially cover the data completeness aspect.

4. **Highlight Best Practices**  
   - From your findings, note if there are any **best-practice** suggestions or novel techniques (e.g., specialized ways of referencing reaction equations, verifying stoichiometric balance, or scanning for contradictory parameters).

5. **Recommend Next Steps**  
   - Based on your collected references, offer suggestions on how a fully comprehensive prompt might be designed or improved—especially in regard to:
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

---

### Example Usage of This Meta-Prompt
1. Provide this meta-prompt to an AI model or incorporate it into a research query.  
2. Supply relevant keywords and context (“prompt engineering for experimental chemistry,” “AI-based process analysis,” “mass balance checks in large language models,” etc.).  
3. Instruct the AI or yourself to compile a list of relevant references, summarizing each method’s structure and how it aligns with or differs from the Deep Analysis workflow.  

