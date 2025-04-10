This document describes an advanced AI prompt designed to simulate rigorous academic peer review, specifically for experimental chemistry manuscripts. The prompt leverages in-context learning and a detailed, Markdown-driven architecture to guide Large Language Models (LLMs), primarily targeting Gemini Advanced 2.5 Pro, through a critical evaluation process without requiring coding or specialized software.

**Key Features:**

- **Method-Centric Analysis:** Critically evaluates experimental methods based on fundamental scientific principles _before_ considering claimed results, aiming to counteract outcome bias.    
- **Comprehensive Information Processing:** Extracts, infers, and integrates information from text, tables, and figures across the manuscript.
- **Quantitative & Visual Validation:** Performs feasibility calculations and analyzes figures/photos to quantitatively assess if methods could realistically achieve reported outcomes and to cross-validate visual information with text.
- **Structured Workflow:** Uses a hierarchical, modular prompt structure that acts like a persistent "workflow library" within the LLM's context memory, enabling guided, multi-step analysis through subsequent user interactions.
- **Persona Engineering:** Employs detailed role-prompting to instill characteristics of a rigorous, skeptical expert reviewer.

**Technical Approach:**

The prompt relies heavily on prompt engineering techniques to overcome LLM limitations in domain-specific knowledge and multi-step reasoning. It explicitly defines different types of context (input, transformation, output, behavioral) and utilizes strategies like hierarchical decomposition, chain-of-thought, ad hoc classification, and N-shot learning principles (implicitly through detailed instructions). The design focuses on translating the complex, often tacit, process of human peer review into concrete, executable steps for the AI, including identifying main claims, analyzing figures multimodally, and scrutinizing experimental protocols for logical flow, completeness, quantitative feasibility, and overall plausibility. The development used a specific, flawed chemistry publication as a challenging test case.

In essence, the project demonstrates how sophisticated prompt engineering can enable standard advanced LLMs to perform complex, domain-specific analytical tasks like simulating a critical scientific review, pushing the boundaries of zero-code AI application.