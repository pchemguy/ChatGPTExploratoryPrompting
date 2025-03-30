# Technical Aspects of LLM

Generally available Large Language Models (LLMs), such as OpenAI $\mathrm{GPT_{x}/o_{x}}$ or Google Gemini family are rapidly evolving, but they still possess limited ability to solve complex domain-specific research and engineering problems. Generally, solving such problems involves
 - facts (e.g., relevant chemical or physical properties of involved materials)
 - workflows/algorithms (e.g., algorithm of balancing chemical redox reactions)
 - execution of multistep solution processes 

The ability to execute multistep solution processes has greatly increased with introduction of "reasoning/thinking" models. Reasoning models generally possess the same knowledge about world as their non-reasoning counterparts, but have been additionally trained/fine-tuned to simulate reasoning processes. The first two bullets above are related to knowledge gaps in model training data and need to be addressed separately.

Several approaches may be applied to compensate for knowledge gaps and improve handling of complex multistep workflows. The most radical approach - training a new model from scratch for a particular knowledge domain (e.g., chemistry or biology) or type of task (music OCR, chemical reaction extraction from manuscripts, etc.). This approach involves the most complicated/costly process that, in principle, provides the greatest flexibility. Fine-tuning pretrained models is a simpler alternative that still necessitates specialized expertise and possessing, at present, a number of other limitations. The simplest (in a sense) in-context learning addresses knowledge gaps by providing additional information via the model's prompt. This approach is the most universal as it does not involve any manipulations with the model, so it can be used with virtually any generally available model (including frontier proprietary models available via official chatbots and APIs).

## In-context learning

[In-context learning](https://en.wikipedia.org/wiki/Prompt_engineering#In-context_learning) focuses primarily on [prompt engineering](https://en.wikipedia.org/wiki/Prompt_engineering) and relies on model's *context*. The context feature, which is essentially a model's working memory, makes it possible for a model to remember previous messages that are part of the same conversation. With additional [meta-learning](https://en.wikipedia.org/wiki/Meta-learning_(computer_science)) (learning to learn) training, models become capable of using their working memory content together with training-based knowledge when generating responses, thus enabling meaningful conversations. Importantly, in-context learning also enables special prompting techniques developed to extend model's abilities to solve complex problems with limited-to-no relevant material in model's training data.

The extra learning/training material may
- be provided to the model
    - directly as part of a prompt
    - in attached files
    - as part of the special instructions feature where available.
- include
    - facts
    - processing/transformation examples
    - descriptions of workflows/algorithms
    - special instructions
- focus on
    - input context (e.g., chemical properties of reagents, description and/or examples of input format/structure)
    - transformation context (e.g., description of a desired workflow/algorithm that should be followed for generating the response)
    - output context (e.g., style guidelines or format, such as plain text / bulleted list / structured CSV format)

### Input context

Input context provides extra information about the "starting point" of the problem. Examples of such extras may include
- physical and/or chemical properties of reagents
    - **format:** plaint text, bulleted lists, JSON, CSV, etc.
    - **problem example:** analysis of potential chemical reactions for a given set of reagents
- description of input format
    - **format:** plain text description, bulleted lists, JSON schema, etc.
    - **problem example:** creation (reverse engineering) of a Python class module to represent serialized data
- sample input files
    - **format:** plain text files containing serialized objects supplied as prompt attachments or via copy/paste as part of the prompt text.
    - **problem:** creation of a Python class that should represent graphical primitives used for rendering SPICE circuit element symbols.
[Retrieval Augmented Generation](https://en.wikipedia.org/wiki/Retrieval-augmented_generation) (RAG) is a family of advanced techniques for supplying input context. These techniques typically necessitate additional software tools and programmatic access via model's APIs.

### Output context

Output context may prescribe what specific information should be included in the output and how it should be organized. For example, it may be desired that generated text followed a particular [language style](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Writing/WritingStyleGuidelines.md) or generated code followed a particular [coding style](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Code/Python/PythonStyleGuidelines.md)

### Transformation context
 
For ordinary uses, it is common to define a problem for LLM and let it generate a solution without any instruction as to how to arrive at it.

**Complex workflows/algorithms handling.** Two common prompt engineering techniques used to improve handling of complex tasks are hierarchical decomposition and [Chain-of-Thought][https://en.wikipedia.org/wiki/Prompt_engineering#Chain-of-thought] (CoT). The former approach focus on splitting a complex problem into a series of simpler steps. These steps may be provided to the model as separate prompts or combined into a structured sequence of steps with emphasis on explicit demonstration of all intermediate work (CoT). For example, this [prompt template](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Science/Chemistry/ChemicalReactionAnalysis.md) provides a structured step-by-step workflow guide to the model, instructing it to perform a chemical process analysis in a particular way.

**Follow my examples.** One-shot/single-shot and few-shot/multi-shot prompting techniques rely on providing to the model one or several examples, each consisting with sample input and associated desired output pairs. By extension, many-shot approach may involve a substantially larger set of examples, compared to few-shot. The number of examples that can be provided depend on the availability of examples, but also on context window length (mentioned below), as each example takes up a certain amount of model's "working" memory.

The main advantage of in-context learning techniques is that they can be used with any leading LLM chatbot, because contextual memory is a *de-facto* standard feature. One of the important limitations of in-context learning is the size of available "working" memory (context window length or input tokens limit). In practice, models may not be able to use the full specified context window, as the quality of recalling may degrade as context usage becomes a large fraction of the maximum limit size. Also, quality of recalling of material placed in the middle may be lower than for beginning and end. Context window limit is rapidly improving (with [Google leading the way](https://ai.google.dev/gemini-api/docs/long-context)), enabling more elaborate in-context learning. 

Speaking of critical limits, output token limit is another essential characteristic. The output token limit is usually much smaller than the input token limit (specific information may not be easily accessible). There is an important consequence of this characteristic in present context. When taking advantage of large input token limit, the input may contain information that does not have a significant affect on the output size  (e.g., we can defined detailed stylistic guidelines for [English](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Writing/WritingStyleGuidelines.md) or [Python](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Code/Python/PythonStyleGuidelines.md) ), 

Explicit description of specific workflows/algorithms may be provided to the model even when the model might be able to produce some kind of solution without additional specific instructions. 


- Chain-of-Thought and Hierarchical decomposition approaches to handling complex tasks with limited to no relevant training data available for training foundation models.
- non-reasoning vs. reasoning vs. deep research for complex tasks (such as deep analysis of academic publications)
- fine-tuning vs. in-context learning
- 
- context size limit, tokens, output token limit
- free vs. subscriptions based plans:
    - models not available on free plan or available with significantly reduced input/output token limits
    - privacy considerations (user data being used for model training on free plan vs. promise not use it on subscription-based plans)
- importance of large input context for many-shot learning

Disclaimer: Humans can also be inaccurate.

https://ai.google.dev/gemini-api/docs/long-context#:~:text=Many%2Dshot%20in%2Dcontext%20learning