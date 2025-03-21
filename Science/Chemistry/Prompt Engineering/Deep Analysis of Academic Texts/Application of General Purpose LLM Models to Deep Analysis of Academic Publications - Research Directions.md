# Instructions and context

Title: Prompt Engineering for Deep Analysis of Academic Publications - Research Directions

Audience: Graduate students, postdocs, researches, scientists in natural and life sciences with no technical knowledge about LLM / prompt engineering and limited to no familiarity with different types of models (non-reasoning vs. reasoning vs. deep research), their abilities to perform complex research-related tasks, their strength and weakness, and their suitability (when to use what type of model).

Goal: Discussion of potential abilities of top general purpose LLM models to perform deep academic publication analysis. Discussion of limitations of the brute-force approach (a-la "review manuscript"), potential strategies for addressing limitations using current state-of-the-art models in combination with advanced prompting techniques / prompt engineering, following by presentation of prompt engineering questions identifying potential prompt engineering research directions towards developing toolset for deep analysis of academic publications.

Format: Blogpost article / Markdown. The full text will be published on GitHub as "work-in-progress", and a summary to be generated will be published as social network posts targeting industrial and academic research community.

Note: Potential prompt engineering research directions are presented in the form of a structured **Deep Research Prompt** and that should be suitable to leading Deep Research models without tailoring to any specific vendor.

Task:
Help me write a draft based on provided context and material below. At this point, I the the article as containing two parts. The focus is on the **Deep Research Prompt** that

# Section Drafts

## Relevant Technical Aspects of LLM  - results of initial brainstorming for the

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


- field scope: experimental chemistry due to author's background expertise
- format - deep research prompt
- disclaimer - aggressive use of LLM Chatbots for text development
- disclaimer - work-in-progress

## Deep Research Prompt - First Draft


 Conduct in-depth research on advanced prompt engineering strategies, methodologies, and best practices specifically designed for
 - Extraction of structured information from collections of academic STEM manuscripts and other science and engineering texts.
 - Subsequent analysis of the extracted information with the goal to validate extracted information, check for internal consistency and consistency with established knowledge.
 The focus should be on techniques applicable to multiple documents, not single papers.

 I am particularly interested in prompts that can be effectively applied across groups of publications in the following fields:

 - Experimental Chemistry:
    Explore prompts designed to extract structured data such as
     - Experimental parameters (e.g., temperature, pressure, concentrations, reaction time).
     - Experimental processes/procedures (e.g., extraction in superfluidic nitrogen, filtration, acquisition of 13C MAS NMR spectrum).
     - Experimental equipment (e.g., lab-scale distillation column, benchtop centrifuge).
     - Materials (e.g., reagents, catalysts, products, byproducts, individual chemicals, mixtures/compositions/solutions)
     - Key results with associated metrics (e.g., reaction yields, purity levels, spectroscopic data points)
     - Methodologies (e.g., specific synthetic routes, catalyst details)
     - Limitations discussed by the authors.
    
    Consider prompts designed for deep analysis of
    - Abstract and conclusions aiming to extract detailed information about both major and minor findings, including any quantitative information.
    - Experimental section aiming to extract as much specific experimental details as possible.
    - Processing and interpretation of tables, extracting all provided experimental information, such as changes of concentration or composition as the process progresses.
    - Interpretation of figures, including data trends, illustrated experimental equipment, etc. For experimental equipment, I am interested in identifying
        - Specific equipment types and variants (e.g., Bruker solution NMR spectrometer, lab-scale ion exchange column, conventional benchtop fractional distillation setup).
        - Inferring key performance characteristics based on the specific equipment identified (e.g., main field strength, resolution, and sensitivity for an NMR spectrometer, number of theoretical plates for a distillation column).  
        - Inferring probable values or value ranges for identified characteristics where possible (e.g., a typical lab-scale benchtop distillation column would have 5-10 theoretical plates).
    
    Consider prompts that might leverage information present in spectral data or reaction diagrams across multiple papers to identify trends or common experimental setups.

 The overall goal is to find prompt engineering techniques that enable the identification and organization of information such as experimental protocols, key results with associated metrics, and limitations discussed by the authors across a set of documents within these specific scientific domains.

 Specifically, the research should aim to uncover prompt design principles and examples that facilitate the extraction of:

 - Experimental parameters and conditions
 - Key findings and quantitative results with their associated metrics and statistical significance
 - Detailed methodologies and experimental protocols
 - Limitations and potential biases discussed in the papers
 - Relevant entities (e.g., chemical compounds) and their relationships

 The output of this research should provide insights into effective prompt engineering strategies for extracting structured information from groups of scientific papers in experimental chemistry, enabling downstream analysis and knowledge synthesis.

