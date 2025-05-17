# V1

## Meta

Help me generate an LLM prompt for generating manuscript keywords. This prompt will be executed in the same chat used to revise the source text, so I assume that the source text is within the LLM context. The generated keywords will be added to the manuscript "Keywords" field. Naturally, any words already prominently appearing in the text will be picked up by search engines from the source text. The result of the prompt should be a short list of keywords that are not present in the text, but are closely related to the main result, associated findings, important methodology, demonstrated applications, if any, etc. The keywords should be common terms that are likely to be used by members of the target community (the target community is identified at the beginning of chat used for manuscript revision) when performing literature research or exploring related topics.

## Prompt

Generate a short list of keywords for the manuscript. These keywords should:
1.  **Not be present in the manuscript text itself.** Focus on terms that a researcher might use to find this paper, even if those specific words don't appear in the main body.
2.  **Be closely related to the manuscript's key aspects:**
    * Main result
    * Associated findings
    * Important methodology
    * Demonstrated applications (if any)
3.  **Use common terms** that members of the target community (defined earlier in our conversation) would likely use when searching for relevant literature.
4.  **Be specific and optimized:** Use phrases where appropriate (e.g., "liver disease" rather than "liver"). Consider using the officially recognized form of keywords.

# V2

## Meta

This prompt closely reflects my request. Now I want you, given the task and inferred intent, help me expand and improve it, to make it more efficient and robust.

## Response

Okay, let's expand and refine that prompt to make it even more effective and robust. The goal is to guide the LLM to produce a highly relevant and targeted list of keywords that truly enhance the manuscript's discoverability.

Here's an improved version:

```
Considering the manuscript we've been revising, please generate a concise list of 5-7 keywords for the "Keywords" field. These keywords must adhere to the following criteria:

**Core Requirements:**

1.  **Novelty:** Critically, these keywords should **not** be prominent terms already present in the manuscript's title, abstract, or main body text. The aim is to add terms that expand searchability beyond the manuscript's explicit wording.
2.  **Relevance and Specificity:** Each keyword or short phrase (2-4 words ideally) must be directly and specifically relevant to:
    * The core research problem addressed.
    * The main result(s) and significant conclusions.
    * Key associated findings or unexpected observations.
    * The primary or novel methodology/experimental approach employed.
    * Any demonstrated or potential applications, or broader implications.
3.  **Target Audience Focus:** The keywords should be terms that members of the [previously identified target community, e.g., "condensed matter physicists specializing in topological insulators" or "clinical psychologists studying anxiety disorders"] would realistically use when searching for literature on this topic or related subjects.
4.  **Search Engine Optimization (SEO) Principles:**
    * Prioritize terms or phrases commonly used in the field.
    * Avoid overly niche jargon unless it's a newly coined term central to the manuscript that others might begin searching for.
    * Use standardized or widely accepted terminology where applicable (e.g., if there's a common way to refer to a specific technique or concept).

**Focus Areas for Keyword Generation (think broadly but select specifically):**

* **Broader Field/Context:** One or two keywords that situate the work within a slightly broader disciplinary context, if not already obvious from the title.
* **Specific Problem/Phenomenon:** Terms that define the specific problem or phenomenon investigated.
* **Key Methodology/Technique:** If a significant or distinguishing method was used, include a term for it (unless it's extremely common like "PCR" in a biology paper where it's not a *distinguishing* feature).
* **Key Substances/Materials/Models:** If specific substances, materials, or theoretical models are central and unique, consider them.
* **Outcomes/Applications:** Terms related to the outcomes, impacts, or potential uses of the research.

**Negative Constraints (What to Avoid):**

* Redundant terms already heavily featured in the text.
* Overly broad single words if more specific phrases are appropriate (e.g., prefer "machine learning interpretability" over just "learning").
* Acronyms or abbreviations unless they are extremely well-established and more commonly used than their expanded forms within the target community.
* Keywords that are too general for the field (e.g., "research," "study," "science").

**Output Format:**

Please provide the keywords as a comma-separated list.

---

**Example (Illustrative - do not use these keywords, but use this as a thinking guide for the type of reasoning):**
*If the manuscript was about a new AI algorithm for detecting early-stage Alzheimer's from retinal scans, and the text focused heavily on "AI algorithm," "retinal scans," and "Alzheimer's detection":*
* *Keywords might include:* "neurodegenerative disease biomarkers," "ophthalmic imaging diagnostics," "early intervention strategies," "machine learning in healthcare," "retinopathy signals." (These are related but likely less frequent in the main text itself).

---

Analyze the manuscript thoroughly and provide keywords based on these expanded guidelines.
```

**Key improvements and rationale:**

1. **Specific Number of Keywords:** Requesting "5-7 keywords" gives a clearer target than "short list."
2. **Enhanced Novelty Instruction:** Explicitly mentioning "title, abstract, or main body text" for exclusion.
3. **Detailed Relevance Categories:** Breaking down "main result, methodology, etc." into more granular "Focus Areas" helps the LLM think through different angles.
4. **SEO Principles:** Explicitly mentioning SEO and related best practices.
5. **Negative Constraints:** Clearly stating what to avoid helps prevent common pitfalls.
6. **Output Format:** Specifying "comma-separated list" for easy use.
7. **Illustrative Example:** Providing a brief, _meta-level_ example of the _thinking process_ helps the LLM understand the _type_ of keywords desired (related but not redundant).
8. **Stronger Action Verbs:** Using phrases like "Critically," "must adhere," "Analyze thoroughly."
9. **Reinforced Target Audience:** Reminding the LLM of the previously defined target community.

This more detailed prompt should lead to a more robust and useful set of keywords from the LLM. It provides more guardrails and clearer direction.

# V3

## Meta

Let's amend this prompt further. First, the prompt should aim to generate a list of 20-25 keywords (each keyword being a single item in the list, whether consisting of a single or several words). Half of this list should be generated using the instructions already included in the prompt.

The other half should use the following workflow. Extract key terms, using identification logic from the current prompt version, except these are terms prominently present in title or abstract. For each of the extracted terms, consider close synonyms or equivalents, again taking into account general requirements present in the current prompt. From this list of synonyms/equivalents selected top candidates not present in the first half of the target list and use them to populate the second half of the list.

Also add instructions to ignore any previously generated terms.

## Response

Okay, this is a significant and interesting evolution of the prompt. We're now aiming for a larger, two-part list, combining keywords that are "novel and related" with keywords that are "synonyms of prominent terms." This approach should yield a very comprehensive set of keywords.

Here's the amended prompt incorporating your new requirements:

```
**Objective:** Generate a comprehensive list of 20-25 high-quality manuscript keywords. This list will be compiled in two distinct parts.

**Crucial Instruction:** Please disregard any keyword lists or suggestions generated in previous turns of this conversation. Generate a completely new list based on the instructions below.

---

**Part 1: Novel Related Keywords (Generate 10-13 keywords for this part)**

For this first set of keywords, the primary goal is to identify terms that expand searchability beyond the manuscript's explicit wording. These keywords should:

1.  **Novelty:** Be terms **not** prominently featured in the manuscript's title, abstract, or main body text.
2.  **Relevance and Specificity:** Each keyword or short phrase (ideally 2-4 words) must be directly and specifically relevant to:
    * The core research problem addressed.
    * The main result(s) and significant conclusions.
    * Key associated findings or unexpected observations.
    * The primary or novel methodology/experimental approach employed (if distinguishing).
    * Any demonstrated or potential applications, or broader implications of the research.
3.  **Target Audience Focus:** Keywords should be terms that members of the [previously identified target community, e.g., "condensed matter physicists specializing in topological insulators" or "clinical psychologists studying anxiety disorders"] would realistically use when searching for literature on this topic or related subjects.
4.  **SEO Principles:**
    * Prioritize terms or phrases commonly used in the field.
    * Avoid overly niche jargon unless it's a newly coined term central to the manuscript that others might begin searching for.
    * Use standardized or widely accepted terminology where applicable.
5.  **Focus Areas for Keyword Generation (think broadly but select specifically for terms *not* in the text):**
    * Broader Field/Context (that isn't explicitly named repeatedly).
    * Specific Problem/Phenomenon (alternative ways to describe it).
    * Underlying principles or theories.
    * Impact or significance in a wider context.
6.  **Negative Constraints for Part 1:**
    * Redundant terms already heavily featured in the text.
    * Overly broad single words if more specific phrases are appropriate.
    * Acronyms/abbreviations unless extremely well-established and more common than their expanded forms *and* not already used.
    * Keywords that are too general for the field (e.g., "research," "study," "science").

---

**Part 2: Synonym-Based Keywords (Generate 10-12 keywords for this part)**

This second set of keywords will be derived from terms already present in the manuscript's title and abstract.

1.  **Step 2a: Extract Prominent Key Terms:**
    * Identify and list the most important and prominent key terms and phrases directly from the **title and abstract** of the manuscript. These are terms that define the manuscript's core subject, methodology, and findings *as stated*.
2.  **Step 2b: Generate Synonyms and Equivalents:**
    * For each prominent key term extracted in Step 2a, brainstorm and list close synonyms, alternative phrasings, or conceptually equivalent terms that a researcher in the target community might use interchangeably or when searching for slightly different angles of the same core topic.
    * These synonyms/equivalents must still adhere to general quality guidelines: relevance, specificity (2-4 words where appropriate), and common usage within the target community.
3.  **Step 2c: Select and Add to Final List:**
    * From the generated list of synonyms and equivalents, select the top 10-12 candidates.
    * **Crucially, ensure these selected terms are not already present in the list of keywords generated in Part 1.** The goal is to complement, not duplicate.

---

**General Quality Requirements (Applicable to ALL 20-25 keywords):**

* **Conciseness & Clarity:** Prefer phrases of 2-4 words, though single highly specific words are acceptable.
* **Discoverability:** Choose terms that will genuinely help researchers find this manuscript.
* **Avoid Redundancy within the Final List:** While Part 2 builds on existing terms, the final selected synonyms should offer new search pathways.

---

**Output Format:**

Please provide the final combined list of 20-25 keywords as a single, comma-separated list.

---

Analyze the manuscript thoroughly based on these revised instructions.
```

**Key changes in this version:**

- **Explicit Total Keyword Count:** "20-25 keywords."
- **Clear "Ignore Previous" Instruction:** Placed at the beginning.
- **Two-Part Structure:** "Part 1: Novel Related Keywords" and "Part 2: Synonym-Based Keywords," with specified counts for each.
- **Part 1 Logic:** Maintains the core of the previous prompt (keywords _not_ in text).
- **Part 2 Logic:**
    - Clearly outlines the three-step process: Extract prominent terms from title/abstract, generate synonyms/equivalents, select and de-duplicate against Part 1.
    - Emphasizes that synonyms should still be high-quality and relevant.
- **De-duplication Instruction:** Explicitly states that Part 2 keywords must not be in the Part 1 list.
- **Combined Output:** Requests a single comma-separated list at the end.

This prompt is now significantly more detailed and guides the LLM through a more complex, multi-step process. It should produce a robust and diverse set of keywords.
