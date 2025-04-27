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

## 2. **Methodology**

### 1. **Meta-Prompting**

Meta-prompting is an emerging methodology in prompt engineering [74, 75]. A prompt generally focuses on a specific question or problem one is trying to solve typically yielding solution to that *actual problem*. A meta-prompt is an abstraction, which focuses on the prompting process itself, and typically aims to affect the inference process in a particular way or seeks to produce a new prompt, which in turn will be used to find a solution to the *actual problem*. In practical terms, it is convenient to refer to the two stages of the meta-promptings/prompting workflow as *prompt generation* (aiming to develop *Prompt Under Developmеnt, PUD*) and *prompt execution*. 

Meta-prompting encompasses a range of techniques often helpful even for relatively simple problems and invaluable for developing complex prompts for complex problems. Prompt generation stage may employ the same LLM model, as the model to be used for subsequent prompt execution. Alternatively, a different model may be used for prompt generation or even a specialized prompt generator tool, such as the one provided by Anthropic [76] (note, this referenced post also provides a reference to the actual meta-prompt used by Anthropic’s prompt generator). The meta-prompting process should be considered as a complex task in a sense that frontier reasoning models are usually preferable for prompt development, particularly for complex tasks. Personally, I mostly focus on complex problems so I mostly use reasoning models for the actual tasks and usually use the same reasoning model for prompt generation.

For complex prompts and advanced prompting techniques, structuring the prompt text is essential for both developer and AI. Common formats used for structuring prompt texts include Markdown, XML, and JSON. This text and associated supporting materials all use Markdown formatting for structuring prompts (Obsidian.md has been used as the primary Markdown editor).

Different meta-prompting techniques can be classified in two groups. Task-agnostic techniques treat the prompt as a piece of technical writing and mostly focus on improving its linguistic characteristics. In this case LLM acts as an advanced proofreader, also capable of improving, for example, structure and clarity of the text. On the other end are techniques used for PUD developed for complex tasks where elaborate prompt-based LLM guidance is desirable. In such a cases, meta-prompts may become quite elaborate and no longer be task-agnostic. In such cases, LLM can act as a peer prompt engineer. In fact, for complex tasks necessitating complex prompt, such as the PeerReviewPrompt presented in this work or coding, meta-prompting techniques from both of these groups become essential. Let us now consider several meta-prompting techniques (note that often these techniques can be readily combined and/or chained).
