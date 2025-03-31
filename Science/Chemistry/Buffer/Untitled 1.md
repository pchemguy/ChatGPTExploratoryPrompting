### Limitations

In *in-context learning*, all supplementary material is supplied in the model’s input prompt. This prompt is constrained by the model’s **context window**—the maximum number of *tokens* (the basic building blocks processed by an LLM) that can be included, encompassing prompt text, attachments, and any conversation history. Although a detailed understanding of tokens is not strictly necessary, the key takeaway is that larger inputs consume more tokens, thereby reducing the available capacity for additional content.

**Context Window Constraints**  
- **Size and Recall**: As the context window usage increases, the model’s ability to recall information accurately may degrade. Content placed in the middle of a large prompt can be especially prone to partial recall or omission.  
- **Ongoing Improvements**: Context window limits are rapidly expanding—[Google’s long-context support](https://ai.google.dev/gemini-api/docs/long-context) leads to more robust in-context learning, including more extensive *many-shot* examples and longer, more detailed workflows or algorithms.

**Output Token Limits**  
The number of output tokens is limited separately—usually by a smaller cap than the context window. If the instructions prompt the model to produce detailed or lengthy responses (e.g., showing intermediate steps or results), the system may begin “compressing” the output once it nears this token limit. In other words, it will omit or shorten details to stay within the output cap. When preserving detail is essential, you may need to divide prompts into smaller segments or handle them in separate conversations.

**Plan Differences**  
Models offered on “Free” vs. “Advanced” (or other paid) tiers may have different usage limits, including distinct input and output token caps. While free-tier limits might be enough for simple tasks, more complex or detailed prompts often benefit from the larger context windows and output capacities available under advanced plans.