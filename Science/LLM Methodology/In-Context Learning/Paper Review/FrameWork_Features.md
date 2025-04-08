# Features: AI-Powered Manuscript Critique Framework

The following list highlights features and components of the presented framework.

1. **Foundational Principles & Rigor**
    - **Core Application:** Designed for critical, expert-level review and identification of potential flaws, inconsistencies, or unsupported claims in experimental chemistry manuscripts.
    - **Expert Skeptic Persona:** Enforces a critically skeptical viewpoint assuming _nothing_ is accurate or valid without rigorous evidence, mirroring high-stakes academic evaluation standards (Section II).
    - **High Standard of Proof:** Demands robust evidence, explicit assumptions, detailed calculation steps, and justification referenced against reliable scientific literature, standard practices, or databases (Section II, IV.A.4).
    - **Cumulative Analysis:** Designed to leverage the entire conversation history and all provided materials for a comprehensive and evolving understanding (Section V.5). 
2. **Advanced Prompt Architecture & Interaction**
    - **Hierarchical & Referenced Structure:** Employs a detailed, structured prompt with internal cross-references, ensuring consistency and linking related analysis tasks (e.g., invoking Figure Analysis within Protocol Analysis).
    - **Modular Toolkit Design:** Functions as a persistent framework where specific analysis modules (e.g., figure analysis, core protocol critique, claim extraction) can be invoked on demand based on user queries or context (Section III).
    - **Persistent Session Framework:** Establishes an interactive "application shell" like environment where the core instructions, persona, and cumulative analysis remain active throughout the conversation.
    - **Guided Analysis Workflow:** Defines clear procedures for complex tasks, including prerequisites (e.g., IV.D.1 before IV.D.2) and a default comprehensive review strategy for general requests (Section IV.A.3, V.3).
    - **LLM Requirements:** Specifies the need for advanced reasoning models capable of complex instruction following and, for full functionality, multimodal analysis (as of Apr 2025, primary target platform - Gemini *Advanced* 2.5 Pro; also tested on Gemini *Standard* 2.5 Pro, *ChatGPT Plus o1* and *SuperGrok Grok 3 Think*).
    - **Zero-Code Accessibility:** Implements entire functionality via standard prompt, requiring no programming, API access, or specialized software installs.
    - **Markdown-Driven Structuring:** Relies on inherent **Markdown structure** (headings, lists, bolding, MathJax extension) to organize complex instructions during the development process and to effectively guide the LLM's sophisticated analytical process within the chat interface. _(Preserving format upon submission is essential for optimal function)._
3. **Deep Methodological Scrutiny (A Priori Evaluation)**
    - **Core Principle: Independent Methodological Scrutiny:** _Crucially_, evaluates experimental design, methods, setup, and assumptions based _solely_ on scientific principles and feasibility, _strictly prohibiting_ the use of reported results as justification for the methods themselves (Section IV.A.2).
    - **Protocol Logic & Completeness Analysis:** Assesses the logical flow of the overall experimental workflow, identifies key stages, and flags significant omissions or missing procedural details required for reproducibility (Section IV.D.1.1).
    - **Core Stage Identification & Analysis:** Isolates and performs in-depth analysis of the specific experimental stages claimed to produce the main result (Section IV.D.2).
    - **Red Flag Detection & Impact Assessment:** Identifies non-standard methods, questionable equipment choices, unconventional procedures, missing controls, or potential safety issues, evaluating their potential impact on validity, reproducibility, and interpretation (Section IV.D.1.3, IV.D.1.4).
    - **Contextual Appropriateness Assessment:** Evaluates the protocol's rigor relative to the stated research goal (e.g., Proof-of-Concept vs. validation) and assesses whether any deviations or shortcuts are scientifically justified or undermine the study's aims (Section IV.D.1.2, Persona II.5).
    - **Critical Parameter Identification:** Determines the inherent performance characteristics of equipment/processes most critical for the success of each experimental stage (Section IV.D.2.3.D.a).
    - **Critique & Alternatives:** Articulates potential impacts of identified flaws and suggests superior, standard alternatives based on established practices and literature (Section IV.D.1.4).
4. **Quantitative Validation & Feasibility Analysis**
    - **Quantitative Figure Interpretation:** Derives quantitative estimates (dimensions, parameters, configurations) from figures (charts, photos, schematics) using stated or inferred scales, explicitly stating assumptions (Section IV.C.3).
    - **Parameter Estimation from Context:** Gauges plausible quantitative values for missing critical equipment/process characteristics using visual data, text, scientific principles, and standard equipment knowledge (Section IV.D.2.3.D.b).
    - **Idealized Performance Modeling:** Performs order-of-magnitude/back-of-the-envelope calculations using simplified, standard theoretical models (e.g., equilibrium stages, reaction kinetics) to estimate the _theoretical maximum performance_ achievable by core experimental stages under ideal conditions (Section IV.D.2.3.F).
    - **Guided Model & Parameter Selection:** Instructs the LLM to identify relevant physical/chemical principles, select appropriate idealized models, and source necessary parameters (from manuscript, estimations, or external literature with citation) for calculations (Section IV.D.2.3.F.a, IV.D.2.3.F.b).
    - **Overall A Priori Feasibility Assessment:** Synthesizes the analysis of core methods, equipment capabilities, and quantitative estimations to evaluate if the described protocol is fundamentally capable, _in principle_, of achieving the main claimed result (Section IV.D.2.4).
    - **Impact vs. Simplicity Plausibility Check:** Performs a high-level assessment comparing the claimed significance/impact of the result against the apparent simplicity/novelty of the core method, flagging potentially implausible scenarios requiring extraordinary evidence (Section IV.D.2.5).
5. **Information Extraction, Inference, and Integration**
    - **Focused Claim Extraction:** Precisely isolates the main claimed result and key subsidiary claims based _only_ on the manuscript's framing sections (Title, Abstract, Introduction, Conclusion) (Section IV.B). 
    - **Claim Classification:** Categorizes the main claimed result using a defined semantic framework based on the targeted unmet need (e.g., Fundamental Understanding, Preparation, Application) (Section IV.B.1).
    - **Numeric Data Extraction:** Identifies and extracts specific quantitative values, units, conditions, and performance metrics reported by the authors within the text and tables, noting inconsistencies (Section IV.D.2.3.B).
    - **Consistency Checking:** Explicitly compares numerical values reported in different sections (e.g., abstract vs. results) for consistency (Section IV.D.2.3.B).
6. **Multimodal Analysis & Integration**
    - **Multimodal Capability:** Leverages models capable of analyzing visual data alongside text (as of Apr 2025, requires Gemini Advanced 2.5 Pro).
    - **Detailed Visual Examination:** Performs meticulous analysis of figures, including charts, schematics, spectra, and photographs, describing content, identifying key features, and noting anomalies (Section IV.C).
    - **Cross-Modal Synthesis:** Integrates information extracted from visuals (including inferred scales and dimensions from photos) with manuscript text, scientific principles, and external knowledge to assess consistency and implications (Section IV.C.4, IV.D.2.3.C).
