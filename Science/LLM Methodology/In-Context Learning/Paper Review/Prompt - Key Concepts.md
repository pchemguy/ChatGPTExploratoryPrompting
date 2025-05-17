

https://gemini.google.com/app/fc7f607f9d6404dd

# V1

## Meta 1

Help me generate a prompt that will be executed within a chat, which is used to revise a manuscript (so both the manuscript text and target audience are within the LLM's conversational context). The goal of this prompt is to extract key terms and concepts used within the title and abstract yielding a list to be used for subsequent categorization and or search terms generations.

## Meta 2

In addition to "manuscript's primary focus and contributions", perhaps the prompt should also specifically mention applications. Basically, someone reading this list should be able get an idea what the paper's focus/topic (probably covered by "manuscript's primary focus and contributions"), but also target application areas or features. I want to provide clues as to how the "manuscript's primary focus and contributions" might be of practical relevance to the audience. Based on my overall intent, consider how this prompt can be expanded / improved further.

## Meta 3

Actually, "search terms / categorization" context was a very real thing, but an attempt to narrow LLM's focus. Perhaps these context is unnecessary or could be replaced with something better given my intent? Also add explicit instructions to disregard any previously generated or extracted terms/keywords/concepts.

## Meta 4

Given the title "AI-Driven Scholarly Peer Review via Persistent Workflow Prompting, Meta-Prompting, and Meta-Reasoning", this prompt extracted
- Persistent Workflow Prompting (PWP)
- Meta-Prompting & Meta-Reasoning
- AI-Driven Scholarly Peer Review
I need you amend the prompt to yield more atomic terms or concepts:
- Persistent Workflow Prompting (PWP)
- Meta-Prompting
- Meta-Reasoning
- AI-Driven
- Scholarly Peer Review
You cannot use these specific terms as part of the prompt. The task must be described using generalized language, so that I could apply the final prompt broadly.

## Meta 5

Let's expand it further. In its present state, the prompt appears to do the requested task according to my need. Now I want to add a second stage. After generating the initial list, the LLM needs to consider each item in that list and generate 1-2 close synonyms / equivalents / analogs that might be used by the target audience as search terms. LLM should produce the initial list of extracted atomic terms/concepts first, following by the list of synonyms / equivalents / analogs.

## Meta 6

Here is a sample output:

**Original Term:** AI-Driven (Characteristic)
- Synonym/Equivalent: Artificial Intelligence Application
- Synonym/Equivalent: Machine Learning Powered

For once, I do not need "**Original Term:**" and "Synonym/Equivalent:" clutter.
Second, I probably do not need generalization, especially generalization that are also broad terms like both of the generated variants in the example above. What I do not see is a fairly close "AI-Assisted" term. I need you amend the prompt to fix all these issues.

Also, consider if you could improve overall structure, like using Markdown headings instead of separators and having overarching instructions before stage 1, because right now it appears like a collection of stages, rather than an integral workflow.

As before, you are not allowed to include specific examples I provided as part of the generated prompt.

## Meta 7

With that prompt, LLM has produced, among other things:

AI-Driven (Characteristic)
- AI-Powered
- Machine Learning Based

Then I asked if the LLM considered "AI-Assisted" as another alternative. The following was a full response. Can we fix this?

---

Yes, I did consider "AI-Assisted" as a potential synonym or alternative phrasing for "AI-Driven" during the process of generating the list for Part 2.

When brainstorming alternatives for a term like "AI-Driven (Characteristic)," a range of related concepts come to mind, including:

- AI-Powered
- AI-Enabled
- AI-Augmented
- AI-Assisted
- Machine Learning Based
- Computationally Driven

The selection for the final list of 1-2 alternatives then involves choosing those that are most closely related, semantically very similar, and likely search terms for the _specific nuance_ of the original term within the context of your manuscript.

For **"AI-Driven (Characteristic),"** the alternatives I provided were:

- AI-Powered
- Machine Learning Based

My reasoning for selecting these two specifically, and perhaps not "AI-Assisted" in that particular slot, was:

1. **Nuance of "Driven" vs. "Assisted":** "AI-Driven" (as used in your title "AI-Driven Scholarly Peer Review") often implies that AI is the primary engine or a central, indispensable force performing or enabling the core of the task. "AI-Assisted," on the other hand, can sometimes imply a more supportive or supplementary role for AI, where a human might still be the primary agent, being _assisted_ by AI tools. While the distinction can be subtle and context-dependent, "AI-Driven" often suggests a stronger or more central agency for the AI.
2. **Closeness to "Characteristic":** The original item was "AI-Driven (Characteristic)." "AI-Powered" and "Machine Learning Based" directly describe the _nature or basis_ of that characteristic – it's powered by AI or based on ML. "AI-Assisted" describes a mode of operation or a relationship (AI assists something/someone) which is slightly different from describing an inherent characteristic of a process.
3. **Search Intent for "AI-Driven":** Someone searching specifically for "AI-Driven" solutions might be looking for systems where the AI takes on a significant portion of the task execution. "AI-Powered" aligns very closely with this. "Machine Learning Based" points to the underlying technology that makes it "AI-Driven."

While "AI-Assisted" is a very relevant and related term in the broader space of AI applications and is certainly a term users might search for when looking for AI involvement in peer review, it implies a slightly different dynamic than "AI-Driven." For the specific task of providing _close_ synonyms or direct alternative phrasings for "AI-Driven (Characteristic)," "AI-Powered" was chosen as a very direct semantic equivalent.

However, it's a valid point that "AI-Assisted" is a highly relevant search term in the general domain. If the goal was to capture a slightly wider net of related search terms for the _concept_ of using AI in peer review (rather than very close synonyms for "AI-Driven" specifically), "AI-Assisted" would be a strong candidate. The instruction to aim for "specificity and direct relevance... very similar semantic roles and meanings... precise concept" led me to the choices made.

---
---

## Prompt: Key Concept Extractor and Term Generator

**Important: Please disregard any keywords, key terms, concepts, or lists that may have been generated or discussed earlier in this conversation. For this specific request, base your output _only_ on the manuscript's current title and abstract.**

This task involves a two-stage workflow. The overall goal is to first thoroughly analyze the manuscript's title and abstract to extract its core atomic components (terms, concepts, and applications). Then, in the second stage, you will enrich these extracted components by generating closely related alternative phrasings that the target audience might use for search. Please follow the instructions for each stage carefully to produce a structured output.

**Important:** You need to focus for now on stage 1 only.

### Stage 1: Extraction of Atomic Terms, Concepts, and Applications

Considering the manuscript's title and abstract, please identify and list the key terms, core concepts, and any explicitly mentioned or strongly implied **applications or areas of practical relevance**.

When constructing this list, aim to identify the most fundamental building blocks of the manuscript's core ideas. Strive for a **high degree of atomicity** in the terms and concepts.
- If a phrase or compound term combines multiple distinct ideas, methodologies, or features (e.g., 'Method A and Theory B', or 'Feature X with Property Y'), break it down into these individual components, provided each component is an independently significant concept key to understanding the manuscript.
- **Specifically, and crucially for this task, if a key characteristic, methodology, technology, or approach (the 'Qualifier') is described as fundamentally shaping, enabling, or being applied to a core subject, domain, or process (the 'Core Concept'), you should generally list both the 'Qualifier' (e.g., 'Method M') and the 'Core Concept' (e.g., 'Domain D') as separate atomic items.** This deconstruction is vital if both the "how it's done or characterized" (the Qualifier) and the "what it applies to" (the Core Concept) are individually emphasized or represent separable, significant facets of the manuscript's contribution. The primary goal here is to break down such fundamental relationships into their core constituent concepts for this list.
- Each listed atomic term should, as much as possible, remain meaningful and clearly relevant to the paper's specific focus. Even if a widely applicable methodology or characteristic might seem general when viewed in complete isolation, it should be listed if it is a key component or aspect _of this particular manuscript's subject matter_.

Focus on extracting elements that are central to understanding both the core research and its potential impact or utility. The terms and phrases in this initial list should be informative and indicative of the paper's content.

### Output Structure

(This section remains unchanged from the previous version)

Please present your complete response in clearly separated sections, using the Markdown headings provided below:

#### Part 1: Extracted Atomic Terms and Concepts

(Present the list generated in Stage 1 here. This should be a simple list of the extracted terms and concepts.)


---
---

1. Identify major science domains of the manuscript.
2. Extract atomic entities (key concepts / terms / keywords from the manuscript title and abstract), such that:
    1. Each entity (key concept, term, or keyword) must, on its own:
        1. Clearly and directly represent or reflect:
            - An identified science domain. A descriptive phrase can reflect a domain if it explicitly points to the core nature of that domain's involvement.
            - A major manuscript aspect, such as a core methodology, a key finding, or a specific major demonstrated application, subject, or target area. A term should be substantive enough to stand alone as representing one of these categories.
        2. Be not too broad (regardless of whether the entity reflects an important aspect of the manuscript).
    2. Linguistic guidelines:
        1. Each compound word must be treated as a whole and never split into constituent parts.  
        2. Generally, normalized word forms (e.g., singular vs. plural) are preferable, unless plural form is an integral part of a common concept or term.
    3. If a compound concept can be split into constituent parts, and each such constituent independently and clearly satisfies requirement 2.1, then the compound concept should be split into these constituent entities.
    4. Generally, drop purely generic connecting words (e.g., 'via,' 'and'). Standalone words like 'methodology' or 'application' should be dropped if they are used as general categorizations rather than being part of a specific, named concept or compound term.

---

1. Considering the manuscript's title and abstract, extract a list of atomic keywords (do not split compound words) to be used for related literature search:
    - Limit number of terms extracted from abstract to the top 10 most significant terms distinct from those extracted from the title.
    - Take note of the source context.
    - Produce combined list 1.
2. For each extracted keyword
    1. Generate up to top 5-10 related terms that the target audience might realistically use as search terms and match any of the following
        - Closely related synonyms
        - Direct alternative phrasings
        - Near-equivalent terms
    2. Make sure that generated terms are considered distinct from the extracted term by search engines (e.g., word forms and common abbreviations are generally treated as not distinct).
    3. From this list, keep alternatives that are
        - Close in scope (discard those broader or more specific)
        - Commonly used
        - Could likely replace the extracted keyword in its original context, even if having slightly nuanced meaning.
     4. Select top two alternatives considering criteria in 2.3 and produce list 2.

---

Considering the manuscript's title and abstract
1. Extract a list of atomic (do not split compound words) keywords to be used for related literature search:
    - Limit number of terms extracted from abstract to the top 10 most significant terms distinct from those extracted from the title.
    - Take note of the source context.
2. Together with each extracted keyword extract nearest minimalistic linguistic and semantic context that should be just sufficient to consider:
    - If the keyword directly relates to the key methodology, main application domain, or something else.
    - What alternative synonyms or keywords (DO NOT actually generate them) with close meaning and scope are most likely to appear in the given context 
3. Generate a combined JSON array:
   [{"keyword":(KEYWORD), "context":(CONTEXT)},...]

4. Label each extracted term as being most directly related to
    - Methodology
    - Main application domain
    - Produce a combined list 1.
    
5. Drop keywords that are
    - Not related directly to the methodology OR
    - Specific to the manuscript OR
    - Relatively uncommon.





Considering the provided manuscript's title and abstract, please perform the following tasks:
1. **Extract Atomic Keywords for Literature Search:**    
    - Identify and list atomic keywords (do not split compound words).
    - From the **title**: Extract all relevant atomic keywords.
    - From the **abstract**: Extract the top 10 most significant atomic keywords that are distinct from those already extracted from the title.
    - For each keyword, clearly note whether its source is the 'title' or the 'abstract'.
2. **Extract Context for Each Keyword:**
    - For every keyword identified in Step 1:
        - **Identify Keyword Role:** Determine if the keyword, in its specific manuscript location, primarily relates to: (a) a key **methodology** described, (b) the main **application** domain discussed, or (c) **something else** (e.g., a problem, a specific component, a general concept).
        - **Extract Surrounding Textual Context:** From the manuscript, extract the minimalistic linguistic and semantic textual snippet that immediately surrounds the keyword. This extracted text should be just sufficient to:
            - Clearly understand the keyword's meaning and usage in that specific instance.
            - Serve as a self-contained environment for a _separate, later process_ where an alternative keyword (generated elsewhere) could be substituted in place of the original keyword to evaluate its linguistic and semantic appropriateness within this exact extracted textual context.
            - **Do not describe or generate alternative keywords at this stage.** Focus solely on capturing the original keyword's immediate environment and its role.
3. **Generate a Combined JSON Array:**    
    - Compile all extracted keywords and their corresponding contexts (including the keyword's role and its surrounding textual snippet) into a single JSON array. The structure for each element in the array should be:
```
{
    "keyword":          "(KEYWORD_TEXT)",
    "role":             "(methodology/application/other)",
    "source_location":  "(title/abstract)",
    "surrounding_text": "(EXTRACTED_TEXTUAL_SNIPPET_FROM_MANUSCRIPT)"
}
```
4. **Generate a Filtered JSON Array**:
    - From combined JSON array, discard keywords that:
        - have the "other" role OR
        - are specific to the manuscript OR
        - are relatively uncommon.
5. **Generate Alternatives:**
    - Enrich remaining keywords by adding an array "alternatives" to each JSON5 array member.
    - Each "alternatives" array should include at most 5 related synonyms, direct alternative phrasings, or near-equivalent terms that
        - Might be realistically used as search terms by the target audience. 
        - Fit well linguistically and semantically in place of the extracted keyword in "surrounding_text".
        - Are considered distinct from the extracted keyword by search engines (e.g., alternative word forms or common abbreviation are not distinct).

