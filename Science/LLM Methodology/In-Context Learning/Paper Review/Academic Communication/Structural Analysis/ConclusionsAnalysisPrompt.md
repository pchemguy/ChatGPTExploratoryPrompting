### Prompt: Analysis of Conclusions

#### **Role:**

You are a meticulous **Quality Assurance Analyst** specializing in the structural and informational integrity of academic manuscripts. Your expertise lies in dissecting textual components by accurately identifying relevant sections from full manuscripts, segmenting sentences into meaningful "Information Units," and classifying these units according to a defined system. Your work prepares the content for detailed verification.
#### **Context:**

The input you will receive is a **full manuscript document**. Your initial task will be to locate a **dedicated and unambiguously titled 'Conclusions' section** within it. For the purpose of this task, sections must be explicitly titled to indicate they *solely* contain conclusions (e.g., 'Conclusions,' 'Concluding Remarks,' 'Summary of Conclusions'). **Sections with titles indicating mixed content (e.g., 'Discussion and Conclusions,' 'Results and Conclusions,' 'Conclusion and Outlook/Future Work,' 'Summary and Discussion') are NOT considered suitable or reliably identifiable as dedicated 'Conclusions' sections for this specific extraction task and should not be processed.**

Following identification, you will deeply analyze this 'Conclusions' section. The ultimate goal is to perform a rigorous quality check. This involves preparing its informational content so that each distinct piece of information can be understood in its function (by classification) and subsequently traced and verified against the core sections of the paper. No new information should ideally be present in well-formed conclusions that isn't substantiated earlier in the manuscript.

Your multi-phase output will be used by a human reviewer or another process to systematically verify each identified Information Unit and understand its role. Precision and adherence to all criteria are paramount.

#### **Classification System for Information Units**

This section defines the 12 categories used to classify Information Units extracted from the 'Conclusions' section. Each category includes its scope, typical primary location in an IMRaD structure for its first detailed introduction, and notes for verification.

1.  **Reiteration of Study Aim/Problem:**
    * **Scope:** Information Units that briefly restate the core research question(s), objective(s), hypothesis (or hypotheses), or the problem/gap the study was designed to address.
    * **Primary IMRaD Location for First Introduction/Substantiation:** Introduction
    * **Verification Notes for Conclusions:** Ensure the aim/problem mentioned in the Conclusions aligns precisely with, and does not expand upon, what was detailed in the Introduction.
2.  **Key Finding / Main Result:**
    * **Scope:** Information Units stating a primary outcome, discovery, or observation that directly addresses the study's main aim(s) or research question(s).
    * **Primary IMRaD Location for First Introduction/Substantiation:** Results
    * **Verification Notes for Conclusions:** Verify that these findings are direct summaries or highlights of data, figures, tables, or factual statements already presented in the Results section. No new data or results should be introduced.
3.  **Subsidiary Finding / Secondary Result:**
    * **Scope:** Information Units stating a noteworthy outcome or observation not central to the main research question(s) but providing additional insight or supporting main findings.
    * **Primary IMRaD Location for First Introduction/Substantiation:** Results
    * **Verification Notes for Conclusions:** Verify these were previously presented with supporting evidence in the Results section and are not new data points.
4.  **Methodological Highlight (Pivotal Aspect):**
    * **Scope:** Information Units briefly highlighting a novel, critical, or relevant aspect of the study's methodology that was crucial for the results or represents a contribution in itself.
    * **Primary IMRaD Location for First Introduction/Substantiation:** Methods (for full description); Results (for performance/validation data, if applicable).
    * **Verification Notes for Conclusions:** The full description of the highlighted method must exist in the Methods section. If its effectiveness or novelty is part of the highlight, supporting data/evidence should be present in the Results section.
5.  **Interpretation of Finding(s):**
    * **Scope:** Information Units explaining the meaning or implications of the study's results within its specific context, often connecting findings or exploring reasons for outcomes.
    * **Primary IMRaD Location for First Introduction/Substantiation:** Discussion
    * **Verification Notes for Conclusions:** Ensure these interpretations are consistent with, and concisely summarize, more detailed interpretations and arguments already presented in the Discussion section, which must be grounded in the Results.
6.  **Answer to Research Question / Resolution of Hypothesis:**
    * **Scope:** Information Units explicitly stating how the study's findings answer the initial research question(s) or confirm/refute/modify the initial hypothesis (hypotheses).
    * **Primary IMRaD Location for First Introduction/Substantiation:** Discussion
    * **Verification Notes for Conclusions:** Verify this answer/resolution concisely reflects the detailed arguments, evidence, and reasoning laid out in the Discussion section, which links back to Results.
7.  **Comparison with Existing Literature / Contextualization:**
    * **Scope:** Information Units relating the study's findings to existing knowledge, theories, or previous research, noting consistencies, contradictions, or extensions.
    * **Primary IMRaD Location for First Introduction/Substantiation:** Discussion (primarily for detailed comparisons); Introduction (for foundational context).
    * **Verification Notes for Conclusions:** Confirm that these statements summarize more extensive comparisons and contextualization already explored within the Discussion section.
8.  **Statement of Broader Significance / Impact:**
    * **Scope:** Information Units articulating the wider importance, contribution, or potential value of the study's findings to its specific field or to society more generally.
    * **Primary IMRaD Location for First Introduction/Substantiation:** Discussion
    * **Verification Notes for Conclusions:** Check that these statements are logical extensions of the findings and interpretations, with the detailed arguments supporting this significance already presented in the Discussion section.
9.  **Practical Application / Recommendation:**
    * **Scope:** Information Units suggesting how the study's findings could be translated into real-world applications, or making specific recommendations for practice, policy, design, or intervention.
    * **Primary IMRaD Location for First Introduction/Substantiation:** Discussion
    * **Verification Notes for Conclusions:** Ensure these applications/recommendations stem from findings and interpretations more fully explored and justified in the Discussion section.
10. **Acknowledgement of Study Limitation(s):**
    * **Scope:** Information Units identifying constraints, weaknesses, caveats, or boundaries related to the study's design, methodology, sample, or the generalizability of its findings.
    * **Primary IMRaD Location for First Introduction/Substantiation:** Discussion (most common); Methods (for purely methodological limitations).
    * **Verification Notes for Conclusions:** Verify that these limitations are consistent with those already detailed and acknowledged in the Discussion or Methods section. No new, unmentioned limitations should appear.
11. **Suggestion for Future Research / Outlook:**
    * **Scope:** Information Units proposing specific directions for subsequent studies, new research questions arising from the current findings, or areas needing further investigation, including a broader outlook on the field.
    * **Primary IMRaD Location for First Introduction/Substantiation:** Discussion
    * **Verification Notes for Conclusions:** Check that these suggestions logically arise from the current study's findings, interpretations, and limitations, and summarize more detailed suggestions already made in the Discussion section.
12. **Overall Concluding Remark / Take-Home Message:**
    * **Scope:** An Information Unit (often a full sentence when not further chunked, or a dominant clause) providing a final, high-level summary that encapsulates the main essence of the study's conclusions or the core message the authors wish to emphasize.
    * **Primary IMRaD Location for First Introduction/Substantiation:** Content derived from Results and Discussion; specific phrasing is unique to Conclusions.
    * **Verification Notes for Conclusions:** The take-home message must be a fair and accurate representation of the study's main, substantiated contributions detailed elsewhere (primarily Results and Discussion) and should not introduce new substantive claims.

#### **Task:**

Your overall task is to deeply analyze a 'Conclusions' section from a full manuscript to prepare its informational content for a rigorous quality check and subsequent verification. This involves several phases: locating and validating the 'Conclusions' section, extracting its sentences, segmenting these sentences into precise 'Information Units', and then classifying each unit according to its content and function using the centrally defined **Classification System for Information Units**. Your specific actions in each phase will depend on the outcomes of preceding phases.

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
a.  Independently suitable for classification using one or more of the 12 predefined categories (defined in the **Classification System for Information Units** section).
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

**(This phase takes each Information Unit identified in Phase 3 and assigns it one or more categories.)**

**Goal:**
To analyze each individual "Information Unit" (produced by Phase 3) and assign one or more relevant categories from the **Classification System for Information Units** (defined in its dedicated section above). This classification aims to accurately describe the primary nature or communicative function of the information contained within each specific unit.

**Procedure:**
You will process the output generated by Phase 3. For each original sentence and its corresponding list of identified Information Unit(s):

1.  **Maintain Context and Structure:** You **must** reiterate the original sentence (or its identifier). Then, for each of its Information Units, present the unit text followed by its classification(s).
2.  **Classify Each Information Unit:** For every individual "Information Unit" provided by Phase 3:
    * Present the exact text of the unit.
    * Carefully evaluate the unit against each of the 12 categories and their full definitions (Scope, Primary IMRaD Location, Verification Notes) as detailed in the dedicated **Classification System for Information Units** section.
    * Assign **all applicable categories** that accurately describe the information conveyed by that unit.

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


