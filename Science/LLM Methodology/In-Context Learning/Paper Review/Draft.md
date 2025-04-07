# Features

- Model Requirements: reasoning / thinking variants (tested on Gemini Advanced 2.5 Pro, SuperGrok Grok 3 Think, ChatGPT Plus o1)
- Multimodal analysis (Gemini Advanced 2.5 Pro only, as of April 2025)
    - analysis of figures, including photographs
    - integration of information in photos, schematics, text, and world knowledge
- Application - critical analysis of an experimental chemistry paper
- Methodology
    - Structured hierarchical prompt with internal references
    - Prompt framework active for the duration of the conversation
    - Prompt framework akin an application shell console with the underlying LLM prompt being an analog of basic OS shell console
    - In-context learning
    - Focused extraction of key findings (Title, abstract, intro, conclusions)
    - Ad-hoc semantic classification
    - Data inference and validation
        - inference of missing characteristics by analysis of photographs, textual information, and integration with world knowledge
        - back-of-envelope / order of magnitude / idealized calculations
        - appropriate governing equation selection
        - retrieving or estimating characteristics necessary for estimation
        - automatic selection of appropriate model by LLM 