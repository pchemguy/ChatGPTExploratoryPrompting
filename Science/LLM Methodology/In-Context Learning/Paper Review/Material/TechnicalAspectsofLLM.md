<p align="right">Humans too can be inaccurate...</p>
  
# Technical Aspects of LLM  
  
Widely available Large Language Models (LLMs)—such as OpenAI's _o1_ or Google’s _Gemini_ family - are evolving rapidly. However, they still face limitations when tackling complex, domain-specific research and engineering problems. Successfully addressing these limitations often requires integrating:
- **Relevant factual knowledge** (e.g., specific chemical or physical properties).
- **Domain-specific workflows or algorithms** (e.g., a defined method for balancing chemical redox reactions).
- **Reliable execution of multi-step solution processes**.

While the introduction of models enhanced for "reasoning" or "thinking" has improved the ability of LLMs to handle multi-step tasks (by simulating reasoning processes through specialized training or fine-tuning), they often share the same core knowledge base as standard models. Consequently, gaps related to specialized factual data and established workflows remain a challenge that requires separate solutions.

For example, simply prompting a general LLM to `Perform peer review of the attached manuscript` is unlikely to produce a particularly useful result. This is likely because actual peer reviews are typically confidential and not widely available as training data for foundational models, highlighting a specific knowledge and process gap.

Several strategies can help bridge these gaps:
1. **Training a new model from scratch:** Tailoring a model specifically for a domain (e.g., chemistry) or task (e.g., chemical reaction extraction). This is the most resource-intensive option but offers maximum control.
2. **Fine-tuning pre-trained models:** Adapting existing models with domain-specific data. This is less resource-intensive than training from scratch but still requires expertise and faces certain constraints.
3. **In-context learning:** Providing necessary knowledge and workflow guidance directly within the prompt given to the LLM. This is often the most practical approach as it requires no changes to the underlying model and can be used with most available LLMs, including proprietary ones.

[In-context learning](https://en.wikipedia.org/wiki/Prompt_engineering#In-context_learning) relies primarily on [prompt engineering](https://en.wikipedia.org/wiki/Prompt_engineering) and leverages the model’s *context* (essentially its working memory of the current conversation). Thanks to [meta-learning](https://en.wikipedia.org/wiki/Meta-learning_(computer_science)) (learning to learn), which is a component of the foundational training process, the model can integrate this short-term contextual information with its training-based knowledge, supporting more coherent and logically consistent responses. It also facilitates specialized prompting techniques that allow the model to tackle complex problems - even when relevant data is absent or limited in the training data.

Additional learning or training materials may be presented to the model:
- **Directly in the prompt**  
- **In attached files**  
- **Via special instructions** (if the platform supports it)

These materials might include facts, transformation examples, detailed workflows or algorithms, or special instructions, and provide:
- **Input context** (e.g., chemical properties of reagents, format description or examples)  
- **Transformation context** (e.g., details of the workflow or algorithm the model should follow)  
- **Behavioral context** (e.g., role prompting)
- **Output context** (e.g., style guidelines or formats such as plain text, bullet points, or CSV)

---

### Input Context

*Input context* supplies additional information about the initial conditions of a problem. Examples include:
- **Physical and/or chemical properties of reagents** (e.g., analyzing possible chemical reactions based on a specific set of reagents)  
- **Description of input format** (e.g., reverse-engineering a Python class module to represent serialized data) 
- **Sample input files** (e.g., creating a Python class for graphical primitives used in rendering SPICE circuit element symbols)  
[Retrieval-Augmented Generation](https://en.wikipedia.org/wiki/Retrieval-augmented_generation) (RAG) provides advanced methods for supplying input context. These techniques typically require additional software tools and programmatic access through the model’s APIs.

---

### Behavioral context

Imposing restrictions on how the model behaves (for example, via role prompting) may (or may not) improve the quality of generated response. This part is tricky in part because models evolve rapidly and in part because this LLM aspect might be particularly opaque.

---

### Output Context

*Output context* outlines what information should appear in the final output and how it should be organized or formatted. For instance, one might require that generated text adhere to a particular [language style](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Writing/WritingStyleGuidelines.md) or that generated code conform to a specific [coding style](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Code/Python/PythonStyleGuidelines.md). This ensures consistency, clarity, and alignment with project or organizational standards.

---

### N-shot Learning (Learning by Example)

One-shot (single-shot) and few-shot (multi-shot) prompting - collectively known as *N-shot* - involves providing one or more examples to the model. A key feature of these techniques is that the *transformation* process itself remains *implicit*. In other words, pure few-shot learning does not explicitly describe how to convert input into the desired output; instead, it depends on the model’s underlying training to infer an appropriate transformation that aligns with the examples given.

N-shot learning examples can focus on any aspect of a problem: the input, the transformation, or the output. For instance:
- **Reformatting plain text into a bulleted list**: Provide examples in which a sample paragraph is paired with its corresponding bulleted list.  
- **Generating code in a specific style**: Show multiple examples of output code that follows particular style guidelines, accompanied by a brief explanation.  
- **Reverse-engineering a Python class module**: Offer several sample text files containing serialized representations of an object (e.g., describing a graphical symbol of a an electrical component), which the model can use to infer how to implement the desired functionality.

In general, more and varied examples lead to better performance. However, the total number of examples is limited by the *context window length*, since each example consumes part of the model’s "working" memory.

---
### Limitations

In *in-context learning*, all supplementary material is supplied in the model’s input prompt. This prompt is constrained by the model’s **context window** - the maximum number of *input [tokens](https://ai.google.dev/gemini-api/docs/tokens)* (the basic building blocks processed by an LLM) that can be included, encompassing prompt text, attachments, and conversation history. Although a detailed understanding of tokens is not strictly necessary, the key takeaway is that larger inputs consume more tokens, thereby reducing the available capacity for additional content.

**Context Window Constraints**  
As the context window usage increases, the model’s ability to recall information accurately may degrade. Content placed in the middle of a large prompt can be especially prone to partial recall or omission. Context window limits are rapidly expanding - [Google’s long-context support](https://ai.google.dev/gemini-api/docs/long-context) leads to more robust in-context learning, including more extensive *[many-shot](https://ai.google.dev/gemini-api/docs/long-context#:~:text=Many%2Dshot%20in%2Dcontext%20learning)* examples, extra reference/context material, and longer, more detailed workflows or algorithms.

**Output Token Limits**  
The number of *output tokens* is limited separately - usually constituting a fraction the context window length. If the instructions prompt the model to produce detailed or lengthy responses (e.g., following an elaborate workflows and showing intermediate steps or results), the system may begin “compressing” the output once it nears this token limit. In other words, it will omit or shorten details to stay within the output cap. When preserving detail is important, you may need to divide prompts into smaller segments or handle them in separate conversations.

**Subscription Plan Differences**  
Models offered on “Free” vs. “Advanced” (or other paid) tiers may have different usage limits, including distinct input and output token caps. While free-tier limits might be enough for simple tasks, more complex or detailed prompts often benefit from the larger context windows and output capacities available under advanced plans.

---

### Transformation context

Often, one simply poses a question to an LLM and lets it solve the problem without specifying a particular method or workflow. However, for more complex tasks, models might fail to devise an appropriate approach on their own, or there could be multiple valid strategies, and you may wish to guide the model toward a more rigorous solution. In these cases, explicitly defining a workflow or algorithm can greatly enhance the quality of the results.

Two common prompt-engineering methods for making workflows explicit are:
- **Hierarchical Decomposition**: Breaking a complex problem into a sequence of simpler, smaller tasks.  
- **[Chain-of-Thought](https://en.wikipedia.org/wiki/Prompt_engineering#Chain-of-thought)** (CoT): Providing detailed, step-by-step demonstrations of intermediate reasoning.  
These methods can be combined or used separately. For example, this experimental [prompt template](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Science/Chemistry/ChemicalReactionAnalysis.md) illustrates a structured, step-by-step workflow for analyzing chemical processes—ensuring the model follows a deliberate approach rather than taking shortcuts.

Developing such explicit workflows can be challenging because human reasoning in specialized domains (e.g., advanced research) often involves [tacit knowledge](https://en.wikipedia.org/wiki/Tacit_knowledge) and techniques learned over time. Formalizing these implicit processes may require [self-reflection](https://en.wikipedia.org/wiki/Self-reflection) and iterative experimentation. Nonetheless, identifying and codifying complex reasoning strategies has value, especially as AI models continue to improve.

---

#### Example: Analyzing a Manuscript on Experimental Chemistry

A more ambitious workflow might involve dissecting a manuscript describing experimental chemistry. This multi-step approach could include:
1. **Extracting key experimental results**  
2. **Identifying the processes** associated with each result  
3. **Listing all reagents, catalysts, products, and byproducts** involved in each process  
4. **Recording quantity and composition** details for each material  
5. **Extracting experimental parameters/protocols**  
6. **Identifying and classifying key equipment** used for each process  
7. **Extracting or inferring performance characteristics** for each piece of equipment  
8. **Analyzing each process**, including any suitable models or governing equations for yield/purity estimations  
9. **Validating reported results**, comparing them to expected outcomes under those models/conditions  
10. **Performing internal consistency checks**, such as mass or composition balances
11. **Evaluate highly unusual or disruptive claims** by:  
    - Checking for conflicts with established knowledge or practices  
    - Identifying questionable equipment choices, protocols, or procedures, particularly those known to perform poorly unless well-justified  
    - Noting any incomplete experimental data (e.g., missing information necessary for a thorough mass balance) without valid explanation  
    - Ensuring that any anomalous results obtained via standard techniques are fully explained, including
        - Sound special modifications used that enabled achieving such results  
        - Theoretical treatment taking into account said modifications and supporting reported results
    - Assessing potentially transformative findings that might disrupt an established field or market niche, and considering how such results might have been missed by other motivated experts  

# ~I made some progress towards developing such a workflow using mostly the ChatGPT o1 model.

---

By explicitly defining such workflows, it becomes easier to guide LLMs toward more consistent, in-depth analysis. As AI capabilities continue to evolve, compiling a library of well-articulated reasoning workflows for specialized domains will likely be a powerful strategy for ensuring rigorous and insightful outputs - and may also present a promising cross-disciplinary research direction.

