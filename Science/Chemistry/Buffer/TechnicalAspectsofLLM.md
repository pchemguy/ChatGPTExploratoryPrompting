<p align="right">Humans too can be inaccurate...</p>
  
# Technical Aspects of LLM  
  
Large Language Models (LLMs) that are generally available - such as OpenAI $\mathrm{GPT_{x}/o_{x}}$ or Google’s Gemini family - are evolving rapidly but still face limitations in solving complex, domain-specific research and engineering problems. Typically, addressing these problems requires:
- **Relevant factual knowledge** (e.g., chemical or physical properties of materials)  
- **Workflows or algorithms** (e.g., a method for balancing chemical redox reactions)  
- **Execution of multi-step solution processes**

The introduction of “reasoning/thinking” models has substantially enhanced the ability of LLMs to perform multi-step processes. While these reasoning models share the same world knowledge as their non-reasoning counterparts, they are additionally trained or fine-tuned to simulate reasoning processes. However, knowledge gaps related to factual data and workflows still need separate solutions.

Several strategies can help bridge these gaps and improve handling of multi-step workflows:
1. **Training a new model from scratch** for a particular domain (e.g., chemistry or biology) or task (e.g., music OCR, chemical reaction extraction). This is the most resource-intensive approach but offers the greatest control over domain-specific capabilities.
2. **Fine-tuning pretrained models**, a more accessible option that still requires specialized expertise and has its own constraints.
3. **In-context learning**, the simplest approach in practical terms, which supplies additional information within the model’s prompt. This method can be used with virtually any model (including proprietary “frontier” models), as it requires no modification to the underlying system.

[In-context learning](https://en.wikipedia.org/wiki/Prompt_engineering#In-context_learning) relies primarily on [prompt engineering](https://en.wikipedia.org/wiki/Prompt_engineering) and leverages the model’s *context* (essentially its working memory of the current conversation). Thanks to [meta-learning](https://en.wikipedia.org/wiki/Meta-learning_(computer_science)) (learning to learn), which is a component of the foundational training process, the model can integrate this short-term contextual information with its training-based knowledge, supporting more coherent and logically consistent responses. It also facilitates specialized prompting techniques that allow the model to tackle complex problems - even when relevant data is absent or limited in the training data.

Additional learning or training materials may be presented to the model:
- **Directly in the prompt**  
- **In attached files**  
- **Via special instructions** (if the platform supports it)

These materials might include facts, transformation examples, detailed workflows or algorithms, or special instructions, and provide:
- **Input context** (e.g., chemical properties of reagents, format description or examples)  
- **Transformation context** (e.g., details of the workflow or algorithm the model should follow)  
- **Output context** (e.g., style guidelines or formats such as plain text, bullet points, or CSV)

### Input Context

*Input context* supplies additional information about the initial conditions of a problem. Examples include:
- **Physical and/or chemical properties of reagents** (e.g., analyzing possible chemical reactions based on a specific set of reagents)  
- **Description of input format** (e.g., reverse-engineering a Python class module to represent serialized data) 
- **Sample input files** (e.g., creating a Python class for graphical primitives used in rendering SPICE circuit element symbols)  
[Retrieval-Augmented Generation](https://en.wikipedia.org/wiki/Retrieval-augmented_generation) (RAG) provides advanced methods for supplying input context. These techniques typically require additional software tools and programmatic access through the model’s APIs.

### Output Context

*Output context* outlines what information should appear in the final output and how it should be organized or formatted. For instance, one might require that generated text adhere to a particular [language style](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Writing/WritingStyleGuidelines.md) or that generated code conform to a specific [coding style](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Code/Python/PythonStyleGuidelines.md). This ensures consistency, clarity, and alignment with project or organizational standards.

### N-shot Learning (Learning by Example)

One-shot (single-shot) and few-shot (multi-shot) prompting - collectively known as *N-shot* - involves providing one or more examples to the model. A key feature of these techniques is that the *transformation* process itself remains *implicit*. In other words, pure few-shot learning does not explicitly describe how to convert input into the desired output; instead, it depends on the model’s underlying training to infer an appropriate transformation that aligns with the examples given.

N-shot learning examples can focus on any aspect of a problem: the input, the transformation, or the output. For instance:
- **Reformatting plain text into a bulleted list**: Provide examples in which a sample paragraph is paired with its corresponding bulleted list.  
- **Generating code in a specific style**: Show multiple examples of output code that follows particular style guidelines, accompanied by a brief explanation.  
- **Reverse-engineering a Python class module**: Offer several sample text files containing serialized representations of an object (e.g., describing a graphical symbol of a an electrical component), which the model can use to infer how to implement the desired functionality.

In general, more and varied examples lead to better performance. However, the total number of examples is limited by the *context window length*, since each example consumes part of the model’s "working" memory.

### Limitations

In *in-context learning*, all supplementary material is supplied in the model’s input prompt. This prompt is constrained by the model’s **context window** - the maximum number of *input [tokens](https://ai.google.dev/gemini-api/docs/tokens)* (the basic building blocks processed by an LLM) that can be included, encompassing prompt text, attachments, and conversation history. Although a detailed understanding of tokens is not strictly necessary, the key takeaway is that larger inputs consume more tokens, thereby reducing the available capacity for additional content.

**Context Window Constraints**  
As the context window usage increases, the model’s ability to recall information accurately may degrade. Content placed in the middle of a large prompt can be especially prone to partial recall or omission. Context window limits are rapidly expanding - [Google’s long-context support](https://ai.google.dev/gemini-api/docs/long-context) leads to more robust in-context learning, including more extensive *[many-shot](https://ai.google.dev/gemini-api/docs/long-context#:~:text=Many%2Dshot%20in%2Dcontext%20learning)* examples, extra reference/context material, and longer, more detailed workflows or algorithms.

**Output Token Limits**  
The number of *output tokens* is limited separately - usually constituting a fraction the context window length. If the instructions prompt the model to produce detailed or lengthy responses (e.g., following an elaborate workflows and showing intermediate steps or results), the system may begin “compressing” the output once it nears this token limit. In other words, it will omit or shorten details to stay within the output cap. When preserving detail is important, you may need to divide prompts into smaller segments or handle them in separate conversations.

**Subscription Plan Differences**  
Models offered on “Free” vs. “Advanced” (or other paid) tiers may have different usage limits, including distinct input and output token caps. While free-tier limits might be enough for simple tasks, more complex or detailed prompts often benefit from the larger context windows and output capacities available under advanced plans.

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
- For any highly unusual/revolutionary results/claims, a clear and detailed explanation/justification should be provided of how appropriate process models and any relevant governing equations support claimed results when all specific experimental/processing protocols and any essential modifications are considered. 
    - demonstrated processes or characteristics that are apparently inconsistent with or contradicting to established knowledge/practices
    - observed odd results (such as unexpected performance characteristics) and/or potentially highly disruptive findings (findings that may enable disruptive scientific and/or industrial/market applications) within an established field using apparently conventional/established equipment/protocols
 
