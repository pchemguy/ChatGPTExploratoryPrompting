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