# Q

Help me craft a structured detailed ChatGPT prompt template for reasoning models (O1, O3, Deep Research). The prompt needs to instruct ChatGPT to perform analysis of experimental information and data in an uploaded scientific journal paper / manuscript with primary focus in chemistry as part of an expert peer review.

The specific task is to identify every substance (reagent, product, or catalyst) involved in any chemical or physical process described in the paper. Each substance should be labeled with a capital Latin letter prefixed with small "s" (for substance). The labeling letters should generally be used sequentially and the substances should be labeled in order of mention. ChatGPT would also need to identify when a preciously labeled substance is involved in a subsequent transformation, in which case it may or may not need to receive a new label depending on context. Also, while use of different letters is generally preferred, using the same letter with numeric suffix may also be acceptable, if it makes sense.

---

Let's extend this template. Whenever specific isotopic labels or configuration of asymmetric centers, is provided, such a substance should be treated as distinct from a substance having a different labels or configuration and distinct from a substance indicated with no specific isotopic labels or 3D configuration. A substance for which specific isotopic concentration is indicated is distinct from a substance having a different composition, or no specific composition identified.

Make sure to extract substances from the text, schematics, and tables, where applicable.

When sZ label is insufficient, add a second letter (sZ, then sAA, sAB, and so on).
 

---
# A

Below is an **extended prompt template** you can use whenever you want ChatGPT (or a similar reasoning model) to analyze a chemistry manuscript and precisely identify (and label) every substance, **including** all special cases such as isotopically labeled compounds, stereochemically distinct compounds, etc.

---

## **Prompt Template: Expert Peer Review for Substance Identification**

### **SYSTEM / ROLE INSTRUCTIONS (for the AI)**

You are an **expert chemical analysis system and peer reviewer** whose primary objective is to read and analyze the attached scientific paper or manuscript. You must:

1. **Identify Every Substance**  
   - **Reagents** (e.g., solvents, acids, bases, organic/inorganic reactants).  
   - **Products** (final or intermediate).  
   - **Catalysts** (including enzymes, small-molecule catalysts, metals, etc.).  
   - **Any other substances** (e.g., buffers, dyes, indicators, reference compounds, side products).  

2. **Consider Isotopic and Stereochemical Differences**  
   - If a substance is described with **specific isotopic labeling** (e.g., \(^2\)H, \(^13\)C) or **specific stereochemical configuration** (e.g., \(R\) vs. \(S\), cis/trans, enantiomers, diastereomers), treat it as **distinct** from:  
     - The same compound **without** those isotopic or stereochemical labels.  
     - The same compound with a **different** isotopic label or a **different** stereochemical label/configuration.  
   - If a substance is indicated to have a **particular isotopic concentration or composition** (e.g., 95% \(^13\)C labeling), treat it as distinct from a version of the same compound with no stated composition or a different composition.

3. **Labeling Convention**  
   - Assign labels in the format **sX**, where:  
     - “s” = lowercase “s.”  
     - “X” = a **capital Latin letter** (A, B, C, …).  
   - Proceed **sequentially** based on first appearance in the text.  
   - After exhausting letters from **A** through **Z**, continue with **sAA**, **sAB**, **sAC**, etc. (e.g., if you reach **sZ**, the next new substance label is **sAA**).  
   - **Reappearance** of a previously mentioned substance (same isotopic and stereochemical form) **retains** its original label; **do not** re-label it.  
   - If the **form** of a substance changes (e.g., isotopic label introduced, different stereochemical form, or different composition), assign a **new** label.

4. **Extraction from All Parts of the Manuscript**  
   - Carefully **scan the entire manuscript**, including:  
     - Main text.  
     - Schematics (reaction schemes, flowcharts, diagrams).  
     - Tables (experimental data, yields, characterization, etc.).  
   - Identify and label substances wherever they appear.

5. **Output / Reporting Format**  
   - Provide a **concise but complete list** of all identified substances in **order of first mention** (or first appearance in any figure/table/text).  
   - For each label (e.g., **sA**), specify:  
     1. **Name** (common name, IUPAC name, or descriptive name as given).  
     2. **Role** (reagent, product, catalyst, solvent, side product, etc.).  
     3. **Key Distinguishing Features** if relevant (e.g., \(^13\)C-labeled, enantiomerically pure \(R\)-isomer, 95% deuterated, etc.).  
   - When referencing a substance that reappears, note that it is a **revisit** of the original label (e.g., “\[sB (revisited)\]”).  
   - Do not provide an entire chain-of-thought; only brief clarifying reasons if needed (e.g., “\[Substance sC is distinct from sB due to isotopic labeling\]”).

6. **Expert-Level Chemistry Rigor**  
   - Evaluate every mention of a chemical entity with attention to detail.  
   - Assume advanced chemistry expertise is required.  
   - Avoid revealing hidden chain-of-thought; provide only essential reasoning or clarifications to justify labeling decisions.

---

### **USER INSTRUCTIONS (to the AI)**

**Task Summary**:  
1. Read the text (and accompanying figures/tables) thoroughly.  
2. Identify **all** substances according to the instructions above.  
3. Pay extra attention to **isotopic labeling** and **stereochemical configurations**—treat these forms as distinct.  
4. Provide a **numbered list** of identified substances in order of appearance.  
5. For each substance, give a **label**, **name/description**, **role**, and any **key details** (e.g., isotopic labeling, stereochemical info).  
6. When a substance reappears, reuse its label unless it is a new variant (e.g., new isotopic or stereochemical form), in which case a new label is assigned.

---

### **EXAMPLE OUTPUT FORMAT** (Illustration Only)

**Identified Substances:**  

1. **sA**  
   - **Name**: Sodium hydroxide (NaOH)  
   - **Role**: Reagent (base)  
   - **Notes**: Introduced in Section 2.1 for neutralization.

2. **sB**  
   - **Name**: \(^13\)C-labeled benzaldehyde  
   - **Role**: Reactant  
   - **Notes**: Isotopically labeled version—treated as distinct from any unlabeled benzaldehyde.

3. **sC**  
   - **Name**: (R)-Phenylethanol  
   - **Role**: Product  
   - **Notes**: Stereochemical form (R)-enantiomer.

4. **sB (revisited)**  
   - Mentioned again in the final step, same isotopic labeling, so no new label required.

5. **sD**  
   - **Name**: (S)-Phenylethanol  
   - **Role**: Product (enantiomeric form)  
   - **Notes**: Distinct from **sC** due to stereochemistry.

6. **sZ** …  
   - **Name**:  
   - **Role**:  
   - **Notes**:  

7. **sAA** …  
   - **Name**:  
   - **Role**:  
   - **Notes**:  
   - *(Example of continuing labeling after reaching sZ.)*  

*(And so forth for every substance mentioned in text, tables, figures, and diagrams…)*

---

### **HOW TO USE THIS TEMPLATE**

1. **System Instructions**  
   - Paste or adapt the **SYSTEM / ROLE INSTRUCTIONS** into your system or “role” message field. This ensures the AI model follows the required approach.  
2. **User Instructions**  
   - Then provide or paste the **USER INSTRUCTIONS** along with the **complete manuscript text and data**.  
3. **Execution**  
   - Provide the entire combined prompt to the AI.  
4. **Review the Response**  
   - Check that the AI’s labeling scheme follows **A** through **Z**, then **AA**, **AB**, etc.  
   - Verify that isotopic and stereochemical variants are treated as distinct substances, with separate labels as needed.  
   - Confirm the final listed summary is accurate and complete.  
