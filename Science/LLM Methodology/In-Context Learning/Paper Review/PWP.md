# **Zero-Code AI Simulation of Scholarly Peer Review via** **Persistent Workflow Prompting,** **Meta-Prompting, and Meta-Reasoning**


Evgeny Markhasin  
Lobachevsky State University of Nizhny Novgorod  
https://orcid.org/0000-0002-7419-3605  
https://linkedin.com/in/evgenymarkhasin

**Abstract**

Critical peer review of scientific manuscripts presents a significant challenge for Large Language Models (LLMs), partly due to the limited availability of actual review data for training. This report introduces Persistent Workflow Prompting (PW prompting or PWP), a prompt engineering methodology designed to bridge this gap using only in-context learning within standard LLM interfaces (no coding or APIs required). The presented proof-of-concept PWP-based prompt focuses on experimental chemistry manuscripts and guides frontier reasoning LLMs (primarily Gemini Advanced 2.5 Pro) through a systematic, multimodal analysis. The prompt features a hierarchical, modular architecture formatted in Markdown, defining complex review tasks as structured workflows. Submitted once at the start of a session, this master prompt equips the LLM with persistent workflows triggered by subsequent user queries (e.g., Analyze the core experimental protocol). Key capabilities demonstrated by the prompt include: identifying core claims vs. evidence, performing multimodal analysis integrating text and figures (including photographs), inferring missing parameters, executing quantitative feasibility checks via idealized process modeling and a priori estimations, comparing these estimations against claimed results, and assessing overall experimental plausibility. This work highlights the potential of advanced prompt engineering to enable complex, domain-specific reasoning and analysis in scientific research using readily available LLMs.

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

The techniques encompassed by meta-prompting are valuable for refining even simple prompts and become indispensable when engineering complex prompts for challenging tasks. The prompt generation stage can utilize the same LLM intended for the subsequent prompt execution, a different model, or even specialized tools like Anthropic’s prompt generator [76]. Given that prompt development itself can be complex, particularly for intricate target tasks, frontier reasoning models are often preferred for the prompt generation stage. For the complex problems addressed in this work, reasoning models were typically employed for both prompt generation and execution.

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

**1: Relying on Conversational Context**

The meta-prompt provides only the answers or clarifications, assuming the LLM retains the full PUD context from the previous turn:

```
Revise the PUD based on our previous discussion, incorporating the following answers/clarifications. Analyze the revised prompt again: are there remaining questions or unclear points? Provide additional feedback if necessary, or generate the revised prompt with a clear, well-organized structure and precise language.

# Answers / Clarifications
{Developer's answers to LLM feedback}
```

- **Pros:** More concise input message. Often sufficient in continuous chat sessions with models exhibiting strong context recall.
- **Cons:** Susceptible to failure if the model's context window is exceeded, if context recall is imperfect (e.g., "lost in the middle"), or if the session is interrupted. Makes the revision step less self-contained and potentially harder to reproduce precisely.

**2: Explicitly Providing Context**

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

---
---

