

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

## Prompt: Key Concept Extractor and Term Generator

**Important: Please disregard any keywords, key terms, concepts, or lists that may have been generated or discussed earlier in this conversation. For this specific request, base your output _only_ on the manuscript's current title and abstract.**

This task involves a two-stage workflow. The overall goal is to first thoroughly analyze the manuscript's title and abstract to extract its core atomic components (terms, concepts, and applications). Then, in the second stage, you will enrich these extracted components by generating closely related alternative phrasings that the target audience might use for search. Please follow the instructions for each stage carefully to produce a structured output.

### Stage 1: Extraction of Atomic Terms, Concepts, and Applications

Considering the manuscript's title and abstract, please identify and list the key terms, core concepts, and any explicitly mentioned or strongly implied **applications or areas of practical relevance**.

When constructing this list, strive for a **high degree of atomicity** in the terms and concepts extracted. If a single phrase, title component, or compound term clearly combines several distinct conceptual elements (for instance, multiple methodologies, distinct features, or a specific characteristic qualifying a broader subject or process), please endeavor to **break these down and list them as the most granular, independently significant terms or concepts** that are key to understanding the manuscript. Each such atomic term should still be meaningful on its own within the paper's context.

The aim of this first list is to generate concise keywords and key phrases that effectively **summarize the manuscript's core subject matter and its practical significance for the target audience**, enabling them to rapidly understand:

1. The manuscript's **primary focus and unique contributions**.
2. The potential **target application areas, practical uses, or significant features/benefits** highlighted.

Focus on extracting elements that are central to understanding both the core research and its potential impact or utility. The terms and phrases in this initial list should be informative and indicative of the paper's content.

### Stage 2: Generating Closely Related Search Alternatives

After you have generated the list from Stage 1, please proceed to this second stage. For **each distinct item** in the list generated in Stage 1:

1. Generate **one to two closely related synonyms, direct alternative phrasings, or near-equivalent terms**.
2. These alternatives should be terms that the **target audience** (as defined in our context) might realistically use as **search terms** when looking for information related to that _specific_ original item from Stage 1.
3. **Crucially, aim for specificity and direct relevance**: The suggested alternatives should maintain a similar level of granularity to the original term. **Avoid overly broad generalizations.** Instead, focus on:
    - Slight variations in wording that result in terms with very similar semantic roles and meanings (for instance, using a different but closely related adjective to describe a method's application, or a minor rephrasing of a compound term, like "X Y" instead of "X-based Y," that retains the core meaning).
    - Common acronyms (if not already the primary term and truly equivalent).
    - Very direct equivalents that someone familiar with the topic might use interchangeably or as an alternative search query for that precise concept. The goal is to find terms that are semantically very close, not distant or overly abstract relations.

### Output Structure

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
