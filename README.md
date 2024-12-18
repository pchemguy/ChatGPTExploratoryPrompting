# ChatGPT Exploratory Prompting

In this repository, I share my beginner's experience exploring features of ChatGPT and the associated workflows. Whenever ChatGPT answers are provided, the GPT-4o model should be assumed. The topics of interest include
* non-fiction (technical and business) writing assistance
* coding assistance
* technical aspects of prompting (such as memory context management)
## 1. Writing assistance for efficient technical and business writing

Both my job and hobbies involve technical and business writing. As opposed to fiction, a typical goal of a non-fiction reader is to minimize the time spent reading and maximize the amount and completeness of relevant information retrieved. Therefore, the efficiency of non-fiction texts largely depends on their information accessibility.  

When it comes to improving the efficiency of non-fiction texts, ChatGPT performs reasonably well even with basic prompts (such as "Convert the following text into standard English"). However, having comprehensive instructions handy often helps improve the result of a prompt. Moreover, both text and code editing should always be considered iterative processes, similar to conventional writing, where one goes through a series of drafts, revisions, and edits. With detailed well-layed-out instructions at hand, it is relatively convenient to refine individual aspects of the text. For this purpose, I have developed two documents:

- Stylistic Guidelines ([Writing Style Guidelines for Technical and Business Texts][WritingStyleGuidelines])  
    These guidelines are designed to be sent directly to ChatGPT and focus on writing mechanics, structure, vocabulary, sentence construction, and coherence. These aspects should apply to most common non-fiction writing activities.
    
- Context Template ([Writing Context Guidelines][WritingContext])  
    This template offers customizable options for defining higher-level writing aspects, such as audience, domain, intent, formality, tone, and other contextual factors. It also allows for tailored "profile" contexts (e.g., "LinkedIn Post") that can be included when submitting the entire contents to ChatGPT, instructing it to apply a specific profile.

The files above do not include any examples. However, examples can be readily generated using appropriate queries, for example, I copied a section from the [Writing Style Guidelines][WritingStyleGuidelines] and prepended it with a generic instruction:

**ChatGPT Prompt**

```
I have a section from the writing style guidelines and need
three defective examples for each bullet point, along with
their corresponding corrected versions.

Structure lists and series with clear, parallel elements:
- Parallel Structure:  
    Ensure parallelism in:  
    - Lists and series  
    - Coordinating conjunctions (e.g., and, but, or)  
    - Correlative conjunctions (e.g., either...or, neither...nor)  
    - Comparisons (e.g., more than, as...as)  
    - Infinitive phrases (e.g., to increase, to improve)  
    - Gerund phrases (e.g., filing, answering)  
    - Verb tense within series  
    - Clauses within sentences
```

<!-- 
## 2. Coding assistance

**TODO**

## 3. Technical aspects and workflows

While ChatGPT is developed as a conversational tool that should be easily accessible to beginners, learning certain technical aspects may drastically improve the results, as evidenced by the emergence of the prompt engineering field.

Divide and conquer
Iterative focused refinement
Technical aspects for tailoring answers

Graphics analysis: vector or raster - interpret serialized file by comparing with graphical representation?

-->

<!-- References -->

[WritingStyleGuidelines]: https://raw.githubusercontent.com/pchemguy/ChatGPTPromptEngineering/refs/heads/main/Writing/WritingStyleGuidelines.md
[WritingContext]: https://raw.githubusercontent.com/pchemguy/ChatGPTPromptEngineering/refs/heads/main/Writing/WritingContext.md

