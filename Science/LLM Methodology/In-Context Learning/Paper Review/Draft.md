Proof of Concept LLM Prompt for Deep Experiment Chemistry Paper Analysis

# Features

- Model Requirements: reasoning / thinking variants (tested on Gemini Advanced 2.5 Pro, SuperGrok Grok 3 Think, ChatGPT Plus o1)
- Multimodal analysis (Gemini Advanced 2.5 Pro only, as of April 2025)
    - analysis of figures, including photographs
    - integration of information in photos, schematics, text, and world knowledge
- Application - critical analysis of an experimental chemistry paper
- Methodology
    - Structured hierarchical prompt with internal references
    - Modular prompt framework active for the duration of the conversation
    - Prompt framework akin an application shell console with the underlying LLM prompt being an analog of basic OS shell console
    - In-context learning
    - Analysis workflow
    - Focused extraction of key findings (Title, abstract, intro, conclusions)
    - Ad-hoc semantic classification
    - Extraction of numeric information from text and tables (probably from figures and photos during multimodal analysis) 
    - Data inference and validation
        - inference of missing characteristics by analysis of photographs, textual information, and integration with world knowledge
        - back-of-envelope / order of magnitude / idealized calculations
        - appropriate governing equation selection
        - retrieving or estimating characteristics necessary for estimation
        - automatic selection of appropriate model by LLM 
    - identification of key performance characteristics (such as HETP for a distillation column) 
    - analysis of experimental methodology
    - identification of the key experimental stages
    - identifying red flags and assessing their potential impact on the study results
    - evaluating context (like certain aspects of a proof-of-concept application study might be potentially relaxed in terms of academic research rigor, if such a move is deliberate, and a sound justification is provided that the core results/goals will not be no significantly influenced or if expected influence is understood, reasonably controlled, does not compromise the results, and there is a sound reason to follow such a path).
    - assessing a priori feasibility of reported study by comparing claimed results with a analysis of experimental methodology, model estimations, and general field knowledge.
    - assessing a priori plausibility that a high-impact result with trivial implementation may have been overlooked by qualified experts.
    - **structured toolkit** designed to guide LLM critique (e.g., define instruction sets for extracting main results, analysis of figures, analysis of experimental protocols)

Alternative design strategy: split design of prompts and interactive submission with individual queries
