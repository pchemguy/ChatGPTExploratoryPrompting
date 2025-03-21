# Q

The following list describes a generic workflow for analyzing experimental chemistry manuscript. This workflow will be a basis for an LLM prompt, and the analysis will be performed by an LLM. This workflow supposed is the basis of hierarchical decomposition of the analysis process to be performed by a CoT capable model. The goals include assessing completeness of provided information and performing basic validation by doing internal consistency checks, such as mass balance check, and checks for consistency with established knowledge. Help me streamline this prompt.

1. **Key findings**:
    - Identify and extract details about the main result and other major results.
    - Perform classification.
    - Novelty should be highlighted in title, abstract, and conclusions; details - in experimental section and supporting information.
2. **Key experimental steps**:
    For each finding 
    - Identify and extract details about associated individual experimental processes / procedures.
    - Perform classification.
3. **Implementation**:
    For each process, identify and extract information about
    - **Materials**
        - Lists of starting materials / reagents, catalysts, products / byproducts.
        - Quantities / composition.
    - **Key equipment**
        - Equipment type.
        - Key performance characteristics.
    - **Process parameters and protocols**
4. **Process analysis**:
    For each process
    - Select appropriate process model.
    - If appropriate, identify governing equations.
    - Given quantities of starting materials, process model, governing equations, and the list of products / byproducts, estimate products quantities and compare with reported results (mass balance check).
5. **Special considerations**:
    - Extract experimental information from both main text and any supporting materials.
    - If materials or their quantities are listed in tables, such information also needs to be extracted.
    - Identify any missing information necessary for process analysis; consider if such information can be inferred.
    - If equipment information is provided in the figures as photos / schematics
        - Interpret figures
        - Identify equipment
        - Identify key performance characteristics and consider if any values / value ranges for such characteristics can be inferred.
        - Integrate inferred data together with extracted data for **Process analysis**.
    - Consider if for any process redundant information related to mass balance checks is provided; perform consistency checks, if possible.

