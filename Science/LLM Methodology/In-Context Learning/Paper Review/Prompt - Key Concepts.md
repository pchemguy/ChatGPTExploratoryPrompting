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

## Prompt

### Prompt: Key Concept Extractor

**Important: Please disregard any keywords, key terms, concepts, or lists that may have been generated or discussed earlier in this conversation. For this specific request, base your output _only_ on the manuscript's current title and abstract.**

Considering the manuscript's title and abstract, please identify and list the key terms, core concepts, and any explicitly mentioned or strongly implied **applications or areas of practical relevance**.

**When constructing this list, strive for a high degree of atomicity in the terms and concepts extracted.** If a single phrase, title component, or compound term clearly combines several distinct conceptual elements (for instance, multiple methodologies, distinct features, or a specific characteristic qualifying a broader subject or process), please endeavor to **break these down and list them as the most granular, independently significant terms or concepts** that are key to understanding the manuscript. Each such atomic term should still be meaningful on its own within the paper's context.

The aim is to generate a concise list of these keywords and key phrases. This list should effectively **summarize the manuscript's core subject matter and its practical significance for the target audience**, enabling them to rapidly understand:
1. The manuscript's **primary focus and unique contributions**.
2. The potential **target application areas, practical uses, or significant features/benefits** highlighted.

Focus on extracting elements that are central to understanding both the core research and its potential impact or utility. The list should be composed of terms and phrases that are informative and indicative of the paper's content.
