# An LLM Prompt for Simulating Academic Peer Review

## Summary <!--Highlight prompt engineering and review methodology ?-->

This post introduces a proof-of-concept LLM [prompt](PeerReviewPrompt.md) simulating academic peer review for experimental chemistry manuscripts, discusses related prompt engineering concepts, and suggests possible research directions. This prompt has been developed and tested using this [publication][EnrichmentURL], and its key features are highlighted below (detailed feature list [here](FrameWork_Features.md)).  

> [!Important]
>
> **Copying Prompt Text:** Please use the "Raw" button (usually found in the toolbar above the text) or use [this link][Raw Prompt] directly to copy the prompt text. Copying directly from the formatted view will not work.

**Basic usage (primary target: Gemini Advanced 2.5 Pro):**  
1. Input the full **raw Markdown-formatted** prompt in a new chat.
2. Submit `Analyze the core experimental protocol` prompt with the manuscript and SI.

See demos for [Gemini Advanced 2.5 Pro][Gemini Demo] ([verbatim copy of analysis][Gemini Analysis]), [ChatGPT Plus o1][o1 Demo], and [SuperGrok Grok 3 Think][Grok Demo] (click on "Analysis of Core Experimental Protocol for H<sub>2</sub><sup>17</sup>O Enrichment" at the bottom). Be aware that advanced components like process modeling, calculations, and multi-modal analysis may yield variable or failed results.

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

## Relevant Technical Aspects of LLM  
  
Widely available Large Language Models (LLMs)—such as OpenAI's _o1_ or Google’s _Gemini_ family - are evolving rapidly. However, they still face limitations when tackling complex, domain-specific research and engineering problems. Successfully addressing these limitations often requires integrating:
- **Relevant factual knowledge** (e.g., specific chemical or physical properties).
- **Domain-specific workflows or algorithms** (e.g., a defined method for balancing chemical redox reactions).
- **Reliable execution of multi-step solution processes**.

While the introduction of models enhanced for "reasoning" or "thinking" has improved the ability of LLMs to handle multi-step tasks (by simulating reasoning processes through specialized training or fine-tuning), they often share the same core knowledge base as standard models. Consequently, gaps related to specialized factual data and established workflows remain a challenge that requires separate solutions.

For example, simply prompting a general LLM to `Perform peer review of the attached manuscript` is unlikely to produce a particularly useful result. This is likely because actual peer reviews are typically confidential and not widely available as training data for foundational models, highlighting a specific knowledge and process gap.

Several strategies can help bridge these gaps:
1. **Training a new model from scratch:** Tailoring a model specifically for a domain (e.g., chemistry) or task (e.g., chemical reaction extraction). This is the most resource-intensive option but offers maximum control.
2. **Fine-tuning pre-trained models:** Adapting existing models with domain-specific data. This is less resource-intensive than training from scratch but still requires expertise and faces certain constraints.
3. **In-context learning:** Providing necessary knowledge and workflow guidance directly within the prompt given to the LLM. This is often the most practical approach as it requires no changes to the underlying model and can be used with most available LLMs, including proprietary ones.

[In-context learning](https://en.wikipedia.org/wiki/Prompt_engineering#In-context_learning) primarily utilizes [prompt engineering](https://en.wikipedia.org/wiki/Prompt_engineering) to guide the LLM by leveraging its _context window_ (essentially, the working memory encompassing the current conversation and provided materials). Thanks to underlying [meta-learning](https://en.wikipedia.org/wiki/Meta-learning_(computer_science)) capabilities developed during foundational training, the model can integrate this immediate contextual information with its pre-existing knowledge. This enables more coherent, logically consistent responses and allows the model to tackle complex problems using specialized prompting techniques, even if relevant data was limited during its initial training.

This crucial contextual information can be supplied to the model in several ways:
- **Directly within the prompt text.**
- **Through attached files** (e.g., documents, data sheets).
- **Via special instructions or system messages** (when available).
These provided materials establish different types of context that shape the model's response. Let's explore these context types in more detail.

---

### Input Context

_Input context_ supplies additional information about the initial conditions or data for a problem. Examples include:
- **Physical and/or chemical properties of reagents**: Providing data for analyzing possible chemical reactions based on a specific set of reagents.
- **Description of input format**: Detailing a data structure, perhaps for reverse-engineering a Python class module to represent serialized data.
- **Sample input files**: Offering examples, such as graphical primitives data used in rendering SPICE circuit element symbols, to help create a corresponding Python class.

[Retrieval-Augmented Generation](https://en.wikipedia.org/wiki/Retrieval-augmented_generation) (RAG) represents a set of advanced methods specifically for supplying relevant input context dynamically, often requiring additional tools and API access.

---

### Transformation Context

Often, one simply poses a question to an LLM and lets it determine the solution path. However, for more complex tasks where the model might struggle to find an appropriate approach, or where a specific, rigorous method is preferred, explicitly defining the _transformation context_ - the workflow or algorithm - can greatly enhance result quality.

Two common prompt-engineering methods for making workflows explicit are:
- **Hierarchical Decomposition**: Breaking a complex problem into a sequence of simpler, smaller tasks.
- **[Chain-of-Thought](https://en.wikipedia.org/wiki/Prompt_engineering#Chain-of-thought)** (CoT): Providing detailed, step-by-step demonstrations of intermediate reasoning.

These methods can be combined or used separately. For example, this experimental [prompt template](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Science/Chemistry/ChemicalReactionAnalysis.md) illustrates a structured, step-by-step workflow for analyzing chemical processes - ensuring the model follows a deliberate approach rather than taking shortcuts.

Developing such explicit workflows can be challenging because human reasoning in specialized domains often involves [tacit knowledge](https://en.wikipedia.org/wiki/Tacit_knowledge). Formalizing these implicit processes may require [self-reflection](https://en.wikipedia.org/wiki/Self-reflection), generalization, and iteration. Nonetheless, codifying complex reasoning strategies is valuable, especially as AI capabilities advance.

---

### Output Context

_Output context_ outlines requirements for the final output's content, organization, or format. For instance, one might require generated text to adhere to a particular [language style](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Writing/WritingStyleGuidelines.md) or generated code to conform to a specific [coding style](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Code/Python/PythonStyleGuidelines.md). This ensures consistency, clarity, and alignment with project or organizational standards.

---

### Behavioral Context

Guiding the model's persona, tone, or interaction style through _behavioral context_ (e.g., via role prompting) is another way to shape the output. The effectiveness of this can vary and may depend on the specific model and task, partly because this aspect of LLM behavior can be less predictable or opaque. Examples include instructing the model to act as a specific expert or adopt a formal tone.

---

### N-shot Learning (Learning by Example)

Beyond defining context directly, models can also learn from examples provided within the prompt. One-shot (single example) and few-shot (multiple examples) prompting - collectively known as _N-shot_ learning - involve providing demonstrations of the desired input, output, or input-output relationship.

A key feature is that the _transformation_ process often remains _implicit_ in pure N-shot learning. The model infers the appropriate transformation based on the examples, relying on its underlying training.

N-shot examples can illustrate any aspect: input format, transformation logic, or output style. For instance:
- **Reformatting**: Provide examples pairing paragraphs with their corresponding bulleted lists.
- **Code Style**: Show multiple code examples following specific guidelines, perhaps with brief explanations.    
- **Reverse-engineering**: Offer sample files of serialized objects (e.g., electrical component symbols) for the model to infer a class implementation.

Generally, more diverse and numerous examples improve performance, but the total number is constrained by the model's _context window length_.

---

### Limitations of In-Context Learning

While powerful, in-context learning relies entirely on information supplied within the prompt (including text, attachments, and history), which is subject to several constraints:

**Context Window Constraints**
The prompt is constrained by the model’s **context window** - the maximum number of [_input tokens_](https://ai.google.dev/gemini-api/docs/tokens) (the basic units processed by LLMs) it can handle. Larger inputs consume more tokens, reducing capacity.

Furthermore, as context window usage increases, recall accuracy may degrade, especially for information placed in the middle of long prompts. While context limits are rapidly expanding (cf. [Google’s long-context support](https://ai.google.dev/gemini-api/docs/long-context)), enabling more robust in-context learning (e.g., extensive *[many-shot](https://ai.google.dev/gemini-api/docs/long-context#:~:text=Many%2Dshot%20in%2Dcontext%20learning)* examples, more reference material, longer workflows), this fundamental limitation remains.

**Output Token Limits**
The number of _output tokens_ is typically limited separately, often to a fraction of the input context window size. If instructions require detailed or lengthy responses (e.g., showing intermediate steps), the model might start “compressing” the output (omitting details) as it nears this limit. Preserving detail might necessitate breaking prompts into smaller segments.

**Subscription Plan Differences**
Free vs. paid tiers often have different usage limits (input/output token caps). Complex tasks generally benefit from the larger capacities of advanced plans.

---
---

## Design of the Presented Prompt

### The Goal

The goal of this project was to see if it was possible to craft an LLM prompt such that a meaningful analysis of an experimental chemistry manuscript could be produced by submitting the manuscript alone with a prompt like `Review the attached paper` (in addition to the crafted prompt).

### Test Publication

For development and testing, I have used this [publication][EnrichmentURL] (repo [copy](Enrichment of H2 17O from Tap Water, Characterization of the Enriched Water, and Properties of Several 17O-Labeled Compounds.pdf) with SI), which is a remarkable example of a disastrous failure of the peer review process. (Actually, I am not sure which is more stunning: how ridiculous the main idea of the paper, how ineptly it was fabricated, how profoundly incompetent the PI on the paper is, or how on Earth this piece of work could ever reach reviewers, let alone get published in a good journal.) Well, at least I had an interesting specimen for my little project...

### Target Model

Given the desired project goal, it was fairly clear that I only had chances with reasoning models. I have made initial attempts with ChatGPT Plus o1. The start was promising. However, performing development with the limit of 50 prompts per week is not very efficient, and I was not willing to pay ten times more for the Pro. The other problem was that I think I hit some input/output token limits. I did try Gemini 2.0 Flash Thinking with mixed results. I suspended the project and considered spending less time doing AI, when Google released Gemini Advanced 2.5 Pro. Google also did not have this 50 prompts per week limit, so I decided to give it another try. From this point forward,

### Conventions

I will use *the model* or gapAI as a shortcut for Gemini Advanced 2.5 Pro. Other reasoning models generally can also be swapped for this shortcut, with certain restrictions. Further, there is this [idea](https://oneusefulthing.org/p/on-the-necessity-of-a-sin?utm_source=publication-search) of interaction with AI as if it were a human (anthropomorphization), hence the concepts of AI learning / understanding / thinking / reasoning or not, even though it does not do those things, at least not in a human sense. Following this approach, the prompt text directly instructs the model to perform various actions or to behave a certain way.

### Prompt Design Methodology

The top-level block structure is roughly based a common pattern used for structured prompts, where the full prompt is split into several blocks that provide behavioral context (**Role** / **Persona** and **Context**) and task description (**Task** / **Objective**). This functional separation is not strict, of course, and the complexity of present objective necessitated a considerably more complex structure, with primary focus on **how** and **what** to do - the component which is generally only included in advanced prompts.

#### Hierarchical Modular Analysis Framework

The presented prompt employs several advanced design strategies. First of all, the primary content block, **[IV. Specific Analysis Instructions (Baseline Framework)][Framework]**, which is responsible for actual implementation of the simulated peer review workflow, organizes instructions using two earlier mentioned established techniques, hierarchical decomposition and chain-of-thought. The content structure is formatted with Markdown marking, which directly submitted to the model as part of the prompt and interpreted by the model.

Next, the prompt designed to be added to the current context directly, rather than producing immediate answer (appropriate instructions describe this design intent to the model and provide specific usage guidelines in sections [III. Context: Framework for Critical Manuscript Review][Framework] and [V. Final Instructions for Interaction][Final Instructions]). The idea is that the instructions are stored in the working memory and used with later prompts. For example, I could prompt the model to retrieve the main result from the manuscript in subsequent prompt, and, when executing, the model would apply earlier parts of earlier submitted prompt related to main result extraction. This approach is not completely new. ChatGPT projects support limited project-wide instructions, and when custom GPTs or Gemini Gems are created, custom instructions are also used that will apply for all conversations. I am not aware, however, whether this idea of deliberately submitting workflow instructions directly through the chat prompt for subsequent use (this is basically a variant of in-context learning) has been employed before, and I have not made any attempt to see if it was. So I am not going to claim any novelty here and simply present employed concepts as used. 

Finally, them main **[IV. Specific Analysis Instructions (Baseline Framework)][Framework]** section is designed as a library of workflows or a framework for performing individual analysis tasks, as well as for performing integrated tasks. For example, [IV.B. Identifying Claimed Results and Contributions (Based ONLY on Title, Abstract, Introduction, and Conclusion)][MainResults] defines a workflow for extracting the key findings. If in a subsequent prompt I inquire about the main result, the model will use this block to follow a predefined workflow. Similarly, if I request an analysis of a particular figure, the model would follow workflow of the section [IV.C. Analyzing Figures (Charts, Schematics, Photos)][FigureAnalysis]. Further, if my first request after submitting the framework prompt is something like `Analyze all figures directly associated with the main result`, the model identifies the need to find the main result first, which triggers the section IV.B, than it identifies related figures, and applies section IV.C for subsequent analysis. If analysis of the core experimental protocol is requested, as suggested in the summary, the model identifies the Section [IV.D.2][ExperimentalCore] as the primary target workflow (with additional instructions in IV.A.3); then the model identifies Sections IV.D.1, IV.B, and IV.C as perquisites and executes these workflows in logical order. (N.B.: analysis of the core experimental protocol focuses on the stages directly contributing to achieving the main result. I have not defined further workflows for a more complete analysis at this stage, because for the test paper it was sufficient to properly analyze this stages. Further expansion of the prompt is necessary to implement a more extended analysis.) 

[III. Context: Framework for Critical Manuscript Review][Framework] primarily describes the modular/framework prompt design to the model. 

#### Ad Hoc Classification for Guided Information Extraction

gapAI is quite good at extracting specific information from pdf. Nevertheless, occasionally even with relatively stable targets, such as the main result, some variations occur when the information is extracted or further in the processing workflow. Another somewhat tricky part is to do further parsing of the extracted information for analysis purpose. E.g., in the test paper used the authors reported an "economical enrichment of 17O-water from tap water via slow evaporation and fractional distillation". There are actually two constituents of interest that should be clearly articulated and at some point analyzed separately, namely what unmet need the study is trying to address (access to cheap highly enriched 17O-water) and where the main novelty resides (reported combination of slow evaporation and fractional distillation). I will discuss the utility of this separation in "Dissecting the Paper" section. Here I want to focus on how this information could be possibly made available in a generic way. One way to guide gapAI in further parsing is by defining an ad hoc classification that captures the targeted scope of documents (here, experimental chemistry manuscript) and the desired characteristic. Hence, I defined "Classification of the Main Claimed Result based on targeted unmet need" as part of the Section IV.B.1, though I made a mistake: instead of defining a separate classification that focused on novelty containing component, I added comments to the section 2.b of this classification.

#### Behavioral Context

[**II. Persona: Expert Critical Reviewer**][Persona]  
The role prompting technique where prompt instructions tell the model to behave as a particular character is a common, though somewhat opaque, means to steer the transformation process and facilitate certain output format or content without explicitly describing such requirements. I went further, by trying to rationalize desirable characteristics of an expert reviewer and imprinting/projecting those characteristics onto the model via detailed description of the indicated roles with associated traits. 

I have pursued two primary goals here. The first one was crucial: erasing the bias coming from the reported result. When models read the manuscript, the reported results by default become the basis for supporting reported methodology. So when I asked the model to analyze experimental protocols, it would typically used the results to support its arguments. This behavior is, of course, completely unacceptable and needed to be addressed by emphasizing and reemphasizing that the reported results can never be used throughout performed analysis as supporting arguments. The second major goal was to encourage the model to produce a detailed rigorous output. While I described this requirements explicitly, I also figured that a good model setting for this behavior could be an advanced examination.

I also included a third aspect to specifically address studies that might have reported important results as proof-of-concept experiments, where, in principle, certain deviation from academic rigor can be tolerated if properly justified. This aspect is further developed in the primary workflow section of the prompt.  

As can be seen from the prompt text, I actually defined multiple role models that focus on different character aspects. The text is also occasionally repetitive (and not only in this section). This redundancy is intentional and important. Because model does not recall content with 100% accuracy, reiterating the most important points throughout a large complex prompt improves model compliance.

At the same time I should stress that I have made no attempt to evaluate the effect of using both role models and associated detailed descriptions. Neither did I try to optimize strategic repetitions. These aspects may very well be a topic of a separate methodological prompt engineering research. 

[V. Final Instructions for Interaction][Final Instructions] mostly reiterates important instructions, defines "default" analysis workflow, and provides output context instructions.

---

### Formalizing the Review Process

 So, gapAI did not know what reviewing a paper meant. Perhaps, I could actually give it specific step-by-step instructions that gapAI could understand and execute and that would implement some kind of an equivalent of a review process, except what those instructions would be?... So I decided to resort to some reflection and generalization exercise: I started considering the various issues with the test paper and trying to articulate checks / analysis instructions targeting those issues in a generalized way.

#### Main Result and Key Findings

The first logical step was to have the gapAI identify the main result and key findings. It turned out that gapAI could extract this information remarkably well. There was some variability, but it was not a big deal. However, from time to time, gapAI would return too much. To make this result more stable, I narrowed the search scope by taking advantage of conventional manuscript structure: the main result is often included in the title, and the main result and subsidiary key findings must be present in the abstract, conclusions, and, often, in the second part of introduction leading to the experimental section. 

#### Multimodal Figure Analysis

Gemini *Advanced* 2.5 Pro supports multimodal figure analysis, so I drafted the Section [IV.C. Analyzing Figures (Charts, Schematics, Photos)][FigureAnalysis] focused on figure analysis. The workflow involves overall description of the figure (which may include, for example, a schematic of experimental setup and a photograph) composition as the first step. The second step is detailed description of individual figure components. The section IV.C intentionally places significant emphasis on photographs, as I wanted to push and test the model abilities, and, at the same time, to see that the model truly interprets the content of photos by comparing produced output with the actual photographs. For example, in case of the present test manuscript, the prompt reliably identifies the aluminum foil (which is not mentioned anywhere in text) in figure S1 wrapped around the fractionating column. Instructions also specifically request to link visual information in pictures to information in schematics and text.

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

[Multimodal PDF]: https://ai.google.dev/gemini-api/docs/document-processing
[Chat API]: https://ai.google.dev/gemini-api/docs/text-generation