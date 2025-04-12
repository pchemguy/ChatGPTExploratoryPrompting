---
tags: []
parent: 'Simulating Peer Review via Persistent Workflow Prompting'
collections:
    - Technique
$version: 30612
$libraryID: 1
$itemKey: 9VK9V99E

---

# Source

ChatGPT 4.5: https://chatgpt.com/c/67fa0031-ddf4-8004-b2b4-cc9336cecd54

---
---

# Tell me about decomposition prompting techniques

Decomposition prompting techniques refer to methods used in prompt engineering that break complex questions or tasks into smaller, simpler subcomponents. This strategy helps AI language models reason step-by-step, increasing their accuracy, reducing confusion, and enabling more detailed, precise answers.

Here’s a structured overview of key decomposition prompting techniques:

## 1. Chain-of-Thought (CoT) Prompting
Chain-of-Thought prompting explicitly instructs the AI model to provide intermediate reasoning steps before giving a final answer.

### Example:
- **Original prompt:**
  > *"What is 18 multiplied by 12?"*

- **CoT Prompt:**
  > *"What is 18 multiplied by 12? Let's think step-by-step."*
  
  **AI Response:**
  > *"18 × 10 = 180;*  
  > *18 × 2 = 36;*  
  > *Adding them gives 180 + 36 = 216;*  
  > *Final Answer: 216."*

### Benefits:
- Enhances accuracy in complex reasoning tasks.
- Improves transparency of model reasoning.

---

## 2. Problem Decomposition (Explicit Stepwise Breakdown)
This approach clearly breaks down the original question into multiple smaller questions or subtasks, each addressed sequentially.

### Example:
- **Original prompt:**
  > *"Summarize the causes of World War I."*

- **Decomposition Prompt:**
  > *"Let's break this down step-by-step:*  
  > *1. Identify key political causes.*  
  > *2. Describe major economic factors.*  
  > *3. Discuss influential social dynamics.*  
  > *4. Summarize how these factors combined to trigger the war."*

### Benefits:
- Simplifies complex tasks.
- Encourages structured responses with deeper insights.

---

## 3. Subquestion Prompting
This method involves explicitly asking the model to generate subquestions and answer them individually.

### Example:
- **Original prompt:**
  > *"Analyze the pros and cons of renewable energy."*

- **Subquestion Prompt:**
  > *"Break the question into subquestions and answer each:*  
  > *(1) What are the advantages of renewable energy?*  
  > *(2) What are the disadvantages?*  
  > *(3) How do these advantages and disadvantages compare?"*

### Benefits:
- Ensures comprehensive coverage of the topic.
- Improves organization and clarity of responses.

---

## 4. Least-to-Most Prompting
This technique addresses simpler parts first, gradually progressing to more complex aspects.

### Example:
- **Original prompt:**
  > *"Explain how photosynthesis contributes to life on Earth."*

- **Least-to-Most Prompt:**
  > *"First, describe briefly what photosynthesis is.*  
  > *Next, explain how photosynthesis produces oxygen.*  
  > *Finally, describe why this oxygen production is essential for life on Earth."*

### Benefits:
- Reduces complexity by addressing foundational concepts first.
- Makes model explanations easier to follow and verify.

---

## 5. Recursive Decomposition
Repeatedly decomposes each generated subtask into finer-grained subproblems until each is sufficiently simple to solve directly.

### Example:
- **Original prompt:**
  > *"Provide an action plan to organize a scientific conference."*

- **Recursive Prompt (First level):**
  > *"Break down conference organization into major tasks:"*
  > - Venue selection
  > - Program creation
  > - Speaker invitations
  > - Registration management
  > - Budget management
  
  **Recursive Prompt (Second level):**
  > *"Now, break down the task 'Venue selection' further into specific subtasks."*

### Benefits:
- Ensures thorough coverage of tasks.
- Creates highly structured, detailed outputs.

---

## 6. Iterative Refinement Prompting
Asks the model to iteratively refine an answer, each time providing more detail or precision.

### Example:
- **Original prompt:**
  > *"Write a short summary about climate change."*

- **Iterative Prompt:**
  - *First round:* "Provide a basic summary."
  - *Second round:* "Expand this summary by including causes and effects."
  - *Third round:* "Include recent scientific findings."

### Benefits:
- Gradually builds complexity and detail.
- Allows targeted refinement based on feedback.

---

## When to Use Decomposition Techniques:
- Solving complex logical or mathematical problems.
- Performing detailed technical analyses (e.g., in chemistry, coding, database schema design).
- Structuring lengthy or complex responses (research papers, structured literature reviews).
- Tasks requiring rigorous stepwise validation (debugging code, scientific methodology checks).

---

## Best Practices:
- Clearly define and structure subcomponents.
- Provide explicit instructions ("Let's think step-by-step...").
- Encourage detailed reasoning at each step.
- Iteratively refine prompts and sub-questions based on the results.

---

## Limitations and Considerations:
- Excessive decomposition might lead to overly verbose responses.
- Each step must be logically clear and distinct to avoid confusion.
- Balancing detail with conciseness is essential for readability and clarity.

---

Decomposition prompting is a powerful tool that significantly enhances AI models’ reasoning capabilities and helps deliver clearer, more accurate, and structured outputs, particularly in complex problem-solving contexts.

---
---

# Find academic publications that introduced each of these techniques to be referenced in an academic manuscript

### 1. Chain-of-Thought (CoT) Prompting

- **Citation**:  
  Wei, J., Wang, X., Schuurmans, D., Bosma, M., Ichter, B., Xia, F., Chi, E., Le, Q., & Zhou, D. (2022). *Chain-of-Thought Prompting Elicits Reasoning in Large Language Models*. arXiv preprint arXiv:2201.11903.  
  [arXiv Link](https://arxiv.org/abs/2201.11903)

- **Summary**:  
  This paper introduces Chain-of-Thought (CoT) prompting, a technique that enhances large language models' performance on complex reasoning tasks by including intermediate reasoning steps in prompts. The authors demonstrate that CoT prompting significantly improves accuracy on arithmetic, commonsense, and symbolic reasoning benchmarks, particularly when applied to large-scale models like PaLM 540B.  

---

### 2. Least-to-Most Prompting

- **Citation**:  
  Zhou, D., Schärli, N., Hou, L., Wei, J., Scales, N., Wang, X., Schuurmans, D., Cui, C., Bousquet, O., Le, Q., & Chi, E. (2023). *Least-to-Most Prompting Enables Complex Reasoning in Large Language Models*. In *Proceedings of the International Conference on Learning Representations (ICLR 2023)*.  
  [OpenReview Link](https://openreview.net/forum?id=WZH7099tgfM)

- **Summary**:  
  This work proposes Least-to-Most prompting, a strategy that decomposes complex problems into simpler subproblems, solving them sequentially to build up to the final solution. The approach addresses the limitations of CoT prompting in handling tasks that require generalization to more difficult problems than those seen in the prompts. The authors show that Least-to-Most prompting enables models like GPT-3 to achieve high accuracy on benchmarks requiring compositional generalization.  

---
---

# Find reference for 2. Problem Decomposition (Explicit Stepwise Breakdown)


### 1. **Decomposed Prompting (DECOMP)**
- **Citation**: LearnPrompting.org. (2024). *Advanced Decomposition Techniques for Improved Prompting in LLMs*. Retrieved from https://learnprompting.org/docs/advanced/decomposition/introduction
- **Summary**: This guide introduces Decomposed Prompting (DECOMP), a technique that breaks down complex tasks into simpler sub-tasks, each handled by appropriate modules. It builds upon Chain-of-Thought prompting by addressing its limitations through more structured approaches.

---

### 2. **Socratic Chain-of-Thought (Socratic CoT)**
- **Citation**: Shridhar, K., Stolfo, A., & Sachan, M. (2022). *Distilling Reasoning Capabilities into Smaller Language Models*. arXiv preprint arXiv:2212.00193.
- **Summary**: This paper proposes Socratic CoT, a reasoning scheme that decomposes the original problem into a sequence of subproblems to guide intermediate reasoning steps. It demonstrates that this approach can effectively distill reasoning capabilities into smaller models.

---

### 3. **Task Navigator Framework**
- **Citation**: Ma, Q., Zhou, H., Liu, T., Yuan, J., & Liu, P. (2024). *Task Navigator: Decomposing Complex Tasks for Multimodal Large Language Models*. In Proceedings of the CVPR 2024 Workshop on Multimodal AI Reasoning (MAR).
- **Summary**: The Task Navigator framework enables large language models to act as navigators, breaking down complex tasks into sub-tasks and guiding multimodal models through the process step by step. It emphasizes iterative decomposition and refinement to tackle complex tasks effectively.

---

### 4. **Divide-and-Conquer Strategy**
- **Citation**: Wu, Z., Bai, H., Zhang, A., Gu, J., Vydiswaran, V. V., Jaitly, N., & Zhang, Y. (2024). *Divide-or-Conquer? Which Part Should You Distill Your LLM?*. arXiv preprint arXiv:2402.15000.
- **Summary**: This study explores a strategy that breaks down reasoning tasks into a problem decomposition phase and a problem-solving phase. It shows that this approach can outperform single-stage solutions and discusses methods to distill these capabilities into smaller models.

---

### 5. **Graph of Thoughts (GoT) Framework**
- **Citation**: Besta, M., Blach, N., Kubicek, A., Gerstenberger, R., Podstawski, M., Gianinazzi, L., ... & Hoefler, T. (2024). *Graph of Thoughts: Solving Elaborate Problems with Large Language Models*. In Proceedings of the AAAI Conference on Artificial Intelligence.
- **Summary**: The Graph of Thoughts framework advances prompting capabilities by modeling information generated by large language models as a graph. This approach enables combining various reasoning paths, facilitating structured problem-solving beyond linear chains of thought.

---
---

# Find reference for 3. Subquestion Prompting

### 1. **Self-Ask Prompting**

- **Citation**: Press, O., Zhang, M., Min, S., Schmidt, L., Lewis, M., & Smith, N. A. (2022). *Measuring and Narrowing the Compositionality Gap in Language Models*. arXiv preprint arXiv:2210.03350.

- **Summary**: This paper introduces the *Self-Ask* prompting technique, where a language model explicitly generates and answers intermediate subquestions before arriving at the final answer. This method enhances the model's reasoning capabilities by structuring complex queries into manageable components. The authors demonstrate that Self-Ask improves performance on multi-hop question answering tasks by narrowing the compositionality gap in language models. 

---

### 2. **Successive Prompting**

- **Citation**: Dua, D., Gupta, S., Singh, S., & Gardner, M. (2022). *Successive Prompting for Decomposing Complex Questions*. arXiv preprint arXiv:2212.04092.

- **Summary**: The authors propose *Successive Prompting*, an iterative approach where complex questions are broken down into simpler subquestions, each answered in sequence. This technique decouples the decomposition and answering processes, allowing for targeted supervision and improved performance on complex reasoning tasks. The method shows significant improvements on benchmarks like the DROP dataset.

---

### 3. **PC-SubQ Prompting**

- **Citation**: Sgouritsa, E., Aglietti, V., Teh, Y. W., Doucet, A., Gretton, A., & Chiappa, S. (2024). *Prompting Strategies for Enabling Large Language Models to Infer Causation from Correlation*. arXiv preprint arXiv:2412.13952.

- **Summary**: This study introduces *PC-SubQ*, a prompting strategy that guides language models through a series of subquestions aligned with the steps of the PC algorithm for causal discovery. By structuring prompts to reflect algorithmic reasoning steps, the method enhances the model's ability to infer causal relationships from correlational data. 

---
---

# Find reference for 5. Recursive Decomposition

### 1. **Recursive Decomposition of Logical Thoughts (RDoLT)**

- **Citation**: Qasim, K. U., Zhang, J., Alsahfi, T., & Butt, A. U. R. (2025). *Recursive Decomposition of Logical Thoughts: Framework for Superior Reasoning and Knowledge Propagation in Large Language Models*. arXiv preprint arXiv:2501.02026.

- **Summary**: This paper introduces RDoLT, a framework that enhances large language models' reasoning capabilities by recursively breaking down complex tasks into sub-tasks of increasing complexity. It incorporates a selection and scoring mechanism to identify promising reasoning paths and a knowledge propagation module that mimics human learning by tracking and propagating strong and weak thoughts. Evaluations across multiple benchmarks, including GSM8K and SVAMP, demonstrate that RDoLT outperforms existing techniques, achieving a 90.98% accuracy on GSM8K with ChatGPT-4, surpassing state-of-the-art methods by 6.28%. 

---

### 2. **Recursive Decomposition with Dependencies (RDD)**

- **Citation**: Hernández-Gutiérrez, S., Alakuijala, M., Nikitin, A. V., & Marttinen, P. (2024). *Recursive Decomposition with Dependencies for Generic Divide-and-Conquer Reasoning*. Presented at NeurIPS 2024.

- **Summary**: This work presents RDD, a scalable divide-and-conquer method for solving reasoning problems with large language models. RDD recursively decomposes complex problems into sub-problems, schedules their execution considering dependencies, solves them recursively, and merges the solutions. This approach supports sub-task dependencies, ordered execution, and error recovery, outperforming other methods in compute-matched settings as task complexity increases. 

---

### 3. **The Art of Socratic Questioning: Recursive Thinking with Large Language Models**

- **Citation**: Qi, J., Xu, Z., Shen, Y., Liu, M., Jin, D., Wang, Q., & Huang, L. (2023). *The Art of Socratic Questioning: Recursive Thinking with Large Language Models*. arXiv preprint arXiv:2305.14999.

- **Summary**: This paper proposes Socratic Questioning, a divide-and-conquer algorithm that mimics human recursive thinking by iteratively breaking down complex reasoning problems into approachable sub-problems. The approach leverages large language models to raise and answer sub-questions until sufficient information is gathered to address the original question. Experiments on tasks like MMLU and LogiQA demonstrate significant performance improvements over state-of-the-art prompting methods.

---
---

# Find reference for 6. Iterative Refinement Prompting

### 1. **SELF-REFINE: Iterative Refinement with Self-Feedback**

- **Citation**: Madaan, A., Lin, S., Gupta, A., Radev, D., & Callison-Burch, C. (2023). *SELF-REFINE: Iterative Refinement with Self-Feedback*. Proceedings of the 37th Conference on Neural Information Processing Systems (NeurIPS 2023).

- **Summary**: This paper introduces SELF-REFINE, a prompting framework where a language model iteratively improves its outputs by generating feedback on its own responses and refining them accordingly. The process continues until a stopping criterion is met, such as achieving a satisfactory output. SELF-REFINE demonstrates significant performance improvements across various tasks, including code generation and sentiment analysis, without requiring additional training or external supervision.

---

### 2. **PREFER: Prompt Ensemble Learning via Feedback-Reflect-Refine**

- **Citation**: Zhang, C., Liu, L., Wang, J., Wang, C., Sun, X., Wang, H., & Cai, M. (2023). *PREFER: Prompt Ensemble Learning via Feedback-Reflect-Refine*. arXiv preprint arXiv:2308.12033.

- **Summary**: PREFER proposes a method that ensembles multiple prompts and iteratively refines them through a feedback-reflect-refine cycle. The approach aims to tackle issues like hallucination and instability in large language models by automatically synthesizing new prompts based on feedback from previous iterations. Experiments show that PREFER achieves state-of-the-art performance across various tasks by effectively leveraging iterative refinement.

---

### 3. **Iteratively Prompt Pre-trained Language Models for Chain of Thought**

- **Citation**: Wang, B., Deng, X., & Sun, H. (2022). *Iteratively Prompt Pre-trained Language Models for Chain of Thought*. arXiv preprint arXiv:2203.08383.

- **Summary**: This work explores an iterative prompting framework to enhance multi-step reasoning in pre-trained language models. By progressively eliciting relevant knowledge through context-aware prompts, the method addresses limitations in existing prompting techniques. The iterative scheme demonstrates improved performance on datasets requiring complex reasoning, highlighting the effectiveness of iterative refinement in prompting strategies.

---
---

# Find reference for zero-shot prompting

### 1. **A Practical Survey on Zero-Shot Prompt Design for In-Context Learning**

- **Citation**: Li, Y. (2023). *A Practical Survey on Zero-Shot Prompt Design for In-Context Learning*. In *Proceedings of the 14th International Conference on Recent Advances in Natural Language Processing* (pp. 641–647). Varna, Bulgaria: INCOMA Ltd.

- **Summary**: This survey provides a comprehensive review of in-context learning techniques, focusing on various prompt types, including zero-shot prompting. It explores different approaches to prompt design, such as manual design and optimization algorithms, and discusses their impact on large language model performance across diverse NLP tasks.

---

### 2. **ZeroPrompt: Scaling Prompt-Based Pretraining to 1,000 Tasks Improves Zero-Shot Generalization**

- **Citation**: Xu, H., Chen, Y., Du, Y., Shao, N., Wang, Y., Li, H., & Yang, Z. (2022). *ZeroPrompt: Scaling Prompt-Based Pretraining to 1,000 Tasks Improves Zero-Shot Generalization*. arXiv preprint arXiv:2201.06910.

- **Summary**: This paper introduces ZeroPrompt, a multitask pretraining approach designed to enhance zero-shot generalization. By scaling prompt-based pretraining to 1,000 tasks, the authors demonstrate significant improvements in zero-shot learning performance across various datasets, highlighting the effectiveness of task scaling over model scaling.

---

### 3. **Universal Self-Adaptive Prompting**

- **Citation**: Wan, X., Sun, R., Nakhost, H., Dai, H., Eisenschlos, J. M., Arik, S. O., & Pfister, T. (2023). *Universal Self-Adaptive Prompting*. arXiv preprint arXiv:2305.14926.

- **Summary**: This study presents Universal Self-Adaptive Prompting (USP), an automatic prompt design approach tailored for zero-shot learning. USP categorizes NLP tasks and selects suitable queries and model-generated responses as pseudo-demonstrations, enabling effective zero-shot performance across a wide range of natural language understanding and generation tasks.

---
---

AI-Driven Review Systems: Evaluating LLMs in Scalable and Bias-Aware Academic Reviews
https://arxiv.org/abs/2408.10365

---
