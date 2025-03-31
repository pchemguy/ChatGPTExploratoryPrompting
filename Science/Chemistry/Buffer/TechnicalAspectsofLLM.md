<p align="right">Humans too can be inaccurate...</p>
  
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
See also 

### Output context

Output context may prescribe what specific information should be included in the output and how it should be organized. For example, it may be desired that generated text followed a particular [language style](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Writing/WritingStyleGuidelines.md) or generated code followed a particular [coding style](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Code/Python/PythonStyleGuidelines.md).

### N-shot learning (learning by example)

One-shot/single-shot and few-shot/multi-shot (collectively N-shot) prompting techniques rely on providing to the model one or several examples. An important aspect of these techniques is that the *transformation* process is implicit. A pure few-short learning material does not include any information as to how to transform the input to the desired output. Instead, we rely on the LLM to come up with some kind of transformation based on model's training such that selected transformation satisfies provided learning examples.

N-shot learning material may focus on any constituent: input, transformation, or output. For example, if we want to have plaint text input reformatted as a bulleted list, we may provide several examples, each containing sample text paragraph and associated bulleted list. If we want to generate a code module that follows a particular coding style, we may give several examples of desired output together with a brief plain-text explanation. If we want to reverse engineer a Python class module implementing functionality of an object describing a graphical representation of a SPICE circuit element symbol, we might provide several sample text files containing serialized representation of the target object.

Generally, a larger number of diverse learning examples improves the resulting performance. However, the number of examples may be limited by the *context window length* (see below), as each example takes up a certain amount of model's "working" memory.

### Limitations

In-context learning provides learning material as part of the model input prompt. The amount of information that can be provided as input to an LLM is generally limited by capacity of its "working" memory, and so is the amount learning material. The characteristic that determines the maximum amount of input a model can accept is its *context window length*. This characteristic is typically specified as the maximum number of *input* [*tokens*](https://ai.google.dev/gemini-api/docs/tokens) (elementary chunks of information operated by the LLM). Deep understanding of this concept is probably not essential. It might be sufficient to accept that each piece of input, such as prompt text, any attachments, and previous messages within the same conversations, are somehow transformed into tokens. Generally, the larger the input, the more tokens it consumes. In practice, models may not be able to use the full specified context window, as the quality of recalling may degrade as context usage becomes a large fraction of the maximum limit size. Also, quality of recalling of material placed in the middle may be lower than for beginning and end. Context window limit is rapidly improving (with [Google leading the way](https://ai.google.dev/gemini-api/docs/long-context)), enabling more elaborate in-context learning. 

Long context windows provided by Google enable
- [many-shot in-context learning](https://ai.google.dev/gemini-api/docs/long-context#:~:text=Many%2Dshot%20in%2Dcontext%20learning), which may be considered an extension of the few-shot learning described above
- significantly extended amount of reference/context material
- extended and more elaborate descriptions of workflows/algorithms. 

The maximum number of output tokens is also limited. This characteristic is completely separate form the context window and is usually much smaller than the input token limit. There is an important consequence of this characteristic in present context. When taking advantage of large input token limit, the input may contain instructions that does not have a significant affect on the output size (output token count). For example, we can defined detailed stylistic guidelines for [English](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Writing/WritingStyleGuidelines.md), and these guidelines probably will not inflate the size of output. On the other hand, when the input contains code functionality specification or description of reasoning workflows/algorithms together with request to provide detailed output showing intermediate steps/results, extending such instructions will generally extend the generated output. At a certain point, the model will start compressing the output by dropping pieces/details, which is not something generally desirable, unless a summary is being generated. To preserve the level of details, it will be necessary to split the prompt (and the problem) in parts that will be handled sequentially in separate prompts or, perhaps, even in separate conversations where possible.

Another important consideration may come from the difference between limits on the Free and Advanced plans. While there is a general trend of providing most features even on the Free plan and tracking down ever changing current differences is difficult, the Free plan generally has reduced usage limits. Perhaps more importantly, the Free plan at least used to have a significantly reduced input/output token limits. These reduced limits were plenty for simple tasks, but for complex tasks (and elaborate prompts) the maximum available token limits are highly desirable (IMHO, a must have).

### Transformation context
 
For ordinary uses, it is common to define a problem for LLM and let it generate a solution without any instruction as to how to arrive at it. For more complex tasks, models may not be able to "figure" out a good workflow for solving the problem. Or there might be various approaches to deriving and/or presenting solution candidates, and you might want to steer the model to a particular, say, more rigorous solution, making sure the model does not take any "shortcuts". In such cases, an explicit workflow or algorithm description may substantially improve the quality of produced result.

Two common prompt engineering techniques used for explicit definition of workflows/algorithms are hierarchical decomposition and [Chain-of-Thought][https://en.wikipedia.org/wiki/Prompt_engineering#Chain-of-thought] (CoT). The former approach focuses on splitting a complex problem into a series of simpler steps. These steps may be provided to the model as separate prompts or combined into a structured sequence of steps with emphasis on explicit demonstration of all intermediate work (CoT). For example, this [prompt template](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Science/Chemistry/ChemicalReactionAnalysis.md) provides a structured step-by-step workflow guide to the model, instructing it to perform a chemical process analysis in a particular way.

A unique challenge with developing this part may be in conceptualizing/rationalizing/generalizing often [implicitly](https://en.wikipedia.org/wiki/Tacit_knowledge) followed reasoning workflows. Conventional human education, perhaps, focuses more on learning specific techniques applicable to a certain group of problems. Once a sufficient number of specialized techniques is learned, the student may be able to implicitly classify the problem at hand and consider which technique to apply. This education process is conceptually similar to the N-shot learning above. Even at advanced levels, education largely shifts towards more complex inputs and techniques. Thus, to come up with a sufficiently generic and explicit workflow description of implicit reasoning processes may necessitate some brain straining with [self-relection](https://en.wikipedia.org/wiki/Self-reflection) and trial and error. Perhaps, identifying such implicit complex reasoning processes involved with advanced research tasks and developing a broad repertoire of generalized explicit workflows for specific knowledge domains might be a good research direction even with rapidly improving AI models.

Recently, I have been trying a couple ideas in this direction. The first one is an experimental [prompt template](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Science/Chemistry/ChemicalReactionAnalysis.md) that defines a workflow for analysis of chemical processes. My other more ambitious idea is developing a workflow for analysis of a manuscript on experimental chemistry. A rough stepwise workflow would involve  
- extraction of key experimental results
- extraction of the processes directly involved with each result
- extraction of all reagent / starting materials, catalysts, products / byproducts, associated with each process
- extraction of quantity and composition for each material
- extraction of experimental parameters / protocols
- extraction and classification of key equipment for each process
- extraction or inference of key performance characteristics for each piece of equipment
- analysis of each processes, including identification of any suitable model and governing equations necessary for performing yield / purity estimations
- qualitative or semi-quantitative validation of reported results against what should typically be expected for identified processes/conditions/equipment
- estimating  yield / purity for each process and comparing with reported values
- evaluating whether there are any results

 
