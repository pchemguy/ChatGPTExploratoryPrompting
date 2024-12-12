# Repo Conventions

## GPT Model

The GPT-4o model is used as the base model for the purpose of this repository (pchemguy/ChatGPTPromptEngineering).

## Sample Prompts and Answers

By default, I will not provide answers to presented sample prompts. Note, to get answers not influenced by conversational context, it might be a good idea to ask them in new chats or chats with little history.

# Answer Contexts and Sources

The original training data is the primary resource used by ChatGPT to answer the questions, but it is important to understand what other sources shape the answers.

1. Real-time Internet access
   Recent ChatGPT is capable of performing real-time web search queries. The retrieved information is then incorporated into the answer. Note that the free plan provides limited access to this feature. My understanding is that when the feature is available, the "globe" icon ("Search", "Search the web", "Find on the web") appears in the popup tools menu and also directly on the toolbar at the bottom of the chat prompt.
2. Local conversational context
   ChatGPT remembers previous questions and answers in the current conversation and uses this information to shape the following answers. When a new conversation is started via the "New Chat" button, the current conversation context should be empty.
3. Global context
   Until recently, I have not realized that there is also the global context, which applies across conversations.

Let us now discuss a few prompts that take advantage of these features or provide insights about applicable contexts.

## Introspection Queries


<details open>
 
 <summary>Hello</summary>

```python
  import os
  ```
  World!
  
</details>


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