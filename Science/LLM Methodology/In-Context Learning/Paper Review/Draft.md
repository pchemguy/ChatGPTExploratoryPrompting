# Simulating Peer Review via Persistent Workflow Prompting

## Abstract

Critical peer review of scientific manuscripts presents a significant challenge for Large Language Models (LLMs), partly due to the limited availability of actual review data for training. This report introduces Persistent Workflow Prompting (PWP), a prompt engineering methodology designed to bridge this gap using only in-context learning within standard LLM interfaces (no coding or APIs required). The presented proof-of-concept PWP prompt focuses on experimental chemistry manuscripts and guides frontier reasoning LLMs (primarily Gemini Advanced 2.5 Pro) through a systematic, multimodal analysis. The prompt features a hierarchical, modular architecture formatted in Markdown, defining complex review tasks as structured workflows. Submitted once at the start of a session, this master prompt equips the LLM with persistent workflows triggered by subsequent user queries (e.g., Analyze the core experimental protocol). Key capabilities demonstrated by the prompt include: identifying core claims vs. evidence, performing multimodal analysis integrating text and figures (including photographs), inferring missing parameters, executing quantitative feasibility checks via idealized process modeling and a priori estimations, comparing these estimations against claimed results, and assessing overall experimental plausibility. This work highlights the potential of advanced prompt engineering to enable complex, domain-specific reasoning and analysis in scientific research using readily available LLMs.

## Summary

This report presents a proof-of-concept advanced AI prompt designed to simulate the peer review process for experimental chemistry manuscripts. The [prompt](PeerReviewPrompt.md) utilizes **Persistent Workflow Prompting** (also discussed) alongside a hierarchical, modular, Markdown-driven architecture to guide AI models through a critical evaluation without requiring coding or specialized software. Developed and tested using *Gemini Advanced 2.5 Pro* and this [publication][EnrichmentURL], its key features (detailed [here](FrameWork_Features.md)) focus on translating the complex, often tacit, human review process into concrete, executable steps for the AI. These steps include identifying main claims, analyzing figures multimodally, and scrutinizing experimental protocols for completeness, quantitative feasibility, and overall plausibility.

**Basic usage (primary target: Gemini Advanced 2.5 Pro):**  
1. Input the full **RAW Markdown-formatted** [prompt](PeerReviewPrompt.md) in a new chat.  
2. Submit `Analyze the core experimental protocol` prompt with the manuscript and SI attached.  

See demos for [Gemini Advanced 2.5 Pro][Gemini Demo] ([verbatim copy of analysis][Gemini Analysis]), [ChatGPT Plus o1][o1 Demo], and [SuperGrok Grok 3 Think][Grok Demo] (click on "Analysis of Core Experimental Protocol for H2_17O Enrichment" at the bottom). Be aware that advanced components like process modeling, calculations, and multimodal analysis may yield variable or failed results. In essence, this project demonstrates how sophisticated prompt engineering can enable current advanced LLMs to perform complex, domain-specific analytical tasks, such as simulating a critical scientific review, thereby pushing the boundaries of zero-code AI applications.

---

### Key Feature Highlights: Deep Analysis of Experimental Chemistry Manuscripts

- **Expert Peer Review Simulation:** Critically evaluates experimental methods _before_ considering claimed results. Rigorously assesses protocols based on fundamental scientific principles to uncover hidden flaws and questionable assumptions, independent of claimed outcomes.
- **Information Extraction, Inference, and Integration:** Actively extracts crucial claims, numeric data, and procedural details from across the entire manuscript (text, tables, figures). Intelligently infers missing parameters and synthesizes disparate information with scientific knowledge to build a cohesive, evidence-based understanding. 
- **Quantitative Reality Check:** Performs rapid back-of-the-envelope calculations, idealized modeling, and figure-based estimations. Rigorously tests if the described methods are _quantitatively capable_ of achieving the reported results _a priori_, flagging claims potentially inconsistent with method simplicity.
- **Multimodal Figure Analysis:** Meticulously analyzes figures, photos, and schematics. Extracts quantitative details _from visuals_ and cross-validates _visual information_ against the text to uncover inconsistencies or provide unique supporting evidence.
- **Guided Analysis Framework:** Leverages in-context learning and a hierarchical, modular, and flexible prompt architecture that systematically guides the LLM through complex, multi-step critiques. Ensures thorough, consistent, and structured evaluation, acting like an interactive, expert-driven review template.
- **Zero-Code Accessibility:** Implements sophisticated manuscript analysis capabilities directly within the standard LLM chat window using generally available advanced reasoning models. Entirely prompt-driven, requiring no programming, API access, or specialized software installs. (Primary target platform - Gemini *Advanced* 2.5 Pro; also tested on Gemini *Standard* 2.5 Pro, *ChatGPT Plus o1* and *SuperGrok Grok 3 Think* as of Apr 2025.) 
- **Markdown-Driven Prompt Architecture:** Relies on inherent **Markdown structure** (headings, lists, bolding, MathJax extension) to organize complex instructions during the development process and to effectively guide the LLM's sophisticated analytical process within the chat interface. _(Preserving format upon submission is essential for optimal function)._

---
---

## Introduction  
  
Widely available Large Language Models (LLMs)—such as OpenAI's _o1_ or Google’s _Gemini_ family - are evolving rapidly. However, they still face limitations when tackling complex, domain-specific research and engineering problems. Successfully addressing these limitations often requires integrating:
- **Relevant factual knowledge** (e.g., specific chemical or physical properties).
- **Domain-specific workflows or algorithms** (e.g., a defined method for balancing chemical redox reactions).
- **Reliable execution of multi-step solution processes**.

While the introduction of models enhanced for "reasoning" or "thinking" has improved the ability of LLMs to handle multi-step tasks (by simulating reasoning processes through specialized training or fine-tuning), they often share the same core knowledge base as standard models. Consequently, gaps related to specialized factual data and established workflows remain a challenge that requires separate solutions.

For example, simply prompting a general LLM to `Perform peer review of the attached manuscript` is unlikely to produce a particularly useful result. This is likely because actual peer reviews are typically confidential and not widely available as training data for foundational models, highlighting a specific knowledge and process gap.

Several strategies can help bridge these gaps:
1. **Training a new model from scratch:** Tailoring a model specifically for a domain (e.g., chemistry) or task (e.g., chemical reaction extraction). This is the most resource-intensive option but offers maximum control.
2. **Fine-tuning pre-trained models:** Adapting existing models with domain-specific data. This is less resource-intensive than training from scratch but still requires expertise and faces certain constraints.
3. **In-context learning:** Providing necessary knowledge and workflow guidance directly within the prompt given to the LLM.

Among these strategies, in-context learning is often the most practical approach as it requires no changes to the underlying model and can be used with most available LLMs, including proprietary ones.

### In-Context Learning

[In-context learning](https://en.wikipedia.org/wiki/Prompt_engineering#In-context_learning) primarily utilizes [prompt engineering](https://en.wikipedia.org/wiki/Prompt_engineering) to guide the LLM by leveraging its _context window_ (essentially, the working memory encompassing the current conversation and provided materials). Thanks to underlying [meta-learning](https://en.wikipedia.org/wiki/Meta-learning_(computer_science)) capabilities developed during foundational training, the model can integrate this immediate contextual information with its pre-existing knowledge. This enables more coherent, logically consistent responses and allows the model to tackle complex problems using specialized prompting techniques, even if relevant data was limited during its initial training.

This crucial contextual information can be supplied to the model in several ways:
- **Directly within the prompt text.**
- **Through attached files** (e.g., documents, data sheets).
- **Via special instructions or system messages** (when available).
These provided materials establish different types of context that shape the model's response. Let's explore these context types in more detail.

### Model Context

**Input Context**
_Input context_ supplies additional information about the initial conditions or data for a problem. Examples include:
- **Physical and/or chemical properties of reagents**: Providing data for analyzing possible chemical reactions based on a specific set of reagents.
- **Description of input format**: Detailing a data structure, perhaps for reverse-engineering a Python class module to represent serialized data.
- **Sample input files**: Offering examples, such as graphical primitives data used in rendering SPICE circuit element symbols, to help create a corresponding Python class.

**Transformation Context**
Often, one simply poses a question to an LLM and lets it determine the solution path. However, for more complex tasks where the model might struggle to find an appropriate approach, or where a specific, rigorous method is preferred, explicitly defining the _transformation context_ - the workflow or algorithm - can greatly enhance result quality.

Two common prompt-engineering methods for making workflows explicit are:
- **Hierarchical Decomposition**: Breaking a complex problem into a sequence of simpler, smaller tasks.
- **[Chain-of-Thought](https://en.wikipedia.org/wiki/Prompt_engineering#Chain-of-thought)** (CoT): Providing detailed, step-by-step demonstrations of intermediate reasoning.

These methods can be combined or used separately. For example, this experimental [prompt template](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Science/Chemistry/ChemicalReactionAnalysis.md) illustrates a structured, step-by-step workflow for analyzing chemical processes - ensuring the model follows a deliberate approach rather than taking shortcuts. Developing such explicit workflows can be challenging because human reasoning in specialized domains often involves [tacit knowledge](https://en.wikipedia.org/wiki/Tacit_knowledge). Formalizing these implicit processes may require [self-reflection](https://en.wikipedia.org/wiki/Self-reflection), generalization, and iteration. Nonetheless, codifying complex reasoning strategies is valuable, especially as AI capabilities advance.

**Output Context**
_Output context_ outlines requirements for the final output's content, organization, or format. For instance, one might require generated text to adhere to a particular [language style](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Writing/WritingStyleGuidelines.md) or generated code to conform to a specific [coding style](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Code/Python/PythonStyleGuidelines.md). This ensures consistency, clarity, and alignment with project or organizational standards.

**Behavioral Context**
Guiding the model's persona, tone, or interaction style through _behavioral context_ (e.g., via role prompting) is another way to shape the output. The effectiveness of this can vary and may depend on the specific model and task, partly because this aspect of LLM behavior can be less predictable or opaque. Examples include instructing the model to act as a specific expert or adopt a formal tone.

### Limitations

While powerful, in-context learning relies entirely on information supplied within the prompt (including text, attachments, and history), which is subject to several constraints:

**Context Window / Input Tokens Limit**
The prompt is constrained by the model’s **context window** - the maximum number of [_input tokens_](https://ai.google.dev/gemini-api/docs/tokens) (the basic units processed by LLMs) it can handle. Larger inputs consume more tokens, reducing capacity.

**Context Recall Accuracy**
Furthermore, as context window usage increases, context recall accuracy may degrade, especially for information placed in the middle of long prompts. While context limits are rapidly expanding (cf. [Google’s long-context support](https://ai.google.dev/gemini-api/docs/long-context)), enabling more robust in-context learning (e.g., extensive *[many-shot](https://ai.google.dev/gemini-api/docs/long-context#:~:text=Many%2Dshot%20in%2Dcontext%20learning)* examples, more reference material, longer workflows), this fundamental limitation remains.

**Output Tokens Limit**
The number of _output tokens_ is typically limited separately, often to a fraction of the input context window size. If instructions require detailed or lengthy responses (e.g., showing intermediate steps), the model might start “compressing” the output (omitting details) as it nears this limit. Preserving detail might necessitate breaking prompts into smaller segments.

**Subscription Plan Differences**
Free vs. paid tiers often have different usage limits (input/output token caps). Complex tasks generally benefit from the larger capacities of advanced plans.

---
---

## Hierarchical Modular Analysis Framework

Simulating the peer review process proved to be a challenging task requiring strong reasoning capabilities. Initial trials with `ChatGPT Plus o1` were promising but limited by usage caps and potential token constraints, while Gemini 2.0 Flash Thinking yielded mixed results. Initial tests of Gemini Advanced 2.5 Pro soon after its introduction demonstrated its superiority for this task over other models tested, which might still be suitable with certain caveats.

The strong reasoning power of Gemini Advanced 2.5 Pro (referred to here as _the model_ or gapAI), combined with less restrictive usage limits, allowed for more efficient iterative development. The improved feature set enabled the creation of a complex prompt structure involving a combination of several advanced prompting techniques to meet the specific challenges of simulating peer review.

The prompt language follows the common practice of interacting with the AI anthropomorphically - using direct instructions as if addressing a human expert - based on the [idea](https://www.oneusefulthing.org/p/on-the-necessity-of-a-sin) that this convention facilitates interaction, despite the underlying differences in how AI processes information. This text follows a similar convention (e.g., when discussing AI's ability to _understand_ user input or something being described/explained to the model).

**Note on Development Tools:** The complex, Markdown-based structure of this prompt benefits significantly from appropriate development tools. A feature-rich Markdown editor, such as [Obsidian](https://obsidian.md), is highly recommended. For managing revisions, I utilize version control systems (VCS) like [GitHub](https://github.com) (Git-based) and [Fossil-SCM](https://fossil-scm.org). As prompts employing patterns like persistent workflows become increasingly intricate, adopting tools and techniques from knowledge management or software development for managing complexity may prove beneficial.

### Persistent Workflow Prompting

While the prompt utilizes a common structured approach (separating **Role/Persona** and **Context** from **Task/Objective**), the complexity of manuscript review necessitated a much more detailed framework. This advanced structure moves beyond basic functional separation to focus primarily on *how* the analysis should be performed and *what* specific steps are involved, detailing procedural components typically found only in highly specialized prompts.

The prompt features a hierarchical modular structure, utilizing hierarchical decomposition and chain-of-thought techniques within **Section [IV. Specific Analysis Instructions (Baseline Framework)][Framework]**. This core section implements the simulated peer review workflow. Its instructions are formatted using Markdown, submitted directly to the model; this formatting is crucial for helping the model parse and understand the intended structure and relationships between steps.

A key technique involves designing the prompt to function as a **persistent workflow library** loaded directly into the model's context memory (this design intent is explained to the model in Sections [III. Context: Framework for Critical Manuscript Review][Framework] and [V. Final Instructions for Interaction][Final Instructions]). Instead of generating an immediate, one-off answer, the main prompt's instructions are stored in the model's working memory for the session. When the user makes subsequent, specific requests, the model applies the relevant predefined workflows from this internal library. This approach avoids needing to resubmit the large framework repeatedly and enables more interactive, focused analysis.

The main **Section [IV. Specific Analysis Instructions][Framework]** serves as this library. For instance:
- A query about the main result triggers the workflow defined in [IV.B. Identifying Claimed Results and Contributions][MainResults].
- A request to analyze a specific figure uses the workflow in [IV.C. Analyzing Figures][FigureAnalysis].
- A combined request like `Analyze figures related to the main result` prompts the model to first execute the IV.B workflow, identify the relevant figures, and then apply the IV.C workflow to each.
- Analyzing the core experimental protocol ([IV.D.2][ExperimentalCore]) involves prerequisite workflows like IV.D.1, IV.B, and IV.C, executed logically based on instructions in IV.A.3. _(N.B.: The current implementation focuses core protocol analysis on key stages; further expansion is needed for full analysis.)_

This method utilizes a form of in-context learning, activating the workflow library directly via the initial chat prompt rather than through separate custom instruction features (like Custom GPTs or Gemini Gems, though the concept is similar). The core function goes beyond simple persistent instructions: the prompt systematically defines detailed workflows for highly complex analysis tasks, effectively acting as a program written in natural language.

### Ad Hoc Classification for Guided Information Extraction

While gapAI effectively extracts specific information, parsing that information for deeper analysis can be challenging, and occasional variations occur even with stable targets like the main result. For example, the test paper claimed "economical enrichment of 17O-water... via slow evaporation and fractional distillation". A thorough analysis requires separating the _unmet need_ (access to cheap 17O-water) from the _claimed novelty_ (the specific combination of methods). This separation allows for independent assessment of the problem's significance and the ingenuity/validity of the proposed solution. To guide the model in making such distinctions generically, the prompt employs _ad hoc classification_. This involves defining categories tailored to the document type (experimental chemistry) and the specific analytical goals. For instance, Section IV.B.1 includes a "Classification of the Main Claimed Result based on targeted unmet need". This classification helps distinguish the problem being addressed. A potential refinement would be to add a separate, parallel classification specifically for the 'novelty component' (e.g., classifying the type of innovation claimed), rather than just adding comments, to enable even more distinct analysis of both aspects.

### Behavioral Context & Persona Engineering

The **[II. Persona: Expert Critical Reviewer][Persona]** section focuses on behavioral context & persona engineering. While role prompting (instructing the model to act as a character) is common, this prompt goes further by rationalizing desirable reviewer characteristics and projecting them onto the model via detailed role descriptions with associated traits. To reinforce these traits and improve compliance within the large, complex prompt, multiple role models focusing on different character aspects were defined, and key instructions were intentionally repeated (given that models lack perfect recall).

The primary goals of this detailed persona engineering:
1. **Counteracting Outcome Bias:** This was crucial. Models often use reported results to justify methodology. The persona instructions repeatedly emphasize that results _cannot_ be used to validate methods; methodology must be assessed independently based on scientific principles because a core principle of scientific review is to evaluate the soundness of the methodology independently of the claimed outcome. A flawed method cannot yield reliable results, regardless of claims.
2. **Encouraging Rigor:** The persona promotes detailed, critical output, explicitly setting the standard as equivalent to a high-stakes academic examination scenario, demanding meticulousness, clear justification, and proactive identification of potential issues.
A third aspect addresses handling proof-of-concept studies, where some deviations from academic rigor might be acceptable if justified (this aspect is elaborated upon in the main workflow instructions).

### Final Instructions

The concluding **[V. Final Instructions for Interaction][Final Instructions]** section serves several key functions. Primarily, it reiterates crucial instructions from earlier sections, particularly reinforcing the core principles of the Persona (Section II) and critical constraints like independent methodological scrutiny (Section IV.A), ensuring these constituents are consistently applied throughout the interaction. It also defines the 'default' analysis workflow - the specific sequence of analysis steps (e.g., executing the full protocol analysis outlined in Section IV.D) that the model should perform automatically when given a general request like `Review this paper`, providing a standardized starting point. Finally, it provides output context guidelines, potentially including instructions on structuring the response, using Markdown effectively, citing sources appropriately, and explicitly stating assumptions, further ensuring the output meets the persona's rigorous standards.

## Formalizing the Review Process

A significant challenge involved translating the complex human task of scientific peer review into specific, executable instructions for the model. I approached this translation through reflection and generalization: I analyzed flaws in a specific test manuscript to articulate corresponding checks and analysis steps in a generic format applicable to other experimental chemistry papers. For development and testing, I selected a particular [publication][EnrichmentURL] (repo [copy with SI](Enrichment of H2 17O from Tap Water, Characterization of the Enriched Water, and Properties of Several 17O-Labeled Compounds.pdf)), which exhibited significant, demonstrable flaws, representing a remarkable example of a disastrous failure of the peer review process. (I am not sure which is more stunning: how ridiculous (fairly close to perpetuum mobile) the main idea of the paper, how ineptly it was fabricated, how profoundly incompetent the PI on the paper is, or how on Earth this piece of work could ever reach reviewers, let alone get published in a good journal.) Because this paper is riddled with issues, it proved particularly helpful for developing relevant instructions via the reflect/generalize workflow and served as a challenging test case for the prompt's ability to guide critical analysis.

### Main Result and Key Findings

Identifying the authors' main claimed result and key findings precisely is the crucial first step in the analysis workflow, as it defines the core assertions against which all evidence must be evaluated. While gapAI demonstrated a strong ability to extract this information, initial tests showed it sometimes returned peripheral points alongside the central claims, leading to variability. To improve stability and focus the starting point for the review, I refined the prompt instructions (Section IV.B) to narrow the model's search scope. Leveraging conventional manuscript structure, the prompt directs the model to identify the main result and key subsidiary findings based only on the information presented in the Title, Abstract, Introduction, and Conclusion sections. This focuses the initial analysis on the authors' explicitly stated primary contributions before delving into the detailed experimental support.

### Multimodal Figure Analysis

Leveraging the multimodal analysis capabilities of Gemini _Advanced_ 2.5, Section [IV.C. Analyzing Figures][FigureAnalysis] was drafted to incorporate visual information. (It's worth noting that during development, other tested models including Gemini 2.5 Pro Standard, ChatGPT Plus o1, and SuperGrok Grok 3 Think were unable to perform this type of figure analysis.) The workflow outlined in Section IV.C guides the model to first provide an overview of a figure's structure (panels, types) and then describe each component in detail. Particular emphasis is placed on analyzing photographs to assess the model's capacity for genuine visual interpretation and correlation with textual descriptions.

This approach proved effective with the test manuscript. For example, the model, guided by the prompt, consistently identified details like the aluminum foil insulation in Figure S1 (absent from the text) and correlated visual elements in photos with corresponding schematics and text. Furthermore, using the generic instructions in Section IV.C, the model successfully tackled the more complex task of inferring scale and estimating dimensions. By comparing visual elements to known parameters (such as the stated volume of the feed RBF to estimate its diameter), it could extrapolate to estimate other dimensions, like the fractionation column length. Although the precise numerical results varied across test runs, the order-of-magnitude estimates obtained were adequate for evaluating the described setup's potential efficiency.

### Experimental Protocol

The workflow for analyzing the experimental protocol is detailed in Section [IV.D. Analyzing the Experimental Protocol][Experimental]. This section is currently structured in two parts:
- **IV.D.1 (General Analysis):** Provides a broad overview of the entire experimental workflow, assessing logical flow, completeness of reporting, contextual appropriateness (e.g., PoC vs. validation), and flagging general red flags (questionable methods, missing controls, safety issues) across all stages. 
- **IV.D.2 (Core Protocol Analysis):** Performs an in-depth, highly critical examination focused only on the specific experimental steps claimed to directly produce the main result.
This tiered structure allows for both a contextual overview and a focused deep analysis, although the split adds complexity. A potential refinement might involve defining different scopes of execution (e.g., 'overview', 'core analysis') for a single, unified workflow section.

A central goal during the development of Section IV.D was to embed instructions for performing quantitative feasibility checks based on fundamental principles - a critical aspect of rigorous scientific review. The prompt guides the AI to, for instance: identify key physical or chemical processes involved (like evaporation or distillation in the test case); select appropriate theoretical models (e.g., applying principles of phase equilibria, reaction kinetics, separation theory, or mass/energy balances); extract, estimate, or research necessary parameters (from text, figures, standard equipment specifications, or literature); calculate theoretically expected outcomes or limits (like maximum enrichment or theoretical yield) under idealized conditions; and crucially, compare these _a priori_, physics-based estimates against the authors' claims. The aim is to assess if the described method is fundamentally capable of achieving the claimed results, independent of whether the authors report success. This goal is reflected in the sample analysis provided (Section D.2, Stage A.F and B.F), where the prompt successfully guided the AI to perform idealized calculations (Vapor Pressure Isotope Effect, Fenske) and compare the theoretical potential of the described methods to the authors' claims.

Furthermore, reflecting on the test case led to the inclusion of a specific high-level "Plausibility Check" (corresponding to section IV.D.2.5). This functions as a sanity check, particularly relevant for potentially groundbreaking claims. It involves assessing scenarios where:
- A study reports performance significantly exceeding established benchmarks.
- A potentially disruptive result is claimed.
- The method relies on conventional equipment/principles, perhaps with custom modifications.
- No clear, scientifically justified innovative step is presented to explain the breakthrough.
If such a discrepancy between claimed impact and methodological basis exists, the prompt guides the AI to question the _a priori_ plausibility, considering the maturity of the field: is it likely such a straightforward path to a high-impact result would have been widely overlooked? This check, directly inspired by the test case, instructs the AI to compare the claimed impact against the apparent simplicity/novelty of the method, flagging potential inconsistencies that demand extraordinary corroborating evidence, as seen clearly in the sample analysis conclusion (D.2.5).

## Sample Queries

Here are potential prompts to submit after the framework prompt:

- `Analyze the core experimental protocol`
- `Extract the main experimental result and key findings`
- `List all figures and tables directly associated with the core experimental protocol and main result`
- `Provide a detailed description of each figure associated with the core experimental protocol`



---
---

<!-- References -->

[EnrichmentURL]: https://pubs.acs.org/doi/10.1021/ac1022887
[Raw Prompt]: https://raw.githubusercontent.com/pchemguy/ChatGPTExploratoryPrompting/refs/heads/main/Science/LLM%20Methodology/In-Context%20Learning/Paper%20Review/PeerReviewPrompt.md
[Gemini Demo]: https://aistudio.google.com/app/prompts?state=%7B%22ids%22:%5B%221sUZsweVq3MU_Et2VNS89IMfgYLIzCKMe%22%5D,%22action%22:%22open%22,%22userId%22:%22101058840941883201829%22,%22resourceKeys%22:%7B%7D%7D&usp=sharing
[Gemini Analysis]: Gemini%20Analysis.md
[o1 Demo]: https://chatgpt.com/share/67f2cad6-0068-8004-818e-da96c4e4544d
[Grok Demo]: https://grok.com/share/bGVnYWN5_0cca0b8b-1298-49ad-a1b2-8e6af6a686e8

[Core Objective]: PeerReviewPrompt.md#i-core-objective
[Persona]: PeerReviewPrompt.md#ii-persona-expert-critical-reviewer
[Context: Framework for Critical Manuscript Review]: PeerReviewPrompt.md#iii-context-framework-for-critical-manuscript-review
[Framework]: PeerReviewPrompt.md#iv-specific-analysis-instructions-baseline-framework
[Final Instructions]: PeerReviewPrompt.md#v-final-instructions-for-interaction

[MainResults]: PeerReviewPrompt.md#b-identifying-claimed-results-and-contributions-based-only-on-title-abstract-introduction-and-conclusion
[FigureAnalysis]: PeerReviewPrompt.md#c-analyzing-figures-charts-schematics-photos
[ExperimentalCore]: peerreviewprompt.md/#d2-in-depth-analysis-of-the-core-experimental-protocol-implementation-of-the-main-result:~:text=practices.%20Cite%20sources.-,D.2.%20In%2DDepth%20Analysis%20of%20the%20Core%20Experimental%20Protocol%20(Implementation%20of%20the%20Main%20Result),-PREREQUISITE%3A%20Section
[Experimental]: PeerReviewPrompt.md#d-analyzing-the-experimental-protocol
[Multimodal PDF]: https://ai.google.dev/gemini-api/docs/document-processing
[Chat API]: https://ai.google.dev/gemini-api/docs/text-generation

[Gemini Editing History]: https://gemini.google.com/app/06a510d123e47ecf
