# Repo Conventions

## GPT Model

The GPT-4o model is used as the base model for the purpose of this repository (pchemguy/ChatGPTPromptEngineering).

## Sample Prompts and Answers

By default, I will not provide answers to presented sample prompts. Note, to get answers not influenced by conversational context, it might be a good idea to ask them in new chats or chats with little history. Note, I format questions/prompts using heading styles, so that they appear in the TOC/outline created by GitHub, Obsidian, and, probably other tools.

# Answer Contexts and Sources

The original training data is the primary resource used by ChatGPT to answer the questions, but it is important to understand what other sources shape the answers.

1. Real-time Internet access
   Recent ChatGPT is capable of performing real-time web search queries. The retrieved information is then incorporated into the answer. Note that the free plan provides limited access to this feature. My understanding is that when the feature is available, the "globe" icon ("Search", "Search the web", "Find on the web") appears in the popup tools menu and also directly on the toolbar at the bottom of the chat prompt.
2. Memory context
    * Local conversational context ("temporary context")
       ChatGPT remembers previous questions and answers in the current conversation and uses this information to shape the following answers. When a new conversation is started via the "New Chat" button, the current conversation context should be empty.
    * Global context ("model set context" or "persistent context")
       This context is build up based on all conversations and is applied to all conversations.

## Introspection Queries - Memory Context

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

A few other sample queries for working with the persistent context.

### Q: Tell me about the current Model Set Context

### Q: Tell me about currently applicable User Preferences. Provide guidance on how I can set and optimize them.

### Q: Provide a detailed description of ChatGPT model context. Explain how I can work with model context to get better answers. While I might be interested in certain technical details, I am not interested in implementation related details. My primary focus is that of an advanced user, who wants to get most of this feature as far as quality and relevance of answers are concerned.

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


---

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

This further exploration provides several candidate term for what I referred as "global context" above.
## Real-Time Web Search Queries
### Q: Who is the 48<sup>th</sup> POTUS?

### Q: Who is the wealthiest candidate for a position in the 47th POTUS administration and what is its proposed job title?

Timestamp: November 2024.

These prompts demonstrates the ChatGPT's real-time web search feature. The first one also demonstrates how ChatGPT handles false assumptions, particularly assumptions that will become true in the near future.

# General Prompting Approaches (the GPT-4o Model)

## Efficient Technical and Business Writing - Writing Style Guidelines for Technical and Business Texts

 ChatGPT is a powerful writing assistant capable of improving various text aspects for more efficient communications. Although ChatGPT
 performs reasonably well with basic prompts (such as "Convert the following text into standard English"), I wanted to create a comprehensive list of instructions that I can use either in its entirety or selectively, depending on the task. To this end, I have developed two documents:

* Stylistic Guidelines ([Writing Style Guidelines for Technical and Business Texts][WritingStyleGuidelines])  
  These guidelines are designed to be sent directly to ChatGPT and focus on writing mechanics, structure, vocabulary, sentence construction, and coherence. These aspects should apply to most of my writing activities.
* Context Template ([Writing Context Guidelines][WritingContext])  


## Load instruction templates from the web




<!-- References -->

[WritingStyleGuidelines]: https://raw.githubusercontent.com/pchemguy/ChatGPTPromptEngineering/refs/heads/main/Writing/WritingStyleGuidelines.md
[WritingContext]: https://raw.githubusercontent.com/pchemguy/ChatGPTPromptEngineering/refs/heads/main/Writing/WritingContext.md