# **AI-Assisted Multimodal Chemical Formula Validation: Insight from  Gemini Thinking Log**

## **Abstract**

This work explores prompt engineering strategies for the validation of chemical formulas in scholarly manuscripts using Large Language Models (LLMs). Building upon previous work on AI-driven peer review, we investigate the efficacy of various prompting techniques, from basic queries to complex framework, for identifying errors in chemical identifiers. Using a challenging test paper known to contain subtle errors, we demonstrate that simple, direct prompts yield unreliable results. More structured prompts show incremental improvements but still lack robustness. Key insights are derived from analyzing Gemini "thinking logs", which reveal challenges related to the models' inherent error-correction tendencies that can mask errors in input text. We then adapt previously demonstrated advanced approach employing Persistent Workflow Prompting (PWP) principles for context conditioning, combined with explicit instructions for multimodal analysis of figures yielding a proof-of-concept prompt for formula validation. This method demonstrates improved reliability in identifying errors both in text and figures. The findings highlight the potential of sophisticated, PWP-informed prompting and multimodal capabilities for chemical entity validation.

## **1. Introduction**

Previous work explored the application of advanced prompt engineering techniques, specifically Persistent Workflow Prompting (PWP), for the critical analysis of scholarly manuscripts in experimental chemistry, using a specific test paper [test paper][test paper] as a challenging case study. This article extends that investigation by focusing on a common yet critical task: the validation of chemical formulas within scientific texts. The same test paper, a 44-page document including its Supporting Information (SI), serves as a pertinent and challenging test case for this task due to known, subtle errors. For instance, page S-8 of the test paper's SI presents the formula for _ferrous ammonium sulfate_ as $\ce{Fe(NH4)2SO4}$, which incorrectly omits one sulfate group (the correct formula for ferrous ammonium sulfate, Mohr's salt, is $\ce{(NH4)2Fe(SO4)2*6H2O}$ or anhydrous $\ce{(NH4)2Fe(SO4)2}$). This exploration details the iterative process of developing prompts to reliably identify such chemical "needles in a haystack".

## **2. Approaches to Chemical Formula Validation with LLMs**

### **2.1. Direct Prompting Attempts and Initial Observations**

Initial efforts involved testing basic prompts with leading LLMs (Gemini Advanced 2.5 Pro and ChatGPT Plus o3). A simple prompt such as:
`Find mistakes in chemical formulas and names.`  
produced highly inconsistent and generally unreliable results, occasionally identifying the target error but lacking systematic accuracy.

A more structured prompt was subsequently developed:

```
## Chemical Formula Extraction and Validation from PDF

Execute the following task step-by-step:
1. Extract each and every chemical formula from the attached PDF.
2. For each extracted formula, extract every directly associated chemical name included in the text, if any.
3. For each extracted formula and associated names, consider if the chemical formula and associated names are correct and flag every formula/names combination that contains any errors.
4. For each flagged item, read the source PDF again and confirm that the item was extracted exactly. In case of any extraction errors, analyze the corrected item and consider if the flag should be removed.
5. Create a Markdown table that should include every flagged formula/names, clear description of any problems, corrected version, and clear reference location of the flagged items.
```

This refined prompt improved the quality of the output and increased the frequency of identifying the target error in $\ce{Fe(NH4)2SO4}$ [GeminiNaiveAnalysis][GeminiNaiveAnalysis]. However, reliability remained a significant issue.

An interesting observation arose from a slightly modified version of this prompt [GeminiNaiveAnalysisReaction][GeminiNaiveAnalysisReaction]. The LLM not only extracted chemical formulas but also identified and flagged an imbalanced chemical reaction scheme from page S-8 of the SI, immediately following the problematic ferrous ammonium sulfate formula. The reaction of Fe(II) and hydrogen peroxide was flagged due to an imbalance in iron atoms (3 Fe on the left, 2 Fe on the right). This error, previously overlooked by the author during manual review, was correctly identified and a balanced version proposed by the LLM. This highlighted the LLM's potential to uncover errors beyond the specific target, even when the prompt was focused on "formulas".

### **2.2. Challenges with LLM Default Behaviors**

Examination of Gemini's "Show thinking" logs (a feature providing insight into the model's processing steps) for various runs revealed a consistent pattern. The LLM often correctly extracted the target formula (e.g., "$\ce{Fe(NH4)2SO4}$: Ferrous ammonium sulfate (Mohr's salt)"). However, in the subsequent validation step, it would sometimes erroneously mark the pair as correct, e.g.:

**Identified Chemical Formulas/Names and Initial Validation:**  
...(Other log lines)...
$\ce{Fe(NH4)2SO4}$**: Ferrous ammonium sulfate. Correct.**

This behavior likely stems from a core strength of LLMs: their inherent capability for error correction and understanding intent despite minor inaccuracies in the input. For instance, querying `What is the capital of grate britain?` typically yields "London", with the misspelling of "Great Britain" being automatically corrected. While usually beneficial, this default error tolerance becomes a hindrance when the objective is to _detect_ such errors. This phenomenon is analogous to the "input bias" discussed in the PWP preprint, where the LLM's tendency to accept input information as factual needs to be actively countered for critical evaluation.

In the context of formula validation, the LLM's natural inclination to reconcile a slightly incorrect formula with its correct accompanying name complicates direct "contrasting" methods (as per Point 3 in the structured prompt above). To address this problem, strategies must either suppress this error-correction tendency in a controlled manner or employ more complex error detection algorithms that avoid direct comparison of such "complementary" yet potentially mismatched entities.

An early attempt at the latter approach involved a multi-step generation and comparison process (see "Appendix. Chemical Formula Analysis - Generated Formulas and Names" for the prompt and an example of LLM response). The intent was for the LLM to:

`Extract a chemical formula from text -> Generate a chemical name -> Generate a chemical formula -> Compare the _extracted_ formula with the _newly generated_ formula.`

This approach, while, possibly, better, still proved unreliable in practice, although some runs did yield interesting outputs, including references to external chemical databases.

## **3. Advanced Validation using PWP-Style Context Conditioning and Multimodal Analysis**

Given the limitations of direct and simple generative approaches, a more robust strategy was adopted, leveraging the context conditioning principles outlined in the PWP preprint. The _PeerReviewPrompt_ detailed in that work successfully mitigated input bias through comprehensive context setting.

A new prompt, the [ChemicalFormulasValidationPrompt][ChemicalFormulasValidationPrompt], was developed by adapting core sections from the _PeerReviewPrompt_:

- Sections **I-III** (Core Objective, Persona, Context: Framework for Critical Review) were largely retained to establish the analytical mindset and operational guidelines.
- Section **V** (Final Instructions for Interaction) was kept to ensure consistent LLM behavior.
- Section **IV.A** (Foundational Principles & Workflow Application) was adapted.
- A new **Chemical Identifier Analysis** subsection was introduced into Section **IV** specifically for formula and name validation, including explicit instructions for multimodal analysis of figures.

This PWP-style prompt can be submitted to the LLM initially (with or without the target PDF). A subsequent query, such as:

`Perform comprehensive Chemical Identifier Analysis`

with the target PDF attached, then initiates the validation workflow.

Demonstration AI chats using this approach with Gemini 2.5 Pro (via Google AI Studio, which often shows enhanced performance over the standard subscription-based Gemini app interface) [GeminiAnalysis][GeminiAnalysis] and ChatGPT Plus o3 [ChatGPTAnalysis][ChatGPTAnalysis] showed improved robustness and reliability. The current [ChemicalFormulasValidationPrompt][ChemicalFormulasValidationPrompt] instructs the LLM to output a table of _all_ extracted chemical formulas, detailing any identified issues and providing corrected versions, or a checkmark if no error is found.

Crucially, this advanced approach consistently identified the target error in $\ce{Fe(NH4)2SO4}$. Furthermore, due to the explicit instruction to perform multimodal analysis (specifically, analyzing figures), the Gemini model also reproducibly identified another error that had been missed in prior manual reviews:

In Figure 2c (page 235 of the main text of the [test paper][test paper]), an NMR spectrum is presented with a label $\ce{(CH3)3Si2O}$ for hexamethyldisiloxane. The correct formula is $\ce{((CH3)3Si)2O}$ or $\ce{(CH3)6Si2O}$. Gemini correctly flagged the inconsistency in the depicted formula.

While occasional false positives were observed in the outputs from both models, the PWP-conditioned prompt with multimodal instructions demonstrated a marked improvement in reliably detecting subtle chemical formula errors, including those embedded within figures. While ChatGPT o3 model is advertised as being capable of multimodal analysis, it failed to identify the error in the figure.

## **4. Discussion**

The journey from simple prompts to a complex, PWP-style conditioned prompt for chemical formula validation highlights several key aspects of interacting with advanced LLMs for error detection tasks:

- **Default Error Correction as a Hurdle:** LLMs are designed to be helpful and understand user intent, often by correcting minor input errors. This becomes counterproductive when the goal is to identify those very errors in a source document. The models may "see" the correct entity implied by the context (e.g., the correct name alongside an incorrect formula) and validate based on that inferred correctness rather than the literal discrepancy.
- **Need for Explicit Critical Stance:** Similar to mitigating input bias in manuscript review, effective error detection requires conditioning the LLM to adopt a highly skeptical and detail-oriented persona, overriding its default tolerance. The PWP framework's emphasis on defining a critical persona and detailed analytical workflows appears beneficial here.
- **Value of Multimodal Analysis:** Chemical information is often presented in figures, diagrams, and spectra. Errors can exist in these visual elements. Explicitly prompting for multimodal analysis, as demonstrated by the identification of the incorrect hexamethyldisiloxane formula in a figure, unlocks a deeper level of validation that text-only analysis would miss.
- **Iterative Prompt Development:** Finding the right prompting strategy is an iterative process. Simple prompts are often insufficient for complex or nuanced tasks requiring high accuracy. Structured prompts, followed by more sophisticated context conditioning and the inclusion of specialized instructions (like multimodal analysis), are necessary to guide the LLM's reasoning effectively.
- **Insights from "Thinking Logs":** Access to the LLM's intermediate processing steps, even if variable in detail, can provide valuable clues about how the model is interpreting instructions and where potential misinterpretations or default overrides are occurring. This can inform further prompt refinement.

## **5. Conclusions**

Validating chemical formulas within scientific texts using LLMs presents unique challenges, partly due to the models' inherent error-correction capabilities that can mask the very errors targeted for detection. Simple prompting strategies are generally unreliable for this task.

This exploration demonstrates that:

1. Structured prompts offer incremental improvements but may still lack the necessary robustness for consistent error identification.
2. A more effective approach involves leveraging advanced prompt engineering principles, such as those embodied in the Persistent Workflow Prompting (PWP) methodology. By carefully conditioning the LLM's context with a critical persona and detailed analytical workflows, its default error-tolerant behavior can be guided towards more rigorous scrutiny.
3. Incorporating explicit instructions for multimodal analysis is crucial for comprehensive validation, enabling the detection of errors in figures and other non-textual elements.
4. The ability of LLMs to sometimes identify related errors not explicitly targeted by the user (e.g., the imbalanced chemical reaction) underscores their potential as powerful, albeit sometimes unpredictable, analytical assistants.


---

## **Appendix. Chemical Formula Analysis - Generated Formulas and Names**

### **Prompt**

```
Execute the following task step-by-step:
1. Extract chemical formulas of each and every chemical species containing at least two elements EXACTLY as they appear in the attached PDF.
2. For each extracted chemical formula generate associated name.
3. Convert each generated name to generated chemical formula.
4. For each generated chemical formula, determine if it matches previously extracted formula.
```

### **Response Example (Illustrative)**

#### Chemical Species Analysis from PDF

Here's an analysis of the chemical species found in the provided PDF document, "Enrichment of H2 17O from Tap Water, Characterization of the Enriched Water, and Properties of Several 17O-Labeled Compounds."

##### Extracted Chemical Formulas, Generated Names, and Formula Comparison

The following table details the chemical formulas extracted directly from the PDF (containing at least two elements), their generated chemical names, the chemical formulas regenerated from these names, and a comparison to determine if the original and regenerated formulas match.

|   |   |   |   |   |   |
|---|---|---|---|---|---|
|**#**|**Extracted Formula (from PDF)**|**Generated Chemical Name**|**Regenerated Chemical Formula (from Name)**|**Matches Original?**|**Source(s) for Name/Regenerated Formula**|
|1|$\ce{H2^{17}O}$|Water-17O|$\ce{H2^{17}O}$|Yes|[Sigma-Aldrich](https://www.sigmaaldrich.com/US/en/product/aldrich/602949), [Sigma-Aldrich](https://www.sigmaaldrich.com/US/en/product/aldrich/603058)|
|2|$\ce{CDCl3}$|Deuterated chloroform|$\ce{CDCl3}$|Yes|[EMBL-EBI](https://www.ebi.ac.uk/chebi/searchId.do?chebiId=CHEBI:85365), [Wikipedia](https://en.wikipedia.org/wiki/Deuterated_chloroform)|
|3|$\ce{Na^{17}OH}$|Sodium hydroxide-17O|$\ce{Na^{17}OH}$ (or $\ce{HNa^{17}O}$)|Yes|Name manually determined due to ambiguous search; Formula from [ChemSpider](https://www.chemspider.com/Chemical-Structure.9346004.html)|
|4|$\ce{H2^{17}O2}$|Hydrogen peroxide-17O2|$\ce{H2^{17}O2}$|Yes|[Sigma-Aldrich](https://www.sigmaaldrich.com/US/en/product/aldrich/574864), [ChemSpider](https://www.chemspider.com/Chemical-Structure.58824490.html)|
|5|$\ce{H2O2}$|Hydrogen peroxide|$\ce{H2O2}$|Yes|[Britannica](https://www.britannica.com/science/hydrogen-peroxide), [US EPA](https://cdxapps.epa.gov/oms-substance-registry-services/substance-details/153015), [AccessScience](https://www.accessscience.com/content/article/a329200)|
|6|$\ce{NO}$|Nitric oxide (Nitrogen monoxide)|$\ce{NO}$|Yes|[EMBL-EBI](https://www.ebi.ac.uk/chebi/searchId.do?chebiId=CHEBI:16480)|
|7|$\ce{H2O}$|Water (Oxidane)|$\ce{H2O}$|Yes|[Wikipedia](https://en.wikipedia.org/wiki/Water), [PubChem](https://pubchem.ncbi.nlm.nih.gov/compound/Water)|
|8|$\ce{H2^{18}O}$|Water-18O|$\ce{H2^{18}O}$|Yes|[PubChem](https://pubchem.ncbi.nlm.nih.gov/compound/Water-18O), [NIST WebBook](https://webbook.nist.gov/cgi/cbook.cgi?ID=C14314422&Mask=4)|
|9|$\ce{KH2PO4}$|Potassium dihydrogen phosphate|$\ce{KH2PO4}$|Yes|[American Chemical Society](https://www.acs.org/molecule-of-the-week/archive/p/potassium-dihydrogen-phosphate.html), [EMBL-EBI](https://www.ebi.ac.uk/chebi/searchId.do?chebiId=CHEBI:63036)|
|10|$\ce{K2HPO4}$|Dipotassium phosphate|$\ce{K2HPO4}$|Yes|[DrugBank](https://go.drugbank.com/drugs/DB09414), [Wikipedia](https://en.wikipedia.org/wiki/Dipotassium_phosphate), [PubChem](https://pubchem.ncbi.nlm.nih.gov/compound/Dipotassium-phosphate)|
|11|$\ce{KCl}$|Potassium chloride|$\ce{KCl}$|Yes|[BYJU'S](https://byjus.com/chemistry/potassium-chloride/), [Wikipedia](https://en.wikipedia.org/wiki/Potassium_chloride)|
|12|$\ce{RuO2}$|Ruthenium(IV) oxide|$\ce{RuO2}$|Yes|[Wikipedia](https://en.wikipedia.org/wiki/Ruthenium\(IV\)_oxide)|
|13|$\ce{NaI}$|Sodium iodide|$\ce{NaI}$|Yes|[Wikipedia](https://en.wikipedia.org/wiki/Sodium_iodide)|
|14|$\ce{H2^{16}O}$|Water-16O|$\ce{H2^{16}O}$|Yes|[Sigma-Aldrich](https://www.sigmaaldrich.com/US/en/product/aldrich/329886), [SSHADE](https://www.sshade.eu/data/specie/MOLEC_1H216O)|
|15|$\ce{CH4}$|Methane|$\ce{CH4}$|Yes|[EMBL-EBI](https://www.ebi.ac.uk/chebi/searchId.do?chebiId=CHEBI:16183), [Wikipedia](https://en.wikipedia.org/wiki/Methane)|
|16|$\ce{HCl}$|Hydrogen chloride|$\ce{HCl}$|Yes|[Wikipedia](https://en.wikipedia.org/wiki/Hydrogen_chloride), [EMBL-EBI](https://www.ebi.ac.uk/chebi/searchId.do?chebiId=CHEBI:17883)|
|17|$\ce{NaOH}$|Sodium hydroxide|$\ce{NaOH}$|Yes|[Wikipedia](https://en.wikipedia.org/wiki/Sodium_hydroxide), [The Chlorine Institute](https://www.chlorineinstitute.org/sodium-hydroxide)|
|18|$\ce{NaCl}$|Sodium chloride|$\ce{NaCl}$|Yes|[EMBL-EBI](https://www.ebi.ac.uk/chebi/searchId.do?chebiId=CHEBI:26710), [Taylor & Francis](https://taylorandfrancis.com/knowledge/Engineering_and_technology/Chemical_engineering/Sodium_chloride/)|
|19|$\ce{Na2CO3}$|Sodium carbonate|$\ce{Na2CO3}$|Yes|[Home Science Tools](https://www.homesciencetools.com/product/sodium-carbonate-30-g/), [Wikipedia](https://en.wikipedia.org/wiki/Sodium_carbonate)|
|20|$\ce{NaHCO3}$|Sodium bicarbonate|$\ce{NaHCO3}$|Yes|[Wikipedia](https://en.wikipedia.org/wiki/Sodium_bicarbonate), [EBSCO Research Starters](https://www.ebsco.com/research-starters/chemistry/sodium-bicarbonate)|
|21|$\ce{Na2SO4}$|Sodium sulfate|$\ce{Na2SO4}$|Yes|[PubChem](https://pubchem.ncbi.nlm.nih.gov/compound/Sodium-Sulfate), [Wikipedia](https://en.wikipedia.org/wiki/Sodium_sulfate)|
|22|$\ce{MgSO4}$|Magnesium sulfate|$\ce{MgSO4}$|Yes|[FAO](https://www.fao.org/fileadmin/templates/agns/pdf/jecfa/cta/68/Magnesium_Sulfate.pdf)|
|23|$\ce{CF3}$|Trifluoromethyl radical|$\ce{CF3}$|Yes|[PubChem](https://pubchem.ncbi.nlm.nih.gov/compound/Trifluoromethyl-radical)|
|24|$\ce{NH2}$|Amino radical|$\ce{NH2}$ (or $\ce{NH2}\cdot$)|Yes|[Wikipedia](https://en.wikipedia.org/wiki/Amino_radical), [Wikipedia](https://en.wikipedia.org/wiki/NH2)|
|25|$\ce{CD3CN}$|Acetonitrile-d3|$\ce{CD3CN}$|Yes|[Merck Millipore](https://www.merckmillipore.com/INTL/en/product/Acetonitrile-D3,MDA_CHEM-102904), [Sigma-Aldrich](https://www.sigmaaldrich.com/US/en/product/aldrich/151807)|
|26|$\ce{CCl4}$|Carbon tetrachloride|$\ce{CCl4}$|Yes|[PubChem](https://pubchem.ncbi.nlm.nih.gov/compound/Carbon-Tetrachloride)|
|27|$\ce{KMnO4}$|Potassium permanganate|$\ce{KMnO4}$|Yes|[PubChem](https://pubchem.ncbi.nlm.nih.gov/compound/Potassium-Permanganate), [DermNet](https://dermnetnz.org/topics/potassium-permanganate)|
|28|$\ce{Fe(NH4)2SO4}$|Ferrous ammonium sulfate|$\ce{(NH4)2Fe(SO4)2}$ or $\ce{Fe(NH4)2(SO4)2·6H2O}$|No (Original likely a typo or refers to a different species than common Ferrous Ammonium Sulfate / Mohr's Salt which is a double salt)|[EMBL-EBI](https://www.ebi.ac.uk/chebi/searchId.do?printerFriendlyView=true&chebiId=76243&structureView=applet), [CAMEO Chemicals - NOAA](https://cameochemicals.noaa.gov/chemical/3473)|
|29|$\ce{KSCN}$|Potassium thiocyanate|$\ce{KSCN}$|Yes|[Wikipedia](https://en.wikipedia.org/wiki/Potassium_thiocyanate), [Spectrum Chemical](https://www.spectrumchemical.com/cas/333-20-0)|
|30|$\ce{Fe(SCN)3}$|Iron(III) thiocyanate|$\ce{Fe(SCN)3}$ (or $\ce{C3FeN3S3}$)|Yes|[PubChem](https://pubchem.ncbi.nlm.nih.gov/compound/Ferric-thiocyanate), [American Chemical Society](https://www.acs.org/content/acs/en/molecule-of-the-week/archive/i/iron-thiocyanate.html)|
|31|$\ce{CH3(CH2)5OH}$|1-Hexanol (Hexan-1-ol)|$\ce{C6H14O}$ (or $\ce{CH3(CH2)5OH}$)|Yes|[PubChem](https://pubchem.ncbi.nlm.nih.gov/compound/1-Hexanol), [Wikipedia](https://en.wikipedia.org/wiki/1-Hexanol)|
|32|$\ce{(CH3)3SiOH}$|Trimethylsilanol|$\ce{(CH3)3SiOH}$ (or $\ce{C3H10OSi}$)|Yes|[Sigma-Aldrich](https://www.sigmaaldrich.com/US/en/product/aldrich/725986), [Wikipedia](https://en.wikipedia.org/wiki/Trimethylsilanol)|
|33|$\ce{((CH3)3Si)2O}$|Hexamethyldisiloxane|$\ce{((CH3)3Si)2O}$ (or $\ce{C6H18OSi2}$)|Yes|[Wikipedia](https://en.wikipedia.org/wiki/Hexamethyldisiloxane), [Thermo Fisher](https://www.thermofisher.com/order/catalog/product/A11848.0F), [Ereztech](https://ereztech.com/product/hexamethyldisiloxane-107-46-0/)|
|34|$\ce{CF3CONH2}$|Trifluoroacetamide|$\ce{CF3CONH2}$ (or $\ce{C2H2F3NO}$)|Yes|[PubChem](https://pubchem.ncbi.nlm.nih.gov/compound/Trifluoroacetamide), [Fisher Scientific](https://www.fishersci.ca/shop/products/2-2-2-trifluoroacetamide-97-thermo-scientific-1/p-7021918)|

**Note on $\ce{Fe(NH4)2SO4}$:** The extracted formula $\ce{Fe(NH4)2SO4}$ does not directly correspond to the common compound Ferrous Ammonium Sulfate (Mohr's Salt), which is a double salt with the formula $\ce{(NH4)2Fe(SO4)2}$ or its hexahydrate $\ce{Fe(NH4)2(SO4)2·6H2O}$. The extracted formula suggests a 1:1 ratio of ammonium to sulfate, whereas Mohr's salt has a 2:2 (or 1:1 after simplifying the sulfate part if written as $\ce{FeSO4·(NH4)2SO4·6H2O}$). The regenerated formula from the name "Ferrous ammonium sulfate" typically refers to the double salt. The PDF on page S-8 in the supporting information lists "$\ce{Fe(NH4)2SO4}$" when discussing the quantitation of $\ce{H2O2}$. This might be a specific notation or a typo in the source document for what is commonly known as Mohr's Salt, or a different, less common species.

The analysis involved extracting formulas exactly as they appeared in the PDF, using web searches to generate their common chemical names, and then using those names to regenerate chemical formulas for comparison.

---

## **6. References**

- **PWP**: Markhasin, E. (2025). _AI-Driven Scholarly Peer Review via Persistent Workflow Prompting, Meta-Prompting, and Meta-Reasoning_. arXiv preprint. https://arxiv.org/abs/2505.03332.  
- **Test paper**: Prasad, B., Lewis, A. R., & Plettner, E. (2011). Enrichment of H217O from Tap Water, Characterization of the Enriched Water, and Properties of Several 17O-Labeled Compounds. _Analytical Chemistry_, 83(1), 231–239. https://doi.org/10.1021/ac1022887.
- **ChemicalFormulasValidationPrompt**: Chemical Formulas Validation Prompt. https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/ChemicalFormulasValidationPrompt/PWP/ChemicalFormulasValidationPrompt.md.
- **GeminiNaiveAnalysis**: Shared Gemini Chat Log. https://g.co/gemini/share/a62c19799936.
- **GeminiNaiveAnalysisReaction**: Shared Gemini Chat Log. https://g.co/gemini/share/70cd2d7b296b.
- **GeminiAnalysis**: Shared Google AI Studio Chat Log. https://aistudio.google.com/app/prompts/1CUpdXeLstQQp1y0UZ9R9ZvaBuhy6CNW1.
- **ChatGPTAnalysis**: Shared ChatGPT Chat Log. https://chatgpt.com/share/681f5b9f-375c-8004-b2f4-294c75371945.

[PWP]: https://arxiv.org/abs/2505.03332
[test paper]: https://doi.org/10.1021/ac1022887
[ChemicalFormulasValidationPrompt]:https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/ChemicalFormulasValidationPrompt/PWP/ChemicalFormulasValidationPrompt.md
[GeminiNaiveAnalysis]: https://g.co/gemini/share/a62c19799936
[GeminiNaiveAnalysisReaction]: https://g.co/gemini/share/70cd2d7b296b
[GeminiAnalysis]: https://aistudio.google.com/app/prompts/1CUpdXeLstQQp1y0UZ9R9ZvaBuhy6CNW1
[ChatGPTAnalysis]: https://chatgpt.com/share/681f5b9f-375c-8004-b2f4-294c75371945
[Private AI Revision Thread]: https://gemini.google.com/app/dc5446a3a1ddb0ef
