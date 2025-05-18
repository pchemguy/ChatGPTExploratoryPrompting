
# **LLM Context Conditioning for Multimodal Validation of Chemical Formulas**

## **Abstract**

## 1. **Introduction**

Large Language Models (LLMs) are increasingly explored for complex analytical tasks within scientific domains. A recent preprint [1] proposed Persistent Workflow Prompting (PWP) as a prompt engineering methodology intended to guide LLMs through intricate, multi-step analyses using standard chat interfaces. That work also explored the use of LLM context conditioning within a PWP-based proof-of-concept prompt, the _PeerReviewPrompt_. This prompt focused on an ill-defined analytical object (the "core methodology") within a relatively localized scope (e.g., abstract, introduction, experimental, and conclusions sections typical of scholarly experimental manuscripts). The LLM context conditioning component within _PeerReviewPrompt_ aimed to instill a critical analytical mindset and mitigate input bias through embedded instructions during the evaluation of a single, deliberately chosen test paper [1, 2]. Observations in that initial study suggested effective suppression of input bias across several tested LLM models.

The present proof-of-concept study builds upon the PWP framework and further investigates the application of LLM context conditioning principles. Here, we address a distinct validation challenge: the identification of errors in chemical formulas within scientific manuscripts, including incorrect formulas in raster images (requiring multimodal analysis encompassing both textual and visual information). This task presents a contrasting scenario: the analytical object (a chemical formula) is comparatively well-defined, yet the scope of analysis must span the entire manuscript, posing a "needle in a haystack" problem for detecting subtle errors. Furthermore, our initial explorations indicated a potentially problematic LLM behavior: an inherent tendency towards error correction, which can lead them to overlook or silently "correct" the very inaccuracies targeted for detection.

This work is exploratory, based on observational assessment using a single test case [2]—the same paper used in [1]—known to contain specific textual and image-based chemical formula errors. The primary objectives were: (i) to conduct an initial evaluation of several prompting strategies (from simple direct prompts to more elaborate PWP-based approaches incorporating task decomposition [3, 4] and self-reflection [5–7]) using generally available frontier reasoning models (Gemini 2.5 Pro and ChatGPT Plus o3 via chat interfaces); (ii) to perform an initial qualitative assessment of these models' multimodal analysis capabilities for this domain-specific task; (iii) to gauge whether basic prompting strategies showed sufficient promise to warrant further investigation, recognizing that poor performance on a challenging, yet relatively circumscribed, test case could be a negative indicator; (iv) to identify a prompt design that could work reliably for this specific test case, rather than achieving optimized prompt text; and (v) to identify potential LLM behavioral issues, such as error suppression, and test potential solutions, again within the confines of this single test case. The PWP-based _ChemicalFormulasValidationPrompt_ developed herein, particularly its new task-specific core section, should be considered relatively unrefined.

This paper details these exploratory approaches and reports on their observed performance. We analyze LLM behaviors—such as apparent error suppression, inconsistent effort ("laziness"), and hallucinations—and discuss how targeted context conditioning appeared to affect the reliability of chemical formula identification in our test case. Notably, observations with Gemini 2.5 Pro suggested the feasibility of multimodal error identification under these conditions, an outcome not observed with ChatGPT Plus o3 in the same test. Ultimately, this study aims to highlight the potential role of context conditioning in adapting LLMs for precise validation tasks in complex scientific documents, while clearly acknowledging its preliminary nature.
## 2. **Methodology**

This study uses the same test publication [2] as in our prior work [1], known to contain demonstrable methodological flaws. The [test paper] file (also available via a link in [Supporting Information](#bookmark=id.ppi0ys93i7h)) constitutes a combination of the main text and supporting information files (as available via paper's DOI [2]) totaling 44 pages. The same test paper presented a pertinent and, as it turned out, challenging test case for this task due to known, subtle errors in chemical formulas.

Specifically, page S-8 of the test paper's SI presents the formula for *ferrous ammonium sulfate* as Fe(NH4)2SO4, which incorrectly omits one sulfate group (the correct formula for ferrous ammonium sulfate, Mohr's salt, is (NH4)2Fe(SO4)2•6H2O or (NH4)2Fe(SO4)2 - anhydrous). The second known error is the formula for *hexamethyldisiloxane* shown on page 235 as spectral label in Figure 2(c), second from the bottom: (CH3)3Si2O (the correct formula is ((CH3)3Si)2O or (CH3)6Si2O).

While the first error is in text-based formula, the second error is in a raster image making this paper also suitable for initial tests of multimodal analysis. Considering, that the *test paper* contains 44 pages, this test case also presents a chemical "needle in a haystack" challenge.

All employed prompting techniques rely solely on standard prompt, requiring no API access, modification to the underlying models, or special tools. Further, all techniques employed target generally available models; specifically, Gemini Advanced 2.5 Pro and ChatGPT Plus o3 have been used in this study and accessed via the official chat bots (Gemini was also accessed via Google AI Studio). This deliberate restriction was adopted to maximize reproducibility of presented result. With these two models, we employed several prompting strategies, starting from basic direct prompts.

Our methodology involved (i) selecting a challenging test case with known errors, (ii) defining the specific errors to be targeted, (iii) systematically developing and testing a series of increasingly sophisticated prompting strategies with two leading LLMs, and (iv) analyzing the LLMs' behavior and performance, particularly focusing on the impact of context conditioning.

1. **Basic direct prompt**

The naive approach asks LLM directly to find errors. This prompt specifically mentions names, as names should generally be used to resolve formula errors.

`Find mistakes in chemical formulas and names.`

2. **Decomposed prompt: extracted formula vs. extracted name**

Because in chemistry communications, the general practice is that most formulas (except, perhaps, for the most basic ones) should have accompanying chemical names, I decided to ask the model to extract chemical names for each extracted formula and attempt to identify problem by comparing (implicitly) the formulas with extracted names.

```
Execute the following task step-by-step:  
1. Extract each and every chemical formula from the attached PDF.  
2. For each extracted formula, extract every directly associated chemical name included in the text, if any.  
3. For each extracted formula and associated names, consider if the chemical formula and associated names are correct and flag every formula/names combination that contains any errors.  
4. For each flagged item, read the source PDF again and confirm that the item was extracted exactly. In case of any extraction errors, analyze the corrected item and consider if the flag should be removed.  
5. Create a Markdown table that should include every flagged formula/names, clear description of any problems, corrected version, and clear reference location of the flagged items.
```

Here Step 4 attempts to elicit self-reflection to reduce errors and observed hallucinations.

3. **Decomposed prompt: extracted formula vs. generated formula**

This prompt uses a different error detection workflow. Instead of comparing extracted formulas and names, it asks LLM to generate names from extracted formulas. The idea here is that for minor errors, LLM might be able generate correct name from incorrect formulas. The Step 3 instructs LLM to generate a new formula from the previously generated name in the hope that this generated formula will be correct regardless of whether extracted formula is correct. Finally, extracted and generated formulas should be compared to identify potential errors.

```
Execute the following task step-by-step:  
1. Extract chemical formulas of each and every chemical species containing at least two elements EXACTLY as they appear in the attached PDF.  
2. For each extracted chemical formula generate associated name.  
3. Convert each generated name to generated chemical formula.  
4. For each generated chemical formula, determine if it matches previously extracted formula.
```

Here, the Step 1 attempts to reduce noise by filtering formula-like strings containing single or no chemical elements.

4. **PWP-based prompt with LLM context conditioning**

Given the limitations of direct and simple generative approaches, a more robust strategy was adopted, leveraging the context conditioning principles outlined in \[1\]. The *PeerReviewPrompt* prompt detailed in that work aimed to mitigated input bias through comprehensive context setting, and initial observations suggested this approach was effective in the test case presented therein. [*ChemicalFormulasValidationPrompt*](#bookmark=id.tq5dg6ujmkjr) adapts core sections from the *PeerReviewPrompt*:

* Sections **I-III** (Core Objective, Persona, Context: Framework for Critical Review) were largely retained to establish the analytical mindset and operational guidelines.  
* Section **V** (Final Instructions for Interaction) was kept to ensure consistent LLM behavior.  
* Section **IV.A** (Foundational Principles & Workflow Application) was adapted.  
* A new **Chemical Identifier Analysis** subsection was introduced into Section **IV** specifically for formula and name validation, providing a dedicated workflow for this task. Key instructions include: meticulous full-document scanning (text and figures) for chemical identifiers, initial attempt to define criteria for what constitutes a relevant chemical formula to reduce noise, a draft of explicit error categorization for formulas and names, protocols for multimodal analysis of figures, and a requirement for structured output detailing original entities, identified problems, proposed corrections, and exact source locations.

Development of such advanced prompts for domain-specific (e.g., experimental chemistry) expert-level analysis necessitates formalization of specialized knowledge and research practices. For example, these reviews [#] might be a convenient starting point for subsequent development of demonstrated in this work proof-of-concept (PoC). However, this aspect is largely beyond the scope of the present work due to its methodology-oriented nature. Instead, we generally focus on more abstract framework development, which is an essential first step.

Due to more abstract and methodology-focused nature of present work, the demonstrated experimental chemistry PoC mostly remains rather abstract.

, such as an experimental chemistry PoC demonstrated in this work,
The other 

For the proof-of-concept `PeerReviewPrompt` detailed herein, **experimental chemistry** was chosen as the application domain. This field, like other mature scientific disciplines, has an established history concerning the engineering and formalization of its specific knowledge and research practices (e.g., M. P. StrNAD et al., _Acc. Chem. Res._ **2023**, _56_, 128–139). Such domain-specific context is particularly relevant considering the rapid expansion of AI applications within chemical research (e.g., J. ZHANG et al., _Chem. Commun._ **2024**, _60_, 6977). While the PWP methodology itself aims for a broadly applicable structure for critical review, its effective tailoring and application in any given area benefit from an awareness of existing domain-specific formalization efforts. For those interested in a deeper exploration of AI in chemistry or in future adaptations of PWP to this specific science, the cited reviews offer valuable insights.