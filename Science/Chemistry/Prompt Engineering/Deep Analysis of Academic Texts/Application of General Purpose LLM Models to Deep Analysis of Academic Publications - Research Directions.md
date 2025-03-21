# Task

Help me write a draft of an article based on provided context and material below. At this point, I see the article as containing three parts:
- The focus is on the **Deep Research Prompt** that comes last.
- The first section discusses Relevant Technical Aspects of LLMs important for the topic being discussed and suggested approaches.
- The middle section briefly discusses the structure of a scientific manuscript, highlighting aspects important for LLM-based analysis. While this matter should be considered as being part of the audience's expertise, the academic writing skill may often be developed/learned more like art, but high degree of rationalization and explicit verbalization are important, as such information must be taken into account explicitly for best result.
You need to
- analyze provided material
- improve language
- identify gaps in material and help fill them
- draft the article, paying attention to clarity and smooth flow.

# Instructions and context

Title: Prompt Engineering for Deep Analysis of Academic Publications - Research Directions

Audience: Graduate students, postdocs, researches, scientists in natural and life sciences with no technical knowledge about LLM / prompt engineering and limited to no familiarity with different types of models (non-reasoning vs. reasoning vs. deep research), their abilities to perform complex research-related tasks, their strength and weakness, and their suitability (when to use what type of model).

Goal: Discussion of potential abilities of top general purpose LLM models to perform deep academic publication analysis. Discussion of limitations of the brute-force approach (a-la "review manuscript"), potential strategies for addressing limitations using current state-of-the-art models in combination with advanced prompting techniques / prompt engineering, following by presentation of prompt engineering questions identifying potential prompt engineering research directions towards developing toolset for deep analysis of academic publications.

Format: Blogpost article / Markdown. The full text will be published on GitHub as "work-in-progress", and a summary to be generated will be published as social network posts targeting industrial and academic research community.

Note: Potential prompt engineering research directions are presented in the form of a structured **Deep Research Prompt** and that should be suitable to leading Deep Research models without tailoring to any specific vendor.

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

## Structure of an Academic Manuscript

- Key findings
    - Title: the main/central finding
    - Abstract and Conclusions: the main finding and other important results; both must clearly identify core novelties/contribution presented in the paper.
- Experimental details
    Primary source - Experimental Section, but useful information may also be contained in Abstract, Conclusions, Results and Discussions (while ideally no new experimental details should be presented outside the Experimental Section, no manuscript is ideal and other sections may contain derived characteristics that can be used for performing internal consistency checks). Some experimental data may only be presented in the form of tables or even as charts/diagrams, so those needs to be analyzed and interpreted as well.

### Classification of Experimental Chemistry Results

Each category includes two examples of paper titles/descriptions.

1. **Material-Focused: Novel Material Synthesis**
    Research primarily aimed at creating or isolating a **new** material (broadly defined: discrete chemical compounds, polymers, composites, solutions, etc.) that has not been previously reported. The central novelty lies in the material's structure, composition, or unique combination of components. Practical considerations (e.g., yield, cost, scale) are important but remain secondary to establishing that the material itself is new.
    - *"Synthesis and Initial Characterization of a Novel Porous Copper-Organic Framework for Gas Storage."*  
    - *"Discovery of a New Layered Calcium Silicate with Tunable Porosity."*  
2. **Characterization-Focused: Property Characterization Study**
    Work centered on **in-depth** measurement, description, and interpretation of the physical, chemical, spectroscopic, or other properties of a material. The compound itself may be known or previously reported, and the synthetic method may be routine; what is **new** is the extensive or specialized characterization. This category also applies to systematic comparative studies of properties if the main thrust is understanding or detailing those properties.
    - *"High-Resolution Solid-State NMR and X-ray Diffraction Analysis of a Known Magnesium Hydride."*  
    - *"Investigating the Electronic and Magnetic Properties of a Well-Studied Manganese Complex."*  
3. **Preparation-Focused: Enhanced Preparation Protocol**
    Studies that **optimize** or **significantly improve** existing methods to prepare a known material. Novelty derives from the improved protocol itself-factors such as yield, purity, sustainability, cost, safety, or scalability are prominently featured. This can include switching from multi-step to one-pot syntheses, use of greener/safer reagents, or employing new reaction conditions to streamline an established procedure.
       - *"A Greener One-Pot Synthesis of Acetylsalicylic Acid with Reduced Byproducts."*  
    - *"Optimized Palladium-Catalyzed Cross-Coupling Route Achieving 90% Yield for a Known Pharmaceutical Intermediate."*  
4. **Application-Focused: Novel Application Discovery**
    Papers highlighting a **new function or use** for a known chemical or class of chemicals in a context that has not been previously demonstrated. The emphasis is on showing **proof-of-concept** or practical feasibility of this new function, whether it's in catalysis, sensing, energy storage, drug delivery, or other domains.
    - *"Repurposing a Common Dye as a Photocatalyst for Solar Fuel Generation."*  
    - *"First Report of a Porphyrin Complex as a Biosensor for Early Disease Detection."*  
5. **Method-Focused: Methodological or Technological Advancement**
    Research introducing or significantly improving a **broadly applicable** chemical process, technique, or piece of equipment. The novelty is in the **method** rather than in the specific materials or the final product. This could involve new synthetic strategies, innovative analytical instrumentation, advanced reaction monitoring technologies, or any major leap in technique that could be applied across different projects or fields.
    - *"Development of a Continuous-Flow Microreactor System for Rapid Peptide Synthesis."*  
    - *"A Novel Electrochemical Detection Platform for Trace Metal Analysis in Water."*  
6. **Mechanism-Focused: Mechanistic Insight or Reaction Pathway Elucidation**
    Studies aiming to **reveal, confirm, or clarify** how a chemical reaction or process occurs. This may also include investigations of **physicochemical** or **physical/mechanical** processes that govern material transformations. Emphasis is on understanding reaction intermediates, transition states, kinetics, thermodynamics, or other fundamental mechanistic details.
    - *"Elucidating the Radical Pathway in a Copper-Mediated Cross-Coupling Reaction via Kinetic and Spectroscopic Studies."*  
    - *"Unraveling the Mechanism of Phase Transformation in Lithium Battery Cathodes Using In Situ X-ray Diffraction."*  

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

