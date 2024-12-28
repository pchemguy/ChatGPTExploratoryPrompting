# Ask ChatGPT to help you generate, debug, and improve prompts

## Prompt generation - Meta-prompt

### Template generation

Since the relevance of ChatGPT responses substantially depend on the quality of prompts, and because ChatGPT seems to be good at  transformative and creative writing tasks, it appears to be a natural question to see if ChatGPT can improve its own prompts. I decided to develop template:

```
{INSTRUCTIONS}

Prompt do be improved

{TARGET PROMPT}
```

where `{INSTRUCTIONS}` direct ChatGPT to improve `{TARGET PROMPT}`. So, I put together an initial version #0 of `{INSTRUCTIONS}`:

<details>
<summary><b>{INSTRUCTIONS} - Version #0</b></summary>  

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
</details>

The next step was to improve version #0 (which is itself a prompt) by substituting it as both `{INSTRUCTIONS}` and `{TARGET PROMPT}`:

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

#### Prompt to be improved

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


<details>
<summary><b>Meta-prompt template</b></summary>  

Help me improve this ChatGPT prompt ("Prompt to be improved" below) to ensure it achieves the following objectives:

1. **Clarity of Task or Request:**   
    - Clearly communicate the intended task, question, or request to ChatGPT in a precise and unambiguous manner.
2. **Resolution of Ambiguities:**
    - Eliminate potential misunderstandings by providing all necessary context, details, and scope to support a relevant and specific response.
3. **Detailed Input:**
    - Include sufficient information to guide ChatGPT’s response effectively, minimizing the need for assumptions or misinterpretation.
4. **Encouragement for Clarification:**
    - Prompt ChatGPT to ask clarifying questions if the input is incomplete, unclear, or likely to lead to suboptimal results.
5. **Re-Reading and Reflection:**
    - Instruct ChatGPT to carefully re-read the prompt before answering, ensuring it identifies and reflects on issues that could impede a direct or meaningful response. These issues may include:
        - **False Premises or Factual Errors:**  
            Examples:
            - "Why are all cats black?" (Incorrect assumption)
            - "Who was the first person to land on Mars?" (Factually incorrect event)
        - **Logical Fallacies or Contradictions:**  
            Example: "What kind of triangle has two right angles?" (Geometric impossibility)
        - **Insufficient Details or Scope:**  
            Example: "Explain everything about physics." (Overly broad)
        - **Vague or Ambiguous Information:**  
            Example: "What is the best?" (Unclear criteria)
        - **Nonsensical Constructs:**  
            Example: "What is the square root of happiness?" (Conceptual inconsistency)
6. **Feedback on Problematic Questions:**
    - Instruct ChatGPT to provide constructive feedback or reflection on problematic aspects of the prompt instead of attempting to generate a direct answer when such issues are detected.

**Final Request:** Please ensure the improved version of this prompt is optimized to encourage thoughtful, structured, and actionable responses from ChatGPT. Provide feedback on whether this revised version meets the stated objectives or suggest further refinements to improve it.

#### Prompt to be improved

`{TARGET PROMPT}`
</details>

The result is also placed in the [MetaPromptTemplate] file.

---

### Extending / reverse engineering data application

Now this template can be used to generate improved prompts and, in fact, other prompt templates for specific tasks.

Given the model [problem #2][], I might want to do some programmatic manipulations involving the `*.asy` files containing text-based description of graphical primitives (such as lines and rectangles), representing a SPICE circuit element (resistor, capacitor, etc.). This file format can viewed in a text editor and has a fairly simple format. My initial approach was to decode the file format manually, create a detailed description of the file format in technical, but natural language, feed this description to ChatGPT and ask it to generate appropriate code. I realized later that this approach was not optimal, but here is the [source of the conversation][Graphical Primitives Design]. The code generation matter is actually beyond the current subject, but the actual focus is on the preparatory steps.

Basically, to generate certain code with ChatGPT, one generally needs to provide some kind of specification / description of the desired code. Preparing such a description is probably a fairly time consuming task as well. Here is an idea: assuming the authors of LTspice did not try to obfuscate the file format (which they did not), its format should be fairly intuitive, given the generic task of storing basic vector representation of graphical primitives. As it turned out, this idea is true, but, what is more important, these "intuition" is accessible to ChatGPT as well (sort of, but for the purposes of such data problems, let's just say that ChatGPT may possess / exhibit certain intuition).

But first things first: I needed to start somewhere. So I came up with the following ChatGPT prompt:

```
Teach me how to generate templates that describe the structure of my data. Both data and templates describing the data will be part of ChatGPT input. These templates need to help ChatGPT interpret the data, minimize ambiguities, and facilitate subsequent analysis / processing / transformation of data.
```

First, this prompt did not include any problem-specific information at all. Instead, it identified a class of data focused reverse engineering problems. Second, I did not attempt to elaborate even on the generic problem. I simply described the concept and wanted to have ChatGPT start contributing very early. Now, rather than submitting this prompt to ChatGPT directly, I added it as the target 


<!-- References -->

[MetaPromptTemplate]: https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Technical/MetaPromptTemplate.md
[problem #2]: https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/README.md#2-ltspice-symbol-and-circuit-parsers
[Graphical Primitives Design]: https://chatgpt.com/share/676feb60-7df8-8004-b9e2-953d9b14f7c6