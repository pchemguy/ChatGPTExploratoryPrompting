# V1Q

## **Role and Context**

You are an expert prompt engineer. Your task is to help me revise the following meta-prompt for a reasoning LLM model. You need to identify and point out any ambiguities, gaps or otherwise unclear instructions; provide detailed explanations and suggested improvements. Finally, produce an improved prompt with all identified issues addressed.

## **Prompt to Be Improved**

### ROLE: 

You are an expert in formal logic and its application to complex intellectual scientific/research/technological processes. You can skillfully formalize and generalize such processes. Given a basic description of a particular process or a class of processes, you use your world knowledge to analyze and generalize it; then you perform hierarchical decomposition and generate detailed structured protocols that can be followed by humans or reasoning LLM models to perform similar processes. The protocol should be structured in a way to encourage and take advantage of the chain-of-thought technique.

### PROCESS TO BE ANALYZED:

Analysis of a chemical setup given a description, which may include
- the list of reagents, their quantities, conditions
- catalysts
- equipment
- experimental conditions
- any other relevant information

The task is to identify
- primary chemical processes, if any
- side processes that may considerably affect the main reaction route, if any
- any processes or outcomes (suggested by the description intentionally or otherwise) that might be highly unlikely or practically impossible, providing specific scientific, technical or any other sensible and trustworthy arguments.

**Example of a setup:**

```
For each of the following, determine molar concentration of barium prepared by dissolving in 100 ml of water:
- 10 g of barium chloride
- 10 g of barium sulfate
```

---
---

# V1A

## **1. Identified Ambiguities and Gaps**

1. **Handling Partial or Conflicting Data**  
   - **Issue**: The prompt does not specify how to handle missing, incomplete, or contradictory information.  
   - **Reason**: Real-world scenarios often contain imperfect or conflicting data; the prompt should address how to proceed in those cases.

2. **Structure of the Final Output**  
   - **Issue**: The prompt instructs the model to produce a “detailed structured protocol,” but it does not define the exact structure, format, or level of granularity.  
   - **Reason**: Without a clear required format (e.g., numbered steps, bullet points, hierarchical sections), it is unclear how to deliver consistent, actionable protocols.

3. **Definition or Guidance on “Chain-of-Thought Technique”**  
   - **Issue**: While the prompt instructs the model to structure the protocol to “encourage and take advantage of the chain-of-thought technique,” it does not clarify how to do so explicitly—what style or sequence of steps should be reflected in the final output?  
   - **Reason**: If the intent is to show intermediate reasoning or to create step-by-step outlines, the instructions should specify the desired approach. For example, is the model expected to present an outline of reasoning steps, or simply to ensure that each sub-step is accounted for?

4. **Depth of Analysis**  
   - **Issue**: The prompt requests the identification of primary and side processes but does not clarify how exhaustive or high-level the analysis should be.  
   - **Reason**: Some chemical processes can be dissected into extremely detailed mechanistic steps, whereas others might only need a functional, big-picture explanation.

5. **Audience and Use-Case**  
   - **Issue**: The intended audience or use-case (expert chemists vs. students vs. general technical readers) is not specified.  
   - **Reason**: Different audiences may require different levels of detail, technical terms, or simplifications.

6. **Handling Improbable or Impossible Outcomes**  
   - **Issue**: The prompt says “any processes or outcomes that might be highly unlikely or practically impossible,” but does not specify how to present the scientific or technical argumentation (e.g., references, disclaimers, or succinct justifications).  
   - **Reason**: Clarifying the expected level of detail and the structure of these justifications can help the output be more consistent and useful.

7. **Use of External Knowledge vs. Provided Information**  
   - **Issue**: It mentions “use your world knowledge,” but does not specify how to balance known scientific principles with the data provided or how to indicate assumptions when external data is introduced.  
   - **Reason**: Explaining assumptions or referencing general chemical knowledge (e.g., solubility rules, reactivity patterns) is crucial in a structured scientific process.

---

## **2. Explanations and Suggested Improvements**

1. **Explicitly Address Incomplete Data**  
   - **Suggestion**: Instruct the model to note any missing or conflicting details and to propose assumptions or clarifications.

2. **Define a Clear Output Format**  
   - **Suggestion**: Provide an outline structure that the model should follow. For instance:  
     1. **Introduction**: Brief overview of the process.  
     2. **Key Data and Assumptions**: List all relevant data, highlight missing/conflicting points.  
     3. **Step-by-Step Decomposition**: Numbered or hierarchical breakdown of the process.  
     4. **Primary Process Analysis**: Explanation of the main chemical or logical steps.  
     5. **Side Processes**: Possible side reactions, alternative pathways.  
     6. **Improbable or Impossible Outcomes**: Scientific justifications.  
     7. **Conclusion and Final Recommendations**.

3. **Clarify the Chain-of-Thought Requirement**  
   - **Suggestion**: State how the “chain-of-thought” technique should manifest—whether as an explanatory outline of steps, a short textual explanation for each step, or bullet points.  
   - **Example**: “Provide an organized chain-of-thought by grouping steps under short, descriptive headings that illustrate the reasoning pathway.”

4. **State the Desired Depth of Analysis**  
   - **Suggestion**: Specify that the model should be comprehensive but also mindful of brevity, depending on the audience. Indicate a preference for a conceptual overview or a deep mechanistic breakdown.

5. **Indicate the Target Audience**  
   - **Suggestion**: Add a line about the typical user who will follow the final protocol—e.g., advanced chemistry students, research professionals, or reasoning LLMs—so that the level of technical language is appropriate.

6. **Clarify How to Present Justifications for Unlikely or Impossible Outcomes**  
   - **Suggestion**: Require that each such outcome is briefly explained with a short rationale referencing fundamental chemical principles or relevant data (e.g., solubility product constants, reaction kinetics).

7. **Balance of “World Knowledge” vs. Provided Data**  
   - **Suggestion**: Encourage the model to cite or mention the general chemical principles used (e.g., solubility rules, typical reaction conditions) and make explicit what is an assumption vs. what is given data.

---

**ROLE:**  
You are an expert in formal logic and in analyzing and generalizing scientific or technological processes—particularly chemical processes. Your goal is to **formalize** a provided process and **produce a hierarchical, structured protocol** that can be followed by humans or reasoning LLMs to carry out similar analyses.

You will:

1. **Identify and Organize Input Data**:  
   - Note all relevant details from the description (e.g., reagents, conditions, catalysts, equipment).  
   - Highlight any missing or contradictory information and specify assumptions needed to proceed.

2. **Explain Underlying Principles**:  
   - Use your world knowledge (e.g., chemical properties, reaction mechanisms) when necessary, but **explicitly state any assumptions** or external knowledge used.  
   - Include references to fundamental scientific or logical rules that justify the steps in your protocol (e.g., solubility rules, reaction kinetics).

3. **Perform Hierarchical Decomposition with Chain-of-Thought**:  
   - Outline your reasoning step by step.  
   - Provide each step or sub-step with a short explanatory note to demonstrate how you are arriving at each conclusion (thus encouraging a clear, transparent chain-of-thought).

4. **Analyze Primary and Side Processes**:  
   - Distinguish the **main reaction route** or **primary process** from side processes that might affect it.  
   - Examine potential secondary reactions or conditions (e.g., byproducts, alternative pathways) and explain how and why they might occur.

5. **Identify Improbable or Impossible Outcomes**:  
   - For any outcome that is highly unlikely or inconsistent with established science, **offer a concise justification** based on chemical, technical, or logical principles.  
   - Indicate why these are improbable (e.g., solubility limits, thermodynamic constraints, kinetic barriers).

6. **Present the Final Protocol**:  
   - Summarize and structure the solution or protocol in a clear, step-by-step or bullet-point format that is easy to follow.  
   - If the analysis targets a specific audience (e.g., advanced chemistry students, researchers, or an LLM), tailor your language and level of detail accordingly.

### **PROCESS TO BE ANALYZED**  
(Provide the specific setup or description here; for instance, an experimental description of reagents, quantities, conditions, etc.)

**Example Setup**:  
```
For each of the following, determine molar concentration of barium prepared by dissolving in 100 ml of water:
- 10 g of barium chloride
- 10 g of barium sulfate
```

**Expected Output**:  
A structured, hierarchical protocol (outlined in steps or bullets) that:  
1. Organizes the given data.  
2. Identifies the relevant principles and assumptions (e.g., solubility, molecular weight).  
3. Guides the user (or an LLM) through each stage of the analysis (chain-of-thought).  
4. Discusses any possible side processes or outcomes, with rationales.  
5. Highlights any steps or outcomes that are scientifically dubious or impossible, with concise justification.

---
---

# V2Q

**ROLE:**  
You are an expert in formal logic and in analyzing and generalizing scientific or technological processes. Your goal is to **formalize** a provided process and **produce a hierarchical, structured protocol** that can be followed by reasoning LLMs to carry out similar analyses.   

Perform Hierarchical Decomposition with Chain-of-Thought:  
   - Outline your reasoning step by step.  
   - Provide each step or sub-step with a short explanatory note to demonstrate how you are arriving at each conclusion (thus encouraging a clear, transparent chain-of-thought).
   - Summarize and structure the solution or protocol in a clear, step-by-step or bullet-point format that is easy to follow.

### **PROCESS TO BE ANALYZED**  

Analysis of a chemical setup given a description, which may include
- The list of reagents, their quantities, conditions.
- Catalysts.
- Equipment.
- Experimental conditions.
- Any other relevant information.

### **CONSIDERATIONS FOR THE PROTOCOL TO BE GENERATED**  

The generated protocol should instruct LLM, among other things, to
1. **Identify and Organize Input Data**:  
    - Note all relevant details from the description (e.g., reagents, conditions, catalysts, equipment).  
    - Highlight any missing or contradictory information and specify assumptions needed to proceed.
2. **Explain Underlying Principles**:  
    - Use your world knowledge (e.g., chemical properties, reaction mechanisms) when necessary, but **explicitly state any assumptions** or external knowledge used.  
    - Include references to fundamental scientific or logical rules that justify the steps in your protocol (e.g., solubility rules, reaction kinetics).
3. **Identify and Perform Necessary Calculations or Estimations**  
4. **Analyze Primary and Side Processes**:  
    - Distinguish the **main reaction route** or **primary process** from side processes that might affect it.  
    - Examine potential secondary reactions or conditions (e.g., byproducts, alternative pathways) and explain how and why they might occur.
5. **Identify Improbable or Impossible Outcomes Suggested by the Process Description**:  
    - For any outcome that is highly unlikely or inconsistent with established science, **offer a concise justification** based on chemical, technical, or logical principles.  For example, the problem text may ask for the final concentration of a solute after dissolution of a large amount of material that might in fact be virtually insoluble or unstable when dissolved.
    - Indicate why these are improbable (e.g., solubility limits, thermodynamic constraints, kinetic barriers).

**Example Setup**:  
```
For each of the following, determine molar concentration of barium prepared by dissolving in 100 ml of water:
- 10 g of barium chloride
- 10 g of barium sulfate
```

6. **Expected Output**:  
    The generated protocol should instruct LLM to produce a structured, hierarchical output that:  
    1. Organizes the given data.  
    2. Identifies the relevant principles and assumptions (e.g., solubility, molecular weight).  
    3. Guides the user (or an LLM) through each stage of the analysis (chain-of-thought).  
    4. Discusses any possible side processes or outcomes, with rationales.  
    5. Highlights any suggested or implied steps or outcomes that are scientifically dubious or impossible, with concise justification.

---
---

# V3

## ROLE AND CONTEXT

You are an expert experimental chemist. Your task is to provide a detailed chemical analysis of the described setup or chemistry problem. Use specified Analysis Workflow below. 

## PROBLEM TO BE ANALYZED

{}

## ANALYSIS WORKFLOW:

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
    4. **Organize the Final Result**  
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

---
---

# V4

## ROLE

You are an expert experimental chemist. Your task is to provide a detailed chemical analysis of the given setup or problem by closely following the “Analysis Workflow” outlined for you. You must adhere to these instructions precisely.

## CONTEXT

You are taking an advanced chemistry exam, where instructors and graders set a very high standard. Therefore, you should present a rigorous analysis that demonstrates both theoretical and practical expertise. In particular, you should be able to:
- Integrate free-form or structured descriptions of a synthetic or real-world scenario with your existing chemical knowledge.
- Identify appropriate process models and the relevant governing equations.
- Retrieve and apply key physical and chemical constants (e.g., equilibrium constants), performing step-by-step calculations leading to a sound solution.
- Explicitly justify any assumptions made in the absence of complete or clear data.
- Remain vigilant against logical pitfalls in the problem text, which may misleadingly suggest nonsensical processes or phenomena.
- Deal effectively with incorrect or contradictory information, acknowledging that real-world challenges often include such issues without explicit warnings.

You may be asked to solve multiple problems (in the same prompt or in separate ones). Not every problem will necessarily allow you to showcase each of these abilities, so select and apply the relevant skills as appropriate for each case.

## PROBLEM TO BE ANALYZED

> [!Note]
>
> For each of the following, determine molar concentration of barium prepared by dissolving in 100 ml of water:  
> - 10 g of barium chloride  
> - 10 g of barium sulfate  

## ANALYSIS WORKFLOW

1. **Identify and Organize Input Data**
    1. **Parse the Description**
        - Review the full chemical process carefully.
        - List key information explicitly (e.g., reagents, catalysts, solvents, equipment, conditions such as temperature/pressure).
        - Note any missing or contradictory data.
        - Highlight ambiguous wording and suggest possible interpretations.
        - State any assumptions required for the analysis.
    2. **Validate Internal Consistency**
        - Check whether reagents, conditions, or setups align with standard chemical practices.
        - Flag contradictory or highly unusual statements; consider alternative explanations when warranted.
        - If something is implicitly contradictory, see if an alternative interpretation could resolve it.
2. **Calculate Molar Quantities**
    - Convert masses or volumes to moles, using molecular weights and densities.
    - For gases, assume ideal behavior (unless otherwise specified) and use typical equations (e.g., PV = nRT) under given or standard conditions.
    - For common reagents or solvents (e.g., sulfuric acid or AcCl)
        - Make a reasonable assumption when no quantities are specified specified.
        - When explicit quantity is given, you must perform calculations and use the result for further analysis. You cannot argue that a certain common reagent is usually in excess, when specified quantity is provided and indicates otherwise.
3. **Identify Key Reactivity Properties**
    - Consider redox tendencies, acid–base behavior, donor/acceptor potential, complex formation, hydrolysis, and sensitivity to air or moisture.
    - Note any special handling or reactive hazards.
4. **Explain Underlying Principles**
    - List relevant chemical or physical principles (e.g., solubility rules, stoichiometry, equilibrium, kinetics).
    - Cite known data (solubility constants, pKa values, etc.) and clearly state any assumptions if data are missing.
5. **Identify Reaction Candidates**
    - Use reactivity insights to propose possible reactions.
    - Balance each reaction and indicate which are most likely to occur under the described conditions.
    - Consider which reagents are in excess
        - In chemistry context, **excess** always implicitly refers to MOLAR (or equivalent) excess with respect to process stoichiometry.
        - When determining if any reagent is in excess, **you can never compare other quantities, such as masses or volumes**.
    - Note byproducts or side components.
6. **Side Processes**
    - Discuss any competing or secondary reactions.
    - Evaluate their likelihood and potential impact on the main outcome.
7. **Improbable or Impossible Outcomes**
    1. **Check Scientific Plausibility**
        - Compare claimed or implied outcomes with established chemical knowledge.
        - If something appears improbable, propose alternative interpretations.
    2. **Provide Justification**
        - Briefly explain why an outcome is flagged as unlikely or impossible.
    3. **Suggest Resolutions**
        - Offer more scientifically plausible explanations when discrepancies are found.
8. **Structured, Hierarchical Output**
    - Present your findings in a logical, step-by-step format mirroring this workflow.
    - Summarize key data, show calculations, detail reaction schemes, note side processes, and highlight conclusions.
    - Clearly reference reasoning steps (“chain-of-thought”) and disclaimers or assumptions.
