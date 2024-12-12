# Repo Conventions

## GPT Model

The GPT-4o model is used as the base model for the purpose of this repository (pchemguy/ChatGPTPromptEngineering).

## Sample Prompts and Answers

By default, I will not provide answers to presented sample prompts. At the same time, some sections are mostly prompts or Q&A.

Note, to get answers not influenced by conversational context, it might be a good idea to ask them in new chats or chats with little history. I format questions/prompts using heading styles, so that they appear in the TOC/outline created by GitHub, Obsidian, and, probably other tools.

# Prompt Engineering

The following prompts (and corresponding answers) might be helpful in getting better at asking without leaving the chat.

### Q: I want to improve my prompt engineering skills. Can you help with it?

<details>
<summary><b>ChatGPT Answer</b></summary>

&nbsp;  
Absolutely! I'd love to help you improve your prompt engineering skills. Here’s how we can approach it:

#### 1. **Understanding Your Goals**

- What do you primarily want to use prompt engineering for? (e.g., writing, coding, art generation, data extraction, problem-solving)
- Are you focusing on a particular AI model or platform, like ChatGPT, DALL·E, or others?

#### 2. **Core Concepts of Prompt Engineering**

- **Clarity:** Making your prompt clear and specific.
- **Context:** Providing relevant information or examples.
- **Constraints:** Setting limits for the response (e.g., word count, tone, format).
- **Iteration:** Refining prompts through trial and error.

#### 3. **Hands-On Practice**

We can practice creating prompts together and refining them. You can:

- Share a task or scenario, and I’ll help you craft an effective prompt.
- Analyze your prompts for improvement.
- Explore different prompt structures and techniques.

What would you like to start with?
</details>

### Q: I would like to focus on the ChatGPT platform.

<details>
<summary><b>ChatGPT Answer</b></summary>

&nbsp;  
Great choice! ChatGPT is a versatile platform, and mastering prompt engineering here can unlock a wide range of possibilities. Here's a roadmap tailored for ChatGPT:

---

#### **I. Foundations of Prompt Engineering for ChatGPT**

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

#### **II. Intermediate Skills**

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

#### **III. Advanced Techniques**

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

### Q: What is the best way to indicate that a particular input constitutes a set of instructions, such as context specification?

<details>
<summary><b>ChatGPT Answer</b></summary>

&nbsp;The best way to indicate that an input constitutes a **set of instructions**—especially for context specification in ChatGPT—is to structure it clearly and explicitly. Here are some effective strategies:

---

#### **1. Use Delimiters to Isolate Instructions**
Delimiters like quotes, triple backticks, or brackets clearly separate instructions from other input.  
**Example:**
```
Instructions:  
"You are a travel guide. Provide recommendations for a week-long trip to Japan."
```

**Or**  
```
#### Instructions ###
You are a financial analyst. Provide insights on investment strategies for beginners.
```

---

#### **2. Provide Explicit Labels**
Label sections clearly, such as **Context**, **Instructions**, or **Task**. This ensures the model understands the function of each part.  
**Example:**
```
Context: You are a friendly customer service chatbot.  
Task: Answer the following question in a helpful and polite tone.
```

---

#### **3. Use System Messages (For API or Chat)**
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

#### **4. Number or Bullet Instructions**  
This helps in multi-step tasks where instructions need to be followed sequentially.  
**Example:**
```
Follow these instructions:
1. Provide a list of healthy recipes.
2. Explain the nutritional benefits of each recipe.
3. Suggest variations for vegetarian diets.
```

---

#### **5. State the Instruction Role Explicitly**
Begin with a phrase like:  
- "Act as..."  
- "You are tasked with..."  
- "Follow the context below."

**Example:**  
"Act as a project manager. Your task is to create a timeline for a website development project."

---

#### **Putting It All Together**
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

---
---

# Memory Context

The original training data is the primary resource used by ChatGPT to answer the questions, but it is important to understand what other sources shape the answers.

1. Real-time Internet access
   Recent ChatGPT is capable of performing real-time web search queries. The retrieved information is then incorporated into the answer. Note that the free plan provides limited access to this feature. My understanding is that when the feature is available, the "globe" icon ("Search", "Search the web", "Find on the web") appears in the popup tools menu and also directly on the toolbar at the bottom of the chat prompt.
2. Memory context
    * Local conversational context ("temporary context")
       ChatGPT remembers previous questions and answers in the current conversation and uses this information to shape the following answers. When a new conversation is started via the "New Chat" button, the current conversation context should be empty.
    * Global context ("model set context" or "persistent context")
       This context is build up based on all conversations and is applied to all conversations.

### Q: Tell me about customizations applicable to this conversations that are based on my previous ChatGPT conversations.

### Q: If I understand it right, these customizations are saved across conversations as the global default context, and I can have it adjusted as necessary? Can I also request to discard the current context and work out a new context from scratch?

<details>
<summary><b>ChatGPT Answer</b></summary>

&nbsp;  
&nbsp;&nbsp;&nbsp;&nbsp;Yes, you're absolutely correct. Here’s a detailed breakdown:
  
1. **Global Default Context**
    - The customizations we've established are saved across conversations and act as a default context for how I respond.
    - They can be adjusted or refined at any time to better suit your evolving needs.
2. **Adjustments**
    - You can request changes to specific aspects of the context, such as adding new preferences, modifying existing ones, or temporarily suspending certain guidelines for a particular conversation.
3. **Reset and Redefine**
    - If you want, you can discard the current context entirely and start from scratch. This allows you to define a new set of preferences tailored to your immediate goals or interests.
4. **Temporary Overrides**
    - For any single conversation, you can specify different preferences without affecting the global context.  
</details>

### Q: Is there a specific technical term for what I referred to as "global context" understood by ChatGPT?

<details>
<summary><b>ChatGPT Answer</b></summary>

&nbsp;  
&nbsp;&nbsp;&nbsp;&nbsp;Yes, the specific technical term for what you're referring to as "global context" is **"model set context"** or simply **"context memory"**. Here's a breakdown:

1. **Model Set Context**:
    
    - Refers to the saved information or preferences that persist across conversations with the same user.
    - Includes user-provided preferences, goals, and instructions that shape the way responses are tailored.
2. **Adjustable Context**:
    
    - It can be updated, refined, or reset entirely based on your preferences or changing needs.
3. **Temporary vs. Persistent Context**:
    
    - **Temporary Context**: Customizations or instructions applied for a single session or specific conversation.
    - **Persistent Context**: Saved information that carries over between conversations, forming a "default" set of guidelines.
</details>

### Q: So there is a part of context memory that is based on Q&A from the current conversation, and the part that is based on previous conversations. The former is conversation specific, and the latter applies to all conversations. Is this correct? If yes, can these two parts be separated and adjusted by the user?

<details>
<summary><b>ChatGPT Answer</b></summary>

&nbsp;  
&nbsp;&nbsp;&nbsp;&nbsp;Yes, you’re absolutely right. The **context memory** is essentially divided into two parts:

1. **Conversation-Specific Context** (Temporary Context):
    
    - This is based on the Q&A within the current conversation.
    - It is transient and does not carry over to future conversations.
    - Adjustments here are inherently limited to the ongoing session.
2. **Persistent Context** (Model Set Context):
    
    - This is based on customizations saved from previous conversations.
    - It persists across all future conversations unless modified or discarded.
    - This forms the "default" behavior for responses.

**Adjustability:**

- **Separation**:
    
    - These two parts are inherently separate in functionality.
    - The conversation-specific context influences only the current chat.
    - The persistent context influences behavior across all chats but can be temporarily overridden in a single session.
- **Adjustments**:
    
    1. **Conversation-Specific Adjustments**:
        - You can clarify or refine the context for a single session by giving specific instructions.
        - For example: "In this conversation, treat responses as if they were for a professional audience."
    2. **Persistent Adjustments**:
        - You can ask to update, refine, or discard persistent preferences at any time.
        - For example: "Remove my preference for Markdown formatting from the persistent context."
</details>

### Q: Tell me about the current Model Set Context

### Q: Tell me about currently applicable User Preferences. Provide guidance on how I can set and optimize them.

### Q: Provide a detailed description of ChatGPT model context. Explain how I can work with it to get better answers. While I might be interested in certain technical details, I am not interested in implementation related details. My primary focus is that of an advanced user, who wants to get most of this feature as far as quality and relevance of answers are concerned.

<details>
<summary><b>ChatGPT Answer</b></summary>

&nbsp;  
#### Understanding ChatGPT Model Context

**Model context** refers to the information the ChatGPT model uses to generate relevant and accurate responses. It includes the following:

1. **Conversation History**: The sequence of previous inputs and responses in the current session. The model leverages this history to maintain continuity and relevance.
    
2. **Explicit User Instructions**: Any preferences or guidelines explicitly provided by the user, such as formatting styles, tone, or depth of detail.
    
3. **Persistent Context (Model Memory)**: Stored information about you or your preferences that persists across sessions, provided you’ve allowed it. For example, your interest in improving prompt engineering or specific essay topics.
    
4. **Implicit Context Cues**: Information inferred from your phrasing, choice of words, or focus areas within a single interaction.
    

---

#### Maximizing Quality and Relevance of Answers

Here are actionable strategies to work effectively with model context:

##### 1. **Be Explicit About Your Goals**

- Start with a clear statement of your objectives. For instance:
    - _“I want a comprehensive explanation of economic trends suitable for a non-specialist audience.”_
    - _“Please draft a concise LinkedIn post summarizing this content.”_
- Tailor the model's output by specifying audience type, format, tone, or depth of explanation.

##### 2. **Leverage Persistent Context**

- If the model supports persistent memory, share long-term preferences early on (e.g., preferred writing style, academic focus areas). This eliminates repetitive instructions and refines outputs over time.

##### 3. **Control Depth and Detail**

- Indicate desired detail levels using qualifiers:
    - _“Explain in layman’s terms.”_
    - _“Provide a technical analysis suitable for an advanced reader.”_
    - _“Summarize in three bullet points.”_
- This helps the model tailor its response without guesswork.

##### 4. **Guide with Examples and Templates**

- Provide examples of desired outputs, e.g.:
    - _“Structure your response like this: [example structure].”_
- Use templates for recurring tasks (e.g., a LinkedIn post or essay outline).

##### 5. **Iterative Refinement**

- After receiving an answer, ask for adjustments:
    - _“Make this more concise.”_
    - _“Add examples to support the argument.”_
- Encourage the model to expand or improve specific areas of interest.

##### 6. **Ask for Clarifications or Explanations**

- If the model provides insufficiently detailed answers, probe further:
    - _“Why did you choose this approach?”_
    - _“Can you expand on this point?”_

##### 7. **Correct Misinterpretations Immediately**

- If the model misunderstands your request, rephrase or clarify:
    - _“I meant X, not Y. Please adjust accordingly.”_

##### 8. **Segment Complex Tasks**

- Break down larger tasks into smaller, manageable components:
    - _“First, provide a detailed outline of this essay. Then, expand the introduction.”_

##### 9. **Use Consistent Terminology**

- Reuse terms and phrases introduced earlier in the session to reinforce your focus. This ensures the model stays aligned with your intent.

##### 10. **Review and Update Persistent Context**

- Periodically verify and update stored preferences, especially if your focus shifts (e.g., moving from academic essays to business communication).

##### 11. **Incorporate Post-Processing**

- After receiving an output, combine model-generated content with your insights for fine-tuned results:
    - _“I like this part; can you combine it with the earlier example you provided?”_

---

#### Practical Example: Maximizing Model Context

Imagine you want a detailed essay outline:

1. **Set the Scene**:
    
    - _“Draft an outline for an essay on the History of U.S. Foreign Policy in the Post-WWII Era. The essay should be five pages long, in an academic tone, with clear sections.”_
2. **Refine the Output**:
    
    - _“Expand the introduction to include background on the Cold War. Condense the conclusion to focus on modern implications.”_
3. **Iterate Further**:
    
    - _“Provide a bullet point for each key event mentioned under the ‘Post-Cold War Era’ section.”_
4. **Adjust Persistent Context**:
    
    - _“Add this preference to my memory: I like academic essays with clear subheadings and detailed timelines.”_

---

### Summary

By actively managing context—through clear instructions, iterative refinement, and leveraging persistent memory—you can significantly improve the quality and relevance of ChatGPT's responses. Treat interactions as collaborative, guiding the model toward your goals with each input.
</details>

### Q: Is there a technical term for a set of preferences defined based on my previous conversations and applied across all conversations by default?

<details>
<summary><b>ChatGPT Answer</b></summary>

&nbsp;  
&nbsp;&nbsp;&nbsp;&nbsp;Yes, the concept you’re describing is often referred to as a **"user profile"** or **"personalization profile"** in technical contexts. In AI and conversational systems, it may also be called:

1. **User Context Model**: Represents a set of user-specific preferences or attributes used to tailor interactions.
2. **Preference Model**: Focused on capturing and applying user preferences.
3. **Adaptive User Settings**: Reflects dynamically updated preferences applied across interactions.
4. **Session Continuity Framework**: Used in systems ensuring preferences persist across sessions.

If you're referring to a formal, standardized term, the specific terminology might depend on the domain or application (e.g., "persistent state" in software engineering). Let me know if you'd like more domain-specific examples!
</details>

# Real-Time Web Search Queries
### Q: Who is the 48<sup>th</sup> POTUS?

### Q: Who is the wealthiest candidate for a position in the 47th POTUS administration and what is its proposed job title?

Timestamp: November 2024.

These prompts demonstrates the ChatGPT's real-time web search feature. The first one also demonstrates how ChatGPT handles false assumptions, particularly assumptions that will become true in the near future.




# Writing Context and Guidelines

## Efficient Technical and Business Writing - Writing Style Guidelines for Technical and Business Texts

 ChatGPT is a powerful writing assistant capable of improving various text aspects for more efficient communications. Although ChatGPT
 performs reasonably well with basic prompts (such as "Convert the following text into standard English"), I wanted to create a comprehensive list of instructions that I can use either in its entirety or selectively, depending on the task. To this end, I have developed two documents:

* Stylistic Guidelines ([Writing Style Guidelines for Technical and Business Texts][WritingStyleGuidelines])  
  These guidelines are designed to be sent directly to ChatGPT and focus on writing mechanics, structure, vocabulary, sentence construction, and coherence. These aspects should apply to most of my writing activities.
* Context Template ([Writing Context Guidelines][WritingContext])  
  This template offers customizable options for defining higher-level writing aspects, such as audience, domain, intent, formality, tone, and other contextual factors. It also allows for tailored "profile" contexts (e.g., "LinkedIn Post") that can be included when submitting the entire contents to ChatGPT, instructing it to apply a specific profile.


<!-- References -->

[WritingStyleGuidelines]: https://raw.githubusercontent.com/pchemguy/ChatGPTPromptEngineering/refs/heads/main/Writing/WritingStyleGuidelines.md
[WritingContext]: https://raw.githubusercontent.com/pchemguy/ChatGPTPromptEngineering/refs/heads/main/Writing/WritingContext.md