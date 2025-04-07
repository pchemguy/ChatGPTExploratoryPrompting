


Proof of Concept LLM Prompt for Deep Experiment Chemistry Paper Analysis


# Feature Categories

- Prompting Methodology
- Manuscript Analysis Methodology

# Features

- Model Requirements: reasoning / thinking variants (tested on Gemini Advanced 2.5 Pro, SuperGrok Grok 3 Think, ChatGPT Plus o1)
- Multimodal analysis (Gemini Advanced 2.5 Pro only, as of April 2025)
    - analysis of figures, including photographs
    - integration of information in photos, schematics, text, and world knowledge
- Application - critical analysis of an experimental chemistry paper
- Methodology
    - Structured hierarchical prompt with internal references
    - Modular prompt framework active for the duration of the conversation
    - Prompt framework akin an application shell console with the underlying LLM prompt being an analog of basic OS shell console
    - In-context learning
    - Analysis workflow
    - Focused extraction of key findings (Title, abstract, intro, conclusions)
    - Ad-hoc semantic classification
    - Extraction of numeric information from text and tables (probably from figures and photos during multimodal analysis) 
    - Data inference and validation
        - inference of missing characteristics by analysis of photographs, textual information, and integration with world knowledge
        - back-of-envelope / order of magnitude / idealized calculations
        - appropriate governing equation selection
        - retrieving or estimating characteristics necessary for estimation
        - automatic selection of appropriate model by LLM 
    - identification of key performance characteristics (such as HETP for a distillation column) 
    - analysis of experimental methodology
    - identification of the key experimental stages
    - identifying red flags and assessing their potential impact on the study results
    - evaluating context (like certain aspects of a proof-of-concept application study might be potentially relaxed in terms of academic research rigor, if such a move is deliberate, and a sound justification is provided that the core results/goals will not be no significantly influenced or if expected influence is understood, reasonably controlled, does not compromise the results, and there is a sound reason to follow such a path).
    - assessing a priori feasibility of reported study by comparing claimed results with a analysis of experimental methodology, model estimations, and general field knowledge.
    - assessing a priori plausibility that a high-impact result with trivial implementation may have been overlooked by qualified experts.
    - **structured toolkit** designed to guide LLM critique (e.g., define instruction sets for extracting main results, analysis of figures, analysis of experimental protocols)

---
---



Alternative design strategy: split design of prompts and interactive submission with individual queries

Reflection on review process


---
---



**Proposed Improved Feature Categories**

1. **Advanced Prompt Architecture & Interaction:**    
    - **Focus:** Highlights the sophisticated design _of the prompt itself_.
    - **Coverage:** Includes features like the hierarchical structure, modularity (acting like a toolkit), persistence (application shell analogy), and how it guides the LLM through complex workflows. This emphasizes the prompt's engineering and user interaction model.
2. **Deep Methodological Scrutiny (A Priori Evaluation):**
    - **Focus:** Emphasizes the core principle of evaluating the experimental methods _independently_ of the claimed results.
    - **Coverage:** Includes identification of stages, analysis of protocol logic/completeness, evaluation of equipment/procedures against standards, identification of red flags/questionable choices, assessment of contextual appropriateness (PoC vs. validation), and suggesting alternatives. Critically, highlights the strict adherence to _a priori_ assessment (Section IV.A.2).
3. **Quantitative Validation & Feasibility Analysis:**
    - **Focus:** Highlights the prompt's ability to guide the LLM in performing quantitative checks and estimations based on the provided information and external knowledge.
    - **Coverage:** Includes multimodal analysis of figures for quantitative detail (scale inference, dimension estimation), extraction of numeric data, inference of missing parameters, back-of-the-envelope/idealized model calculations (Section D.2.3.F), comparison with theoretical limits, and overall _a priori_ feasibility/plausibility assessments (linking method capability to claimed results, Section D.5 & D.6).
4. **Targeted Information Extraction & Synthesis:**
    - **Focus:** Covers the directed extraction and organization of key information from the manuscript.
    - **Coverage:** Includes extracting main/subsidiary claims (Section B), identifying key performance indicators reported by authors, extracting procedural details, and synthesizing information across different manuscript sections (e.g., comparing abstract claims to detailed methods). Includes the semantic classification of the main claim (Section B.1.c).
5. **Multimodal Analysis & Integration:**
    - **Focus:** Specifically calls out the capability to analyze and integrate visual information (figures, photos, schematics) with textual descriptions and scientific principles.
    - **Coverage:** Detailed figure/photo analysis (Section C), using visual data for quantitative estimation, cross-referencing visuals with text, identifying inconsistencies revealed by visuals. (While related to Quantitative Validation, its distinct input type warrants highlighting).
6. **Foundational Principles & Rigor:**
    - **Focus:** Captures the underlying philosophy and operational standards embedded in the prompt.
    - **Coverage:** Explicit persona definition (skeptical expert), emphasis on high standards (PhD qual level), requirement for evidence-based reasoning and citation, distinction between research stages, identification of potential bias/fallacies. Also covers LLM requirements (model dependencies).



---
---


# Key Highlights: AI-Powered Manuscript Critique Framework

- **Expert Peer Review Simulation:** Critically evaluates experimental methods _before_ considering claimed results. Rigorously assesses protocols based on fundamental scientific principles to uncover hidden flaws and questionable assumptions, independent of claimed outcomes.
- **Information Extraction, Inference, and Integration:** Actively extracts crucial claims, numeric data, and procedural details from across the entire manuscript (text, tables, figures). Intelligently infers missing parameters and synthesizes disparate information with scientific knowledge to build a cohesive, evidence-based understanding.
- **Quantitative Reality Check:** Performs rapid back-of-the-envelope calculations, idealized modeling, and figure-based estimations. Rigorously tests if the described methods are _quantitatively capable_ of achieving the reported results _a priori_, flagging claims potentially inconsistent with method simplicity.
- **Deep Figure Analysis:** Meticulously analyzes figures, photos, and schematics. Extracts quantitative details _from visuals_ and cross-validates _visual information_ against the text to uncover inconsistencies or provide unique supporting evidence.
- **Guided Analysis Framework:** Leverages in-context learning and a modular and hierarchical prompt architecture that systematically guides the LLM through complex, multi-step critiques. Ensures thorough, consistent, and structured evaluation, acting like an interactive, expert-driven review template.
- **Zero-Code Accessibility:** Unleashes sophisticated manuscript analysis capabilities directly within the standard LLM chat window using generally available advanced reasoning models. Entirely prompt-driven, requiring **no programming, API access, or specialized software installs.** (Primary target platform - Gemini *Advanced* 2.5 Pro; also tested on *ChatGPT Plus o1* and *SuperGrok Grok 3 Think* as of Apr 2025.)

---
---

# Detailed Feature Highlights

1. **Advanced Prompt Architecture & Interaction**
    - **Hierarchical & Referenced Structure:** Employs a detailed, structured prompt with internal cross-references, ensuring consistency and linking related analysis tasks (e.g., invoking Figure Analysis within Protocol Analysis).
    - **Modular Toolkit Design:** Functions as a persistent framework where specific analysis modules (e.g., figure analysis, core protocol critique, claim extraction) can be invoked on demand based on user queries or context (Section III).
    - **Persistent Session Framework:** Establishes an interactive "application shell" like environment where the core instructions, persona, and cumulative analysis remain active throughout the conversation (Section III, V.5).
    - **Guided Analysis Workflow:** Defines clear procedures for complex tasks, including prerequisites (e.g., D.1 before D.2) and a default comprehensive review strategy for general requests (Section IV.A.3, V.3).
2. **Deep Methodological Scrutiny (A Priori Evaluation)**
    - **Core Principle: Independent Methodological Scrutiny:** _Crucially_, evaluates experimental design, methods, setup, and assumptions based _solely_ on scientific principles and feasibility, _strictly prohibiting_ the use of reported results as justification for the methods themselves (Section IV.A.2).
    - **Protocol Logic & Completeness Analysis:** Assesses the logical flow of the overall experimental workflow, identifies key stages, and flags significant omissions or missing procedural details required for reproducibility (Section D.1.1).
    - **Core Stage Identification & Analysis:** Isolates and performs in-depth analysis of the specific experimental stages claimed to produce the main result (Section D.2).
    - **Red Flag Detection & Impact Assessment:** Identifies non-standard methods, questionable equipment choices, unconventional procedures, missing controls, or potential safety issues, evaluating their potential impact on validity, reproducibility, and interpretation (Section D.1.3, D.1.4).
    - **Contextual Appropriateness Assessment:** Evaluates the protocol's rigor relative to the stated research goal (e.g., Proof-of-Concept vs. validation) and assesses whether any deviations or shortcuts are scientifically justified or undermine the study's aims (Section D.1.2, Persona II.5).
    - **Critical Parameter Identification:** Determines the inherent performance characteristics of equipment/processes most critical for the success of each experimental stage (Section D.2.3.D.1).
    - **Critique & Alternatives:** Articulates potential impacts of identified flaws and suggests superior, standard alternatives based on established practices and literature (Section D.1.4).
3. **Quantitative Validation & Feasibility Analysis**
    - **Quantitative Figure Interpretation:** Derives quantitative estimates (dimensions, parameters, configurations) from figures (charts, photos, schematics) using stated or inferred scales, explicitly stating assumptions (Section C.3).
    - **Parameter Estimation from Context:** Gauges plausible quantitative values for missing critical equipment/process characteristics using visual data, text, scientific principles, and standard equipment knowledge (Section D.2.3.D.2).
    - **Idealized Performance Modeling:** Performs order-of-magnitude/back-of-the-envelope calculations using simplified, standard theoretical models (e.g., equilibrium stages, reaction kinetics) to estimate the _theoretical maximum performance_ achievable by core experimental stages under ideal conditions (Section D.2.3.F).
    - **Guided Model & Parameter Selection:** Instructs the LLM to identify relevant physical/chemical principles, select appropriate idealized models, and source necessary parameters (from manuscript, estimations, or external literature with citation) for calculations (Section D.2.3.F.1, D.2.3.F.2).
    - **Overall A Priori Feasibility Assessment:** Synthesizes the analysis of core methods, equipment capabilities, and quantitative estimations to evaluate if the described protocol is fundamentally capable, _in principle_, of achieving the main claimed result (Section D.5).
    - **Impact vs. Simplicity Plausibility Check:** Performs a high-level assessment comparing the claimed significance/impact of the result against the apparent simplicity/novelty of the core method, flagging potentially implausible scenarios requiring extraordinary evidence (Section D.6).
4. **Targeted Information Extraction & Synthesis**
    - **Focused Claim Extraction:** Precisely isolates the main claimed result and key subsidiary claims based _only_ on the manuscript's framing sections (Title, Abstract, Introduction, Conclusion) (Section B).
    - **Claim Classification:** Categorizes the main claimed result using a defined semantic framework based on the targeted unmet need (e.g., Fundamental Understanding, Preparation, Application) (Section B.1.c).
    - **Numeric Data Extraction:** Identifies and extracts specific quantitative values, units, conditions, and performance metrics reported by the authors within the text and tables, noting inconsistencies (Section D.2.3.B).
    - **Consistency Checking:** Explicitly compares numerical values reported in different sections (e.g., abstract vs. results) for consistency (Section D.2.3.B).
5. **Multimodal Analysis & Integration**
    - **Multimodal Capability:** Leverages models capable of analyzing visual data alongside text (Currently requires specific models like Gemini Advanced 2.5 Pro - as of Apr 2025).
    - **Detailed Visual Examination:** Performs meticulous analysis of figures, including charts, schematics, spectra, and photographs, describing content, identifying key features, and noting anomalies (Section C).
    - **Cross-Modal Synthesis:** Integrates information extracted from visuals (including inferred scales and dimensions from photos) with manuscript text, scientific principles, and external knowledge to assess consistency and implications (Section C.4, D.2.3.C).
6. **Foundational Principles & Rigor**
    - **Expert Skeptic Persona:** Enforces a critically skeptical viewpoint assuming _nothing_ is accurate or valid without rigorous evidence, mirroring high-stakes academic evaluation standards (Section II).
    - **High Standard of Proof:** Demands robust evidence, explicit assumptions, detailed calculation steps, and justification referenced against reliable scientific literature, standard practices, or databases (Section II, IV.A.4).
    - **Core Application:** Designed for critical, expert-level review and identification of potential flaws, inconsistencies, or unsupported claims in experimental chemistry manuscripts.
    - **LLM Requirements:** Specifies the need for advanced reasoning models capable of complex instruction following and, for full functionality, multimodal analysis (as tested).
    - **Cumulative Analysis:** Designed to leverage the entire conversation history and all provided materials for a comprehensive and evolving understanding (Section V.5).

