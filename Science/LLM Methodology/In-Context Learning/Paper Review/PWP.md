# **AI Simulation of Scholarly Peer Review via** **Persistent Workflow Prompting,** **Meta-Prompting, and Meta-Reasoning**

Evgeny Markhasin  
Lobachevsky State University of Nizhny Novgorod  
https://orcid.org/0000-0002-7419-3605  
https://linkedin.com/in/evgenymarkhasin

## **Notes**

>[!Warning]
>
> - **Consider adding TOC**  
> - **Add notes on (Markdown, XML, JSON, hierarchy, etc.) to 2.2.2 Persistent Workflow Prompting (PWP)**  
> - **Description of shared convos in SI**  
> ---  
> - This chat documents the use of ai for revision of the manuscript. It also servers as a demo of advanced active use of ai as a peer for development of the manuscript. It begins with a draft already containing preliminary revised sections.
> ---  
> - By taking advantage of meta-reasoning and codifying tacit knowledge, it is likely possible to develop PWP libraries for solving many STEM problems (including those presented at international subject olympiads and humanity’s last exam) using workflows similar to those applied by humans. Further, such PWP libraries may demonstrate compatible performance between different frontier models and significantly improved stability of solutions for complex workflows between different runs.
> ---
> - Presented PWP-based prompt for critical peer-review-like analysis of experimental chemistry manuscripts demonstrated robust performance across frontier reasoning LLM models and between runs. The prompt successfully elicited complex in-depth generally reproducible analysis of the test manuscript and reliably picked major flaws within the prompts target scope.
> ---
> - The prompt has been developed and tested using a single flawed manuscript as available from the publisher. The manuscript was combined with supporting information file as provided by the publisher, but no other modifications have been introduced into the manuscript. No quantitative benchmark has been constructed for systematic evaluation of prompt performance; performance-related statements are solely based on author’s conventional (as in human-driven) evaluation of generated analyses.
> ---
> - Development of specialized domain- or even task-specific benchmarks for complex STEM tasks targeted by PWP architecture may prove instrumental for systematic refinement or such prompts. Of interest is development of focused benchmarking techniques that would enable gauging performance of individual blocks/sections within complex hierarchical prompts. If such techniques are combined with PWP-based meta-meta-prompts (to be developed) targeting LLM-driven meta-analysis of PWP-prompt performance, an automated sematics-driven prompt refinement process may be devised.



## **Abstract**

Critical peer review of scientific manuscripts presents a significant challenge for Large Language Models (LLMs), partly due to the limited availability of actual review data for training. This report introduces Persistent Workflow Prompting (PW prompting or PWP), a prompt engineering methodology designed to bridge this gap using pure prompting techniques within standard LLM chatbot interfaces (no coding or APIs required). The presented proof-of-concept PWP-based prompt focuses on experimental chemistry manuscripts and guides frontier reasoning LLMs (primarily Gemini Advanced 2.5 Pro) through a systematic, multimodal analysis. The prompt features a hierarchical, modular architecture formatted in Markdown, defining complex review tasks as structured workflows. Submitted once at the start of a session, this master prompt equips the LLM with persistent workflows triggered by subsequent user queries (e.g., Analyze the core experimental protocol). Key capabilities demonstrated by the prompt include: identifying core claims vs. evidence, performing multimodal analysis integrating text and figures (including photographs), inferring missing parameters, executing quantitative feasibility checks via idealized process modeling and a priori estimations, comparing these estimations against claimed results, and assessing overall experimental plausibility. This work highlights the potential of advanced prompt engineering to enable complex, domain-specific reasoning and analysis in scientific research using readily available LLMs.

## **1. Introduction**

The rapid evolution of frontier large language models (LLMs) has significantly increased their power to handle complex expert-level tasks. This increasing power, in turn, stimulates research exploring ways to further expand LLMs' abilities and identify novel applications. Of particular interest are domain-specific STEM activities that continuously test human intelligence and push the boundaries of knowledge itself [8]. This focus is evident in the development of challenging benchmarks testing LLM abilities on problems ranging from international subject olympiads (e.g., OlympiadBench [9]) to graduate/expert-level STEM problems (GPQA [10], SuperGPQA [11], SciQA [12, 13], SciQAG [14], and Humanity's Last Exam [15]). Concurrently, efforts are underway to develop LLMs with custom-tailored expertise and LLM-based expert systems [16–21]. While the capabilities of reasoning models like OpenAI o1 [22] and Google Gemini 2.5 Pro [23] represent significant advancements, these models remain limited when their training data lacks the specific domain facts or procedural knowledge necessary for devising effective solution workflows.

Several strategies can help bridge these gaps:

1. **Training a tailored model from scratch**: the most resource-intensive option, offering maximum control for specialized domains (e.g., protein chemistry) and tasks (e.g., chemical reaction extraction).
2. **Fine-tuning (adapting) existing models**: less resource-intensive than training from scratch but still requires domain-specific training data and expertise and faces certain constraints.
3. **Steering responses at inference time**: often the most practical approach that relies on advanced prompting techniques to provide necessary knowledge and workflow guidance directly within the prompt, requiring no changes to the underlying model and compatible with most available LLMs, including proprietary ones.

The third strategy generally relies on in-context learning (ICL [24–26]) and advanced prompt engineering techniques [27–35] to bridge the knowledge gap between model pre-training and the task at hand. Particular appeal of inference-time techniques stems from their ability to take full advantage of the most powerful frontier models, which incorporate
- the most expensive training (only accessible to select few vendors in the world),
- the best continuously improving world understanding,
- emerging multimodal analysis functionality,
- rapidly increasing inference-time limits.
Building on the potential of prompt engineering, this study focuses on developing and applying advanced prompting techniques to the challenge of AI-driven scholarly peer review, acting as a model complex problem of significant interest.

### **1.1 Scholarly Peer Review**

Scholarly peer review is a cornerstone of academic research, demanding significant time, domain expertise, and critical reasoning. Using technical means to facilitate this process is a long-standing goal, which has gained urgency with the explosive growth of publishing activities and the recent advances in generative AI technologies increasingly used in academic publishing ==[###]==. The last few years alone have witnessed a wealth of publications addressing this automation problem via diverse approaches, including basic and methodological research [36–44], graph-based manuscript modeling [45], prompt-focused techniques [40, 44], probing capabilities of private and open-source models [36, 46, 47], investigations with reasoning models [38, 48], training custom models [47–49], developing multi-model/agentic systems [36, 45–47, 50, 51], and launching publicly accessible services [36, 41, 48, 52]. Due to its intellectually demanding nature, using AI for peer-review-like feedback also serves as a valuable method for evaluating and pushing the boundaries of advanced models.

Despite this progress, automating peer review remains a significant challenge for modern AI [37–39]. Key difficulties include inherent complexity of this task, the need for field-specific tailoring, and the historical lack of readily available, large-scale training datasets (with a number of attempts to address the latter issue [41, 43, 46–48, 53–60]). Furthermore, existing approaches often face limitations. Training data consisting of high-level reviewer comments may not effectively teach models the detailed, step-by-step reasoning required for rigorous manuscript evaluation. Similarly, prompts based solely on common reviewer guideline questions (see, e.g., [61]) may fail to elicit the necessary depth of analysis compared to methods like chain-of-thought (CoT) prompting [62–64].

### **1.2 Our Approach: Persistent Workflow Prompting**

To address these limitations, particularly the need for detailed procedural guidance in AI-driven review, we explore an approach centered on advanced prompt engineering. Instead of relying solely on ICL examples or simple question lists, we focus on codifying the _intellectual workflow_ inherent in rigorous peer review. Drawing inspiration from techniques like task decomposition [65, 70], plan-and-solve prompting [66], and role-playing [67, 68], we introduce **Persistent Workflow Prompting (PWP)**. PWP utilizes a highly structured, hierarchical prompt that guides an LLM through a detailed analysis process. This guidance involves decomposing the complex task of reviewing (specifically for experimental chemistry manuscripts in this work) into a sequence of manageable steps, effectively translating tacit expert knowledge [71] into an actionable protocol for the AI. This methodology allows for complex analysis using only the standard chat interface of LLMs.

### **1.3 Scope and Operational Constraints**

Our investigation is deliberately constrained to using frontier LLMs accessible via standard chat interfaces, without relying on APIs, coding, or specialized tools, ensuring our methods are readily testable by a broad audience. Consequently, prompt engineering, specifically PWP, is the primary means of guiding the model. We focus on state-of-the-art reasoning models (primarily Gemini Advanced 2.5 Pro, also tested with ChatGPT Plus o1 & o3, and SuperGrok Grok 3 Think) to maximize performance under these constraints. Key technical limitations influencing this work include model context window size, output token limits, and context recall accuracy [72, 73], which are particularly relevant given our goal of developing a large, structured prompt for analyzing full-length manuscripts and supporting information. While model limitations like hallucinations exist, their systematic characterization is beyond the scope of this initial study.

### **1.4 Contributions and Outline**

The main contributions of this paper are:

1. **Persistent Workflow Prompting (PWP):** We design, implement, and introduce PWP, a prompt engineering methodology employing a persistent, structured, workflow-based prompt to guide LLMs through complex, multi-step analytical tasks via standard chat interfaces.
2. **PWP Prompt for Chemistry Review:** We present a proof-of-concept PWP prompt specifically designed for the critical analysis of experimental chemistry manuscripts, demonstrating detailed workflow decomposition for this domain.
3. **Meta-Development Insights:** We describe the meta-prompting and meta-reasoning techniques used to iteratively develop and refine the PWP prompt, offering practical insights applicable to creating other complex, structured prompts.
4. **Empirical Demonstration:** We provide a qualitative demonstration and analysis of the PWP prompt's application using readily available reasoning LLMs, showcasing its ability to generate detailed, structured peer-review-like feedback incorporating multimodal analysis and quantitative checks.

==The remainder of this paper is organized as follows: Section 2 details the methodology, including the meta-prompting techniques used (2.1), the architecture of the PWP prompt (2.2), and the process of formalizing the review workflow (2.3). Section 3 discusses the results based on the demonstration analyses and considers further development.==

## **2. Methodology**

### **2.1 Meta-Prompting**

Meta-prompting represents an emerging methodology within prompt engineering [74, 75]. While a standard prompt typically targets a specific _actual problem_ seeking a direct solution, a meta-prompt operates at a higher level of abstraction. It focuses on the prompting process itself, aiming either to refine the LLM's inference process for the actual problem or to generate a new prompt - the _Prompt Under Development_ (PUD) - which will subsequently be used to solve the actual problem. This meta-prompting workflow thus often involves two distinct stages: _prompt generation_ (developing the PUD) and _prompt execution_ (using the PUD to address the actual problem).

The techniques encompassed by meta-prompting are valuable for refining even simple prompts and become indispensable when engineering complex prompts for challenging tasks. The prompt generation stage can utilize the same LLM intended for the subsequent prompt execution, a different model, or even specialized tools like Anthropic’s prompt generator [76] with an XML-based meta-prompt. Given that prompt development itself can be complex, particularly for intricate target tasks, frontier reasoning models are often preferred for the prompt generation stage. For the complex problems addressed in this work, reasoning models were typically employed for both prompt generation and execution.

The meta-prompting techniques utilized in this work can be broadly classified into two groups based on their primary focus and how they engage the LLM:

1. **Linguistic and Structural Refinement:** This group includes techniques primarily aimed at improving the PUD text itself - its clarity, conciseness, grammar, and overall structure (akin to those described later in sections 2.1.1 and 2.1.2). In these approaches, the LLM generally functions as an advanced editor or proofreader, enhancing the prompt's readability and organization without necessarily analyzing the deep semantics of the instructions relative to the target task.
2. **Semantic and Workflow Engineering:** This group focuses on developing the functional core of the PUD, including its internal logic and detailed workflows (related to techniques in sections 2.1.4 and 2.1.5). A key characteristic here is that the meta-prompt or previous prompts within the chat often explicitly instruct the LLM to consider the _semantic meaning_ of the PUD's content and to utilize the description or context of the _actual target task_ when generating, refining, or validating the PUD's instructions (e.g., suggesting workflow steps). In this capacity, the LLM acts more as a collaborative partner or peer engineer, contributing directly to the design of the prompt's operational logic.

 While there can be overlap, this distinction is useful. Developing sophisticated prompts like the `PeerReviewPrompt` typically requires applying techniques from both groups iteratively to ensure the prompt's language and structure are sound (Group 1) and to develop its complex workflows and logic using task-aware, semantically-focused meta-prompting (Group 2). Managing the complexity inherent in such advanced prompts necessitates careful structuring of the prompt text (using Markdown consistently in this study, edited primarily using Obsidian.md), benefiting both the human developer and the LLM's interpretation and facilitating the creation of hierarchical, modular prompts. The following subsections detail several specific meta-prompting techniques, illustrating these different approaches.

#### **2.1.1 Language-Focused Refinement**

One of the simplest meta-prompting approaches focuses directly on the linguistic quality of the PUD. In its basic form, the meta-prompt asks the LLM to improve the PUD text, for example:

```
Help me improve the following prompt:
---
{PUD Text}
```

This pattern primarily targets the linguistic and structural aspects of the `{PUD Text}`. By providing minimal guidance on _how_ to improve it, the meta-prompt encourages the LLM to function like a human editor, applying general principles of clear technical writing, such as improving conciseness, grammar, and structure. However, unlike a human editor potentially unfamiliar with the subject matter, the LLM can leverage its "world knowledge" during meta-prompt processing to also consider and potentially refine the prompt's semantics.

More specific meta-prompts within this category can explicitly direct the LLM to focus on particular aspects, such as enhancing clarity, ensuring logical flow, or enforcing structural and grammatical parallelism (e.g., following principles outlined in AI-focused style guides like [77]).

#### **2.1.2 Basic Iterative Refinement**

Building on simple linguistic checks, a more interactive meta-prompting pattern involves soliciting feedback from the LLM to iteratively refine the PUD. The first step typically asks the LLM to analyze the PUD for potential issues:

```
Analyze the following prompt below (Prompt Under Development or PUD) and consider if its instructions are clear, unambiguous, and complete. Provide feedback or ask clarifying questions regarding any potential issues.
---
{PUD Text}
```

This turns the meta-prompting process into a dialogue. Based on the LLM's feedback (e.g., questions about ambiguous instructions or missing details), the developer can provide clarifications. A subsequent meta-prompt then instructs the LLM to incorporate these clarifications and generate a revised PUD. The structure of this second meta-prompt can follow two main strategies regarding the inclusion of the PUD text itself:

**1. Relying on Conversational Context**

The meta-prompt provides only the answers or clarifications, assuming the LLM retains the full PUD context from the previous turn:

```
Revise the PUD based on our previous discussion, incorporating the following answers/clarifications. Analyze the revised prompt again: are there remaining questions or unclear points? Provide additional feedback if necessary, or generate the revised prompt with a clear, well-organized structure and precise language.

# Answers / Clarifications
{Developer's answers to LLM feedback}
```

- **Pros:** More concise input message. Often sufficient in continuous chat sessions with models exhibiting strong context recall.
- **Cons:** Susceptible to failure if the model's context window is exceeded, if context recall is imperfect (e.g., "lost in the middle"), or if the session is interrupted. Makes the revision step less self-contained and potentially harder to reproduce precisely.

**2. Explicitly Providing Context**

The meta-prompt includes both the clarifications _and_ the PUD text being revised:

```
Revise the prompt text provided below, incorporating the following answers/clarifications. Analyze the revised prompt again: are there remaining questions or unclear points? Provide additional feedback if necessary, or generate the revised prompt with a clear, well-organized structure and precise language.

# Answers / Clarifications
{Developer's answers to LLM feedback}

---
# Prompt Text to Revise
{PUD Text - the version needing revision}
```

- **Pros:** More robust and explicit. Ensures the LLM operates on the correct PUD version, minimizing errors due to context loss. Each revision step is self-contained, aiding reproducibility and documentation. Recommended for very long/complex PUDs or when maximum reliability is needed.
- **Cons:** Results in a longer input message, which might seem redundant if context recall is perfect.

While Strategy 1 was often employed successfully during the highly interactive development phases described in this work, Strategy 2 offers greater robustness, particularly for complex prompts or less predictable conversational contexts. The iterative cycle of feedback, clarification using either strategy, and LLM-driven revision remains a powerful technique for improving the clarity and effectiveness of complex prompts. This overall interactive refinement approach was frequently employed during the development of the `PeerReviewPrompt` to clarify intricate workflow steps and reviewer expectations.

#### **2.1.3 Meta-Meta-Prompting**

As meta-prompts themselves become more complex and elaborate - potentially employing sophisticated prompt engineering techniques similar to those used in prompts targeting actual problems (like Anthropic's prompt generator meta-prompt [76]) - they too can benefit from LLM-based analysis and refinement. Applying meta-prompting techniques to improve another meta-prompt introduces a second layer of abstraction, a process termed *meta-meta-prompting*. In such a scenario, the LLM's output is not a PUD, but rather an improved _meta-prompt_ intended for subsequent use in prompt generation (an example is shown in the initial part of chat [78]).

Given the higher level of abstraction (refining the prompt-generation tool rather than the problem-solving prompt), meta-meta-prompting often focuses primarily on the linguistic and structural refinement (==Group 1 techniques==) of the meta-prompt under development (mPUD). Ensuring the meta-prompts instructions for the LLM generating the PUD are clear, well-organized, and unambiguous is typically the main goal. However, for particularly complex meta-prompts that embed intricate logic or detailed workflow-generation procedures, applying semantic-focused techniques (==Group 2==) during meta-meta-prompting - analyzing the meaning and effectiveness of the meta-prompt's own instructions - can also be justified and beneficial. The `DetailedMetaPrompt.md` provided in the {{Supporting Information}}{{LNK: #SI}}, designed for developing elaborate PUDs, serves as an example where such deeper refinement at the meta-meta level might be considered. Its application is demonstrated in a shared ChatGPT conversation [[7]]. This practice highlights how refining the tools used for prompt generation can be part of the overall development process for complex PUDs like the `PeerReviewPrompt`.

#### **2.1.4 Workflow Generation and ICL-Based Techniques**

This subsection explores several related meta-prompting techniques focused on generating or refining the core workflow within a PUD, often leveraging templates or examples.

**1. Template-Based Workflow Suggestion:**

One approach uses a structured PUD template where the LLM is explicitly asked to devise the operational workflow. Consider this meta-prompt:

```
Analyze the following prompt template. Consider if the overall structure is clear.
Provide feedback/questions on any potential issues.
Then, devise a detailed workflow to replace the placeholder "{Workflow to be suggested by LLM}".

---
## Persona:
... (Description of a suitable role) ...

## Task:
... (Description of the task) ...
... (Detailed requirements) ...

## Processing Steps:
{Workflow to be suggested by LLM}
```

This technique leverages the LLM's ability to decompose complex tasks. Including such an explicit workflow often yields better PUD performance compared to relying solely on a high-level task description, even if the LLM could potentially infer the steps. The LLM-suggested workflow can then be reviewed and refined either manually or using iterative meta-prompting (==Section 2.1.2==). This pattern offers a balance between automated assistance and developer control, as illustrated in the development of the "_modBibliographyHyperlinker_" VBA module [79].

**2. ICL-Facilitated Prompt Generation:**

In-context learning (ICL), typically used to provide examples of solving the _actual problem_, can also be applied during meta-prompting. Existing, well-structured prompts can serve as examples or references within a meta-prompt to guide the generation of a new PUD for a similar task. The reference prompts can be provided explicitly within the meta-prompt:

```
Help me create a new prompt based on the reference prompt(s) provided below.
The new prompt should accomplish the following task:

## New Task Description
... (Description of the task for the new PUD) ...

---
# Reference Prompt(s)
{Full text of one or more existing prompts as examples}

---
Ask for clarification if needed before generating the new prompt.
```

Providing the reference prompts explicitly, as shown in the template above, ensures the LLM has the exact examples intended, analogous to the more robust ==Strategy 2== discussed for iterative refinement (==Section 2.1.2==). However, similar to ==Strategy 1== in iterative refinement, it is also possible to rely on the LLM's conversational context by simply asking it to use a specific prompt from earlier in the chat history as a reference, without explicitly resubmitting its text. This implicit approach is more concise but depends entirely on the model's ability to accurately recall the relevant prior context.

For instance, the development of the prompt for the "_modZoteroFieldRecovery_" VBA module successfully utilized this implicit context strategy, referencing the refined prompt for "_modBibliographyHyperlinker_" developed earlier within the same AI chat [80] without explicitly copying it. This example demonstrates the application of context-dependent ICL for prompt generation, though the explicit inclusion method offers greater reliability.

**3. Guided Workflow Generation:**

While allowing the LLM to suggest a workflow from scratch (as in ==Technique 1== above) offers flexibility, it may sometimes lack sufficient direction for highly complex or nuanced tasks. In such cases, *Guided Workflow Generation* provides a more robust approach. Here, the developer manually creates an initial draft of the workflow - ranging from a high-level outline to a detailed protocol - and includes it within the PUD template given to the meta-prompt. The meta-prompt then asks the LLM to refine, complete, or elaborate on this provided draft workflow. This initial human guidance significantly constrains the LLM's output towards the desired structure and logic. This guided approach was fundamental to developing the detailed analysis protocols within the `PeerReviewPrompt` (specifically its ==Section IV==) and was also used for the "_MarkupProcessor_" VBA module [78], where providing a detailed initial draft greatly simplified subsequent refinement.

#### **2.1.5 Meta-Prompting for Complex Prompts**

Developing highly complex PUDs often benefits from treating the LLM less like a simple tool and more like a collaborative partner or peer engineer, particularly when using state-of-the-art reasoning models. This approach involves more sophisticated meta-prompting techniques to refine intricate structures, logic, and content. Examples of such techniques used during the development of the `PeerReviewPrompt` include (see shared AI chats [81, 82] for further details):

- **Focused Refinement:** Targeting specific parts of the PUD for improvement.

```
Here is my current version of the prompt. Improve paragraph 1 in section D.2.
---
{Relevant excerpt of PUD Text, including section D.2}
```

- **Structure Optimization:** Collaboratively reasoning with the LLM about the PUD's high-level architecture, such as persona design or section organization, weighing pros and cons of different structures.

```
Do you see the two-level role of a researcher playing the role of a student? What are the pros and cons of this architecture? If it doesn't provide obvious benefits, how would I collapse it to a single role, while maintaining all features and specifications related to the ultimate objective? [...]

Reflect on this idea: generating a collapsed single role per recommendations, but reintroducing the student role not as a simulation, but specifying somehow this behavior as part of the expert's role. [...]

Help me integrate the hybrid persona definition into the previous Expert Analyst persona.
```

- **Reflective Refinement:** Asking the LLM to reflect on undesired behaviors observed during prompt execution and suggest improvements to the PUD to mitigate them.

```
How do I improve the original prompt to make sure you do not use reported results for justifications [during analysis]?
```

- **Section Generation from Unstructured Notes:** Providing rough notes or questions and asking the LLM to structure them into a formal section of the PUD according to specified formatting rules.

```
Help me define section "5. A Priori Plausibility Assessment" from the following text notes, formatting it as a bulleted list where each question/assessment becomes its own bullet and all conditionals are dropped:
---
[Text notes, e.g., "Does the main result involve a process... superior compared to existing alternatives...? If yes, do authors identify... novel highly unintuitive solution...?"]
---
```

- **Reverse-Engineering with Generalization:** Analyzing a specific example of desired reasoning or output (potentially generated manually or in a separate context) and asking the LLM to generalize that process into abstract instructions suitable for inclusion in the PUD. For example, ==Section IV.D.2.F== of the `PeerReviewPrompt` (see prompt text in {{Supporting Information}}{{LNK: #SI}}) concerning logical plausibility checks was developed using this approach. First, a guided analysis of a specific process (similar to [83]) was performed. Then, the LLM was asked to abstract this specific analysis into general instructions for the PUD (==Section IV.D.2-3== of the prompt at that time), directing the model executing the PUD to identify suitable physical/chemical models, extract parameters, find governing equations, perform estimations, and compare with claimed results, without using terminology specific to the initial example analysis (source chat for this step was unfortunately lost).

### **2.2 Prompt Architecture: Hierarchical Modular Analysis Framework**

#### **2.2.1 Scope Definition and Development Test Case**

Leveraging domain expertise in experimental physical chemistry, this field was selected as the target scope for the initial `PeerReviewPrompt` development. The prompt's detailed workflows and evaluation criteria were designed accordingly.

A crucial part of the iterative development process involved selecting a suitable test publication to serve as both a benchmark and a source of challenging analysis requirements. A specific publication [1] focusing on isotopic enrichment, known to contain significant and demonstrable methodological flaws, was chosen for this purpose. Its known issues made it a particularly informative test case for developing a prompt aimed at critical evaluation rather than simple summarization. The use of a single publication for development is a limitation of this initial proof-of-concept work, necessitated by resource constraints; testing on a broader range of manuscripts remains future work.

For practical testing during development, the manuscript file and its corresponding supporting information were combined into a single PDF document, which was used as the input for the LLM analyses discussed later.

#### **2.2.2 Persistent Workflow Prompting (PWP)**

The `PeerReviewPrompt` builds upon several advanced prompting techniques but introduces *Persistent Workflow Prompting* (PWP) as its core architectural principle. While incorporating standard top-level components like Role/Persona (==Section II== of the prompt), Context (==Section III==), and Task/Objective, the prompt's primary innovation lies in its detailed, hierarchical structure designed to guide complex analysis. This structure moves beyond basic instructions to meticulously define _how_ the analysis should be performed through explicit, multi-step workflows detailed primarily in the core ==Section IV: Specific Analysis Instructions==.

The complexity of these workflows is managed using Markdown formatting within the prompt text. This formatting is essential, serving both to organize the extensive instructions for the human developer/user and, critically, to aid the LLM in parsing and correctly interpreting the intended hierarchical structure and dependencies between different analysis steps.

The essence of PWP involves designing the initial, large prompt not merely as a single request, but as a *persistent workflow library* intended to be loaded into the LLM's context memory at the start of a session (the prompt explicitly states this intent in ==Sections III and V==). Once loaded, this internal library of predefined workflows remains active. Subsequent, shorter user queries (e.g., "Analyze the core experimental protocol", "Extract the main result") act as triggers, invoking the relevant, detailed workflow(s) stored within the initial prompt's structure. This PWP approach enables complex, multi-turn analysis interactively without requiring the user to repeatedly submit the large, detailed framework, thereby preserving context window space for the manuscript and conversational history.

==Section IV== of the `PeerReviewPrompt`, titled "Specific Analysis Instructions (Baseline Framework)", serves as the primary workflow library. For instance:

- A query about the main result triggers the specific workflow defined in ==**Section IV.B**== (Identifying Claimed Results and Contributions).
- A request to analyze a specific figure invokes the workflow detailed in ==**Section IV.C**== (Analyzing Figures).
- A combined request like _"Analyze figures related to the main result"_ prompts the model to chain workflows: first executing Section IV.B to identify relevant figures, then applying the Section IV.C workflow to each identified figure.
- Analyzing the core experimental protocol (covered in ==**Section IV.D.2**==) involves prerequisite workflows (like those in ==IV.D.1==, ==IV.B, IV.C==), executed logically based on overarching instructions (e.g., ==Section IV.A.3==). (N.B.: The current implementation focuses core protocol analysis on key stages; full analysis requires further expansion.)

PWP activates this workflow library directly via the standard chat prompt, differentiating it from platform-specific features like Custom GPTs or Gemini Gems, which achieve persistence through separate mechanisms. The function of the PWP prompt thus extends beyond simple persistent instructions; it systematically encodes detailed procedures for complex analytical tasks, effectively acting as a high-level, declarative program specified in natural language and structured using Markdown.

#### **2.2.3 Behavioral Context and Persona Engineering**

Beyond defining workflows, the `PeerReviewPrompt` utilizes **Persona Engineering** within its ==**Section II: Persona: Expert Critical Reviewer**== to instill specific behavioral characteristics crucial for critical analysis. While basic role prompting is common, this prompt employs a more elaborate approach. It explicitly rationalizes desirable traits of an expert reviewer (e.g., skepticism, objectivity, meticulousness) and attempts to project these onto the LLM through detailed role descriptions and associated expected behaviors.

To enhance the LLM's adherence to these traits, especially given the overall prompt's complexity and length, the persona definition is intricate, addressing multiple facets of the reviewer role. Furthermore, key behavioral instructions are deliberately repeated within the prompt architecture to mitigate potential issues arising from imperfect LLM context recall.

The primary goals driving this detailed persona engineering were:

- **Counteracting Outcome Bias:** A common failure mode observed was the LLM using reported results to justify the methodology. The persona instructions strongly and repeatedly emphasize a core principle of scientific review: methodology must be evaluated _independently_ based on established scientific principles, irrespective of the claimed outcomes. A flawed method cannot produce reliable results, thus results cannot validate the method itself.
- **Encouraging Analytical Rigor:** The persona aims to elicit detailed, critical, and well-justified output. It explicitly sets the expected standard of analysis as analogous to that required in a high-stakes academic examination (e.g., PhD qualifying exam), demanding meticulous attention to detail, clear reasoning, and proactive identification of potential flaws or ambiguities.

A secondary aspect, addressed primarily within the main workflow instructions (Section IV) but reinforced by the persona, involves appropriately adjusting expectations when evaluating proof-of-concept studies, where certain deviations from maximum rigor might be acceptable if explicitly acknowledged and justified by the authors.

#### **2.2.4 Custom Classification for Guided Information Extraction**

While LLMs can effectively extract specific information, such as a paper's main claimed result, interpreting this information for deeper, structured analysis requires further guidance. Claims often intertwine distinct components, like the problem being addressed (the _unmet need_) and the proposed solution (_claimed novelty_ or methodology). A rigorous evaluation necessitates assessing these components independently - evaluating the problem's significance separately from the solution's validity and ingenuity.

To facilitate this analysis reliably, a custom classification scheme was developed specifically for the `PeerReviewPrompt` and implemented in ==**Section IV.B.1**== (titled "Classification of the Main Claimed Result based on targeted unmet need"). This scheme provides the LLM with predefined categories relevant to experimental chemistry research. Its purpose is to guide the LLM, after identifying the main claim, to systematically parse it into key components by classifying the nature of the unmet need and the proposed solution according to these categories. Applying this scheme to the test paper's [1] claim regarding "economical enrichment of ==H217O==... via slow evaporation and fractional distillation", for example, assists the LLM in parsing the claim into its core components: the _unmet need_ (accessible ==H217O==), the _proposed solution methodology_ ("slow evaporation and fractional distillation"), and any explicitly claimed novelty (importantly, allowing the scheme to guide the LLM in recognizing when, as in this case, specific novelty is not clearly articulated by the authors).

This structured decomposition, guided by the custom classification scheme, enables a more consistent and rigorous downstream analysis (like the ==_A Priori_ Plausibility Check== described in ==Section 2.3==) compared to relying on free-form claim interpretation. Given the distinct roles of the unmet need, the proposed methodology, and the claimed novelty, future refinements could involve developing separate, parallel classification schemes for multiple components. For instance, adding classifications to characterize the *type of solution methodology* employed (e.g., synthesis, separation, characterization technique) and the *nature of the claimed novelty* (e.g., new compound, improved efficiency, new application) - alongside the existing focus on the unmet need - could enable an even more granular and systematic analysis.

 #### **2.2.5 Operational Guidelines and Default Procedures**
 
 The concluding section of the `PeerReviewPrompt` (==**Section V: Final Instructions for Interaction**==) establishes overall operational guidelines for the LLM's interaction and output. This final section serves several key functions aimed at ensuring consistent and high-quality analysis throughout a session:
 
 1. **Instructional Reinforcement:** This function involves strategically reiterating crucial directives presented earlier in the prompt. Specifically, this reinforcement includes emphasizing the core principles of the expert reviewer Persona (defined in ==Section II==) and critical analytical constraints, such as the requirement for independent methodological scrutiny (from ==Section IV.A==). Such repetition acts as a safeguard against context degradation or imperfect recall, promoting consistent application of the intended methodology.
 2. **Default Workflow Definition:** Here, the prompt specifies a "default" analysis workflow - a predefined sequence of analysis tasks (e.g., executing the comprehensive protocol analysis detailed in ==Section IV.D==) - that the LLM should perform automatically when given a general, high-level request like _"Review this paper"_. This default workflow provides a standardized and thorough starting point for analysis when specific sub-tasks are not initially requested by the user.
 3. **Output Formatting and Context Guidelines:** Finally, this section provides instructions regarding the format and context of the LLM's output. These guidelines can cover aspects such as structuring the response logically, using Markdown effectively for readability, citing any external knowledge sources appropriately (if permitted), and explicitly stating any assumptions made during the analysis. These output standards further ensure the generated review aligns with the rigorous expectations set by the Persona.

### **2.3 Formalizing the Review Process**

#### **2.3.1 The Challenge: Translating Expert Review into Actionable Prompts**

A significant challenge in developing AI systems for tasks like scholarly peer review lies in translating the complex, often nuanced, reasoning processes of human experts into explicit, executable instructions suitable for an LLM. Expert review relies heavily on domain-specific knowledge, critical thinking, pattern recognition, and a considerable amount of _tacit knowledge_ [71] - intuitions, heuristics, and ingrained understandings that experts apply subconsciously and often find difficult to articulate fully. Consequently, simply asking an LLM to "review a paper" typically yields superficial results, lacking the depth and critical rigor of true expert evaluation (as discussed in ==Section 1.1==).

This limitation stems partly from the nature of generative pre-trained models. By default, LLMs often process input text by integrating it with their existing knowledge base, excelling at tasks like summarization where the input is largely taken at face value. Critical analysis, however, requires a different stance - one of abstraction and skepticism, where the input manuscript is evaluated against external principles and knowledge without being automatically accepted as truth. This critical stance, treating the manuscript as an object of scrutiny rather than incorporated fact, is generally not the default behavior and requires specific guidance. While frontier LLMs can perform complex abstract operations, eliciting in-depth critical analysis necessitates either specialized training or, as explored in this work, advanced prompting techniques designed to guide the model through a rigorous, structured evaluation process.

Therefore, creating the `PeerReviewPrompt` necessitated a deliberate process of formalizing the intellectual workflow of critical review in experimental chemistry, aiming to make the implicit explicit and codify expert reasoning into a structured, actionable protocol. The subsequent sections detail this formalization process, including reflections on the meta-reasoning involved.

#### **2.3.2 Deconstructing the Core Review Workflow**

The process of formalizing the review workflow began by reflecting on how an expert typically approaches a manuscript. Rather than reading linearly like a novel, a reviewer often seeks specific high-level information first to orient themselves and determine the paper's core assertions.

**Identifying Claims:** The initial step usually involves identifying the **main claimed result** and any **key supporting findings**. This information is typically sought in the title, abstract, introduction, and conclusions. Understanding precisely _what_ the authors claim to have achieved is paramount before evaluating _how_ they claim to have achieved it. For the test paper [1], this meant extracting the claim about inexpensive ==H217O== enrichment via specific methods. This process of identifying and extracting core claims was formalized into the workflow detailed in **==Section IV.B== (Identifying Claimed Results and Contributions)** of the `PeerReviewPrompt`, including the custom classification scheme (discussed in Section 2.2.4) to help parse these claims structurally.

**Initial Methodological Assessment:** Once the core claims are understood, the focus shifts to evaluating the methodology described. A fundamental principle, emphasized throughout the `PeerReviewPrompt` (particularly in ==Section IV.A== and the ==Persona== definition), is the **independent assessment of methodology**. The validity of the experimental design, procedures, and data analysis must be judged based on scientific principles and best practices within the field, _without_ relying on the claimed results as justification. This critical step involves scrutinizing the core experimental approach detailed by the authors, which corresponds to the analysis workflows initiated in ==Section IV.D== (Analysis of Experimental Methodology) of the prompt. The goal at this stage is to determine if the described methods are fundamentally sound and capable, in principle, of supporting the types of claims being made.

#### **2.3.3 Meta-Reasoning II: Implementing Quantitative and Multimodal Analysis**

Beyond assessing the general soundness of the methodology, a deeper critical review, particularly in experimental sciences, often involves evaluating the _quantitative feasibility_ of the claims based on the described procedures. Simply stating that evaporation and distillation were used is insufficient; the reviewer must assess whether the _specific implementation_ described could plausibly achieve the _magnitude_ of the claimed result (e.g., the high isotopic enrichment reported in ==[1]==). This assessment often requires comparing the reported outcomes against theoretical expectations derived from established scientific principles.

**Quantitative Feasibility Checks:** Translating this expert practice into the `PeerReviewPrompt` involved defining a structured workflow for quantitative checks (formalized in ==**Section IV.D.2.F**==). Based on analyzing the test case ==[1]== and generalizing the required reasoning, the following sequence of steps was identified and encoded in the prompt:

1. **Identify Key Claims/Parameters:** Extract the specific quantitative results claimed by the authors that require verification (e.g., enrichment levels).
2. **Identify Core Processes/Equipment:** Pinpoint the key experimental steps and apparatus responsible for achieving the claimed result (e.g., evaporation stage, fractional distillation column).
3. **Select Appropriate Models/Equations:** Determine the relevant physical or chemical models and governing equations that describe the identified processes (e.g., Rayleigh equation for distillation, principles of evaporation kinetics).
4. **Extract Explicit Parameters:** Gather necessary parameters for calculations that are explicitly provided in the manuscript or SI (e.g., starting material amounts, temperatures, reported efficiencies).
5. **Address Missing Information (Parameters):** Recognize when critical parameters needed for the calculation are _not_ provided in the text. This involves two sub-steps:
    - a) _Inferring from Visual Data (Multimodal Analysis):_ For missing physical dimensions or setup details, instruct the LLM to analyze figures, diagrams, or photographs provided in the manuscript/SI. For example, the prompt guides the LLM to analyze the photograph of the experimental setup (SI Fig. 1 in ==[1]==) to estimate the dimensions of the improvised fractionation column by identifying scalable reference objects within the image.
    - b) _Retrieving Standard Parameters:_ For missing fundamental constants or material properties not specific to the setup, instruct the LLM to retrieve standard values from its knowledge base or reliable external sources (e.g., separation coefficients for ==H216O/H217O==).
6. **Perform Calculations:** Execute the theoretical calculations using the gathered parameters and selected models.
7. **Compare and Evaluate:** Compare the theoretically estimated outcomes with the results claimed by the authors, assessing the plausibility of the claims based on this quantitative analysis.

**Multimodal Integration:** The explicit inclusion of step ==5a== represents a key aspect of formalizing the process for modern multimodal LLMs like Gemini Advanced 2.5 Pro. Instead of relying on the reviewer's potentially subjective estimations for missing parameters (like assuming a typical column efficiency), the prompt attempts to guide the LLM to extract objective information directly from visual evidence provided by the authors, integrating text and image analysis within the review workflow.

#### **2.3.4 Formalizing Heuristics (e.g., "Too Good to Be True")**

Expert reviewers often develop intuitive heuristics or "rules of thumb" based on experience, which trigger skepticism or closer scrutiny even before detailed analysis. One such common heuristic is the "too good to be true" assessment. Formalizing such intuitive judgments into explicit prompt instructions is challenging but crucial for enabling deeper AI-driven critique. The process of developing the _A Priori_ Plausibility Assessment (==**Section IV.D.2.5**== of the `PeerReviewPrompt`) serves as a case study for this type of formalization, originating from the initial assessment that the claims in the test paper ==[1]== seemed highly improbable.

Deconstructing this initial skeptical reaction involved identifying the underlying factors contributing to it. Reflection suggested the "too good to be true" assessment in this specific case arose from a combination of observations:

1. **Potentially Disruptive Claim:** The claimed result (cheap, accessible ==H217O==) promised significant impact, potentially disrupting existing markets and enabling new research avenues. High-impact claims often warrant higher scrutiny.
2. **Conventional Methodology:** The core experimental methods described (slow evaporation, fractional distillation) were well-established, widely understood, and generally considered conventional, lacking inherent novelty.
3. **Lack of Methodological Innovation:** The description of the experimental setup did not highlight any specific, non-trivial innovations or clever adaptations of the conventional methods that would plausibly explain the extraordinary outcome claimed. The apparatus appeared largely standard or even improvised (e.g., the packing material).
4. **Conflict with Established Knowledge:** Basic principles of physical chemistry suggest that achieving significant isotopic separation with the described simple methods and setup is extremely difficult, likely requiring far more sophisticated apparatus or processes.
5. **Absence of Author Justification:** The authors did not provide theoretical calculations, detailed process modeling, or other strong evidence within the paper to demonstrate the feasibility of their claimed results using the described methods, despite the apparent conflict with established knowledge (Point 4).

These factors were then translated into a structured set of questions and checks within ==Section IV.D.2.5== of the prompt. This section guides the LLM to systematically assess the _a priori_ plausibility by considering the scale of the claim versus the apparent novelty and sophistication of the methods, prompting for justification and checking for alignment with fundamental principles _before_ delving into the quantitative verification of results. This formalization attempts to replicate the function of the expert heuristic by triggering targeted skepticism based on specific, identifiable characteristics of the claims and methodology presented.

#### **2.3.5 Meta-Meta-Reasoning: Reflecting on the Knowledge Codification Process**

The process of developing the `PeerReviewPrompt` involved not only formalizing the steps of peer review (meta-reasoning) but also reflecting on _how_ to effectively achieve that formalization, particularly when translating intuitive or tacit expert knowledge into explicit LLM instructions (meta-meta-reasoning). Attempting to codify one's own subconscious reasoning processes, as undertaken when deriving the quantitative checks (==Section 2.3.3==) or the plausibility heuristics (==Section 2.3.4==), presents unique challenges. This reflective phase aimed to identify potentially transferable strategies for developing complex, workflow-based prompts for other expert domains.

Several principles or strategies emerged from this meta-meta-reasoning process:

1. **Start with Concrete Cases:** Analyzing specific instances, like the demonstrably flawed test paper ==[1]==, provided concrete anchors for identifying both effective expert reasoning patterns and common pitfalls (like outcome bias) that the prompt needed to address or emulate.
2. **Trace the Reasoning Flow:** Consciously mapping out the sequence of questions, comparisons, and calculations an expert would likely perform (e.g., "What is the main claim?" -> "Is the method plausible?" -> "Do the numbers add up?") helped define the core structure of the prompt's workflows.
3. **Deconstruct Intuitive Judgments:** When faced with an intuitive reaction (e.g., "This seems too good to be true"), actively probing the basis for that intuition by asking "why?" and identifying the specific contributing factors (as detailed in ==Section 2.3.4==) was key to translating it into objective, rule-based checks for the LLM.
4. **Isolate and Address Contradictions:** A primary goal of critical analysis is identifying inconsistencies. The formalization process focused on creating prompt instructions that explicitly direct the LLM to look for contradictions between:
    - Claims and established scientific knowledge/principles.
    - Claimed results and theoretical estimations based on the described methods.
    - Different parts of the manuscript or supporting information.
5. **Identify Missing Information:** Recognizing that expert review often involves identifying crucial _omitted_ details, the prompt development included steps specifically designed to check for and handle missing methodological information essential for validation or reproduction (as detailed in ==Section 2.3.3, step 5==).
6. **Generalize Specific Analyses:** After analyzing a specific case, consciously abstracting the reasoning process and removing case-specific details was necessary to create generalizable workflow instructions applicable to a broader class of problems within the target domain (e.g., experimental chemistry papers). This was crucial for the reverse-engineering technique mentioned in ==Section 2.1.5==.
7. **Iterative Refinement (Linking back to Meta-Prompting):** The entire formalization process was not linear but iterative, relying heavily on the meta-prompting techniques (==Section 2.1==) to refine both the linguistic expression and the semantic logic of the prompt instructions based on trial runs and LLM feedback.
8. **Prioritize Sensitivity for Issue Flagging:** Recognizing the AI's role as an _assistant_ primarily tasked with flagging potential issues for human evaluation, the design prioritized minimizing false negatives (missed issues) over minimizing false positives (incorrectly flagged issues). False negatives require laborious human rediscovery, while false positives can typically be dismissed more easily by the expert reviewer. Consequently, the prompt's persona (==Section 2.2.3==) and workflows were intentionally designed to encourage an _excessively critical_ or _negatively biased_ stance, aiming to maximize the identification of potential flaws, while treating the reduction of excessive false-positive "noise" as a secondary goal.

By consciously applying these strategies, it was possible to translate complex, often tacit, expert reasoning processes into the structured, explicit workflows embedded within the `PeerReviewPrompt`. These principles may offer guidance for others seeking to develop sophisticated prompts for complex analytical tasks in other domains.

#### **2.3.6 Linking Formalized Procedures to PWP Architecture**

The outcome of the formalization process described above - including the deconstructed review workflows (==2.3.2==), the quantitative and multimodal analysis steps (==2.3.3==), the formalized heuristics (==2.3.4==), and the overarching design principles (==2.3.5==) - directly informed the architecture and content of the `PeerReviewPrompt`.

Specifically, the detailed, multi-step procedures derived via meta-reasoning were implemented as the hierarchical workflows within **==Section IV (Specific Analysis Instructions)==** of the prompt. The Persistent Workflow Prompting (PWP) architecture (==Section 2.2.2==) provided the mechanism to organize and store these complex, formalized procedures persistently within the LLM's context. Subsequent user queries then trigger these specific, pre-defined workflows, effectively guiding the LLM through the formalized expert reasoning process for tasks like analyzing the main result (==Section IV.B==), evaluating figures (==Section IV.C==), or assessing methodological plausibility and feasibility (==Section IV.D==). The persona engineering (==Section 2.2.3==) and operational guidelines (==Section 2.2.5==) further ensure that these workflows are executed with the desired critical stance and rigor.

In essence, the PWP architecture serves as the vehicle for delivering the formalized review process, translating the abstract principles and deconstructed steps identified through meta-reasoning (and further rationalized through meta-meta-reasoning) into an executable, natural language program for guiding advanced LLMs.

