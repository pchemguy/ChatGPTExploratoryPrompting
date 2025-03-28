# Technical Aspects of LLM

General purpose LLMs, such as OpenAI GPT-4 or Google Gemini 2.0 Flash are rapidly evolving, but they still possess limited ability to handling complex domain-specifc research and engineering tasks. On the one hand, limited specialized data may be available for model training, so models may not know certain facts. On the other hand, limitations may be due to lack of examples in the training data, demonstrating *how* to do certain complex tasks (workflow/algorithms examples), or because potential solutions involve multiple interdependent steps.

Relatively recently introduced reasoning models have been developed to improve LLMs' ability to handle complex multistep tasks. Generally, the reasoning feature cannot compensate for lack of specific facts in the training data or 

- General purpose vs. specialized models
- Limited abilities of genereal-purpose models to perform highly-specialized tasks, such as deep paper manuscript analysis due to lack of training material
- Chain-of-Thought and Hierarchical decomposition approaches to handling complex tasks with limited to no relevant training data available for training foundation models.
- non-reasoning vs. reasoning vs. deep research for complex tasks (such as deep analysis of academic publications)
- fine-tuning vs. in-context learning
- context size limit, tokens, output token limit
- free vs. subscriptions based plans:
    - models not available on free plan or available with significantly reduced input/output token limits
    - privacy considerations (user data being used for model training on free plan vs. promise not use it on subscription-based plans)
- importance of large input context for many-shot learning


```mermaid
flowchart TB
    A([Start]) --> B{1. Identify<br>and Organize<br>Input Data}
    B --> B1[1.1 Parse the Description<br>
    • Review process<br>
    • List key info<br>
    • Note missing/contradictory data<br>
    • Highlight ambiguities and assumptions]
    B --> B2[1.2 Validate Internal Consistency<br>
    • Check if reagents & conditions are standard<br>
    • Flag contradictions<br>
    • Seek alternative interpretations]
    B --> C{2. Calculate<br>Molar Quantities<br>
    • Convert masses/volumes to moles<br>
    • For gases, assume ideal behavior<br>
    • For common reagents, make<br>reasonable assumptions as needed}
    C --> D{3. Identify Key<br>Reactivity Properties<br>
    • Redox, acid-base, complex formation<br>
    • Hazards or special handling}
    D --> E{4. Explain Underlying<br>Principles<br>
    • List chemical/physical concepts<br>
    • Cite data (pKa, solubility, etc.)<br>
    • State assumptions if data are missing}
    E --> F{5. Identify Reaction Candidates<br>
    • Propose possible reactions<br>
    • Balance equations<br>
    • Consider reagent excess (molar basis)<br>
    • Note byproducts}
    F --> G{6. Side Processes<br>
    • Discuss competing/secondary reactions<br>
    • Evaluate likelihood & impact}
    G --> H{7. Improbable or<br>Impossible Outcomes}
    H --> H1[7.1 Check Scientific Plausibility<br>
    • Compare with known chem knowledge<br>
    • Propose alternative interpretations]
    H --> H2[7.2 Provide Justification<br>
    • Explain why outcome is flagged<br>
    • Suggest resolutions]
    H --> I{8. Structured,<br>Hierarchical Output<br>
    • Present findings step-by-step<br>
    • Summarize data & calculations<br>
    • Highlight conclusions & assumptions}
    I --> Z([End])
```