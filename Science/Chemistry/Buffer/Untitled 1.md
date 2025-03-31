### Transformation Context

Often, one simply poses a question to an LLM and lets it solve the problem without specifying a particular method or workflow. However, for more complex tasks, models might fail to devise an appropriate approach on their own—or there could be multiple valid strategies, and you may wish to guide the model toward a more rigorous solution. In these cases, explicitly defining a workflow or algorithm can greatly enhance the quality of the results.

Two common prompt-engineering methods for making workflows explicit are:
- **Hierarchical Decomposition**: Breaking a complex problem into a sequence of simpler, smaller tasks.  
- **[Chain-of-Thought](https://en.wikipedia.org/wiki/Prompt_engineering#Chain-of-thought)** (CoT): Providing detailed, step-by-step demonstrations of intermediate reasoning.

These methods can be combined or used separately. For example, this experimental [prompt template](https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Science/Chemistry/ChemicalReactionAnalysis.md) illustrates a structured, step-by-step workflow for analyzing chemical processes—ensuring the model follows a deliberate approach rather than taking shortcuts.

Developing such explicit workflows can be challenging because human reasoning in specialized domains (e.g., advanced research) often involves [tacit knowledge](https://en.wikipedia.org/wiki/Tacit_knowledge) and techniques learned over time. Formalizing these implicit processes may require [self-reflection](https://en.wikipedia.org/wiki/Self-reflection) and iterative experimentation. Nonetheless, identifying and codifying complex reasoning strategies has value, especially as AI models continue to improve.

#### Example: Analyzing a Manuscript on Experimental Chemistry

A more ambitious workflow might involve dissecting a manuscript describing experimental chemistry. This multi-step approach could include:

1. **Extracting key experimental results**  
2. **Identifying the processes associated with each result**  
3. **Listing all reagents, catalysts, products, and byproducts** involved in each process  
4. **Recording quantity and composition** details for each material  
5. **Extracting experimental parameters/protocols**  
6. **Identifying and classifying key equipment** used for each process  
7. **Extracting or inferring performance characteristics** for each piece of equipment  
8. **Analyzing each process**, including any suitable models or governing equations for yield/purity estimations  
9. **Validating reported results**, comparing them to expected outcomes under those models/conditions  
10. **Evaluating unusual or revolutionary claims**:
    - Explaining how any novel process, model, or method justifies the reported outcomes  
    - Identifying inconsistent or contradictory results and discussing potential reasons  
    - Highlighting any potentially disruptive findings with the capacity to transform an existing field

By explicitly defining such workflows, one can guide LLMs to offer more consistent, in-depth analysis. As AI capabilities continue to expand, building a library of clearly articulated reasoning workflows for specialized domains will likely be an effective way to ensure rigorous and insightful model outputs.