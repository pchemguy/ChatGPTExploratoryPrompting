
**## 1. Introduction**

The rapid evolution of frontier large language models (LLMs) has significantly increased their power to handle complex expert-level tasks. Consequently, research exploring ways to further expand these abilities and identify novel applications is intensifying. Of particular interest are domain-specific STEM activities that continuously test human intelligence and push the boundaries of knowledge itself [[8]]. This focus is evident in the development of challenging benchmarks testing LLM abilities on problems ranging from international subject olympiads (e.g., OlympiadBench [[9]].) to graduate/expert-level STEM problems (GPQA [[10]], SuperGPQA [[11]], SciQA [[12, 13]], SciQAG [[14]], and Humanity's Last Exam [[15]].). Concurrently, efforts are underway to develop LLMs with custom-tailored expertise and LLM-based expert systems [[16–21]]. While the capabilities of reasoning models like OpenAI's o1 [[22]]. and Google's Gemini 2.5 Pro [[23]]. represent significant advancements, these models remain limited when their training data lacks the specific domain facts or procedural knowledge necessary for devising effective solution workflows.

Several strategies can help bridge these gaps:

1. Tailoring a model specifically for a domain or task (e.g., chemistry, chemical reaction extraction): the most resource-intensive option, offering maximum control.
2. Adapting (fine-tuning) existing models with domain-specific data: less resource-intensive than training from scratch but still requires expertise and faces certain constraints.
3. Providing necessary knowledge and workflow guidance directly within the prompt: often the most practical approach, requiring no changes to the underlying model and compatible with most available LLMs, including proprietary ones.

The third strategy generally relies on in-context learning (ICL [[24–26]].) and advanced prompt engineering techniques [[27–35]]. to bridge the knowledge gap between model pre-training and the task at hand. Building on the potential of prompt engineering, this study focuses on applying this strategy to the complex challenge of AI-assisted scholarly peer review.

### **1.1 Scholarly Peer Review**

Scholarly peer review is a cornerstone of academic research, demanding significant time, domain expertise, and critical reasoning. Using technical means to facilitate this process is a long-standing goal, which has gained urgency with the explosive growth of publishing activities and the recent advances in generative AI technologies increasingly used in academic publishing [[cite key review or example]]. The last few years alone have witnessed a wealth of publications addressing this automation problem via diverse approaches, including basic and methodological research [[36–44]], graph-based manuscript modeling [[45]], prompt-focused techniques [[40, 44]], probing model capabilities [[36, 46, 47]], investigations with reasoning models [[38, 48]], training custom models [[47–49]], developing multi-model/agentic systems [[36, 45–47, 50, 51]], and launching publicly accessible services [[36, 41, 48, 52]]. Due to its intellectually demanding nature, using AI for peer-review-like feedback also serves as a valuable method for evaluating and pushing the boundaries of advanced models.

Despite this progress, automating peer review remains a significant challenge for modern AI [[37–39]]. Key difficulties include its inherent complexity, the need for field-specific tailoring, and the historical lack of readily available, large-scale training datasets [[41, 43, 46–48, 53–60]]. Furthermore, existing approaches often face limitations. Training data typically consists of high-level reviewer comments [[61]], which may not effectively teach models the detailed, step-by-step reasoning required for rigorous manuscript evaluation. Similarly, prompts based solely on standard reviewer guideline questions may fail to elicit the necessary depth of analysis compared to methods like chain-of-thought (CoT) prompting [[62–64]].

### **1.2 Our Approach: Persistent Workflow Prompting**

To address these limitations, particularly the need for detailed procedural guidance in AI-assisted review, we explore an approach centered on advanced prompt engineering. Instead of relying solely on ICL examples or simple question lists, we focus on codifying the _intellectual workflow_ inherent in rigorous peer review. Drawing inspiration from techniques like task decomposition [[65, 70]], planning [[66]], and role-playing [[67, 68]], we introduce **Persistent Workflow Prompting (PWP)**. PWP utilizes a highly structured, hierarchical prompt that guides an LLM through a detailed analysis process. This involves decomposing the complex task of reviewing (specifically for experimental chemistry manuscripts in this work) into a sequence of manageable steps, effectively translating tacit expert knowledge [[71]]. into an actionable protocol for the AI. This methodology allows for complex analysis using only the standard chat interface of LLMs.

### **1.3 Scope and Operational Constraints**

Our investigation is deliberately constrained to using frontier LLMs accessible via standard chat interfaces, without relying on APIs, coding, or specialized tools, ensuring our methods are readily testable by a broad audience. Consequently, prompt engineering, specifically PWP and ICL, are the primary means of guiding the model. We focus on state-of-the-art reasoning models (primarily Gemini 2.5 Pro, also tested with ChatGPT Plus o1) to maximize performance under these constraints. Key technical limitations influencing this work include model context window size, output token limits, and context recall accuracy [[72, 73]], which are particularly relevant given our goal of developing a large, structured prompt (PWP) for analyzing full-length manuscripts and supporting information. While model limitations like hallucinations exist, their systematic characterization is beyond the scope of this initial study.

### **1.4 Contributions and Outline**

The main contributions of this paper are:

1. **Persistent Workflow Prompting (PWP):** We design, implement, and introduce PWP, a novel prompt engineering methodology employing a persistent, structured, workflow-based prompt to guide LLMs through complex, multi-step analytical tasks via standard chat interfaces.
2. **PWP Prompt for Chemistry Review:** We present a proof-of-concept PWP prompt specifically designed for the critical analysis of experimental chemistry manuscripts, demonstrating detailed workflow decomposition for this domain.
3. **Meta-Development Insights:** We describe the meta-prompting and meta-reasoning techniques used to iteratively develop and refine the PWP prompt, offering practical insights applicable to creating other complex, structured prompts.
4. **Empirical Demonstration:** We provide a qualitative demonstration and analysis of the PWP prompt's application using readily available reasoning LLMs, showcasing its ability to generate detailed, structured peer-review-like feedback incorporating multimodal analysis and quantitative checks.

The remainder of this paper is organized as follows: Section 2 details the methodology, including the meta-prompting techniques used (2.1), the architecture of the PWP prompt (2.2), and the process of formalizing the review workflow (2.3). Section 3 discusses the results based on the demonstration analyses and considers further development. _(Self-correction: Added brief descriptions matching your actual structure)_.

---

**Summary of Changes:**

- **Structure:** Reorganized slightly using H3 headings (1.1, 1.2, 1.3, 1.4) for better flow within Section 1.
- **Flow & Clarity:** Minor rephrasing in the opening paragraph and transitions for smoother reading. Slightly synthesized the peer review challenges.
- **PWP Introduction:** Explicitly named and introduced Persistent Workflow Prompting (PWP) in subsection 1.2 ("Our Approach").
- **Contributions & Outline:** Added the essential subsection 1.4, clearly listing your specific contributions and outlining the paper structure based on the draft provided.
- **Custom Markup:** Preserved your `{{...}}{{...}}` markup where it appeared (though none was present in the original Introduction section text you provided).
- **Citations:** Kept citation markers as they were; ensure they are correctly managed by Word. Added one placeholder `[cite key review or example]` where appropriate.

Please review this revised Introduction. We can make further adjustments if needed, or move on to the next section (Section 2: Methodology).