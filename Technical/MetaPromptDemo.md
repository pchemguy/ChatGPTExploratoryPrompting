# Meta-Prompting

Since the relevance of ChatGPT responses substantially depend on the quality of prompts, and because ChatGPT seems to be good at  transformative and creative writing tasks, it appears to be a natural question to see if ChatGPT can improve its own prompts. I decided to develop "meta" template:

```
{INSTRUCTIONS}

Prompt do be improved

{TARGET PROMPT}
```

So, I put together an initial version #0 of `{INSTRUCTIONS}`:

```
Help me improve the following ChatGPT prompt. I want to make sure that I
- communicate my task / question / request to ChatGPT as clear as possible;
- resolve any ambiguities;
- provide sufficient details to generate a relevant answer;
- encourage ChatGPT to ask clarifying questions to further improve results;
- instruct ChatGPT to re-read the prompt and reflect on it before producing the answer to see if the question may include issues that make the question unanswerable directly, such as:
    - false premises / factual errors (misleading or loaded questions),
      Example: "Why are all cats black?"
      Example:  "Who was the first person to land on Mars?"
    - logical fallacies / contradictions,
      Example: "What kind of triangle has two right angles?"
    - insufficient information / lack of details or scope,
      Example: "Explain everything about physics."
    - vague or ambiguous information
      Example: "What is the best?"
    - nonsensical constructs
      Example: "What is the square root of happiness?"
- instruct ChatGPT to provide feedback / reflection on the problematic question instead of trying to generate a direct answer.
```

The next step was to improve version #0, which is also a prompt, by substituting it as both `{INSTRUCTIONS}` and `{TARGET PROMPT}`:

<details>
<summary><b>ChatGPT Prompt</b></summary>
Help me improve the following ChatGPT prompt. I want to make sure that I
- communicate my task / question / request to ChatGPT as clear as possible;
- resolve any ambiguities;
- provide sufficient details to generate a relevant answer;
- encourage ChatGPT to ask clarifying questions to further improve results;
- instruct ChatGPT to re-read the prompt and reflect on it before producing the answer to see if the question may include issues that make the question unanswerable directly, such as:
    - false premises / factual errors (misleading or loaded questions),
      Example: "Why are all cats black?"
      Example:  "Who was the first person to land on Mars?"
    - logical fallacies / contradictions,
      Example: "What kind of triangle has two right angles?"
    - insufficient information / lack of details or scope,
      Example: "Explain everything about physics."
    - vague or ambiguous information
      Example: "What is the best?"
    - nonsensical constructs
      Example: "What is the square root of happiness?"
- instruct ChatGPT to provide feedback / reflection on the problematic question instead of trying to generate a direct answer.

### Prompt to be improved

Help me improve the following ChatGPT prompt. I want to make sure that I
- communicate my task / question / request to ChatGPT as clear as possible;
- resolve any ambiguities;
- provide sufficient details to generate a relevant answer;
- encourage ChatGPT to ask clarifying questions to further improve results;
- instruct ChatGPT to re-read the prompt and reflect on it before producing the answer to see if the question may include issues that make the question unanswerable directly, such as:
    - false premises / factual errors (misleading or loaded questions),
      Example: "Why are all cats black?"
      Example:  "Who was the first person to land on Mars?"
    - logical fallacies / contradictions,
      Example: "What kind of triangle has two right angles?"
    - insufficient information / lack of details or scope,
      Example: "Explain everything about physics."
    - vague or ambiguous information
      Example: "What is the best?"
    - nonsensical constructs
      Example: "What is the square root of happiness?"
- instruct ChatGPT to provide feedback / reflection on the problematic question instead of trying to generate a direct answer.
</details>

The result is placed in the [MetaPromptTemplate] file.


<!-- References -->

[MetaPromptTemplate]: https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Technical/MetaPromptTemplate.md