# ChatGPT Tutorial

In this repository, I share my beginner's experience exploring features of ChatGPT and the associated workflows. Whenever ChatGPT answers are provided, the GPT-4o model should be assumed. The topics of interest include
* technical and business writing assistance
* coding assistance
* persistent context
* project development strategies

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
I have a section from the writing style guidelines and need three defective examples for each bullet point, along with their corresponding corrected versions.

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

## 2. Coding assistance

**TODO**

## 3. Technical aspects and workflows

While ChatGPT is probably developed as a conversational tool that should be easily accessible to beginners, learning certain technical aspects definitely improves the results, as evidenced by the emergence of the prompt engineering field.

### Prompt engineering

Here are a few sample prompts to get learning assistance from ChatGPT.

#### Q: I want to improve my prompt engineering skills. Can you help with it?

<details>
<summary><b>ChatGPT Answer</b></summary>

&nbsp;  
Absolutely! I'd love to help you improve your prompt engineering skills. Here’s how we can approach it:

##### 1. **Understanding Your Goals**

- What do you primarily want to use prompt engineering for? (e.g., writing, coding, art generation, data extraction, problem-solving)
- Are you focusing on a particular AI model or platform, like ChatGPT, DALL·E, or others?

##### 2. **Core Concepts of Prompt Engineering**

- **Clarity:** Making your prompt clear and specific.
- **Context:** Providing relevant information or examples.
- **Constraints:** Setting limits for the response (e.g., word count, tone, format).
- **Iteration:** Refining prompts through trial and error.

##### 3. **Hands-On Practice**

We can practice creating prompts together and refining them. You can:

- Share a task or scenario, and I’ll help you craft an effective prompt.
- Analyze your prompts for improvement.
- Explore different prompt structures and techniques.

What would you like to start with?
</details>

#### Q: I would like to focus on the ChatGPT platform.

<details>
<summary><b>ChatGPT Answer</b></summary>

&nbsp;  
Great choice! ChatGPT is a versatile platform, and mastering prompt engineering here can unlock a wide range of possibilities. Here's a roadmap tailored for ChatGPT:

---

##### **I. Foundations of Prompt Engineering for ChatGPT**

1. **Prompt Structure**
    
    - **Instruction-based:** "Explain [concept] in simple terms."
    - **Context-driven:** "You are a [role]. Provide advice on [topic]."
    - **Constraints-focused:** "Summarize [text] in 50 words."
2. **Key Techniques**
    
    - **Role Assignment:** Define a role for the model.  
        _Example:_ “You are a coding expert helping a beginner.”
    - **Step-by-Step Instructions:** Break down complex tasks into smaller steps.  
        _Example:_ “List 3 ideas, then explain each in detail.”
    - **Use Placeholders:** Indicate where input/output should go.  
        _Example:_ “Generate a story about [character] in [setting].”

---

##### **II. Intermediate Skills**

1. **Iterative Prompting**  
    _Example:_
    
    - **Initial Prompt:** “Summarize this text.”
    - **Follow-up:** “Make it more concise.”
    - **Further Refinement:** “Now in a professional tone.”
2. **Chaining Prompts**  
    Use the output of one prompt as the input for the next.  
    _Example:_
    
    1. “Generate a list of project ideas.”
    2. “Now expand on idea #2.”
3. **Leveraging System Messages**  
    _Example:_
    
    - **System Message:** “You are a formal technical assistant.”
    - **User Prompt:** “Explain how quantum computing works.”

---

##### **III. Advanced Techniques**

1. **Prompt Optimization**  
    Test different variations of prompts to improve output quality:
    
    - Add or remove context.
    - Use different tones or levels of detail.
2. **Multi-Turn Conversations**  
    Manage complex tasks across multiple interactions:
    
    - “Track our conversation history and summarize key points so far.”
3. **Handling Ambiguity**  
    Teach ChatGPT how to ask clarifying questions:
    
    - “If the input is unclear, ask for clarification before proceeding.”

---

Would you like to dive into a specific technique, or do you have a particular scenario you want to practice with?
</details>

#### Q: What is the best way to indicate that a particular input constitutes a set of instructions, such as context specification?

<details>
<summary><b>ChatGPT Answer</b></summary>

&nbsp;The best way to indicate that an input constitutes a **set of instructions**—especially for context specification in ChatGPT—is to structure it clearly and explicitly. Here are some effective strategies:

---

##### **1. Use Delimiters to Isolate Instructions**
Delimiters like quotes, triple backticks, or brackets clearly separate instructions from other input.  
**Example:**
```
Instructions:  
"You are a travel guide. Provide recommendations for a week-long trip to Japan."
```

**Or**  
```
##### Instructions ###
You are a financial analyst. Provide insights on investment strategies for beginners.
```

---

##### **2. Provide Explicit Labels**
Label sections clearly, such as **Context**, **Instructions**, or **Task**. This ensures the model understands the function of each part.  
**Example:**
```
Context: You are a friendly customer service chatbot.  
Task: Answer the following question in a helpful and polite tone.
```

---

##### **3. Use System Messages (For API or Chat)**
In platforms like ChatGPT, **system messages** define context clearly. Although not visible to all users in the UI, they are essential in API interactions.  
**Example (if coding):**
```json
{
  "role": "system",
  "content": "You are a helpful tutor specializing in math."
}
```

In the UI:
```
System Message: You are a financial assistant providing personal finance advice.
```

---

##### **4. Number or Bullet Instructions**  
This helps in multi-step tasks where instructions need to be followed sequentially.  
**Example:**
```
Follow these instructions:
1. Provide a list of healthy recipes.
2. Explain the nutritional benefits of each recipe.
3. Suggest variations for vegetarian diets.
```

---

##### **5. State the Instruction Role Explicitly**
Begin with a phrase like:  
- "Act as..."  
- "You are tasked with..."  
- "Follow the context below."

**Example:**  
"Act as a project manager. Your task is to create a timeline for a website development project."

---

##### **Putting It All Together**
Here's a comprehensive structure:  
```
### Context ###
You are a language tutor helping a student learn French.

### Instructions ###
1. Provide 5 common French phrases for beginners.
2. Include pronunciation tips.
3. Offer cultural context where relevant.
```

This method ensures clarity, minimizes ambiguity, and sets the model up for success.

---

Would you like to experiment with a specific prompt structure to see how it works in practice?  
</details>


Model context
Divide and conquer
Iterative focused refinement
Technical aspects for tailoring answers


<!-- References -->

[WritingStyleGuidelines]: https://raw.githubusercontent.com/pchemguy/ChatGPTPromptEngineering/refs/heads/main/Writing/WritingStyleGuidelines.md
[WritingContext]: https://raw.githubusercontent.com/pchemguy/ChatGPTPromptEngineering/refs/heads/main/Writing/WritingContext.md

