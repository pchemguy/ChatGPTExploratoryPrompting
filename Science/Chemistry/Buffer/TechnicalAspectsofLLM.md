# Technical Aspects of LLM

General purpose LLMs, such as OpenAI GPT-4 or Google Gemini 2.0 Flash are rapidly evolving, but they still possess limited ability to solve complex domain-specifc research and engineering problems. Two essential constituents of such solutions involve *facts* and *workflows/algorithms*. For example, to determine coefficients in chemical schematic of a redox reaction, one would need to know chemical properties of reagents (facts) and master balancing techniques (workflow/algorithm). Hence, model's abilities may be limited due to lack in the training data of specialized data or examples, demonstrating *how* to perform certain complex tasks. Moreover, even when workflow/algorithm information is available in the training data "baseline" models are not optimized for developing multistep solutions for complex problems.

A number of approaches have emerged to address deficiencies in training data and improve complex workflow handling abilities. Relatively recently introduced *reasoning/thinking* models have been developed to improve LLMs' ability to handle complex multistep tasks. Reasoning models generally possess the same knowledge about world as their non-reasoning counterparts, but they have been additionally trained (fine-tuned) to simulate reasoning processes. Several approaches may be used to compensate for training data deficiencies: 
- training/creating a new model from scratch
- fine-tuning pretrained model
- taking advantage of in-context learning.

Each approach has pro's and con's. Creating a new model is most complicated/costly process that, in principle, provides the greatest flexibility. Fine-tuning is a simpler alternative that still necessitates specialized expertise. In-context learning, on the other hand, provides additional information to the trained model directly as part of a prompt, in the form of attached files, or as part of the special instructions feature where available. Such additional information may include facts, special processing/transformation examples, descriptions of workflows/algorithms, and special instructions. Models also usually "remember" previous messages that are part of the same conversation, so the entire conversation is usually also a part of the model's *context*.

Two common prompting techniques used to improve handling complex tasks are hierarchical decomposition and [Chain-of-Thought][https://en.wikipedia.org/wiki/Prompt_engineering#Chain-of-thought] (CoT). The former approach focus on splitting a complex problem into a series of simpler steps. Then these steps maybe provided to the model as separate prompts, or they may be combined into a structured sequence of steps with emphasis on explicit demonstration of all intermediate work (CoT).

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

