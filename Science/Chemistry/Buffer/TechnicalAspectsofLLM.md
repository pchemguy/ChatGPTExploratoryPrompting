# Technical Aspects of LLM

General purpose LLMs, such as OpenAI GPT-4 or Google Gemini 2.0 Flash are rapidly evolving, but they still possess limited ability to handling complex domain-specifc research and engineering tasks. On the one hand, limited specialized information may be available for model training.

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