# Memory Management Demo

The [Memory Management][] section of the README.md file discusses the two main components of ChatGPT memory. Let's do a practical memory management tutorial. For the duration of this tutorial, I will use  

```
CODE BLOCKS
```

to indicate ChatGPT prompts, unless explicitly stated otherwise.

> [!WARNING]
> **This tutorial changes/resets SQL code generation preferences stored in persistent memory for demonstration purposes. I am not aware of any reliable means to save/restore persistent memory state, so if this preference is important and used/set, consider whether you want to proceed.**

## Key prompts and prompt templates

### Persistent memory status

```
Is persistent memory on?
```

### Memory management in chat

```
Teach me about persistent memory and temporary context.
Provide me detailed instructions on how I can manage both directly in chat and notify me of any prerequisites.
```

```
Show me persistent memory and explain how I can modify it
```  
 
```
Show me the temporary context for this chat and explain how I can modify it
```  

> [!IMPORTANT]
>In case of conflict, preferences stored in temporary context take precedence over persistent memory.

```
Save instructions to persistent memory.

Instructions: {INSTRUCTIONS}
```

```
Add preferences to temporary context.

Preferences: {PREFERENCES}
```

**Examples:**

```
Save instructions to persistent memory.

Instructions: assume that any prompts may be Markdown-formatted; use Markdown-formatted output by default.
```

```
Add preferences to temporary context.

Preferences: assume that any prompts may be Markdown-formatted; use Markdown-formatted output by default.
```

### Check memory for specific instructions

```
Is the following concept set in persistent memory or temporary context?

Concept: {CONCEPT}
```

```
Are the following instructions set in persistent memory or temporary context?  

Instructions: {INSTRUCTIONS}
```

```
Tell me about my current preferences regarding
{PREFERENCE TARGET}.
Indicate where the preferences are stored, if any.
In case of conflict, indicated the prevailing preference.
```

**Examples:**

```
Are the following instructions set in persistent memory or temporary context?  

Instructions: Use Markdown-formatted input/output by default.
```

```
Is the following concept set in persistent memory or temporary context?

Concept: Default input/output format.
```

```
Tell me about my current preferences regarding
default input/output format.
Indicate where the preferences are stored, if any.
In case of conflict, indicated the prevailing preference.
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

I do not know how important this preference is (maybe, this behavior is used by default) so I just keep it.

```
Tell me about my current preferences regarding
default input/output format.
Indicate where the preferences are stored, if any.
In case of conflict, indicated the prevailing preference.
```

 The goal is to set Markdown format as the default preference. For the purpose of this tutorial, this preference can be set in either permanent memory (this is what I have) or temporary context. _After executing one of the following prompts, verify the preference using the previous prompt._ For example:

```
Save instructions to persistent memory.
Instructions: assume that any prompts may be Markdown-formatted; use Markdown-formatted output by default.
```

or

```
Add preferences to temporary context.
Preferences: assume that any prompts may be Markdown-formatted; use Markdown-formatted output by default.
```

### 4. Check and set input/output format preferences

<!-- References -->

[Memory Management]: https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/README.md#memory-management