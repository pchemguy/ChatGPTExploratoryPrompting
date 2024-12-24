# ChatGPTTutorial
Notes and materials related to efficient use of ChatGPT as a writing and coding assistant.

In this repository, I share my beginner's experience exploring features of ChatGPT and related workflows. Unless otherwise specified, all ChatGPT responses assume the use of the GPT-4o model. The key areas of interest include:

- Non-fiction writing assistance, with a focus on technical and business contexts
- Coding support and guidance
- Technical aspects of prompting, such as memory context management and meta-prompting

**Disclaimer:**  
This repository is a work in progress. While some development may occur on the `dev` branch, I aim to update the `main` branch more frequently or directly. As a result, content may change periodically, and portions may appear incomplete or inconsistent at any given time.

## 1. Writing assistance for efficient technical and business writing

Both my work and hobbies involve technical and business writing. The primary goal of non-fiction readers is typically to minimize the time spent reading while maximizing the amount and completeness of relevant information retrieved. Consequently, the efficiency of non-fiction texts heavily depends on their accessibility and clarity.  

ChatGPT performs reasonably well in enhancing the efficiency of non-fiction texts, even with basic prompts like "Convert the following text into standard English". However, using detailed and comprehensive instructions often leads to significantly improved results. Additionally, editing — whether for text or code — should always be viewed as an iterative process, akin to traditional writing, where drafts undergo multiple revisions and refinements. Well-structured instructions effectively drive ChatGPT, simplifying the overall revision process and targeted refinement of specific text aspects.

To streamline this refinement process, I have developed two documents:

- **Stylistic Guidelines** ([Writing Style Guidelines for Technical and Business Texts][WritingStyleGuidelines]):  
    These guidelines are designed to be provided directly to ChatGPT and focus on core aspects such as writing mechanics, structure, vocabulary, sentence construction, and overall coherence. They are applicable to most common non-fiction writing tasks.
    
- **Context Template** ([Writing Context Guidelines][WritingContext]):  
    This template offers customizable options for defining high-level writing parameters, including audience, domain, intent, formality, tone, and other contextual factors. It also allows for creating tailored "profile" contexts (e.g., "LinkedIn Post"), which can be included when submitting instructions to ChatGPT, enabling it to adapt to specific needs.    

While the above documents do not include examples, examples can be generated easily using appropriate prompts. For instance, a section from the [Writing Style Guidelines][WritingStyleGuidelines] can be copied and prefixed with a general instruction, for example:

<details>
<summary><b>ChatGPT Sample Prompt</b></summary>

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
</details>


## 2. Coding assistance

**TODO**

## 3. Technical aspects and workflows

While ChatGPT is developed as a conversational tool that should be easily accessible to beginners, learning certain technical aspects may drastically improve the results, as evidenced by the emergence of the prompt engineering field.

Divide and conquer
Iterative focused refinement
Technical aspects for tailoring answers

Graphics analysis: vector or raster - interpret serialized file by comparing with graphical representation?



<!-- References -->

[WritingStyleGuidelines]: https://raw.githubusercontent.com/pchemguy/ChatGPTPromptEngineering/refs/heads/main/Writing/WritingStyleGuidelines.md
[WritingContext]: https://raw.githubusercontent.com/pchemguy/ChatGPTPromptEngineering/refs/heads/main/Writing/WritingContext.md

