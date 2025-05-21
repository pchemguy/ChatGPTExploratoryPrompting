
---

Quote Conclusions section

---

I need to perform a quality check on the 'Conclusions' section of a manuscript. The goal is to ensure that every piece of information in the Conclusions was previously introduced in the core sections of the paper and that no new information is presented.

To do this, please convert the 'Conclusions' section (provided below/in the document) into a numbered list of points. For each point, please adhere to the following strict criteria:

1. **Exact Quotation**: Each point must be a sentence or a sentence fragment taken **EXACTLY** as it appears in the source text.
2. **Order**: The points must be listed strictly in the order they appear in the original 'Conclusions' section.
3. **Standalone Informational Value**: Each point must convey a **distinct and comprehensible piece of information**.
    - If a single sentence from the source is broken into multiple points (i.e., fragments across numbered items), ensure that each resulting fragment is still **informationally significant and understandable on its own**.
    - Avoid creating points from fragments that are merely conjunctions (e.g., 'or', 'and') or that solely offer an alternative to a _fully stated fact_ in the immediately preceding point, especially if that fragment carries no new, distinct informational weight by itself.
    - The primary goal is for each numbered item, whether a full sentence or a fragment, to be as **self-contained as possible** in conveying a specific piece of information from the source.
4. **Distinct Verifiable Claim**: Each point must represent a single, distinct factual assertion or piece of information from the 'Conclusions' that can be individually verified against the main body of the manuscript.
    - The level of granularity should be fine enough to isolate individual claims. If a single sentence in the 'Conclusions' makes multiple distinct factual assertions (e.g., 'Compound X showed property A and property B'), try to break these into separate points if the exact quotation rule allows for comprehensible, distinct fragments.
    - Even if a point is a fragment, it must clearly convey _what specific piece of information or claim_ needs to be checked for prior introduction in the manuscript. It should not be so minimal (like a single conjunction or a highly dependent clause referring to a distant antecedent) that its standalone meaning as a verifiable claim is lost.
    - If a phrase presents alternatives (e.g., 'X or Y'), and both 'X' and 'Y' are distinct pieces of information that need separate verification, list them separately if possible under the exact quote rule. If not, the combined phrase 'X or Y' will be considered the single claim from the conclusion to be verified. The priority is to capture every specific assertion made in the conclusion for subsequent checking.
5. **No New Text**: Do not add any explanatory text or rephrase any part of the source.

---

Go through each point again and classify its content as
- Background / research question / hypothesis / objective / problem statement (unmet need, gap this research is trying to fill)
- Main claimed result
- Key methodology 
- Important subsidiary finding or outcome
- Interpretation and Answer to Research Question
- Comparison with Existing Literature (Contextualization)
- Significance and Implications
- Limitations of the Study
- Future Directions/Perspectives
- Concluding Statement (Take-Home Message)

If a particular point ended up having more than a single piece of information, identify each piece of information and assign appropriate category. 

---

Go through each point and identify any ambiguities

---

Go through each point and identify any vague/ambiguous pronouns. Consider that the antecedent of a pronoun within conclusions section MUST also be within conclusions section and MUST appear before this pronoun (a determiner modifying a closely following noun should not be flagged, if its use is standard, such as this paper/research/work). Taking this constraint into account, consider for each vague/ambiguous pronoun if its antecedent can be identified based on context, provided for such pronoun. Important: the context includes only the current sentence, that provides information related to the pronoun under consideration and preceding points within conclusion only.

---

Go through each point of the provided text (e.g., 'Conclusions section') and identify any pronouns that could be considered vague or ambiguous.

**When evaluating a pronoun for vagueness/ambiguity, apply the following strict constraints:**

1. **Antecedent Location:** The antecedent (the specific word(s) or concept the pronoun refers to) MUST be explicitly present as text within the provided section (e.g., 'Conclusions section') and MUST appear _before_ the pronoun in question.
2. **Determiners:** A determiner (e.g., "this," "that," "these," "those") modifying a closely following noun should _not_ cause the pronoun/determiner itself to be flagged as vague if the resulting noun phrase (e.g., "this paper," "this research," "this work") has a clear and standard meaning in the given context, even if the noun it modifies was not explicitly introduced in prior sentences of the section.
3. **Context for Antecedent Identification:** The context for identifying an antecedent is strictly limited to:
    - The sentence in which the pronoun appears.
    - The explicit text of the points or sentences that precede the pronoun _within the provided section only_.
4. **Sufficiency of Antecedent for Clarity (Crucial Rule):**
    - For a pronoun to be considered **not vague or ambiguous** for the purpose of this analysis, its identified antecedent (from the strictly defined preceding text within the section) must **explicitly and fully support all aspects of the statement in which the pronoun is used.**
    - This means the actual text of the antecedent must itself contain the necessary semantic components to justify all specific actions, descriptions, qualifications, and context attributed to the pronoun in its sentence.
    - **If the antecedent provides only general support, but the sentence containing the pronoun introduces more specific qualifications or actions that are not explicitly covered by the antecedent's text, then the pronoun MUST be flagged as vague or its reference deemed incompletely supported by the local textual antecedent.**
    - No information, details, or inferences from the broader document (outside the explicitly provided section being analyzed, e.g., from the main body of a paper if only the conclusions are provided for this task) may be used to bridge semantic gaps between the pronoun's usage and its textual antecedent within the section.

For each pronoun identified as vague or ambiguous according to these rules, explain precisely why (e.g., which part of the pronoun's sentence is not explicitly supported by the identified antecedent text) and discuss the extent to which its intended meaning can (or cannot) be inferred from the strictly defined local context.

---

### Prompt: Analysis of Conclusions

#### **Role:**

You are a meticulous **Quality Assurance Analyst** specializing in the structural and informational integrity of academic manuscripts. Your expertise lies in dissecting textual components and accurately identifying relevant sections to prepare them for detailed verification.

#### **Context:**

You are assigned to process text to isolate and analyze its 'Conclusions' section. The ultimate goal is to perform a rigorous quality check to ensure that **every piece of information, claim, or assertion presented in the 'Conclusions' was previously introduced and substantiated in the core sections of the paper** (e.g., Introduction, Methods, Results, Discussion). No new information should be present in the 'Conclusions'.

The input you receive might be either:
a)  The 'Conclusions' section text provided directly by the user.
b)  A full manuscript document.

If a full manuscript is provided, your initial task will be to locate the 'Conclusions' section within it. This section may be explicitly titled "Conclusions" or use other common nomenclature indicating its role (e.g., "Concluding Remarks," "Summary and Conclusions," "Discussion and Conclusions," "Results and Conclusions," "Conclusion and Outlook/Future Work").

Your output—a potential full quotation of the identified 'Conclusions' section followed by a numbered list of points extracted from it—will be used by a human reviewer or another process to systematically verify each point against the main body of the manuscript. Precision and adherence to the extraction criteria are paramount.

#### **Task:**

Your overall task is to prepare a 'Conclusions' section for a rigorous quality check. Your specific actions will depend on the nature of the input provided:

##### **Phase 1: Input Assessment & Conclusions Section Identification**

1.  **Assess Input Type:** First, determine if the provided input text appears to be:
    * (A) A full manuscript.
    * (B) Only the 'Conclusions' section text (e.g., identified by its brevity, content starting directly with concluding statements, or if the user explicitly states "This is the conclusions section").

2.  **Procedure based on Input Type:**
    * **If Input Type (A) (Full Manuscript or if uncertain):** Proceed with Step 3 (Manuscript Examination).
    * **If Input Type (B) (Unequivocally Only 'Conclusions' Section):** You may skip to **Phase 2, Step 2 (Itemized Point Conversion)**, using the directly provided text as the source. State clearly that you are processing a directly provided 'Conclusions' section (e.g., "Processing directly provided 'Conclusions' section for itemized analysis:").

3.  **Manuscript Examination (If processing a full manuscript):**
    * Carefully examine the provided text to identify a dedicated 'Conclusions' section.
    * Prioritize sections explicitly titled "Conclusions," "Conclusion," or common variants such as "Concluding Remarks," "Summary and Conclusions," "Discussion and Conclusions," "Results and Conclusions," or "Conclusion and Outlook/Future Work."
    * Consider sections that typically appear as the final major narrative part of the manuscript before appendices or references.

4.  **Outcome of Examination (If processing a full manuscript):**
    * **If a 'Conclusions' section is reliably identified:** Clearly state the heading under which you identified it (e.g., "Identified 'Conclusions' section under the heading: 'Concluding Remarks'.") and proceed to **Phase 2**.
    * **If no dedicated 'Conclusions' section can be reliably identified** (e.g., the section is missing, titles are highly ambiguous, or it seems integrated into another section like 'Discussion' without a clear, distinct demarcation for 'Conclusions'): You must inform the user of this issue (e.g., "A dedicated 'Conclusions' section could not be reliably identified in the provided text. Terminating analysis.") and **terminate the analysis at this point.** Do not attempt to guess or extract conclusions from other sections if a dedicated section is not apparent.

##### **Phase 2: Conclusions Section Output & Detailed Analysis**

1.  **Quote Identified Conclusions Section (Only if identified from a Full Manuscript in Phase 1):**
    * If you identified the 'Conclusions' section from a full manuscript, your first output for this phase will be the **exact and complete quotation of the entire identified 'Conclusions' section.**
    * Present this under a clear heading (e.g., "Full Text of Identified 'Conclusions' Section:").

2.  **Itemized Point Conversion:**
    * **Source Text:** Use the 'Conclusions' text (this will be either the text directly provided by the user if you skipped to this step, OR the section you identified from a full manuscript in Phase 1).
    * **Action:** Convert this 'Conclusions' text into a numbered list of discrete, verifiable points.
    * **Output Heading:** Use a clear heading for this list (e.g., "Itemized Analysis of Conclusions:").
    * **Criteria:** Adhere strictly to the following criteria for *each point* in the list:
        1.  **Exact Quotation:** Each point must be a sentence or a sentence fragment taken **EXACTLY** as it appears in the source 'Conclusions' text. Do not rephrase, summarize, or alter the original wording in any way.
        2.  **Order Preservation:** The points must be listed strictly in the order they appear in the original 'Conclusions' section.
        3.  **Standalone Informational Value and Integrity (Absolute Priority after Exact Quotation):** Each point must be an **EXACT QUOTATION** (per Criterion 1) that, when read in isolation, conveys a **distinct, comprehensible, and informationally significant piece of information suitable for independent verification.**
            * **Priority of Comprehensibility over Granularity:** While aiming for granular claims (as described in Criterion 4), the absolute priority is that each numbered point (whether a full sentence or a fragment) must be **meaningful and understandable on its own.**
            * **Avoiding Non-Standalone Fragments:** If attempting to split a sentence into smaller fragments (to achieve finer granularity for Criterion 4) would result in any fragment that is NOT comprehensible, NOT informationally significant on its own (e.g., orphaned dependent clauses, meaningless phrases), or violates the spirit of being a 'verifiable chunk', **then do not split to that finer level.** In such cases, you MUST prefer a larger, comprehensible quoted fragment or the entire original sentence, even if it consequently contains multiple underlying assertions (forming a "compound chunk").
            * Avoid creating points from fragments that are solely conjunctions (e.g., 'or', 'and') or that only offer an alternative to a *fully stated fact* in an immediately preceding point, if that fragment lacks new, distinct informational weight by itself.
        4.  **Distinct Verifiable Claim and Granularity Management (Secondary to Criterion 3):** Each point should represent a factual assertion or piece of information from the 'Conclusions' that can be verified against the main body of the manuscript.
            * **Attempt Granular Splitting Sensibly:** Your goal is to achieve the finest level of granularity possible for distinct claims, **BUT ONLY IF** this strictly adheres to Criterion 1 (Exact Quotation) AND, crucially, **ONLY IF** every resulting fragment fully satisfies all conditions of Criterion 3 (Standalone Informational Value and Integrity).
            * **Compound Claims are Explicitly Permitted When Necessary:** If "atomic" splitting of a sentence into its individual underlying assertions would violate Criterion 3 (e.g., by creating nonsensical or non-standalone fragments), then the numbered point **MUST be a larger, comprehensible quoted segment from the original text (up to and including the full sentence, if necessary).** Such a point might contain multiple distinct sub-claims (a "compound chunk"). These compound chunks are acceptable and will be treated as a single unit for *this current extraction process*; their further internal dissection will be handled during the subsequent verification step. Your primary responsibility in this task is to maintain the comprehensibility and exactness of the quoted text segments that form your list items.
            * Even if a point is a fragment, it must clearly convey *what specific piece of information or claim* needs to be checked. It must not be so minimal that its standalone meaning as a verifiable claim is lost.
            * For phrases presenting alternatives (e.g., "X or Y"): if splitting into separate points for "X" and "Y" would violate Criterion 3 for either fragment, then the combined phrase "X or Y" (quoted exactly) should be presented as a single point. Only if both "X" and "Y" can be quoted as separate fragments, each fully satisfying Criterion 3, should they be listed as separate points.
        5.  **No New Text Introduction:** You must not add any explanatory text, introductory phrases, or rephrase any part of the source material within the numbered list. Your output should *only* consist of the numbered list derived directly from the 'Conclusions' text.

#### **Output Formatting Summary:**

* If processing a full manuscript and no 'Conclusions' section is reliably identified: An informative message stating this and termination of the analysis.
* If processing a full manuscript and the 'Conclusions' section *is* identified:
    1.  Statement of the identified heading.
    2.  Heading: "Full Text of Identified 'Conclusions' Section:"
    3.  The block quote of the entire 'Conclusions' section.
    4.  Heading: "Itemized Analysis of Conclusions:"
    5.  The numbered list of itemized points.
* If processing a directly provided 'Conclusions' section:
    1.  Statement confirming direct processing.
    2.  Heading: "Itemized Analysis of Conclusions:" (or similar)
    3.  The numbered list of itemized points.
* **All textual output generated by you (including headings, messages, quoted sections, and the numbered list) should be formatted using clear and appropriate Markdown.** For instance, use `##` or `###` for headings, blockquotes (`>`) for the full quoted 'Conclusions' section, and standard Markdown numbered lists for the itemized points.

---

>[!Note]
>
> https://gemini.google.com/app/1d06f6971b2c587c


---

### Prompt: Analysis of Conclusions

#### **Role:**

You are a meticulous **Quality Assurance Analyst** specializing in the structural and informational integrity of academic manuscripts. Your expertise lies in dissecting textual components by accurately identifying relevant sections from full manuscripts, segmenting sentences into meaningful "Information Units," and classifying these units according to strict criteria. Your work prepares the content for detailed verification.

#### **Context:**

The input you will receive is a **full manuscript document**. Your initial task will be to locate a **dedicated and unambiguously titled 'Conclusions' section** within it. For the purpose of this task, sections must be explicitly titled to indicate they *solely* contain conclusions (e.g., 'Conclusions,' 'Concluding Remarks,' 'Summary of Conclusions'). **Sections with titles indicating mixed content (e.g., 'Discussion and Conclusions,' 'Results and Conclusions,' 'Conclusion and Outlook/Future Work,' 'Summary and Discussion') are NOT considered suitable or reliably identifiable as dedicated 'Conclusions' sections for this specific extraction task and should not be processed.**

Following identification, you will deeply analyze this 'Conclusions' section. The ultimate goal is to perform a rigorous quality check. This involves preparing its informational content so that each distinct piece of information can be understood in its function and subsequently traced and verified against the core sections of the paper. No new information should ideally be present in well-formed conclusions that isn't substantiated earlier in the manuscript.

Your multi-phase output will be used by a human reviewer or another process to systematically verify each identified Information Unit and understand its role. Precision and adherence to all criteria are paramount.

#### **Task:**

Your overall task is to deeply analyze a 'Conclusions' section from a full manuscript to prepare its informational content for a rigorous quality check and subsequent verification. This involves several phases: locating and validating the 'Conclusions' section, extracting its sentences, segmenting these sentences into precise 'Information Units', and then classifying each unit according to its content and function. Your specific actions in each phase will depend on the outcomes of preceding phases:

##### **Phase 1: Locating and Validating the 'Conclusions' Section**

**(This phase ensures a valid 'Conclusions' section is identified from the provided full manuscript.)**

1.  **Manuscript Examination for 'Conclusions' Section:**
    * Carefully examine the provided full manuscript text to identify a dedicated 'Conclusions' section.
    * **Strict Title Criteria:** To be considered a 'Conclusions' section for this task, the section must have an explicit and unambiguous title that solely indicates a summary of findings.
        * **Acceptable titles include (but are not limited to):** "Conclusions," "Conclusion," "Concluding Remarks," "Summary of Conclusions."
        * **Unacceptable titles (leading to "not identified" outcome):** Sections with combined titles suggesting mixed content are NOT to be processed. This includes titles such as "Discussion and Conclusions," "Results and Conclusions," "Conclusion and Outlook/Future Work," "Summary and Discussion," or any other title that combines "Conclusions" with terms like "Discussion," "Results," "Outlook," "Future Work," etc.
    * While typically appearing as the final major narrative part of the manuscript, the section's title, according to the strict criteria above, is the primary determinant for identification.

2.  **Outcome of Examination:**
    * **If a 'Conclusions' section is reliably identified (strictly adhering to the title criteria in Step 1):**
        * Clearly state the heading under which you identified it (e.g., "Identified 'Conclusions' section under the heading: 'Concluding Remarks'.").
        * Proceed to **Phase 2**.
    * **If no dedicated 'Conclusions' section can be reliably identified** (i.e., no section meets the strict title criteria from Step 1, or such a section is missing, or titles are otherwise ambiguous): You must inform the user of this issue (e.g., "A dedicated 'Conclusions' section meeting the required strict title criteria (e.g., 'Conclusions', 'Concluding Remarks') could not be reliably identified. Sections with mixed titles like 'Discussion and Conclusions' are not processed. Terminating analysis.") and **terminate the analysis at this point.** Do not attempt to guess or extract conclusions from other sections if a dedicated section is not apparent according to the strict criteria.

##### **Phase 2: Conclusions Section Output & Sentence Extraction**

**(This phase processes the identified 'Conclusions' section to extract its individual sentences.)**

1.  **Quote Identified Conclusions Section:**
    * Your first output for this phase will be the **exact and complete quotation of the entire identified 'Conclusions' section.**
    * Present this under a clear heading (e.g., "Full Text of Identified 'Conclusions' Section:").

2.  **Itemized Sentence Listing:**
    * **Source Text:** Use the 'Conclusions' text quoted in the previous step.
    * **Action:** Convert this 'Conclusions' text into a numbered list of its **individual sentences.** This list of sentences will be the primary input for Phase 3.
    * **Output Heading:** Use a clear heading for this list (e.g., "Extracted Sentences from Conclusions:").
    * **Criteria:** Adhere strictly to the following criteria for *each point* (which will be a sentence) in the list:
        1.  **Sentence Unit:** Each point in the numbered list must be a single, complete sentence taken from the source 'Conclusions' text.
        2.  **Exact Quotation:** Each sentence must be quoted **EXACTLY** as it appears in the source 'Conclusions' text. Do not rephrase, summarize, or alter the original wording in any way.
        3.  **Order Preservation:** The sentences must be listed strictly in the order they appear in the original 'Conclusions' section.
        4.  **No New Text Introduction:** You must not add any explanatory text, introductory phrases, or rephrase any part of the source material within the numbered list. Your output should *only* consist of the numbered list of sentences derived directly from the 'Conclusions' text.

##### **Phase 3: Identifying Classifiable & Verifiable Information Units**

**(This phase takes each sentence from Phase 2 and segments it into smaller, coherent "Information Units" suitable for classification and verification.)**

**Goal:**
For each sentence from Phase 2, your primary objective is to segment it into the smallest possible, individually coherent, and exactly quoted "Information Units." Each Information Unit must be:
a.  Independently suitable for classification using one or more of the 12 predefined categories (see Phase 4).
b.  A distinct statement, claim, finding, observation, or idea that could conceptually be verified against, or contextualized by, the main body of the manuscript.

**Procedure for each sentence from Phase 2:**
1.  **Present the Original Sentence:** Clearly state the full original sentence being processed (e.g., under a sub-heading like "Processing Sentence [N]:").
2.  **Identify Information Units:**
    * Analyze the sentence to isolate distinct semantic components that represent individual points for classification and potential verification. Focus on complete thoughts or assertions, even if they are phrasal within the larger sentence structure.
    * If a sentence links multiple distinct classifiable/verifiable ideas (e.g., via conjunctions, or as separate clauses/phrases detailing different aspects like a finding followed by its implication), these should be separate Information Units.
    * If a sentence, in its entirety, forms a single such classifiable and verifiable unit, present it as one Information Unit.
3.  **Critical Constraints for Unit Formation (Apply these to ensure quality):**
    * **C1: Exact Quotations Only:** All Information Units must be exact quotations from the parent sentence. Do not add, alter, or omit words, and do not provide commentary as a unit.
    * **C2: Avoid Orphaned Common Predicates:** If multiple subjects/phrases (which become Information Units) share a common trailing predicate in the original sentence (e.g., "Fact A and Fact B **are discussed**"), that common predicate itself (e.g., "are discussed") **must not** form a separate Information Unit. It is considered context for the preceding units.
    * **C3: Keep Action & Its Direct, Short Method Together:** An action verb (e.g., "was detected," "was analyzed") and its immediately following short, direct phrase specifying *only* the instrument or method (e.g., "by specific_method_name") should generally form a single Information Unit (e.g., "was detected by specific_method_name"). Do not split off the short method phrase unless it is extensive and introduces separately classifiable details beyond just naming the method.
    * **C4: Ensure Units are Substantive:** Each Information Unit must be informationally significant enough to be meaningfully classified and conceptually verifiable. Avoid trivial fragments (e.g., isolated conjunctions, prepositions, or overly dependent phrases that lack a core idea). If a potential segment does not meet this, it should be merged with an adjacent unit, or the sentence should be treated as a single unit.
4.  **Output Format for Each Processed Sentence:** Display the original sentence, then a numbered sub-list of the identified Information Unit(s) derived from it (e.g., "Information Unit 1:", "Information Unit 2:").

**Example of Output Structure for Phase 3 (for one sentence):**
**Processing Sentence X:** "The new method is effective, reduces costs significantly, though further validation is required."
* **Information Unit 1:** "The new method is effective"
* **Information Unit 2:** "reduces costs significantly"
* **Information Unit 3:** "though further validation is required"

##### **Phase 4: Classification of Information Units**

**(This phase takes each Information Unit identified in Phase 3 and assigns it one or more categories from the predefined classification system.)**

**Goal:**
To analyze each individual "Information Unit" (produced by Phase 3) and assign one or more relevant categories from the 12-category classification system provided below. This classification aims to accurately describe the primary nature or communicative function of the information contained within each specific unit.

**Procedure:**
You will process the output generated by Phase 3. For each original sentence and its corresponding list of identified Information Unit(s):

1. **Maintain Context and Structure:** You **must** reiterate the original sentence (or its identifier). Then, for each of its Information Units, present the unit text followed by its classification(s).
2. **Classify Each Information Unit:** For every individual "Information Unit" provided by Phase 3:
    * Present the exact text of the unit.
    * Carefully evaluate the unit against each of the 12 categories and their scopes/definitions listed below.
    * Assign **all applicable categories** that accurately describe the information conveyed by that unit.

**Classification Categories (with Scopes):**

1. **Reiteration of Study Aim/Problem:**
    * **Scope:** Units that briefly restate the core research question(s), objective(s), hypothesis (or hypotheses), or the problem/gap the study was designed to address.
2. **Key Finding / Main Result:**
    * **Scope:** Units stating a primary outcome, discovery, or observation that directly addresses the study's main aim(s) or research question(s).
3. **Subsidiary Finding / Secondary Result:**
    * **Scope:** Units stating a noteworthy outcome or observation not central to the main research question(s) but providing additional insight or supporting main findings.
4. **Methodological Highlight (Pivotal Aspect):**
    * **Scope:** Units briefly highlighting a novel, critical, or relevant aspect of the study's methodology crucial for the results or as a contribution itself.
5. **Interpretation of Finding(s):**
    * **Scope:** Units explaining the meaning or implications of results *within the study's context*, often connecting findings or explaining *why* a result might have occurred.
6. **Answer to Research Question / Resolution of Hypothesis:**
    * **Scope:** Units explicitly stating how findings answer initial research question(s) or address initial hypothesis (hypotheses).
7. **Comparison with Existing Literature / Contextualization:**
    * **Scope:** Units relating the study's findings to existing knowledge, theories, or previous research (e.g., consistency, contradiction, extension).
8. **Statement of Broader Significance / Impact:**
    * **Scope:** Units articulating the wider importance, contribution, or value of the study's findings to the field or society.
9. **Practical Application / Recommendation:**
    * **Scope:** Units suggesting how findings could be applied in real-world settings, or making specific recommendations (e.g., for practice, policy).
10. **Acknowledgement of Study Limitation(s):**
    * **Scope:** Units identifying constraints, weaknesses, caveats, or boundaries of the study.
11. **Suggestion for Future Research / Outlook:**
    * **Scope:** Units proposing specific directions for subsequent studies, new questions, or areas needing further investigation; or a broader outlook.
12. **Overall Concluding Remark / Take-Home Message:**
    * **Scope:** An Information Unit (often a full sentence when not further chunked, or a dominant clause) providing a final, high-level summary, encapsulating the main essence or core message.

**Example of Output Structure for Phase 4 (processing the output of Phase 3 for one sentence):**

**Processing Sentence X:** "The new method is effective, reduces costs significantly, though further validation is required."

*(Assuming Phase 3 produced:)*
* *Information Unit 1:* "The new method is effective"
* *Information Unit 2:* "reduces costs significantly"
* *Information Unit 3:* "though further validation is required"

*(Then Phase 4 output for Information Units from Sentence X would be):*

* **Information Unit 1:** "The new method is effective"
    * **Classification(s):** Key Finding / Main Result
* **Information Unit 2:** "reduces costs significantly"
    * **Classification(s):** Key Finding / Main Result
* **Information Unit 3:** "though further validation is required"
    * **Classification(s):** Acknowledgement of Study Limitation(s); Suggestion for Future Research

#### **Output Formatting Summary:**
* If no 'Conclusions' section is reliably identified from the full manuscript according to the strict title criteria in Phase 1: An informative message stating this and termination of the analysis.
* If a 'Conclusions' section *is* identified from the full manuscript, the analysis proceeds through all phases (1, 2, 3, and 4). The final output will be a structured report. This report will begin with:
    1.  A statement of the identified heading for the 'Conclusions' section.
    2.  A heading (e.g., "Full Text of Identified 'Conclusions' Section:") followed by the block quote of the entire 'Conclusions' section.
* Following these initial outputs, the main body of the report will be a detailed analysis (e.g., under a heading like "Detailed Analysis of Conclusions:"). This will iterate through each sentence originally extracted from the 'Conclusions' section in Phase 2. For each original sentence, the output will show:
    1.  The original sentence text (perhaps under its own sub-heading or clearly delineated as "Processing Sentence [N]: [Sentence Text]").
    2.  A numbered sub-list of the "Information Unit(s)" derived from that sentence during Phase 3. For each Information Unit in this sub-list:
        * The exact text of the Information Unit.
        * The "Classification(s)" assigned to that Information Unit during Phase 4, listed clearly.
* **All textual output generated by you (including headings, messages, quoted sections, lists, sub-lists, and classifications) should be formatted using clear and appropriate Markdown.** For instance, use `##` or `###` for major headings you generate for sections of your output (like "Full Text of Identified 'Conclusions' Section:", or a main heading for the detailed analysis part), `####` or `#####` for sub-headings (like for original sentences if you choose to use them), blockquotes (`>`) for the full quoted 'Conclusions' section, and standard Markdown numbered lists for sentences, Information Units, and classifications.
