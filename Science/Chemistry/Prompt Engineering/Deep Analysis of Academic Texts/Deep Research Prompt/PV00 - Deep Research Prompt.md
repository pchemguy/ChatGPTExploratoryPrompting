# Task:

Help me create a prompt for Deep Research analysis. The goal of this analysis is to identify any published prompts or prompt design strategies for deep analysis of experimental chemistry papers. The particular focus is on prompts assessing completeness of provided information and performing basic validation by doing internal consistency checks, such as mass balance check, and checks for consistency with established knowledge. Such prompts should implement workflow given below or any part of it.
# Base Workflow for Deep Analysis of Academic Texts:

1. **Key Findings**:
    - Identify and extract the primary result and any other major outcomes or observations.
    - Classify these results.
    - Focus on
        - claims of novelty: the title, abstract, and conclusions
        - supporting details: the experimental section and/or supplementary materials.
2. **Key Experimental Steps**:
    For each finding 
    - Classify it.
    - Identify and extract the specific experimental processes or procedures that led to it.
3. **Implementation**:
    For each experimental process identified above, gather and summarize:
    - **Materials**
        - List all starting materials, reagents, catalysts, and products/byproducts.
        - Record quantities, compositions, or concentrations.
    - **Key Equipment**
        - Note the type of equipment.
        - Include any critical performance characteristics.
    - **Process Parameters and Protocols**
        - Provide details such as reaction time, temperature, pressure, stirring rate, and other relevant conditions.
4. **Process analysis**:
    - Select an appropriate process model for each experimental procedure.
    - If relevant, identify governing equations or theoretical frameworks.
    - Using the model, the listed materials, and reported process parameters, estimate expected product yields.
    - Compare these estimates with the reported product amounts to perform a mass balance or consistency check.
5. **Special considerations**:
    - Review both the main text and any supplementary information, including tables and figures, for additional experimental details.
    - Identify any missing or inconsistent information necessary for a complete process analysis, and determine if it can be inferred.
    - If equipment details appear only in figures or schematics, interpret them, infer, if possible, information necessary for process analysis.
    - Integrate any inferred or supplemental data into your process analysis.
    - Highlight any discrepancies or omissions (e.g., missing mass balance data, contradictory parameter values) and assess their impact on the reliability of the reported results.
