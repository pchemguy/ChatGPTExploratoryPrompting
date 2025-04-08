<p align="right">Humans too can be inaccurate...</p>
  
## Technical Aspects of LLM  
  
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

[In-context learning](https://en.wikipedia.org/wiki/Prompt_engineering#In-context_learning) primarily utilizes [prompt engineering](https://en.wikipedia.org/wiki/Prompt_engineering) to guide the LLM by leveraging its _context window_ (essentially, the working memory encompassing the current conversation and provided materials). Thanks to underlying [meta-learning](https://en.wikipedia.org/wiki/Meta-learning_(computer_science)) capabilities developed during foundational training, the model can integrate this immediate contextual information with its pre-existing knowledge. This enables more coherent, logically consistent responses and allows the model to tackle complex problems using specialized prompting techniques, even if relevant data was limited during its initial training.

This crucial contextual information can be supplied to the model in several ways:
- **Directly within the prompt text.**
- **Through attached files** (e.g., documents, data sheets).
- **Via special instructions or system messages** (when available).
These provided materials establish different types of context that shape the model's response. Let's explore these context types in more detail.

---

### Input Context

_Input context_ supplies additional information about the initial conditions or data for a problem. Examples include:
- **Physical and/or chemical properties of reagents**: Providing data for analyzing possible chemical reactions based on a specific set of reagents.
- **Description of input format**: Detailing a data structure, perhaps for reverse-engineering a Python class module to represent serialized data.
- **Sample input files**: Offering examples, such as graphical primitives data used in rendering SPICE circuit element symbols, to help create a corresponding Python class.

[Retrieval-Augmented Generation](https://en.wikipedia.org/wiki/Retrieval-augmented_generation) (RAG) represents a set of advanced methods specifically for supplying relevant input context dynamically, often requiring additional tools and API access.

---

### Transformation Context

Often, one simply poses a question to an LLM and lets it determine the solution path. However, for more complex tasks where the model might struggle to find an appropriate approach, or where a specific, rigorous method is preferred, explicitly defining the _transformation context_ - the workflow or algorithm - can greatly enhance result quality.

Two common prompt-engineering methods for making workflows explicit are:
- **Hierarchical Decomposition**: Breaking a complex problem into a sequence of simpler, smaller tasks.
- **[Chain-of-Thought](https://en.wikipedia.org/wiki/Prompt_engineering#Chain-of-thought)** (CoT): Providing detailed, step-by-step demonstrations of intermediate reasoning.

These methods can be combined or used separately. For example, this experimental [prompt template](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Science/Chemistry/ChemicalReactionAnalysis.md) illustrates a structured, step-by-step workflow for analyzing chemical processes - ensuring the model follows a deliberate approach rather than taking shortcuts.

Developing such explicit workflows can be challenging because human reasoning in specialized domains often involves [tacit knowledge](https://en.wikipedia.org/wiki/Tacit_knowledge). Formalizing these implicit processes may require [self-reflection](https://en.wikipedia.org/wiki/Self-reflection), generalization, and iteration. Nonetheless, codifying complex reasoning strategies is valuable, especially as AI capabilities advance.

---

### Output Context

_Output context_ outlines requirements for the final output's content, organization, or format. For instance, one might require generated text to adhere to a particular [language style](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Writing/WritingStyleGuidelines.md) or generated code to conform to a specific [coding style](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Code/Python/PythonStyleGuidelines.md). This ensures consistency, clarity, and alignment with project or organizational standards.

---

### Behavioral Context

Guiding the model's persona, tone, or interaction style through _behavioral context_ (e.g., via role prompting) is another way to shape the output. The effectiveness of this can vary and may depend on the specific model and task, partly because this aspect of LLM behavior can be less predictable or opaque. Examples include instructing the model to act as a specific expert or adopt a formal tone.

---

### N-shot Learning (Learning by Example)

Beyond defining context directly, models can also learn from examples provided within the prompt. One-shot (single example) and few-shot (multiple examples) prompting - collectively known as _N-shot_ learning - involve providing demonstrations of the desired input, output, or input-output relationship.

A key feature is that the _transformation_ process often remains _implicit_ in pure N-shot learning. The model infers the appropriate transformation based on the examples, relying on its underlying training.

N-shot examples can illustrate any aspect: input format, transformation logic, or output style. For instance:
- **Reformatting**: Provide examples pairing paragraphs with their corresponding bulleted lists.
- **Code Style**: Show multiple code examples following specific guidelines, perhaps with brief explanations.    
- **Reverse-engineering**: Offer sample files of serialized objects (e.g., electrical component symbols) for the model to infer a class implementation.

Generally, more diverse and numerous examples improve performance, but the total number is constrained by the model's _context window length_.

---

### Limitations of In-Context Learning

While powerful, in-context learning relies entirely on information supplied within the prompt (including text, attachments, and history), which is subject to several constraints:

**Context Window Constraints**
The prompt is constrained by the model’s **context window** - the maximum number of [_input tokens_](https://ai.google.dev/gemini-api/docs/tokens) (the basic units processed by LLMs) it can handle. Larger inputs consume more tokens, reducing capacity.

Furthermore, as context window usage increases, recall accuracy may degrade, especially for information placed in the middle of long prompts. While context limits are rapidly expanding (cf. [Google’s long-context support](https://ai.google.dev/gemini-api/docs/long-context)), enabling more robust in-context learning (e.g., extensive *[many-shot](https://ai.google.dev/gemini-api/docs/long-context#:~:text=Many%2Dshot%20in%2Dcontext%20learning)* examples, more reference material, longer workflows), this fundamental limitation remains.

**Output Token Limits**
The number of _output tokens_ is typically limited separately, often to a fraction of the input context window size. If instructions require detailed or lengthy responses (e.g., showing intermediate steps), the model might start “compressing” the output (omitting details) as it nears this limit. Preserving detail might necessitate breaking prompts into smaller segments.

**Subscription Plan Differences**
Free vs. paid tiers often have different usage limits (input/output token caps). Complex tasks generally benefit from the larger capacities of advanced plans.

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

