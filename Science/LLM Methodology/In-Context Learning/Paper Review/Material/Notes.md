Abstract: section on methodology

---

Title: ... and via LLM-assisted prompt engineering

---

Methodology - limitations - test paper

---

Methodology

**Acs peer review**  

**A note on peer review**  

Scholar peer review is knowledge and reasoning intensive process involving complex workflows that need to be tailored to specific field/subfield/journal. The inherent complexity of this process is only one reason why peer review is a challenging task for ai systems. Limit availability of review examples that could be used for model training is another reason, though a number of specialized data sets have used for training and testing purposes []. Another

Structured systematic analysis and complex workflows are crucial for preparation of high quality peer reviews. But **these activities largely really on mostly tacit knowledge of high-level experts and are generally time-intensive.**

Perhaps a bigger question would be to what extent tacit knowledge involved in research/engineering/medicine activities can be codified/formalized, that is reduced/decomposed to actionable workflows/structured abstract/generalized protocols involving simpler steps accessible (whatever it means) to SOTA AI.

Problem of generating increasingly abstracting protocols that still elicit detailed and tailored response

Meta-reasoning meta-learning meta-research

   even for state-of-the-art (SOTA) LLM models

Two common strategies for a complex problem, and associated workflows

https://researcher-resources.acs.org/publish/peer_reviews
https://reviewertoolkit.acs.org/reviewertoolkit/story.html

---

**LLM-assisted PE**

https://gemini.google.com/app/59e84d4879cebb1c
https://gemini.google.com/app/efb8c56cfe127897
https://gemini.google.com/app/d2c4bde3d736612e
https://gemini.google.com/app/6d2be1cb7165c2e2
https://gemini.google.com/app/3228c100823b1c62
https://gemini.google.com/app/c0bbf5c426b3f66a
https://gemini.google.com/app/df57ae1b7998afd1
https://gemini.google.com/app/ea9bea57348f2876
https://chatgpt.com/c/674ef0cb-665c-8004-b7d0-fb28e7a9af12

---

Idealized model

[https://gemini.google.com/app/1f630e421bf874e8](https://gemini.google.com/app/1f630e421bf874e8)  
[https://gemini.google.com/app/ea9bea57348f2876](https://gemini.google.com/app/ea9bea57348f2876)  

Multimodal capabilities

Google Gemini ADVANCED 2.5 Pro (but not the "standard" version available without subscription) repeatedly demonstrated ability to analyze and understand images and integrated extracted and inferred information. In particular, it consistently identified aluminum foil around the fractionation column in the SI Fig. 1 [§], and this information was not present anywhere in text. It has also inferred scale information based on text description per instructions and used this information for subsequent analysis of the underlying physical processes.

While OpenAI has indicated that their recent o3 reasoning model is capable of performing multimodal analysis, in my limited testing of this feature, I have not observed strong evidences of this capability. Furthermore, OpenAI, as opposed to Google, hides ChatGPT's reasoning models' thought process, so direct verification of OpenAI's claims is also problematic.


[https://openai.com/index/thinking-with-images](https://openai.com/index/thinking-with-images)

---

For very complex prompt development use the best reasoning models and treat it like a peer. I have been using ChatGPT Plus o1 and Google Gemini Advanced 2.5 Pro. The o1 Pro version might have provided additional advantage, it but requires more substantial financial commitment. The problem with o1 Plus is its restrictive use limit: with 50 prompts per week, it is very limited in practice. Now the o3 model is out, and it is likely to be even more restrictive. Input/output token limits are two other important characteristics that motivated my switching from OpenAI to Google.

  

The general strategy is start small by drafting initial prompt. In fact, when developing something new, don't bother about having a prompt at all.

---

Consider whether the following points should be integrated in the prompt or if the present version covers them sufficiently already. 

Consider the following complex prompt provided as `PeerReviewPrompt.md` attachment. This

Prompt implements a proposed Persistent Workflow Prompting (PWP) technique described in the attached manuscript `MetaPWP.pdf`. Analyze both the prompt text and manuscript and consider which concepts/ideas may be integrated in the prompt engineer/tutor prompt to extend its capabilities for assistance and development of very complex prompts.


---

I am suspicious about the main claim after reading a scholarly manuscript's title and abstract. I need a clear guide on how to proceed. Please structure your response into two main parts:

- **Part 1: Metacognitive Analysis**
    Describe a step-by-step process using metacognition for me to identify, analyze, and clearly articulate the specific reasons behind my suspicion (e.g., issues with claim strength, scope, methodology implied, contradiction with known facts).
- **Part 2: Teaching the LLM**
    Explain practical strategies (like designing specific prompts or defining heuristics) to use the insights from Part 1 to teach an LLM to recognize and flag similarly suspicious claims in other scholarly publications. Focus on strategies that uses standard prompt only (no API access, coding, or model modification is allowed).

Please provide practical, actionable steps for both the metacognitive analysis and the process of instructing the LLM.

---

Assume the role of an expert peer reviewer conducting a thorough critical appraisal of the attached scholarly manuscript and its supporting information. Your goal is to identify potential reasons for skepticism regarding the study's claims, rigor, and reporting. Please analyze the entire text and report on the following points, providing specific examples or locations from the text where possible:

1. **Claim Clarity & Consistency:** Identify the main claim(s) in the Abstract. Track if the Introduction's hypothesis, the Methods' objectives, the Results' key findings, and the Discussion's conclusions are fully aligned with this claim in scope and certainty. Note any discrepancies.
2. **Methodological Rigor & Transparency:** Based on *all* details in the Methods (main text + SI), evaluate the appropriateness of the study design, sample size and selection, intervention/exposure definition, outcome measures (validity/reliability), and statistical analysis plan for addressing the main claim. Is sufficient detail provided for replication? Note specific weaknesses or ambiguities.
3. **Results Reporting & Support:** Do the Results presented (including *all* figures, tables in main text and SI) directly and robustly support the main claim(s)? Is there evidence of selective reporting (cherry-picking significant findings, omitting non-significant ones mentioned in methods or SI)? Are effect sizes and confidence intervals reported and interpreted appropriately? Are visualizations potentially misleading?
4. **Discussion Integrity:** Does the Discussion accurately interpret the findings considering *all* results (main + SI)? Are the study's limitations (identified from your analysis of methods/results/SI) fairly and adequately discussed? Is the strength of the conclusion justified by the evidence? Does it align with the Abstract claim?
5. **Cross-Sectional Consistency:** Explicitly identify any major contradictions or inconsistencies found *between any sections* of the document (Abstract, Intro, Methods, Results, Discussion, SI) regarding key information (e.g., sample characteristics, methods used, results, conclusions).
6. **Overall Red Flags:** Note any other signs suggesting potential bias, lack of rigor, or overly promotional language (e.g., funding sources, undeclared COI hints, excessive jargon, hype).

Please provide a structured report addressing these points based on your analysis of the complete text provided below.

---

Act as a critical appraisal tool. I attached a manuscript and supporting information. Evaluate potential reasons for suspicion using the checklist below, noting flags based *only* on the information provided:

**Critical Checklist - Flag potential issues:**
* [ ] Abstract-Intro Misalign
* [ ] Inadequate/Flawed Methods (Main Text)
* [ ] **SI Methods Reveal Issues:** SI Methods detail flaws/limitations not clear in main text.
* [ ] Results (Main) Don't Support Claim / Cherry-Picking
* [ ] **SI Data Contradicts/Weakens Main Results:** SI data shows different picture, unreported negative findings, or high variability.
* [ ] Over-Interpretation in Discussion
* [ ] Limitations Ignored/Downplayed (across all sections including SI)
* [ ] **Inconsistency Between Main Text & SI:** Direct contradictions found.
* [ ] Misleading Visuals (if described)
* [ ] Biased Language/Tone
* [ ] Potential COI/Funding Bias

**Output:** List flagged checklist points, explaining *why* based on the provided information.

---
---

Help me revise a manuscript to be submitted to arXiv CS.ai. The paper is focused on prompt engineering and its applications to complex STEM tasks. The manuscript introduces a new prompting technique, PWP, a proof-of-concept prompt, which was developed via meta-prompting and meta-reasoning. Both developed prompt and methodology are novel, complex, and important.

---
---

### 3. **Formalizing the Review Process**

A significant challenge involved translating the complex human task of scientific peer review into specific, executable instructions for the model. I approached this translation through reflection and abstraction. Reading the paper is naturally the first generic step a scientist does. Importantly, papers are usually not read like fiction books and are not read for pleasure.

**Main Result and Key Findings**

Usually, the first matter I want to know is the main claimed result and key findings. Typical structure of academic manuscript varies to some extent with fields and targeted journals. For experimental chemistry papers, I would look for information about the claimed results in the title, abstract, conclusions, and, possibly, the part of the introduction section that leads to the experimental section and describes proposed solutions used by the authors. A result statement should perhaps answer three questions: what unmet need the study addresses; what key methodology has been used to address the said unmet need, and what the specific novelty is.

Identifying key findings is important to judge whether the specific focus and area of the reported study are relevant to my work or interests to decide on turn whether the paper is worth further reading/consideration. If the findings are in fact of potential interest to me and I will proceed to further reading, I need to a have a clear understanding of the result statements, so that I could critically evaluate the author's claims to see if they are well supported by described experimental methodology (for theoretical scope, that would be probably theoretical or computational methodology) and data acquisition, processing, and interpretation methodology.

LLMs are good at summarizing, and tested reasoning models (primarily ChatGPT Plus o1 and Google Gemini Advanced 2.5 Pro) reliably identified the main result (the most important contribution of outcome) even without any scope hints. The was some variation, however, with key findings (subsidiary discoveries or novel outcomes), as the models would sometimes retrieve experimental information from the experimental section, so instruction limiting the scope to "framing" sections only improved stability of extracted key findings.

It should be helpful to illustrate abstract concepts with concrete examples, so let us consider the test paper \[[1](#bookmark=id.7da56ld7hdii)\]. The main result claimed by the authors is an inexpensive and accessible protocol for preparation of highly enriched 17O water. Enriched H217O is of interest to biochemical research. It is available commercially, but its high price severely hinders its use. An inexpensive source could make its potential applications much more accessible, hence the unmet need in highly enriched H217O. The authors also indicate that they used a combination of slow evaporation and fractional distillation as the key methods to achieve the main result. The novelty component, on the other hand, is not identified.

Defining classification of the main claimed result ([Section IV.B.1](#bookmark=id.azlx012fyxhs)) helps model determine, in this case, that neither enriched water, which is commercially available nor employed techniques are novel. These conclusions are important for the *A Priori* Plausibility Check ([Section IV.D.2.5](#bookmark=id.bxukq7k16p3)) discussed later.

**Analysis of Experimental Methodology**

When I read the test paper, I quickly realized that the claimed result was nonsensical, but how? 

While each experiment stage/technique/procedure should be critically evaluated, typically the natural priority would be to start with the main result and key findings, one thing at a time starting from the main finding \= main claimed result. 

I read this paper \[[1](#bookmark=id.7da56ld7hdii)\] when I was in grad school, and the main result indicated in the title grabbed my attention right away, as it was relevant to my research. But it also sounded too good to be true. I kept reading it and quickly realized that my "too good to be true" hunch was correct. Over there last year or so I made a few attempts to have LLMs review this paper using a direct basic prompt with early results not being particularly promising. In retrospect, the limitations I observed make certain sense. As the term "generative pre-trained transformers" suggests, modern LLMs transform input texts based on world knowledge that comes from their pre-training datasets and any subsequent fine-tuning, such as instruction following. LLMs excel at basic concrete text operations, such as summarizing. This operation is concrete in the logical sense as the input is taken at its face value by default, unless specific training data, subsequent fine-tuning or hidden system instructions affect this process. While leading general purpose LLMs may interpret the request to review an academic text somewhat differently from a request to summarize it, the typical output suggests that the performed process is closer to a generic text review. Additionally, whether due to intentional efforts of developers or being an emergent ability (or a combination), leading models in a sense understand the limits of their training and use in-context information derived from user inputs and previous outputs within the current context (and also possibly from contents of the permanent memory developed based on prior sessions) alongside their world knowledge to compensate for gaps in their training. Even when there is an immediate contradiction between the model's world knowledge and in-context information, the model may not necessarily call on it. Anything less obvious is likely beyond the basic analysis, partly because a review request needs to be interpreted conceptually differently from a basic, largely linguistic analysis.

A critical analysis is an abstraction over, say, summarization. While summarization operations do not question the truth of the input text and are compatible with input text going into the model's context as is, amending/adapting model's world knowledge, for critical analysis this behavior is unacceptable. How could the model perform in-depth semantic analysis of the text, if the text to be examined is added to the model's context first, becoming part of model's understanding of the truth? The input text must be treated separately from any other model's knowledge sources, and this abstraction adds on complexity. Frontier LLMs have repeatedly demonstrated ability to perform complex abstract operations, but they need to be trained to perform such operations or, if training is lacking, guided using advanced prompting techniques.

I set out to develop a prompt to guide an LLM through the manuscript analysis process. The approach I decided to use was to try to trace my own reasoning and analysis flow of this test paper retrospectively, reflect on my reasoning processes, surface relevant knowledge and concepts from my background, which I used subconsciously as the basis of my analysis, articulate my intuition as much as possible, forming some kind of analysis workflow that would act as a decomposition of the desired review process and could guide the LLM analysis. I also hoped to generalize individual analysis steps in a fashion that would enable analysis of a whole group of papers. Coming from experimental physical chemistry, I set an ambitious goal of targeting experimental chemistry papers.

After the title had grabbed my attention, I wanted to learn the core the experimental steps used by the authors to implement the main result. And the first sentence of the abstract clearly indicated that a combination of "slow evaporation and fractional distillation" was used for this purpose (the expected place for a direct statement of the main result). The abstract continued describing procedures used for quantitative characterization of the main result and further research, but I wanted to focus solely on the preparation steps. I was highly skeptical about the paper's premise and wanted to quickly assess first whether the core experimental methodology was sound. Thanks to my background, I quickly made judgment that it was not, but back then I did not have to verbalize the reasoning process that lead to this conclusion and was mostly subconscious. To guide an LLM, I need to come up with specific instructions to reproduce my thinking. Perhaps a somewhat more intuitive task would be to think of what specific arguments and reasoning I would want to see in a solution, if analysis of just the core the experimental steps in this paper is given as a problem to a student taking an advanced, say qualifying, examination.

I realized that I dismissed the claimed results as dubious by contrasting them with my knowledge of the complexity of the target task (isotopic enrichment) and the profoundly insufficient capabilities of the described apparatus for such a task. To remove intuition and unidentified knowledge from the equation, making this analysis clear, objective, and validatable, one would need to perform a suitable theoretical modeling of the core processes in accordance with described experimental methodology and compare the calculated estimations with claimed results. More specific steps include:

1\) Identification and extraction of key experimental characteristics to be verified (for example, claimed H217O enrichment at each step)
2\) Identification of the key processes and equipment used for each of the two identified core experimental steps (such as, evaporation and fractional distillation).
3\) Selection of suitable process models and associated governing equations.
4\) Identification and extraction of key parameters from manuscript text necessary for performing calculations (for example, fractional column length, starting amounts of materials, etc.).
5\) Handling of missing critical information, specific to the described experimental setup, necessary for performing theoretical calculations (for example, fractional column length).
6\) Pulling missing necessary parameters not specific to described setup from appropriate external sources (for example, separation coefficient of H216O/H217O).
7\) Perform actual calculation and compare estimations with claimed results.

**Handling Missing Information**

The test manuscript lacks key parameters necessary for performing theoretical calculations. In particular there are basically no parameters specified for the improvised fractionation column used. When I performed calculations initially, I simply used a typical value for a number of theoretical plates for a lab column. This is a completely valid approach. When Google released Gemini Advanced 2.5 Pro with multimodal capabilities, I decided to try to have Gemini analyze the photograph of the experimental apparatus found in SI Fig 1\. The photograph dos not appear to be particularly distorted, so I wanted to have Gemini gauge the scale by identifying something in the photograph that is also mentioned in text along with some kind of size characteristic that can be used to transfer this information to linear item size and use it as scale in the photograph to gauge the length of the fractional column. I also wanted Gemini to analyze information that is available and see if it could find any information at all that could be used for estimation of theoretical plate height.

**Too Good to Be True**

As I mentioned, I thought that the main claimed result in the test paper was too good to be true (the first sentence of the abstract). Would it be possible to have a recipe for LLM that could be used to raise a similar question? After a reflecting on why had this attitude right from the beginning, I figured that

1\) The main claimed result is potentially disruptive as it positioned as a cheap source of material available commercially at much higher price (potential disruption of market niche) and has promising research applications, if the price is dropped (potential disruption of a research field).
2\) The core experimental methodology relies on conventional well-established, well-understood, and widely-used processes (evaporation and fractional distillation).
3\) The experimental setup uses mostly conventional setup with poor customization choices (no novel equipment).
4\) Description of the experimental setup does not identify a single non-trivial (or even trivial for that matter) novelty used by the authors to achieve claimed result.
5\) Based on undergraduate-level physical chemistry knowledge, the task of substantial separation of isotopes is difficult, if not completely impossible, to perform in a research lab, not to mention in an academic lab by a graduate student.
6\) The authors made no attempt to back their claimed results by theoretical estimations based on established knowledge that would demonstrate the feasibility of the claimed result.

Points 1\) and 2\) imply that their should be a sizable pool of highly qualified experts within academia and industry who would be eager and capable to grab what appears to be a very low hanging fruit (the setup should be trivial for a qualified expert according to points 3\) and 4). Based on field knowledge and points 3\) \- 5), the described experimental setup even before performing any estimations is likely grossly inadequate for achieving the claimed result. Lack of any attempt on the authors' part to justify a highly suspicious (based on straightforward arguments in points 1\) \- 5)) claimed results is a likely indication of their gross incompetence.

**Knowledge Codification Strategies**

The primary goal of scholarly manuscript analysis should probably be identification of flaws/issues, such as

* Explicit statements and implicit premises / assumptions that contradict established knowledge or should be labeled as highly questionable and be subjected to special scrutiny.
* Missing key methodological details essential for validation of the described methodology (experimental details, data processing, etc.) or its independent reproduction using solely information provided in the manuscript. Supporting information may also be considered, but with caution, in a sense that the key details should generally be placed in the manuscript, possibly as appendixes, if appropriate, rather than moved to supporting information.
* Poor methodological practices (e.g., unjustified use of oversimplified or custom equipment; using experimental implementations that are known or likely to be suboptimal, when established solutions should be readily accessible; using inappropriate equipment, materials, protocols, techniques, procedures, data acquisition / processing practices).

Find 

* Analyze text / problem / etc. (may involve well-articulated strategies, but also intuition and tacit knowledge)
* Identify flaws / weaknesses / questionable aspects / contradictions with established knowledge / accepted practices / logical fallacies (may involve well-articulated strategies, but also intuition and tacit knowledge)
* Reflect on intuitive reactions:
* Articulate reaction as a statement.
* Ask *why* questions and/or try elaborate to expose your own implicit premises/arguments
* Formulate flaw as a statement
* Formulate *what* and *why* a questions
* Generalize questions