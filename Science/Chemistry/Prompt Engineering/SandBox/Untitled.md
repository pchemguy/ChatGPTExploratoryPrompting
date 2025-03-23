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

