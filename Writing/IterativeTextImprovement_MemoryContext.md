# Iterative text improvement example - memory context

Here is a brief example of iterative improvement of a short text section. I started a new ChatGPT chat and loaded the "Writing Style Guidelines". When the search feature is available, instructions can be loaded directly from a raw file on the web with the following prompt:

> [!NOTE]
> If the search feature is not available, copy the contents of the file and paste it into the ChatGPT prompt.

**Prompt**

> Load instructions from https://raw.githubusercontent.com/pchemguy/ChatGPTPromptEngineering/refs/heads/main/Writing/WritingStyleGuidelines.md

**Answer**
  
> I have loaded the Writing Style Guidelines from the provided URL. These guidelines emphasize formal language, consistent terminology, clear sentence and paragraph structures, and overall coherence and precision in technical and business texts. I will adhere to these standards in our ongoing conversation.

Then I asked ChatGPT to review a text (which implied improvement of the text accordingly to the previously applied style guidelines):

<details>
<summary><b>Prompt</b></summary>  

> Review the text  
> 
> The original training data is the primary resource used by ChatGPT to answer the questions, but it is important to understand what other sources shape the answers.  
> 
> 1. Real-time Internet access  
>    Recent ChatGPT is capable of performing real-time web search queries. The retrieved information is then incorporated into the answer. Note that the free plan provides limited access to this feature. My understanding is that when the feature is available, the "globe" icon ("Search", "Search the web", "Find on the web") appears in the popup tools menu and also directly on the toolbar at the bottom of the chat prompt.  
> 1. Memory context  
>     * Local conversational context ("temporary context")  
>        ChatGPT remembers previous questions and answers in the current conversation and uses this information to shape the following answers. When a new conversation is started via the "New Chat" button, the current conversation context should be empty.  
>     * Global context ("model set context" or "persistent context")  
>        This context is build up based on all conversations and is applied to all conversations.  

</details>

<details>
<summary><b>ChatGPT answer</b></summary>  

> Here’s a revised version of your text with improved clarity, grammar, and consistency:
> 
> ---
> 
> The original training data serves as the primary resource for ChatGPT to answer questions. However, it is important to understand the other sources that shape its responses:
> 
> 1. **Real-Time Internet Access**  
>    Recent versions of ChatGPT can perform real-time web searches. The retrieved information is then incorporated into the answers. Note that the free plan offers limited access to this feature. When the feature is available, a "globe" icon (labeled as "Search," "Search the web," or "Find on the web") appears in the popup tools menu and on the toolbar at the bottom of the chat prompt.
> 
> 2. **Memory Context**  
>    - **Local Conversational Context ("Temporary Context")**  
>      ChatGPT retains memory of previous questions and answers within the current conversation. This information shapes subsequent responses. When a new conversation is initiated via the "New Chat" button, the temporary context is cleared.  
>    - **Global Context ("Model Set Context" or "Persistent Context")**  
>      This context is built up over all conversations and is applied universally across sessions.  
> 
> ---
> 
> ### Key Improvements:
> 1. **Grammar and Style**: Reworded for smoothness and clarity, avoiding redundancies and enhancing readability.
> 2. **Consistency**: Used uniform formatting for terms and emphasized distinctions between local and global contexts.
> 3. **Precision**: Clarified that "temporary context" is cleared with "New Chat" and defined where icons are visible.
> 
</details>

Finally, I wanted feedback on the contents, so I followed with the prompt:  

**Prompt**

> Now give me feedback on the contents. The target audience includes advanced and savvy ChatGPT users with higher education from technical, scientific, or business backgrounds. This text supposed to tell about the mentioned ChatGPT features to people who probably have never heard about them. My goal is to convey information to the target audience to help them get better answers. The text is introductory and should remain brief. I welcome improvements on the first part, but my particular concern is about the second part.  
   Is it accurate? Should I add something?

<details>
<summary><b>ChatGPT answer</b></summary>  

> Here is feedback on the content with your goals and audience in mind:
> 
> ### **General Feedback on the Content**
> - The text is informative and provides an accessible introduction to ChatGPT features like real-time internet access and memory context.
> - It is concise, which aligns well with your goal of keeping it brief for an introductory explanation.
> - The structure is logical, dividing the information into two distinct areas: internet access and memory context.
> 
> ### **Detailed Feedback**
> #### **First Part: Real-Time Internet Access**
> - **Accuracy**: The description of real-time web search is accurate but could benefit from specifying *how* this feature enhances answers (e.g., incorporating up-to-date or niche information). Advanced users may want to understand its limits (e.g., inability to access subscription-based or restricted content).
> - **Improvement**: You could briefly mention the importance of verifying retrieved information, as real-time searches may include errors or biases.
> - **Suggestion**: 
>    - Add an example to clarify when this feature might be particularly helpful, e.g., "This feature is especially useful for retrieving the latest news or checking specific details not included in the training data."
> 
> #### **Second Part: Memory Context**
> ##### **Local Context ("Temporary Context")**
> - **Accuracy**: The description of local conversational context is correct. Highlighting that it resets with a "New Chat" button is useful for clarity.
> - **Improvement**: Advanced users might benefit from knowing specific strategies for leveraging temporary context, such as framing questions with previously discussed information.
> - **Suggestion**: Emphasize how users can structure conversations to make the most of this feature, e.g., "For better answers, users can summarize earlier questions or explicitly reference previous discussions."
> 
> ##### **Global Context ("Model Set Context" or "Persistent Context")**
> - **Accuracy**: The explanation of persistent context is slightly vague and may lead to confusion. ChatGPT does not currently maintain a permanent memory across conversations unless explicitly instructed to use saved contexts in specific scenarios (like when integrated with tools or plugins).
> - **Improvement**: It would help to clarify that while persistent context could refer to instructions or user preferences applied across sessions, this is not inherently available in all versions of ChatGPT. Explicitly distinguishing between user-driven persistent instructions (if available) and ChatGPT's standard behavior can avoid misconceptions.
> - **Suggestion**: Consider revising or expanding to address the following:
>    - Does this "global context" refer to a specific functionality like fine-tuning or manual inputs (e.g., instructions saved in Pro/Custom versions)?
>    - Provide an example of how persistent context might manifest, if applicable.
> 
> ---
> 
> ### **Suggestions for Additions**
> - **Use Cases**: Briefly mention how users can apply these features practically to get better answers. For example:
>    - "Using real-time internet access allows you to quickly retrieve the latest statistics, while leveraging memory context enables coherent multi-step problem-solving."
> - **Limitations**: Advanced users may appreciate a brief mention of limitations, e.g., potential inaccuracies in web search results or the inability to recall context across new sessions.
> 
> ---
> 
> ### **Revised Second Part**
> Here is a revised version based on your concerns:
> 
> 2. **Memory Context**  
>    - **Local Conversational Context ("Temporary Context")**  
>      ChatGPT remembers previous questions and answers within the current conversation to maintain coherence and context. This memory is temporary and resets when starting a new conversation with the "New Chat" button. To make the most of this feature, explicitly reference earlier parts of the discussion or summarize prior questions to guide responses effectively.  
>    - **Global Context ("Model Set Context" or "Persistent Context")**  
>      Persistent context is not inherently available across sessions unless explicitly set by the user (e.g., with advanced features in certain versions). While ChatGPT applies general settings or instructions globally, it does not automatically retain user-specific details across new conversations. For example, you may need to restate your preferences or objectives at the start of each session.  
> 
> ---
> 
> ### **Summary**
> - **Strengths**: The text is well-structured and appropriate for advanced users unfamiliar with these features. It introduces key concepts effectively.
> - **Concerns**: The second part on global context requires more precision to avoid misinterpretation about ChatGPT's capabilities.
> - **Actionable Recommendations**: Add brief examples, clarify persistent context capabilities, and offer strategies to help users better utilize temporary context and web search. 
> 
</details>
