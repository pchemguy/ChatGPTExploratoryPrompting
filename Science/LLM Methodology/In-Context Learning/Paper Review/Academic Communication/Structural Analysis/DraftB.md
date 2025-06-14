# **Ai-Facilitated Analysis of Abstracts and Conclusions: Flagging Unsubstantiated Claims and Ambiguous Pronouns**

## 1. Introduction

Computer-assisted tools for academic writing have a long history [1], but the recent emergence of state-of-the-art (SOTA) large language models (LLMs) has enabled new forms of accessible semantic and linguistic analysis [5, 6] and synthesis [7]. Modern LLM architectures, such as Gemini Pro 2.5 Pro [2], ChatGPT Plus o3 [3], and Claude Opus 4 [4], possess capabilities that are particularly useful for the semantic and structural analysis of technical texts. Specifically, their large context windows allow for the analysis of full-length research papers [8, 9], while in-context learning (ICL) [11–13] combined with advanced prompting strategies [14–22] makes it possible to systematically focus the model's attention on specialized aspects of a manuscript [8, 9].

Many scholarly publications that report original research follow the IMRaD (Introduction, Methods, Results, and Discussion) structure [#]. Two other critical sections, the Abstract and the Conclusions, serve as academic summaries that frame this main body of work. This study focuses on the semantic and linguistic quality of these two summary sections. We propose an LLM-based workflow to diagnose two common issues that can detract from the clarity and integrity of these summaries: the inclusion of information not substantiated in the main text and the use of ambiguous pronoun constructs.

Both of these issues undermine the core function of a scholarly manuscript: the effective communication of scientific information. Scientists generally expect that all factual claims within a summary must originate from and be substantiated by the IMRaD content of the paper [#], where proper context is provided. Introducing new information (unsubstantiated claim) in a summary section either deprives that information of necessary context or undermines the communicative function of the summary itself. Similarly, ambiguous pronouns (e.g., "it" or a standalone "this") can disrupt narrative flow and complicate comprehension by obscuring the intended antecedent (\<quote here\>) [#]. To address these problems, we developed and tested a series of proof-of-concept (PoC) structured prompts designed to guide an LLM in identifying and flagging these specific issues within a sample text [33]. The prompts and our development process are detailed in the appendices and supporting information.

## 2. Methodology

### 2.1. Materials

The proof-of-concept prompts developed in this study were tested using a single, deliberately selected publication as the input text [33]. The selected test paper was chosen because prior analysis [8, 9] had identified it as containing relevant examples of the textual issues under investigation. The specific sections of the test paper analyzed were the Abstract and Conclusions. All prompt development and testing were performed using the Gemini Pro 2.5 Pro model accessed via its official web and mobile interface, as well as via Google AI Studio [2]. Additional testing was also performed using ChatGPT Plus o3 model accessed via its official web interface [3]. 

### 2.2. Prompt Development Process

The core of this methodology is a suite of structured prompts (provided in full in the Appendices) that guide an LLM to act as a `Quality Assurance Analyst`. Presented prompts were created through an iterative, three-stage process designed to move from a high-level goal to a robust, automated workflow:

1. **Manual Task Decomposition:** The analytical goal (e.g., "flag new information") was first broken down into a logical sequence of smaller, well-defined subtasks suitable for an LLM. Initial prompts were drafted for each subtask.
2. **Interactive Testing and Refinement:** The subtask prompts were tested interactively on the test case within a single LLM conversation. This step served to evaluate the viability of the decomposition scheme and refine the clarity of the instructions for each step.
3. **Meta-Prompting for Workflow Integration:** The refined subtask sequence was integrated into a single, comprehensive workflow prompt using meta-prompting techniques - a process where one prompt is used to guide an LLM to develop and refine another, more specialized prompt [8]. This integration was guided by a previously developed "Adaptive Prompt Engineering Assistant & Tutor" prompt ([8], Appendix B) to structure and formalize the final instructions.

Developed prompts perform two distinct types of analysis - informational and linguistic - applied separately to the Abstract and Conclusions sections.

### 2.3. Informational Integrity Analysis

This analysis uses a dedicated prompt to execute a multi-phase workflow that involves locating the target section, segmenting it into sentences, and decomposing those sentences into discrete "Information Units" (IUs). Each IU is then classified according to a detailed 13-category schema defined in the prompt. The final phase involves verifying each IU against the IMRaD sections of the paper to flag new or unsubstantiated information.
  
The use of a custom classification system to guide an LLM's semantic analysis is a conceptual approach explored in our prior work [8]. The 13-category schema employed in this study is a further development of that approach, designed specifically for the nuanced informational content of academic summaries. The schema was developed to be a modular tool applicable to both Abstracts and Conclusions, containing categories common to both summary types as well as categories more specific to one. Each category includes a scope definition, the primary IMRaD section where the information is expected to originate, and verification notes for the LLM. For the present PoC study, the system's primary function was to guide the LLM's verification process by directing its search to the most probable IMRaD source section for any given Information Unit.

### 2.4. Linguistic Clarity Analysis

The workflow for this analysis evolved during development. Our initial approach utilized a basic prompt that relied on the LLM's general semantic capabilities, but early testing revealed this method was not sufficiently robust. This finding motivated the development of a more structured workflow where the LLM performs a highly structured assessment. For each pronoun, the workflow defines a precise **"pronoun context"** by systematically deconstructing its own clause into its semantic components (e.g., action, subject, concept, and all modifiers). It then performs a component-wise **sufficiency check** to determine if the pronoun context is properly supported by the context of the identified antecedent.

Judging whether such support is sufficient can be challenging for an LLM, particularly when the pronoun's sentence involves an interpretive 'action' (the verb) and abstract concepts (e.g., "This illustrates the power of..."). To account for this scenario, the prompt separates the analysis of the often more abstract interpretive verbs from that of the more concrete 'substantive components' of the claim (the object of the verb and its modifiers). The analysis separation is achieved by including a dedicated sufficiency check branch for the 'action component'. However, it should be noted that potentially abstract 'substantive components' (particularly the syntactic head noun of the object) are not treated with similar specificity in the current prompt version.

### 2.5. Testing Protocol

To assess the robustness and consistency of the prompts across two different models, a systematic evaluation was conducted. The prompts were tested against the publication [33] using two different frontier LLMs under two distinct conditions: a "limited context run" (for linguistic analysis) where only the "Conclusions" section was provided as input, and a "full context run" where the entire manuscript was provided. Models were accessed solely through the official web and mobile user interfaces; no API access was employed. All tests were conducted by manual submission of prompt texts. Each prompt was submitted to a new AI chat after completion of the previous one. With ChatGPT, each series was executed within a dedicated project, and the test manuscript was submitted once per series as a project file. With Gemini, the test manuscript was attached to each AI chat from Google Drive. Each experiment was repeated in a series of 20-40 successive runs. Additionally, each series was typically repeated at least twice, with each repetition performed on a separate day. The results of individual outputs were manually collected on spreadsheets for subsequent evaluation of success/failure rates.

## 3. Results

This section presents the results from the evaluation of the two proof-of-concept prompts developed in this study. We first detail the quantitative results from the systematic, multi-run testing of the `Linguistic Clarity Analysis` prompt. Following this, we report the outcome of the `Informational Integrity Analysis` prompt when applied to its target test case.

### 3.1. Informational Integrity Analysis

The ground truth for this analysis was established by analyzing the "Conclusions" section of the test paper [33] for information not previously substantiated in the IMRaD sections. The third sentence of the Conclusions states: "From approximately **500 mL of 40-fold enriched water, about 90 mL of H217O** was obtained." While the input volume of "500 mL" is mentioned in the main text, the specification of "**40-fold enriched water**" (presumably the implied result of the first experimental stage) is not. Furthermore, the output quantity of "**90 mL of H217O**" is not explicitly stated in the main text, nor can it be directly derived from the data presented in the paper's tables or figures. Therefore, these pieces of information should be flagged as "unsubstantiated claims".

The prompt's performance was evaluated for its ability to identify these two distinct pieces of unsubstantiated information across 20 runs for each model. The number of successful identifications ("hits") for each target is summarized in Table 1.

**Table 1.** Successful Identifications of Unsubstantiated Information (out of 20 runs).

|               | ChatGPT Plus o3 | Gemini Pro 2.5 Pro |
| ------------- | :-------------: | :----------------: |
| **"90 mL"**   |       19        |         19         |
| **"40-fold"** |        0        |         19         |

### 3.2. Linguistic Clarity Analysis

The ground truth for this analysis was established by examining the second-to-last sentence of the "Conclusions" section in the test case [33] contains a potentially ambiguous standalone pronoun: "**This** illustrates the **power of 17O NMR** in the detection of the reactions of O-containing functional groups." This sentence involves an interpretive claim characterized by a typical action/verb ("illustrates"), an abstract concept ("power of 17O NMR"), and a scope modifier ("detection of the reactions of O-containing functional groups"), which narrows the scope of the technique included in the "concept part".

The relevant context in the preceding sentence includes "Five other 17O-labeled compounds were also prepared ... and characterized by NMR and GC-MS." This antecedent context does not explicitly mention the "detection of any reactions". Furthermore, this passing generic mention of NMR (along with another complementary analytical technique) for routine characterization does not semantically support the claim of illustrating the "power" of the technique. The last sentence _does_ mention a reaction detected by NMR and could conceivably act as a formal antecedent in this case, if the last two sentences were swapped (though neither of these sentences is a suitable last sentence in this case), but the sentence following the pronoun cannot serve as a valid antecedent. The pronoun "This", therefore, should be flagged as ambiguous and lacking a clear antecedent in the local context.

The primary success criterion for the quantitative evaluation was the prompt's ability to guide the LLM to correctly identify that the "detection of reactions" component within the target sentence's pronoun context was not explicitly supported by the antecedent text. The performance of the prompt was tested across two LLMs, with test series conducted on different days to assess consistency. Performance was evaluated under both limited context (only the "Conclusions" section provided) and full context (the full manuscript provided) conditions. A total of 201 test runs were conducted with the Gemini Pro 2.5 Pro model, and 59 runs were conducted with the ChatGPT Plus o3 model. The results are summarized in Tables 2 and 3.

**Table 2.** Performance of the `Linguistic Clarity Analysis` Prompt with Gemini Pro 2.5 Pro.

| **Series** | **Context** | **Runs** | **Successes** | **Failures** | **Success Rate** |
| :--------: | ----------- | :------: | :-----------: | :----------: | :--------------: |
|     A      | Limited     |    21    |      12       |      9       |       ~55%       |
|     B      | Limited     |    40    |      14       |      26      |       ~35%       |
|     C      | Limited     |    40    |      21       |      19      |       ~55%       |
|     A      | Full        |    20    |      14       |      6       |       ~70%       |
|     B      | Full        |    40    |      34       |      6       |       ~85%       |
|     C      | Full        |    40    |      35       |      5       |       ~90%       |

**Table 3.** Performance of the `Linguistic Clarity Analysis` Prompt with ChatGPT Plus o3.

|    **Series**    | **Context** | **Runs** | **Successes** | **Failures** | **Success Rate** |
| :--------------: | ----------- | :------: | :-----------: | :----------: | :--------------: |
|        B         | Limited     |    20    |      20       |      0       |      ~100%       |
|        A         | Full        |    19    |      17       |      2       |       ~90%       |
|        B         | Full        |    20    |      16       |      4       |       ~80%       |

Note: One run was excluded from Series A (Full Context) due to the accidental use of an incorrect model version.

## 4. Discussion

### 4.1. Interpretation of Findings

The results provide initial demonstration of effective guidance of LLMs via structured workflow prompts to perform specific, non-trivial analytical tasks on summary sections of scholarly manuscripts. Under favorable setup, both models demonstrated similarly high success rate on the linguistic analysis, though Gemini's model behavior was somewhat less consistent than that of ChatGPT. On the other hand, Gemini consistently outperformed ChatGPT in the informational integrity analysis.

The first  test, `Informational Integrity Analysis`, targeted two identified numerical quantiles introduced in the Conclusions section of the test case (unsubstantiated information). The tested Gemini model successfully identified both targets at the success rate of 95% (Table 1). Curiously, the ChatGPT model demonstrated near binary performance: it flagged one of the quantities with 95% success rate, while completely missing (0% success rate) the other one (Table 1). When these result were interpreted by Gemini, the model made an interesting observation: "" 

This test involves a number of challenges. First, the model needs to analyze the entire manuscript, with summary section potentially buried in the middle of a large document. While modern models demonstrate robust analytical capabilities with respect to the structure of conventional technical texts, non-conventional structure, headings, or even combined sections may complicate the process of identification and extraction of a summary section, particularly Conclusions. Further, within the summary, the model needs to accurately isolate every "atomic" claim (information unit, IU) with appropriate context. These requirements necessitate sufficiently large context window, accurate recall, and strong analytical capabilities for splitting the target section. Locating specific sources of individual identified IUs may not be a trivial task either. Numeric quantities, including derived values, often should appear literally in the appropriate IMRaD sections. At the same time, rounded values or ranges might be more appropriate in a summarizing statement. Non-numeric claims, e.g., related to methods or materials (not tested in this work), where appropriate, may use synonyms or semantically equivalent expressions, further stressing LLM's "reasoning" abilities. However, it is reasonable to expect that the challenges associated with locating specific non-trivial sources will more likely result in false positives, meaning a potential non-issue case being brought to human's attention rather than failing to flag a real problem.

To facilitate development process and potentially improve robustness of prompts, two major approaches have been employed, including development of modular workflow structure and of a custom Classification System for Information Units. Custom classification system may facilitate extraction of IUs from unstructured text and their subsequent analysis, though no attempt has been made in this study to test this hypothesis quantitatively or qualitatively. Decomposition techniques, techniques like CoT (and its variations), as well as our previous work [8] provide strong evidence in favor of workflow prompts design for complex analytical tasks. While both non-reasoning and reasoning models demonstrate improved performance with such techniques, reasoning models possess naturally better capability to take advantage of complex workflow prompts.

Modular structured prompt design potentially offers a number of benefits. In present case, the prompt employs a linear workflow process that "drills down" the hierarchical organization of technical texts, starting from the entire input and gradually narrowing focus in a staged process eventually zeroing in on "atomic" IUs. The idea here is that any intermediate result/output (particularly for reasoning models) becomes part of models context that can be used/addressed in subsequent steps. For example, once the Conclusions section is identified and extracted, it becomes a separate "focused" piece in the models context, and subsequent stages involving this section, in a sense, no longer need to address the entire manuscript (though in present case, no attempt to gauge potential performance improvement due to the detailed workflow prompt design has been made). Modular structured workflow design offers two other important benefits. On the one hand, prompt sections can be reused in different prompt involving the same sub-tasks, such as identification of a summary section and splitting it into sentences, as demonstrated by the two prompts developed for the two reported test targets. Equally important, is the structured prompt's (with detailed output) potential ability to provide insights into LLM's specific failure modes.

Close examination of detailed individual LLM responses revealed a number of observations.
1. **Instruction Following - Report Output:**
   ChatGPT's outputs were generally considerably more terse, often ignoring some of the instructions. For example, the subsection **"5. Report Verification Findings for Each Information Unit (IU)"** of **"Phase 5: Referencing and Verification of Information Units (IU)"** specifically mandated to provide details on both substantiated (**Subsection A**) and unsubstantiated (**Subsection B**) items. Additionally, "**4. Evaluate Numeric Quantities (If the IU contains them)**" places specific focus on numeric quantities. ChatGPT output largely ignored these instructions, as opposed to output of Gemini, making it difficult to diagnose potential issues.
   
   Gemini's output was generally more insightful. For example, the only case classified as failure to flag the "40-fold" piece clearly reveals that Gemini successfully extracted this quantity (like in all other cases), considered it, and provided an explanation of its non-flagging decision: `"40-fold enriched water" is a reasonable summary of the pre-concentration by evaporation step.` Similarly, with the other case: `The "about 90 mL" output is reasonably close to the sum of the most enriched fractions detailed (70 mL).`





isolate every "atomic" claim with appropriate context from the summary section.

The high success rates for the `Linguistic Clarity Analysis` in the full context condition (Tables 1 & 2) demonstrate the robustness of this prompt's architecture for identifying a complex case of pronoun ambiguity. The performance divergence between context conditions and models for this task highlights key differences in model behavior, with ChatGPT o3 showing a remarkable (100%) ability to adhere to the prompt's local constraints, while Gemini Pro's performance benefited significantly from wider context.

The `Informational Integrity Analysis` results introduce further nuance. This task of identifying unsubstantiated information appears more challenging than the linguistic check. ChatGPT's complete failure to identify the unsubstantiated modifier ("40-fold") suggests a potential weakness in verifying adjectival descriptors compared to quantitative values ("90 mL"). Gemini Pro's stronger performance on both targets indicates its reasoning process was better suited for this specific verification task. These outcomes underscore that even for seemingly similar verification tasks, prompt effectiveness can be highly dependent on the model used and the specific nature of the target information (e.g., modifier vs. quantity).

The temporal variability observed in the `Linguistic Clarity Analysis` for Gemini Pro (Table 1, limited context) is also a critical finding for researchers using public-facing LLM interfaces, as it suggests that prompt performance can be non-deterministic.



---
---


The data shows a significant dependency on the provided context. The success rates in the full context condition (70-88%) were dramatically higher than in the limited context condition (35-57%). Furthermore, the performance in the limited context condition showed substantial variability between series conducted on different days.

The ChatGPT o3 model demonstrated a perfect (100%) success rate in the single limited context series. The performance in the full context condition was also high and consistent, with success rates of 90% and 80% across the two series.

~ ### 3.2. Informational Integrity Analysis

#### 3.1.1. Ground Truth Analysis

The "Conclusions" section of the test paper [33] was analyzed for information not previously substantiated in the IMRaD sections. The third sentence of the Conclusions states: "From approximately **500 mL of 40-fold enriched water, about 90 mL of H217O** was obtained." While the input volume of "500 mL" is mentioned in the main text, the specification of "**40-fold enriched water**" (presumably the implied result of the first experimental stage) is not. Furthermore, the output quantity of "**90 mL of H217O**" is not explicitly stated in the main text, nor can it be directly derived from the data presented in the paper's tables or figures. Therefore, these pieces of information were flagged as "unsubstantiated claims".

---
---

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
