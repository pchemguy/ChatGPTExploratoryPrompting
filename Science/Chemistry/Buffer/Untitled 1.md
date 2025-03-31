Large Language Models (LLMs) that are generally available - such as OpenAI $\mathrm{GPT_{x}/o_{x}}$ or Google’s Gemini family - are evolving rapidly but still face limitations in solving complex, domain-specific research and engineering problems. Typically, addressing these problems requires:

- **Relevant factual knowledge** (e.g., chemical or physical properties of materials)  
- **Workflows or algorithms** (e.g., a method for balancing chemical redox reactions)  
- **Execution of multi-step solution processes**

The introduction of “reasoning/thinking” models has substantially enhanced the ability of LLMs to perform multi-step processes. While these reasoning models share the same world knowledge as their non-reasoning counterparts, they are additionally trained or fine-tuned to simulate reasoning processes. However, knowledge gaps related to factual data and workflows still need separate solutions.

Several strategies can help bridge these gaps and improve handling of multi-step workflows:

1. **Training a new model from scratch** for a particular domain (e.g., chemistry or biology) or task (e.g., music OCR, chemical reaction extraction). This is the most resource-intensive approach but offers the greatest control over domain-specific capabilities.

2. **Fine-tuning pretrained models**, a more accessible option that still requires specialized expertise and has its own constraints.

3. **In-context learning**, the simplest approach in practical terms, which supplies additional information within the model’s prompt. This method can be used with virtually any model (including proprietary “frontier” models), as it requires no modification to the underlying system.

[In-context learning](https://en.wikipedia.org/wiki/Prompt_engineering#In-context_learning) relies primarily on [prompt engineering](https://en.wikipedia.org/wiki/Prompt_engineering) and leverages the model’s *context* (essentially its working memory of the current conversation). Further [meta-learning](https://en.wikipedia.org/wiki/Meta-learning_(computer_science)) enables the model to integrate this short-term contextual information with its training-based knowledge, supporting more coherent and logically consistent responses. It also facilitates specialized prompting techniques that allow the model to tackle complex problems—even when relevant data is absent or limited in the training set.

**Additional learning or training materials** may be presented to the model:

- **Directly in the prompt**  
- **In attached files**  
- **Via special instructions** (if the platform supports it)

These materials might include facts, transformation examples, detailed workflows or algorithms, or special instructions, and can address:

- **Input context** (e.g., chemical properties of reagents, input format and example structures)  
- **Transformation context** (e.g., details of the workflow or algorithm the model should follow)  
- **Output context** (e.g., style guidelines or formats such as plain text, bullet points, or CSV)