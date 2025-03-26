
1. **Identify and Organize Input Data**
    1. **Parse Description**  
        - Read through the entire chemical process description carefully.  
        - List the key pieces of information explicitly:
             - Reagents and quantities.  
             - Catalysts and solvents.  
             - Relevant equipment used and experimental conditions or environment* (e.g., “room temperature, atmospheric pressure”).  
           - Check for *missing or contradictory* data. If any exist (e.g., the most common solvent for inorganic materials is water).
           - Look for ambiguous wording and explorer possible interpretations 
           - State any *assumptions* needed to proceed.      
    2. **Validate Internal Consistency**  
        - Confirm whether the described reagents, conditions, or setups align with known chemical practices.  
             - *E.g., “Dissolving a known soluble salt vs. an insoluble salt.”*  
        - If contradictory or highly unusual statements appear, flag them explicitly. 
             - *E.g., “The text claims to dissolve barium sulfate to form a high-concentration solution, but barium sulfate is nearly insoluble.”*
         - If a particular contradictory phenomenon is implicit, consider if alternative interpretation is possible.
             - *E.g., if the text suggests dissolution of an insoluble substance, rather than explicitly indicates successful result.*
2. **Calculate molar quantities** 
    - Determine molecular masses and convert mass quantities
    - For liquids specified as volumes, look up densities (prefer authorities resources, such as established suppliers, e.g., Sigma Aldrich; use Wikipedia as a fall back), indicate information sources, and calculate molar quantities.
    - For gasses, assume ideal behavior and use associated equation for conversion, unless stated otherwise; make reasonable assumption about temperature and pressure, unless provided explicitly or implicitly (e.g., normal or standard units, such as standard liters). 
3. **Identify Key Reactivity Properties for Each Material**
    - Redox behavior (*e.g., typical oxidizers and reducers*)
    - Acid/base/amphoteric
    - Donor/acceptor of electrons
    - ions/molecules capable of forming complexes or insoluble compounds
    - Hydrolysis/solvolysis targets
    - Materials, highly sensitive to water, oxygen in air, etc.
    - etc.
4. **Explain Underlying Principles**
    - **List Relevant Chemical / Physical Principles**  
           - Use standard references or your chemical knowledge to identify what principles might apply:
             - *Solubility rules, stoichiometry, thermodynamics, reaction kinetics, pH effects, complex formation, etc.*  
           - For each principle, provide a short rationale or how it applies   
    - **Cite Known Scientific Data**  
       - If employing external data (e.g., solubility constants, molecular weights), **explicitly list** them
       - If the process requires additional data (e.g., pKa values, equilibrium constants) but these are not provided, state the assumptions
5. **Identify reaction candidates**
    - consider previously identified reactivities and to identify materials with complementary behavior
    - draft most likely candidate reaction schematics, balance equations.
        - Clearly state the *primary route* of the reaction or physicochemical process (such as dissolution).
    - consider which materials are in excess (make a reasonable explicit assumption about any missing quantities, e.g., solvent is almost always in excess).
    - check if material quantities are consistent with stoichiometry of reactions and make adjustments, if necessary (e.g., permanganate is typically reduced to Mn(||) in acidic conditions, but the reducer must be sufficiently strong and be in excess; heating/kinetics may also need to be taken into account; otherwise, if such conditions are not satisfied, manganese dioxide may need to be considered as the final reduction state.)
    - Note if any side components (e.g., ions, byproducts) form and consider their impact:
6. **Side Processes**
    - Investigate possible competing or side reactions.
    - Evaluate likelihood of these side processes.
    - Explain if these side reactions meaningfully alter the main outcome
7. **Identify Improbable or Impossible Outcomes**
    1. **Check Scientific Plausibility**  
        - Compare each claimed or implied outcome with basic chemical knowledge.
        - Consider alternative interpretations for any identified improbable implied outcome.
    2. **Provide a Concise Justification**  
        - For any flagged improbability, *briefly state the reason*.  
    3. **Suggest Resolution or Correct Interpretation**  
        - If an outcome is improbable, consider if there may exist an alternative sensible interpretation, indicate the most sound meaning.
8. **Structured, Hierarchical Output**
    1. **Organize the Final Result**  
        - Present the results in a step-by-step hierarchy that *mirrors your analysis*. For instance:
             1. **Data Recap**: Summarize input data and assumptions.  
             2. **Calculations**: Show any math or formula used.  
             3. **Chemical Reactivities**.
             4. **Chemical Principles Applied**: List solubility and stoichiometric points.  
             5. **Reaction Candidates and the Most Likely Balanced Processes**
             6. **Side Processes**: State whether they matter.  
             7. **Improbable Outcomes**: Flag and justify.  
             8. **Conclusions**: Provide final numeric or qualitative answers
    - **Highlight Reasoning (“Chain-of-Thought”)**  
        - Make explicit references to your sub-steps or logic in a transparent manner:  
    - **Include Any Disclaimers or Assumption Checks**  
        - If certain required data or steps were omitted or unknown:
