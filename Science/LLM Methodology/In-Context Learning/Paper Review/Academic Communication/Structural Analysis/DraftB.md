# **Ai-Facilitated Analysis of Abstracts and Conclusions: Flagging Unsubstantiated Claims and Ambiguous Pronouns**

## 1. Introduction

Computer-assisted tools for academic writing have a long history [1], but the recent emergence of state-of-the-art (SOTA) large language models (LLMs) has enabled new forms of accessible semantic and linguistic analysis [5, 6] and synthesis [7]. Modern LLM architectures, such as Gemini Pro 2.5 Pro [2], ChatGPT Plus o3 [3], and Claude Opus 4 [4], possess capabilities that are particularly useful for the semantic and structural analysis of technical texts. Specifically, their large context windows allow for the analysis of full-length research papers [8, 9], while in-context learning (ICL) [11–13] combined with advanced prompting strategies [14–22] makes it possible to systematically focus the model's attention on specialized aspects of a manuscript [8, 9].

Many scholarly publications that report original research follow the IMRaD (Introduction, Methods, Results, and Discussion) structure [#]. Two other critical sections, the Abstract and the Conclusions, serve as academic summaries that frame this main body of work. This study focuses on the semantic and linguistic quality of these two summary sections. We propose an LLM-based workflow to diagnose two common issues that can detract from the clarity and integrity of these summaries: the inclusion of information not substantiated in the main text and the use of ambiguous pronoun constructs.

Both of these issues undermine the core function of a scholarly manuscript: the effective communication of scientific information. Scientists generally expect that all factual claims within a summary must originate from and be substantiated by the IMRaD content of the paper [#], where proper context is provided. Introducing new information (unsubstantiated claim) in a summary section either deprives that information of necessary context or undermines the communicative function of the summary itself. Similarly, ambiguous pronouns (e.g., "it" or a standalone "this") can disrupt narrative flow and complicate comprehension by obscuring the intended antecedent (\<quote here\>) [#]. To address these problems, we developed and tested a series of proof-of-concept (PoC) prompts designed to guide an LLM in identifying and flagging these specific issues within a sample text [33]. The prompts and our development process are detailed in the appendices and supporting information.

## 2. Methodology

### 2.1. Materials

The proof-of-concept prompts developed in this study were tested using a single, deliberately selected publication as the input text [33]. The selected test paper was chosen because prior analysis [8, 9] had identified it as containing relevant examples of the textual issues under investigation. The specific sections of the test paper analyzed were the Abstract and Conclusions. All prompt development and testing were performed using the Gemini Pro 2.5 Pro model accessed via its official web interface [2].

### 2.2. Prompt Development Process

The final prompts were created through an iterative, three-stage process designed to move from a high-level goal to a robust, automated workflow:

1. **Manual Task Decomposition:** The analytical goal (e.g., "flag new information") was first broken down into a logical sequence of smaller, well-defined subtasks suitable for an LLM. Initial prompts were drafted for each subtask.
2. **Interactive Testing and Refinement:** The subtask prompts were tested interactively on the test case within a single LLM conversation. This step served to evaluate the viability of the decomposition scheme and refine the clarity of the instructions for each step.
3. **Meta-Prompting for Workflow Integration:** The refined subtask sequence was integrated into a single, comprehensive workflow prompt using meta-prompting techniques - a process where one prompt is used to guide an LLM to develop and refine another, more specialized prompt [8]. This integration was guided by a previously developed "Adaptive Prompt Engineering Assistant & Tutor" prompt ([8], Appendix B) to structure and formalize the final instructions.

### 2.3. Analytical Framework and Prompts

The core of this methodology is a suite of structured prompts (provided in full in the Appendices) that guide an LLM to act as a `Quality Assurance Analyst`. The framework performs two distinct types of analysis - informational and linguistic - applied separately to the Abstract and Conclusions sections.

1. **Informational Integrity Analysis:** This analysis uses a dedicated prompt to execute a multi-phase workflow that involves locating the target section, segmenting it into sentences, and decomposing those sentences into discrete "Information Units" (IUs). Each IU is then classified according to a detailed 13-category schema defined in the prompt. The final phase involves verifying each IU against the IMRaD sections of the paper to flag new or unsubstantiated information.
2. **Linguistic Clarity Analysis:** This analysis uses a separate prompt to assess pronoun ambiguity and logical flow. The resulting workflow isolates the target section and its sentences, then analyzes each sentence in sequence to identify vague or ambiguous pronouns (e.g., a standalone "this") by strictly evaluating the local textual antecedent.

