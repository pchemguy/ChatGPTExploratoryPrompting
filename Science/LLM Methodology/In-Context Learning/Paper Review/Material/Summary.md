This report demonstrates a proof-of-concept of an advanced AI prompt designed to simulate peer review for experimental chemistry manuscripts. The [prompt](PeerReviewPrompt.md) leverages also discussed Persistent Workflow Prompting and hierarchical, modular, Markdown-driven architecture to guide AI models through a critical evaluation process without requiring coding or specialized software. This prompt has been developed and tested using *Gemini Advanced 2.5 Pro* and this [publication][EnrichmentURL], and its key features are highlighted below (detailed feature list [here](FrameWork_Features.md)). The design focuses on translating the complex, often tacit, process of human peer review into concrete, executable steps for the AI, including identifying main claims, analyzing figures multimodally, and scrutinizing experimental protocols for logical flow, completeness, quantitative feasibility, and overall plausibility. 

**Basic usage (primary target: Gemini Advanced 2.5 Pro):**  
1. Input the full **RAW Markdown-formatted** [prompt](PeerReviewPrompt.md) in a new chat.
2. Submit `Analyze the core experimental protocol` prompt with the manuscript and SI attached.

See demos for [Gemini Advanced 2.5 Pro][Gemini Demo] ([verbatim copy of analysis][Gemini Analysis]), [ChatGPT Plus o1][o1 Demo], and [SuperGrok Grok 3 Think][Grok Demo] (click on "Analysis of Core Experimental Protocol for H<sub>2</sub><sup>17</sup>O Enrichment" at the bottom). Be aware that advanced components like process modeling, calculations, and multi-modal analysis may yield variable or failed results. In essence, the project demonstrates how sophisticated prompt engineering can enable standard advanced LLMs to perform complex, domain-specific analytical tasks like simulating a critical scientific review, pushing the boundaries of zero-code AI application.


Persistent Workflow Prompting enables an advanced proof-of-concept AI prompt designed to simulate rigorous academic peer review, specifically for experimental chemistry manuscripts. The prompt leverages in-context learning and a detailed, Markdown-driven architecture to guide Large Language Models (LLMs), primarily targeting Gemini Advanced 2.5 Pro, through a critical evaluation process without requiring coding or specialized software.

A proof-of-concept Persistent Workflow Prompt design enables simulation of the peer review process

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


This post introduces a proof-of-concept LLM [prompt](PeerReviewPrompt.md) simulating academic peer review for experimental chemistry manuscripts, discusses related prompt engineering concepts, and suggests possible research directions. This prompt has been developed and tested using this [publication][EnrichmentURL], and its key features are highlighted below (detailed feature list [here](FrameWork_Features.md)).  

**Basic usage (primary target: Gemini Advanced 2.5 Pro):**  
1. Input the full **RAW Markdown-formatted** [prompt](PeerReviewPrompt.md) in a new chat.
2. Submit `Analyze the core experimental protocol` prompt with the manuscript and SI attached.

See demos for [Gemini Advanced 2.5 Pro][Gemini Demo] ([verbatim copy of analysis][Gemini Analysis]), [ChatGPT Plus o1][o1 Demo], and [SuperGrok Grok 3 Think][Grok Demo] (click on "Analysis of Core Experimental Protocol for H<sub>2</sub><sup>17</sup>O Enrichment" at the bottom). Be aware that advanced components like process modeling, calculations, and multi-modal analysis may yield variable or failed results.