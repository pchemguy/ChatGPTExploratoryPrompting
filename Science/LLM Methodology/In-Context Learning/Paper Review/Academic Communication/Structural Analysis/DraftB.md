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

#### 2.3.1 Informational Integrity Analysis

This analysis uses a dedicated prompt to execute a multi-phase workflow that involves locating the target section, segmenting it into sentences, and decomposing those sentences into discrete "Information Units" (IUs). Each IU is then classified according to a detailed 13-category schema defined in the prompt. The final phase involves verifying each IU against the IMRaD sections of the paper to flag new or unsubstantiated information.
  
The use of a custom classification system to guide an LLM's semantic analysis is a conceptual approach explored in our prior work [8]. The 13-category schema employed in this study is a further development of that approach, designed specifically for the nuanced informational content of academic summaries. The schema was developed to be a modular tool applicable to both Abstracts and Conclusions, containing categories common to both summary types as well as categories more specific to one. Each category includes a scope definition, the primary IMRaD section where the information is expected to originate, and verification notes for the LLM. For the present PoC study, the system's primary function was to guide the LLM's verification process by directing its search to the most probable IMRaD source section for any given Information Unit.

#### 2.3.2 Linguistic Clarity Analysis

The workflow for this analysis evolved during development. Our initial approach utilized a basic prompt that relied on the LLM's general semantic capabilities, but early testing revealed this method was not sufficiently robust. This finding motivated the development of a more structured workflow where the LLM performs a highly structured assessment. For each pronoun, the workflow defines a precise **"pronoun context"** by systematically deconstructing its own clause into its semantic components (e.g., action, subject, concept, and all modifiers). It then performs a component-wise **sufficiency check** to determine if the pronoun context is properly supported by the context of the identified antecedent.

Judging whether such support is sufficient can be challenging for an LLM, particularly when the pronoun's sentence involves an interpretive 'action' (the verb) and abstract concepts (e.g., "This illustrates the power of..."). To account for this scenario, the prompt separates the analysis of the often more abstract interpretive verbs from that of the more concrete 'substantive components' of the claim (the object of the verb and its modifiers). The analysis separation is achieved by including a dedicated sufficiency check branch for the 'action component'. However, it should be noted that potentially abstract 'substantive components' (particularly the syntactic head noun of the object) are not treated with similar specificity in the current prompt version.

## 3. Results and Discussion

This section presents preliminary results of the developed proof-of-concept (PoC) prompts when applied to the test case publication [33]. We analyze the two target issues - the presence of unsubstantiated claim and the use of an ambiguous pronoun - by first establishing the ground truth and then presenting the output from the corresponding LLM-based analysis.

### 3.1. Case 1: Unsubstantiated Claim Check

#### 3.1.1. Ground Truth Analysis

The "Conclusions" section of the test paper [33] was analyzed for information not previously substantiated in the IMRaD sections. The third sentence of the Conclusions states: "From approximately **500 mL of 40-fold enriched water, about 90 mL of H217O** was obtained." While the input volume of "500 mL" is mentioned in the main text, the specification of "**40-fold enriched water**" (presumably the implied result of the first experimental stage) is not. Furthermore, the output quantity of "**90 mL of H217O**" is not explicitly stated in the main text, nor can it be directly derived from the data presented in the paper's tables or figures. Therefore, these pieces of information were flagged as "unsubstantiated claims".

#### 3.1.2. LLM Prompt Results

The "Informational Integrity Analysis" prompt was applied to the full text of the test paper [#].

`[Placeholder: Insert the relevant portion of the LLM's output here. This should be the part of the output that analyzes the sentence "From approximately 500 mL of 40-fold enriched water, about 90 mL of H217O was obtained." and flags the unsubstantiated terms.]`

The LLM successfully identified the unsubstantiated terms, classifying them as "New Information in Conclusions." The output correctly noted that while the 500 mL quantity was present, the "40-fold" specification and the "90 mL" result were not found in the IMRaD body of the manuscript.

### 3.2. Case 2: Ambiguous Pronoun Check

#### 3.2.1. Ground Truth Analysis

The second-to-last sentence of the "Conclusions" section contains a potentially ambiguous standalone pronoun: "**This** illustrates the **power of 17O NMR** in the detection of the reactions of O-containing functional groups." This sentence involves an interpretive claim characterized by a typical action/verb "illustrates", an abstract concept "power of 17O NMR", and the rest of the sentence "detection of the reactions of O-containing functional groups" constitutes scope modifier, indicating a specific use of the technique ("17O NMR") specified in the concept being modified. The relevant context in the preceding sentence includes "Five other 17O-labeled compounds were also prepared ... and characterized by NMR and GC-MS." Not only this context (as well as the omitted part of the sentence) has nothing to do with detection of any reactions whatsoever, but also this passing non-specific mentioning of NMR alone with other analytical technique constitutes a routine established use of the technique (characterization by NMR), and has nothing to do with stated illustration of its power. The last sentence _does_ mention a reaction detected by NMR and could conceivably act as a formal antecedent in this case, if the last two sentences were swapped (though neither of these sentences is a suitable last sentence in this case), but the sentence following the pronoun cannot serve as a valid antecedent. The pronoun "This", therefore, should be flagged as ambiguous and lacking a clear antecedent in the local context.

#### 3.2.2. LLM Prompt Results

The "Linguistic Clarity Analysis" prompt was applied to the test paper, focusing on the "Conclusions" section.

`[Placeholder: Insert the LLM's output for the analysis of the sentence "This illustrates the power of 17O NMR..." here. The output should show the pronoun being flagged and the reasoning provided by the LLM.]`

The prompt successfully guided the LLM to flag the pronoun "This" as ambiguous. The model's reasoning noted the lack of a sufficient antecedent in the preceding sentence and correctly disregarded the subsequent sentence as a possible source.

### 3.3. Discussion

The results demonstrate the feasibility of using structured, multi-phase prompts to guide an LLM in identifying specific stylistic and informational issues in academic summaries. In both test cases, the PoC prompts successfully replicated the findings of an expert human analysis.

**Limitations:** This study is a proof-of-concept and, as such, has significant limitations. The prompts were developed and tested on a single manuscript that was deliberately chosen for containing known issues. The robustness and generalizability of these specific prompts across different writing styles, disciplines, and document formats are unknown. Furthermore, the analysis of more subtle or complex instances of these issues has not been evaluated.

**Implications and Future Work:** Despite the limitations, this work suggests a promising direction for developing accessible, AI-assisted tools for improving scholarly writing. Future work should focus on testing these prompts on a larger and more diverse corpus of publications to assess their reliability and identify failure modes. Subsequent research could explore refining the prompts to handle more complex cases, expanding the classification schema, and integrating these checks into a more automated document analysis pipeline.
