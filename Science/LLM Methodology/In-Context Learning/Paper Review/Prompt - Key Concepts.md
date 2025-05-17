

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

"**Important: Please disregard any keywords, key terms, concepts, or lists that may have been generated or discussed earlier in this conversation. For this specific request, base your output _only_ on the manuscript's current title and abstract.**

This task involves a two-stage workflow. The overall goal is to first thoroughly analyze the manuscript's title and abstract to extract its core atomic components (terms, concepts, and applications). Then, in the second stage, you will enrich these extracted components by generating closely related alternative phrasings that the target audience might use for search. Please follow the instructions for each stage carefully to produce a structured output.

### Stage 1: Extraction of Atomic Terms, Concepts, and Applications

Considering the manuscript's title and abstract, please identify and list the key terms, core concepts, and any explicitly mentioned or strongly implied **applications or areas of practical relevance**.

When constructing this list, aim to identify the most fundamental building blocks of the manuscript's core ideas. Strive for a **high degree of atomicity** in the terms and concepts.

- If a phrase or compound term combines multiple distinct ideas, methodologies, or features (e.g., 'Method A and Theory B', or 'Feature X with Property Y'), break it down into these individual components, provided each component is an independently significant concept key to understanding the manuscript.
- **Specifically, and crucially for this task, if a key characteristic, methodology, technology, or approach (the 'Qualifier') is described as fundamentally shaping, enabling, or being applied to a core subject, domain, or process (the 'Core Concept'), you should generally list both the 'Qualifier' (e.g., 'Method M') and the 'Core Concept' (e.g., 'Domain D') as separate atomic items.** This deconstruction is vital if both the 'how it's done or characterized' (the Qualifier) and the 'what it applies to' (the Core Concept) are individually emphasized or represent separable, significant facets of the manuscript's contribution. The primary goal here is to break down such fundamental relationships into their core constituent concepts for this list.
- Each listed atomic term should, as much as possible, remain meaningful and clearly relevant to the paper's specific focus. Even if a widely applicable methodology or characteristic might seem general when viewed in complete isolation, it should be listed if it is a key component or aspect _of this particular manuscript's subject matter_.

The aim of this first list is to generate concise keywords and key phrases that effectively **summarize the manuscript's core subject matter by its constituent parts and its practical significance for the target audience**, enabling them to rapidly understand:

1. The manuscript's **primary focus and unique contributions through these atomic elements**.
2. The potential **target application areas, practical uses, or significant features/benefits** highlighted.

Focus on extracting elements that are central to understanding both the core research and its potential impact or utility. The terms and phrases in this initial list should be informative and indicative of the paper's content.

### Stage 2: Generating Closely Related Search Alternatives

(This section remains unchanged from the previous version, focusing on synonym quality and format)

After you have generated the list from Stage 1, please proceed to this second stage. For **each distinct item** in the list generated in Stage 1:

1. Generate **one to two closely related synonyms, direct alternative phrasings, or near-equivalent terms**.
2. These alternatives should be terms that the **target audience** (as defined in our context) might realistically use as **search terms** when looking for information related to that _specific_ original item from Stage 1.
3. **Guidance on "Closely Related":** While maintaining a similar level of granularity and avoiding overly broad generalizations is important, also consider practical search behavior. The alternatives should be terms the target audience might use to find the original concept, even if there are subtle semantic differences. Focus on:
    - Slight variations in wording. This includes terms with very similar primary meanings, but can also extend to **terms representing closely related nuances or facets of the same core idea, especially if these are common alternative queries used by the target audience for the original concept.** For example, if the core idea involves an agent (like an AI system) performing a task, consider common variations in how that agent's role or the nature of its involvement is described (e.g., leading the action, supporting the action, enabling the action), provided these are relevant and frequently used alternative phrasings for that context.
    - Common acronyms (if not already the primary term and truly equivalent).
    - Very direct equivalents that someone familiar with the topic might use interchangeably or as an alternative search query for the precise original item. The overall goal is to find terms that are semantically very close **or are highly relevant alternative search queries for the specific original item**, rather than distant or overly abstract relations. Prioritize terms that the target audience would likely use to find the manuscript's specific concept.

### Output Structure

(This section remains unchanged from the previous version)

Please present your complete response in two clearly separated sections, using the Markdown headings provided below:

#### Part 1: Extracted Atomic Terms and Concepts

(Present the list generated in Stage 1 here. This should be a simple list of the extracted terms and concepts.)

#### Part 2: Closely Related Search Alternatives

(Present the results of Stage 2 here. For each original term from Stage 1, list its closely related search alternatives indented beneath it. Do **not** use prefixes like 'Original Term:' or 'Synonym/Equivalent:'. See the example format below.)

**Example format for Part 2:**

- [Original Term A from Stage 1]
    - [Alternative A1]
    - [Alternative A2] (if a second relevant alternative is found)
- [Original Term B from Stage 1]
    - [Alternative B1]
