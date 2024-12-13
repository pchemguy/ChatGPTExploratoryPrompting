# Iterative text improvement example - memory context

Here is a brief example of iterative improvement of a short text section. I started a new ChatGPT chat and loaded the "Writing Style Guidelines". When the search feature is available, instructions can be loaded directly from a raw file on the web with the following prompt:

```
Load instructions from https://raw.githubusercontent.com/pchemguy/ChatGPTPromptEngineering/refs/heads/main/Writing/WritingStyleGuidelines.md
```

<details open>
<summary><b>ChatGPT answer</b></summary>
> I have loaded the Writing Style Guidelines from the provided URL. These guidelines emphasize formal language, consistent terminology, clear sentence and paragraph structures, and overall coherence and precision in technical and business texts. I will adhere to these standards in our ongoing conversation.
</details>

Then I asked ChatGPT to review a text (which implied improvement of the text accord):

```
Review the text

The original training data is the primary resource used by ChatGPT to answer the questions, but it is important to understand what other sources shape the answers.

1. Real-time Internet access
   Recent ChatGPT is capable of performing real-time web search queries. The retrieved information is then incorporated into the answer. Note that the free plan provides limited access to this feature. My understanding is that when the feature is available, the "globe" icon ("Search", "Search the web", "Find on the web") appears in the popup tools menu and also directly on the toolbar at the bottom of the chat prompt.
2. Memory context
    * Local conversational context ("temporary context")
       ChatGPT remembers previous questions and answers in the current conversation and uses this information to shape the following answers. When a new conversation is started via the "New Chat" button, the current conversation context should be empty.
    * Global context ("model set context" or "persistent context")
       This context is build up based on all conversations and is applied to all conversations.
```

<details>
<summary><b>ChatGPT answer</b></summary>

Here’s a revised version of your text with improved clarity, grammar, and consistency:

---

The original training data serves as the primary resource for ChatGPT to answer questions. However, it is important to understand the other sources that shape its responses:

1. **Real-Time Internet Access**  
   Recent versions of ChatGPT can perform real-time web searches. The retrieved information is then incorporated into the answers. Note that the free plan offers limited access to this feature. When the feature is available, a "globe" icon (labeled as "Search," "Search the web," or "Find on the web") appears in the popup tools menu and on the toolbar at the bottom of the chat prompt.

2. **Memory Context**  
   - **Local Conversational Context ("Temporary Context")**  
     ChatGPT retains memory of previous questions and answers within the current conversation. This information shapes subsequent responses. When a new conversation is initiated via the "New Chat" button, the temporary context is cleared.  
   - **Global Context ("Model Set Context" or "Persistent Context")**  
     This context is built up over all conversations and is applied universally across sessions.  

---

### Key Improvements:
1. **Grammar and Style**: Reworded for smoothness and clarity, avoiding redundancies and enhancing readability.
2. **Consistency**: Used uniform formatting for terms and emphasized distinctions between local and global contexts.
3. **Precision**: Clarified that "temporary context" is cleared with "New Chat" and defined where icons are visible.

Let me know if you'd like further adjustments!

</details>