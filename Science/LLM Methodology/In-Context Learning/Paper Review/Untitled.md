# Beyond Simple Queries: Building an LLM "Expert" for Critical Chemistry Paper Review

## Introduction: LLMs in the Lab?

Large Language Models (LLMs) like ChatGPT have rapidly entered the public consciousness. Many researchers, postdocs, and graduate students in the life and natural sciences have likely experimented with them, perhaps asking for summaries, explanations of concepts, or even help drafting emails. While useful for simpler tasks, harnessing LLMs for deep, critical scientific analysis requires moving beyond basic questions.

The standard peer-review process, while essential, is time-consuming and can sometimes fail to catch subtle (or even significant) flaws in experimental design, data interpretation, or claims. Could we leverage LLMs to assist in this process, acting as a highly critical preliminary reviewer?

This post explores an experiment in "prompt engineering" – the art and science of crafting detailed instructions for LLMs. I've developed a complex prompt designed to guide an LLM to perform a rigorous, skeptical analysis of experimental chemistry manuscripts, mimicking the mindset of an experienced, critical expert reviewer. This isn't about replacing human experts, but exploring how structured instructions can enable AI to perform more sophisticated scientific reasoning tasks.

**Target Audience:** This post is primarily for researchers, postdocs, and advanced students in chemistry and related fields who are curious about the potential of LLMs beyond basic use cases.
**Goal:** To dissect the structure and techniques used in a complex LLM prompt designed for critical scientific paper analysis, illustrating the possibilities of advanced prompt engineering.

## The Challenge: Mimicking Expert Skepticism

Analyzing an experimental chemistry paper rigorously requires more than just understanding the text. It demands:

1.  **Deep Domain Expertise:** Understanding chemical principles, standard techniques, equipment limitations, and potential pitfalls.
2.  **Methodological Rigor:** Evaluating *how* something was done, independent of the claimed results.
3.  **Critical Skepticism:** Actively looking for inconsistencies, unsupported claims, missing information, and potential flaws, rather than assuming correctness.
4.  **Structured Evaluation:** Systematically examining different aspects of the paper – claims, methods, figures, data, conclusions.

Can we instruct an LLM to adopt this mindset and structured approach?

## Introducing the "Expert Critical Reviewer" Prompt

I've developed a detailed prompt that attempts to instill these characteristics into an LLM. Its core objective is:

> *Critically analyze the provided experimental chemistry manuscript (and any supporting materials) from the perspective of a highly skeptical expert. Identify potential flaws, inconsistencies, questionable methods, unsupported claims, or missing information, applying rigorous scientific scrutiny.*

**(You can find the full prompt text here: [Link to your prompt file on GitHub - e.g., prompt.md])**

## Key Features & Design Philosophy (Summary)

Before diving into the details, here are the most significant features and underlying principles of the prompt's design:

1.  **Defined Persona:** The prompt explicitly assigns a detailed persona ("Expert Critical Reviewer") with specific qualifications, a skeptical mindset, and high performance standards (akin to a PhD qualifying exam). This forces the LLM to adopt a specific viewpoint and evaluation criteria.
2.  **Emphasis on *A Priori* Methodological Scrutiny:** A core constraint (**"The Principle of Independent Methodological Scrutiny"**) forbids the LLM from using the *reported results* to justify the *validity of the methods*. The methods must be evaluated based on scientific principles *before* considering the outcomes. This is crucial for objective critique.
3.  **Structured & Modular Workflow:** The prompt is broken down into distinct sections (Persona, Context, Specific Instructions, Final Rules) and sub-sections (Analysis of Claims, Figures, Protocols). This modularity allows for targeted analysis (e.g., "Analyze only Figure 3") while maintaining the overall critical framework.
4.  **Detailed Analytical Checklists:** Specific sections (like Figure Analysis and Protocol Analysis) provide step-by-step instructions and checklists, guiding the LLM through a systematic evaluation process.
5.  **Quantitative Estimation & Justification:** The prompt pushes the LLM to move beyond qualitative statements by requiring quantitative estimates (e.g., dimensions from figures, theoretical performance limits based on idealized models) and demanding justifications based on scientific principles or external data.
6.  **Plausibility Checks:** It includes mechanisms to compare the claimed impact of the research with the apparent simplicity or novelty of the methods, flagging potential inconsistencies that warrant deeper scrutiny.

## How the Framework Changes the Game: An OS/Shell Analogy

To understand why this detailed prompt framework is necessary and how it functions, consider this analogy:

- **The Base LLM (e.g., the core ChatGPT model) is like an Operating System (OS).** It has immense general capabilities but lacks specific instructions for complex, specialized tasks out-of-the-box. If you simply give the base LLM the manuscript and ask, "Review this paper," the OS receives the request directly. It will use its general knowledge and heuristics to generate _a_ review, but it might be superficial, lack deep skepticism, miss critical details, or fail to follow a rigorous scientific evaluation methodology. The output quality can be unpredictable.
    
- **The Elaborate Prompt Framework (like the one described here) is like installing a specialized Shell or Command-Line Environment on top of the OS.** When you first submit this large prompt, you are "loading" this environment. The LLM uses its **in-context learning** ability to understand and adopt the rules, persona, constraints, and procedures defined within the framework for the rest of the conversation.
    
- **Your Subsequent Request ("Review this paper") is now like typing a command into that specialized Shell.** The request isn't handled directly by the generic OS anymore. Instead, the Shell (the prompt framework) intercepts it and interprets it according to its own pre-defined rules. In our case, the framework defines "Review this paper" as triggering the **Default Task** (Section V.3) – a specific, multi-step program involving the detailed experimental protocol analysis outlined in Section D.
    

Essentially, the prompt framework transforms a simple natural language request into the execution command for a complex, pre-defined analytical program that runs _within_ the LLM's contextual understanding. This structured approach, enabled by the detailed framework acting as an interpretive layer, is what allows for a dramatically different, more rigorous, and predictable output compared to interacting with the base LLM directly.

## Harnessing Multimodality: Integrating Visual Evidence

Modern LLMs are increasingly capable of processing not just text, but also images. This prompt framework is explicitly designed to leverage this multimodal capability for a more holistic and critical analysis, moving beyond purely textual evaluation.

Here's how the prompt directs the LLM to handle visual information (figures, schematics, and critically, **photos** of experimental setups) found in manuscripts or supporting materials:

1. **Detailed Visual Interrogation (Section IV.C):** The prompt doesn't just ask _if_ a figure exists; it mandates a meticulous examination. For photos, this includes describing the scene, identifying equipment (linking to text), assessing relevance, and crucially, **estimating quantitative parameters**. The LLM is instructed to infer scale using known objects if not explicitly provided and to **show its reasoning and calculations**.
2. **Text-Visual Cross-Verification:** A key step is comparing the visual evidence directly against the textual descriptions in the manuscript. Does the photo of the setup match the description in the methods section? Are there inconsistencies or ambiguities?
3. **Inference from Combined Information:** The framework pushes the LLM to make inferences based on the _combination_ of visual and textual data. For example, seeing a particular type of clamp in a photo might imply certain temperature limitations not mentioned in the text, or the apparent scale in a photo might contradict reported yields or concentrations.
4. **Integration into Methodological Critique (Section IV.D):** Critically, the analysis of figures isn't a standalone exercise. The prompt explicitly requires **integrating these visual findings and inferences into the core experimental protocol analysis**. For instance:
    - When analyzing a specific experimental stage (Section D.2.3.C), the associated figures _must_ be analyzed using the full Section C methodology, and the findings used to assess the stage's description and feasibility.
    - When evaluating equipment performance and gauging missing parameters (Section D.2.3.D), the prompt directs the LLM to use quantitative estimates _derived from the figure analysis_ as primary data points.

This integrated multimodal approach forces the LLM to treat figures and photos not as mere illustrations, but as critical data sources to be interrogated, quantified where possible, and used actively to validate or challenge the claims and descriptions presented in the text. It aims to mimic how an experienced researcher would scrutinize visual evidence for subtle clues about the experiment's actual execution and potential limitations.

**A Practical Note on Multimodal Capabilities (as of April 2025):**

It's crucial to understand that the sophisticated, integrated analysis of images (especially photos of experimental setups) described above pushes the limits of current widely accessible AI models. The prompt's requirements for detailed description, quantitative estimation from visuals, inference based on combined text/image data, and using those inferences in subsequent analytical steps (Sections IV.C and IV.D) are particularly demanding.

Based on initial testing:

- **Successful Execution:** This level of detailed multimodal analysis appears most reliably achievable using advanced models like **Google's Gemini 2.5 Pro**, typically accessed via the **Gemini Advanced** subscription tier. 
- **Observed Limitations:** Other currently available multimodal models tested, including those powering **ChatGPT Plus (GPT-4 variants)**, **Grok**, and the **standard (free) tier of Gemini 2.5 Pro**, have shown limitations in consistently performing the full depth of integrated visual analysis mandated by this prompt framework, particularly concerning the quantitative and inferential steps based on photos.

**Implication:** Executing this prompt framework _to its full potential_, especially the multimodal aspects, may currently require access to premium, state-of-the-art LLMs. The capabilities of different models and service tiers are evolving rapidly, so this landscape may change, but users should be aware that not all multimodal models will handle these specific complex instructions equally well at this time.

## Deep Dive: Prompt Structure and Techniques

Let's examine the different sections of the prompt to understand how they work together:

**I. Core Objective:**
* **Function:** Sets the overarching goal in a single, clear statement.
* **Technique:** Goal Definition. Simple but essential for focusing the LLM.

**II. Persona: Expert Critical Reviewer:**
* **Function:** Defines the "mindset" and expertise level the LLM should emulate. Crucially, it emphasizes skepticism and rigor, setting high standards (PhD/Postdoc exam level). It also includes awareness of practical constraints vs. methodological compromises.
* **Technique:** Persona Assignment. This is a powerful technique to guide the LLM's tone, perspective, and evaluation criteria. Defining specific traits (skeptical, methodologically rigorous, practically aware) shapes the output significantly.

**III. Context: Framework for Critical Manuscript Review:**
* **Function:** Acts as meta-instructions, explaining *how* the LLM should use the different parts of the prompt. It establishes the prompt as a persistent foundation and clarifies the modular application of instructions.
* **Technique:** Meta-Instruction and Workflow Definition. Guides the LLM on interpreting and applying the complex set of rules provided.

**IV. Specific Analysis Instructions (The Analytical Engine):**
This is the core operational part, broken into modules:

* **A. Foundational Principles & Workflow Application:**
    * **Function:** Sets overarching rules like scope control and evidence requirements (citing literature, principles, databases). Critically, it introduces **"The Principle of Independent Methodological Scrutiny"** – a fundamental constraint preventing outcome bias in methods evaluation. It also defines how different analysis modules (like Protocol and Figure analysis) interact.
    * **Technique:** Constraint Definition, Evidence Requirement, Workflow Logic. The "Independent Methodological Scrutiny" is a key constraint designed to force objective evaluation.

* **B. Identifying Claimed Results and Contributions:**
    * **Function:** Instructs the LLM to *first* identify the authors' main claims based *only* on the framing sections (Title, Abstract, Intro, Conclusion), *before* looking at the methods/results details. Includes a classification system for the type of claim.
    * **Technique:** Information Isolation & Staged Analysis. Separating claim identification from evidence evaluation helps prevent confirmation bias. Classification provides structure.

* **C. Analyzing Figures:**
    * **Function:** Provides a detailed checklist for analyzing visual information (charts, photos, schematics). It requires describing content, estimating dimensions (even inferring scale), cross-verifying with text, and assessing practical implications.
    * **Technique:** Structured Checklist, Quantitative Estimation from Visuals, Cross-Verification. Pushes the LLM to extract meaningful, quantitative data from images and critically link it to the text.

* **D. Analyzing the Experimental Protocol:**
    * **Function:** This is the most detailed section, designed for deep methodological critique. It's split into a general overview (D.1) and an in-depth core analysis (D.2). It constantly reinforces the "Independent Methodological Scrutiny" principle.
        * **D.1 (General Overview):** Assesses overall flow, completeness, contextual appropriateness (e.g., PoC vs. validation), general red flags (questionable equipment, unconventional procedures, safety), and requires suggesting superior alternatives with justification.
        * **D.2 (In-Depth Core Analysis):** Focuses intensely on the steps directly producing the main claimed result. For *each* core stage, it requires:
            * Describing the procedure, equipment, and reported metrics.
            * Analyzing associated figures (using Section C).
            * Critically analyzing equipment/process performance, including *gauging plausible values for missing parameters* based on figures, principles, or typical specs.
            * Performing an ***a priori* feasibility assessment** for that stage.
            * Estimating **idealized theoretical performance** using simplified models and literature values (if needed via search), comparing this theoretical limit to what would be *needed* for the overall claim.
        * **Synthesis (D.4, D.5):** It then requires synthesizing the stage-by-stage analysis into an *overall a priori feasibility assessment* of the core protocol. Finally, it includes a crucial **"A Priori Plausibility Check"** (D.5) comparing the claimed impact/significance of the result against the apparent complexity/novelty of the method, looking for potential discrepancies (e.g., extraordinary claim from seemingly simple methods).
    * **Technique:** Hierarchical Analysis (General -> Specific), Strict *A Priori* Evaluation, Constraint Reinforcement, Quantitative Estimation (Gauging Missing Values), Idealized Modeling & Calculation, Comparative Analysis (Theoretical vs. Needed), Plausibility Heuristics. This section uses multiple advanced techniques to force a deeply critical, quantitative, and principled evaluation of the experimental methods *before* considering the reported outcome.

**V. Final Instructions for Interaction:**
* **Function:** Provides rules for the ongoing interaction, ensuring consistency, defining default behavior (performing the full protocol analysis if no specific question is asked), and specifying output format.
* **Technique:** Interaction Rules, Default Behavior Definition.

## Why This Level of Detail?

Crafting such a long and specific prompt serves several purposes:

1.  **Guides Complex Reasoning:** It breaks down a highly complex task (critical review) into manageable, sequential steps.
2.  **Enforces Rigor and Skepticism:** Explicit instructions and constraints (like the Persona and Independent Scrutiny) force the LLM out of a potentially agreeable or superficial mode.
3.  **Reduces Ambiguity:** Detailed checklists minimize the chance of the LLM overlooking critical aspects.
4.  **Promotes Quantitative Analysis:** Explicit requests for estimation and calculation push the LLM towards more concrete evaluations.
5.  **Mitigates "Hallucination":** While not foolproof, grounding the analysis in specific instructions, manuscript details, and external scientific principles can help reduce confabulation.

## Potential Applications & Limitations

A prompt like this could potentially be used for:

* **Pre-screening manuscripts:** Identifying potential red flags before full peer review.
* **Training tool:** Helping students learn critical appraisal skills by seeing a structured breakdown.
* **Idea generation:** Identifying weaknesses in existing work that suggest avenues for new research.

However, limitations are crucial to acknowledge:

* **Input Dependent:** The quality of the analysis depends heavily on the detail and clarity of the input manuscript.
* **No True Understanding:** The LLM is pattern-matching and following instructions, not truly *understanding* the chemistry in a human sense.
* **Potential for Errors:** LLMs can still misunderstand instructions, make calculation errors, or misinterpret scientific concepts.
* **Not a Replacement for Experts:** This is a tool to *augment* human expertise, not replace the nuanced judgment of experienced researchers and peer reviewers.

## Conclusion: Prompting as Programming for Reasoning

This exploration demonstrates that LLMs can be guided to perform sophisticated analytical tasks far beyond simple Q&A, *if* given sufficiently detailed and well-structured instructions. Designing prompts like this is akin to programming a reasoning process. The "Expert Critical Reviewer" prompt is an attempt to codify the principles of rigorous scientific skepticism for an AI.

While still experimental, this approach highlights the potential for advanced prompt engineering to unlock new capabilities for LLMs in scientific research. I encourage others to experiment with complex prompting in their own domains and share their findings.

---
**(Optional: Add a link to the prompt file itself here if you're hosting it publicly on GitHub)**

[Link to the `prompt.md` file in your repository]

---