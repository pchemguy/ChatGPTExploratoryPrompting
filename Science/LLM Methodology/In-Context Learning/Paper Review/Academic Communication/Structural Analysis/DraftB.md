# **Ai-Facilitated Analysis of Abstracts and Conclusions: Flagging Unsubstantiated Claims and Ambiguous Pronouns**

## 1. Introduction

Computer-assisted tools for academic writing have a long history [1], but the recent emergence of state-of-the-art (SOTA) large language models (LLMs) has enabled new forms of accessible semantic and linguistic analysis [5, 6] and synthesis [7]. Modern LLM architectures, such as Gemini Pro 2.5 Pro [2], ChatGPT Plus o3 [3], and Claude Opus 4 [4], possess capabilities that are particularly useful for the semantic and structural analysis of technical texts. Specifically, their large context windows allow for the analysis of full-length research papers [8, 9], while in-context learning (ICL) [11–13] combined with advanced prompting strategies [14–22] makes it possible to systematically focus the model's attention on specialized aspects of a manuscript [8, 9].

Many scholarly publications that report original research follow the IMRaD (Introduction, Methods, Results, and Discussion) structure [#]. Two other critical sections, the Abstract and the Conclusions, serve as academic summaries that frame this main body of work. This study focuses on the semantic and linguistic quality of these two summary sections. We propose an LLM-based workflow to diagnose two common issues that can detract from the clarity and integrity of these summaries: the inclusion of information not substantiated in the main text and the use of ambiguous pronoun constructs.

Both of these issues undermine the core function of a scholarly manuscript: the effective communication of scientific information. Scientists generally expect that all factual (that is, evidential rather than summative) claims within a summary must originate from and be substantiated by the IMRaD content of the paper [#], where proper context is provided. Introducing new information (an unsubstantiated claim) in a summary section either deprives that information of necessary context or undermines the communicative function of the summary itself. Similarly, ambiguous pronouns (e.g., "it" or a standalone "this") can disrupt narrative flow and complicate comprehension by obscuring the intended antecedent ("The way that many scientists and engineers treat the pronoun it is unsettling but the way that many scientists and engineers treat the word this is criminal") [#]. To address these problems, we developed and tested a series of proof-of-concept (PoC) structured prompts designed to guide an LLM in identifying and flagging these specific issues within a sample text [33]. The prompts and our development process are detailed in the appendices and supporting information.

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

The ground truth for this analysis hinges on the distinction between a pronoun's intrinsic grammatical ambiguity and its semantic adequacy. While a standalone pronoun like "this" is often considered grammatically vague by default, its semantic adequacy depends entirely on whether its full context is explicitly supported by a clear antecedent. The test case for this analysis is the second-to-last sentence of the "Conclusions" section in the test case \[33\]: "**This** illustrates the **power of 17O NMR** in the detection of the reactions of O-containing functional groups." This sentence involves an interpretive claim, and its "pronoun context" can be deconstructed into three main components:
- **Action/verb:** "illustrates"
- **Abstract concept:** "power of 17O NMR"
- **Scope modifier:** "detection of the reactions of O-containing functional groups"
For the reference to be considered semantically adequate, each of these components must be explicitly supported by the antecedent text.

The relevant context in the preceding sentence includes "Five other 17O-labeled compounds were also prepared ... and characterized by NMR and GC-MS." This antecedent context does not explicitly mention the "detection of any reactions". Furthermore, this passing generic mention of NMR (along with another complementary analytical technique) for routine characterization does not semantically support the claim of illustrating the "power" of the technique. The last sentence _does_ mention a reaction detected by NMR and could conceivably act as a formal antecedent in this case, if the last two sentences were swapped (though neither of these sentences is a suitable last sentence in this case), but the sentence following the pronoun cannot serve as a valid antecedent. The pronoun "This", therefore, should be flagged as ambiguous and lacking a clear antecedent in the local context.

The primary success criterion for the quantitative evaluation was the prompt's ability to guide the LLM to correctly identify that the "detection of reactions" component within the target sentence's pronoun context was not explicitly supported by the antecedent text. The performance of the prompt was tested across two LLMs, with test series conducted on different days to assess consistency. Performance was evaluated under both limited context (only the "Conclusions" section provided) and full context (the full manuscript provided) conditions. A total of 201 test runs were conducted with the Gemini Pro 2.5 Pro model, and 59 runs were conducted with the ChatGPT Plus o3 model. The results are summarized in Tables 2 and 3.

**Table 2.** Performance of the `Linguistic Clarity Analysis` Prompt with ChatGPT Plus o3.

| **Series** | **Context** | **Runs** | **Successes** | **Failures** | **Success Rate** |
| :--------: | ----------- | :------: | :-----------: | :----------: | :--------------: |
|     B      | Limited     |    20    |      20       |      0       |      ~100%       |
|     A      | Full        |    19    |      17       |      2       |       ~90%       |
|     B      | Full        |    20    |      16       |      4       |       ~80%       |

Note: One run was excluded from Series A (Full Context) due to the accidental use of an incorrect model version.

**Table 3.** Performance of the `Linguistic Clarity Analysis` Prompt with Gemini Pro 2.5 Pro.

| **Series** | **Context** | **Runs** | **Successes** | **Failures** | **Success Rate** |
| :--------: | ----------- | :------: | :-----------: | :----------: | :--------------: |
|     A      | Limited     |    21    |      12       |      9       |       ~55%       |
|     B      | Limited     |    40    |      14       |      26      |       ~35%       |
|     C      | Limited     |    40    |      21       |      19      |       ~55%       |
|     A      | Full        |    20    |      14       |      6       |       ~70%       |
|     B      | Full        |    40    |      34       |      6       |       ~85%       |
|     C      | Full        |    40    |      35       |      5       |       ~90%       |

## 4. Discussion

The results provide an initial demonstration that structured workflow prompts can effectively guide LLMs to perform specific, non-trivial analytical tasks on summary sections of scholarly manuscripts. In the `Linguistic Clarity Analysis`, both models demonstrated similarly high success rates with full context, though their performance characteristics differed under limited context. In the `Informational Integrity Analysis`, Gemini consistently outperformed ChatGPT, revealing important differences in model capabilities for this specific task.

### 4.1. Informational Integrity Analysis

The first  test, `Informational Integrity Analysis`, targeted two identified numerical quantiles introduced in the Conclusions section of the test case (unsubstantiated information), as discussed in the ground truth analysis above, using the prompt *"ConclusionsClassificationAndReferencesPrompt.md"*. The tested Gemini model successfully identified both targets at the success rate of 95% (Table 1). Curiously, the ChatGPT model demonstrated near binary performance: it flagged one of the quantities with 95% success rate, while completely missing (0% success rate) the other one (Table 1). When these result were interpreted by Gemini, the model made an interesting observation. Syntactically, "90 mL" (correctly flagged by both models) is the head of a noun phrase that acts as the subject. On the other hand, "40-fold" (completely missed by ChatGPT) functions as an adjectival modifier. It possible that the latter more "obscure" role contributed to ChatGPT failure.

This test involves a number of challenges. First, the model needs to analyze the entire manuscript, with summary section potentially buried in the middle of a large document. While modern models demonstrate robust analytical capabilities with respect to the structure of conventional technical texts, non-conventional structure, headings, or even combined sections may complicate the process of identification and extraction of a summary section, particularly Conclusions. Further, within the summary, the model needs to accurately isolate every "atomic" claim (information unit, IU) with appropriate context. These requirements necessitate sufficiently large context window, accurate recall, and strong analytical capabilities for splitting the target section. Locating specific sources of individual identified IUs may not be a trivial task either. Numeric quantities, including derived values, often should appear literally in the appropriate IMRaD sections. At the same time, rounded values or ranges might be more appropriate in a summarizing statement. Non-numeric claims, e.g., related to methods or materials (not tested in this work), where appropriate, may use synonyms or semantically equivalent expressions, further stressing LLM's "reasoning" abilities. However, it is reasonable to expect that the challenges associated with locating specific non-trivial sources will more likely result in false positives, meaning a potential non-issue case being brought to human's attention rather than failing to flag a real problem.

To facilitate development process and potentially improve robustness of prompts, two major approaches have been employed, including development of modular workflow structure and of a custom Classification System for Information Units. Custom classification system may facilitate extraction of IUs from unstructured text and their subsequent analysis, though no attempt has been made in this study to test this hypothesis quantitatively or qualitatively. Decomposition techniques, techniques like CoT (and its variations), as well as our previous work [8] provide strong evidence in favor of workflow prompts design for complex analytical tasks. While both non-reasoning and reasoning models demonstrate improved performance with such techniques, reasoning models possess naturally better capability to take advantage of complex workflow prompts.

Modular structured prompt design potentially offers a number of benefits. In present case, the prompt employs a linear workflow process that "drills down" the hierarchical organization of technical texts, starting from the entire input and gradually narrowing focus in a staged process eventually zeroing in on "atomic" IUs. The idea here is that any intermediate result/output (particularly for reasoning models) becomes part of models context that can be used/addressed in subsequent steps. For example, once the Conclusions section is identified and extracted, it becomes a separate "focused" piece in the models context, and subsequent stages involving this section, in a sense, no longer need to address the entire manuscript (though in present case, no attempt to gauge potential performance improvement due to the detailed workflow prompt design has been made). Modular structured workflow design offers two other important benefits. On the one hand, prompt sections can be reused in different prompt involving the same sub-tasks, such as identification of a summary section and splitting it into sentences, as demonstrated by the two prompts developed for the two reported test targets. Equally important, is the structured prompt's (with detailed output) potential ability to provide insights into LLM's specific failure modes.

Close examination of detailed individual LLM responses revealed a number of observations.
- **Instruction Following - Report Output:**
  ChatGPT's outputs were generally considerably more terse, often ignoring some of the instructions. For example, the subsection **"5. Report Verification Findings for Each Information Unit (IU)"** of **"Phase 5: Referencing and Verification of Information Units (IU)"** specifically mandated to provide details on both substantiated (**Subsection A**) and unsubstantiated (**Subsection B**) items. Additionally, "**4. Evaluate Numeric Quantities (If the IU contains them)**" places specific focus on numeric quantities. ChatGPT output largely ignored these instructions, as opposed to output of Gemini, making it difficult to diagnose potential issues.
   
  Gemini's output was generally more insightful. For example, the only case classified as failure to flag the "40-fold" piece clearly reveals that Gemini successfully extracted this quantity (like in all other cases), considered it, and provided an explanation of its non-flagging decision: `"40-fold enriched water" is a reasonable summary of the pre-concentration by evaporation step.` Similarly, with the other case: `The "about 90 mL" output is reasonably close to the sum of the most enriched fractions detailed (70 mL).`
- **No False Positives:**
  Neither model flagged any other numeric quantity, which is the desired result according to our ground truth analysis. Gemini flagged several times evaluative/interpretive statements, such as:
  
  `The assertion that "The most practical method for determining the enrichment was found to be the reaction of the H217O with BSTFA to yield hexamethyldisiloxane". While the method is described, its comparative "practicality" over other determination methods detailed (e.g., 1-hexanol derivatization) is not explicitly justified or stated as a finding within the IMRaD sections.`
  
  These targets are more difficult/abstract and were not targeted by the present version of the prompt, though it might be conceivable to target such targets with crafted instructions. 

### 4.2. Linguistic Clarity Analysis

The other  test, `Linguistic Clarity Analysis`, targeted a problematic standalone "this" reference, as discussed in the ground truth analysis above, using the prompt "ConclusionsLinguisticAnalysisPrompt.md". The context for this analysis is limited solely to the summary section being analyzed, that is any "this/it" reference must have a clear antecedent within the section itself. For this reason, this analysis could be implemented in two modes: "limited context", with only the Conclusions section provided to the LLM, and "full context", where model would need identify the Conclusions section in the full manuscript. ChatGPT model demonstrated consistently high success rate (according to criteria discussed in the Results section) in both modes, with 85% rate with in the full context mode and reaching a perfect score in the limited context mode (Table 2). Gemini model demonstrated the same success rate with full context, but surprisingly low performance in the limited context mode. Gemini also demonstrated somewhat apparently odd behavior during the first Series A tests, which were excluded from further consideration (Table 3).

The oddity with Series A Gemini analysis was in distribution of failed runs. These two series involved 41 runs total executed in succession. Oddly, in both cases the majority of failed runs were in the last half of the corresponding series. For this reason, both series were doubled in length (40 runs each) and repeated twice on two separate days (series B and C). The series B and C demonstrated consistent behavior:  full context - close high performance (matching that of the ChatGPT model); limited context - consistently low performance.

As discussed in the Results section the present prompt version primarily targeted the concrete "detection of reactions" scope modifier. Close examination of models' output revealed, however, that both models also correctly flagged the abstract concept "power of 17O NMR" as unsupported by the antecedent at nearly identical rate. In the case of poorly preforming limited-context series with Gemini, flagging of "power of 17O NMR" was also comparably poor.

