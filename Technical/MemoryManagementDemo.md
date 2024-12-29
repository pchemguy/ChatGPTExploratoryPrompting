# Memory Management Demo

The [Memory Management][] section of the README.md file discusses the two main components of ChatGPT memory. Let's do a practical memory management tutorial. For the duration of this tutorial, I will use  

```markdown
CODE BLOCKS
```

to indicate ChatGPT prompts, unless explicitly stated otherwise.

## Key prompts and prompt templates

**Persistent memory status**

```markdown
Is persistent memory on?
```

**Memory management in chat**

```markdown
Teach me about persistent memory and temporary context. Provide me detailed instructions on how I can manage both directly in chat and notify me of any prerequisites.
```

```markdown
Show me persistent memory and explain how I can modify it
```  
 
```markdown
Show me the temporary context for this chat and explain how I can modify it
```  

> [!IMPORTANT]
> Key information users need to know to achieve their goal.

**Check memory for specific instructions**

```markdown
Is the following concept set in persistent memory or temporary context?

Concept: {CONCEPT}
```

```markdown
Are the following instructions set in persistent memory or temporary context?  

Instructions: {INSTRUCTIONS}
```

```markdown
Tell me about my current preferences regarding {PREFERENCE TARGET}. Indicate where the preferences are stored, if any.
```

Examples:

```markdown
Are the following instructions set in persistent memory or temporary context?  

Instructions: Use Markdown-formatted input/output by default.
```

```markdown
Is the following concept set in persistent memory or temporary context?

Concept: Default input/output format.
```

```markdown
Tell me about my current preferences regarding default input/output format. Indicate where the preferences are stored, if any.
```

## Tutorial

### 1. Start a new chat/conversation

This step is important! It aims to maximize reproducibility of responses when compared to responses provided in this tutorial. Do not use an existent chat!

### 2. Verify that persistent memory is enabled

```
Is persistent memory on? Provide detailed instructions on how I can change this settings. Also include information on relevant ChatGPT instructions to control the status of persistent memory directly in chat.
```

 Make sure that the answer is affirmative. Once I suddenly received a negative answer in a new conversation even though the setting was in fact turned on. That response was consistent within the conversation, so I had to ditch it and start a new one to fix the issue. If the setting has not been enable, enable it for the duration of this tutorial and disable it afterwards, if so desired.

### 3. Check and set input/output format preferences



<!-- References -->

[Memory Management]: https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/README.md#memory-management