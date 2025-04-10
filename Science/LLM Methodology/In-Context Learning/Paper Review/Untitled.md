## Reorganized Explanation with Enhanced Clarity & Detail (Conciseness Review)

This section outlines the methodology used to design a proof-of-concept LLM prompt for performing a meaningful critical review of an experimental chemistry manuscript, using Gemini Advanced 2.5 Pro as the primary target model (other advanced reasoning models might also be suitable with certain caveats). Achieving this goal required strong reasoning capabilities. Initial trials with `ChatGPT Plus o1` were promising but limited by usage caps and potential token constraints. Gemini 2.0 Flash Thinking yielded mixed results. Development accelerated significantly with the availability of Gemini Advanced 2.5 Pro (referred to here as _the model_ or gapAI), which offered the necessary reasoning power without restrictive usage limits, allowing for more efficient iterative development. The prompt follows the common practice of interacting with the AI anthropomorphically - using direct instructions as if addressing a human expert - based on the [idea](https://www.oneusefulthing.org/p/on-the-necessity-of-a-sin) that this convention facilitates interaction, despite the underlying differences in how AI processes information. This text follows a similar convention (e.g., when discussing AI's ability to *understand* user input).

### Prompt Design Methodology

#### Hierarchical Modular Analysis Framework

The prompt employs a structured approach, building upon common patterns that separate behavioral context (**Role/Persona**, **Context**) from the task description (**Task/Objective**). However, the complexity of the manuscript review task required moving beyond this basic functional separation to develop a considerably more detailed structure. This structure places primary focus on _how_ the analysis should be performed and _what_ specific steps to take - components typically elaborated only in advanced, highly specialized prompts.

Several advanced design strategies are employed. The core of the prompt's methodology lies in **Section [IV. Specific Analysis Instructions (Baseline Framework)][Framework]**, which implements the simulated peer review workflow. This section organizes detailed instructions using established techniques like hierarchical decomposition and chain-of-thought. The instructions are formatted using Markdown, which is submitted directly to the model; _this formatting is crucial for helping the model parse and understand the intended structure and relationships between the steps._

#### In-Context Learning & Workflow Library

A key technique involves designing the prompt to function as a persistent **workflow library** loaded directly into the model's context memory (this design intent is explained to the model in Sections [III. Context: Framework for Critical Manuscript Review][Framework] and [V. Final Instructions for Interaction][Final Instructions]). Instead of generating an immediate, one-off answer, the main prompt's instructions are stored in the model's working memory for the session. When the user makes subsequent, specific requests, the model applies the relevant predefined workflow from this internal library. This approach avoids needing to resubmit the large framework repeatedly and enables more interactive, focused analysis.

The main **Section [IV. Specific Analysis Instructions][Framework]** serves as this library. For instance:
- A query about the main result triggers the workflow defined in [IV.B. Identifying Claimed Results and Contributions][MainResults].
- A request to analyze a specific figure uses the workflow in [IV.C. Analyzing Figures][FigureAnalysis].
- A combined request like `Analyze figures related to the main result` prompts the model to first execute the IV.B workflow, identify the relevant figures, and then apply the IV.C workflow to each.
- Analyzing the core experimental protocol ([IV.D.2][ExperimentalCore]) involves prerequisite workflows like IV.D.1, IV.B, and IV.C, executed logically based on instructions in IV.A.3. _(N.B.: The current implementation focuses core protocol analysis on key stages; further expansion is needed for full analysis.)_

This method utilizes a form of in-context learning. While conceptually similar to persistent instructions in features like Custom GPTs or Gemini Gems, this implementation embeds the workflows directly via the initial chat prompt.  

#### Ad Hoc Classification for Guided Information Extraction

While gapAI effectively extracts specific information, parsing that information for deeper analysis can be challenging, and occasional variations occur even with stable targets like the main result. For example, the test paper claimed "economical enrichment of 17O-water... via slow evaporation and fractional distillation". A thorough analysis requires separating the _unmet need_ (access to cheap 17O-water) from the _claimed novelty_ (the specific combination of methods). This separation allows for independent assessment of the problem's significance and the ingenuity/validity of the proposed solution. To guide the model in making such distinctions generically, the prompt employs _ad hoc classification_. This involves defining categories tailored to the document type (experimental chemistry) and the specific analytical goals. For instance, Section IV.B.1 includes a "Classification of the Main Claimed Result based on targeted unmet need". This classification helps distinguish the problem being addressed. A potential refinement would be to add a separate, parallel classification specifically for the 'novelty component' (e.g., classifying the type of innovation claimed), rather than just adding comments, to enable even more distinct analysis of both aspects.

#### Behavioral Context & Persona Engineering

The **[II. Persona: Expert Critical Reviewer][Persona]** section focuses on behavioral context & persona engineering. While role prompting (instructing the model to act as a character) is common, this prompt goes further by rationalizing desirable reviewer characteristics and projecting them onto the model via detailed role descriptions with associated traits. To reinforce these traits and improve compliance within the large, complex prompt, multiple role models focusing on different character aspects were defined, and key instructions were intentionally repeated (given that models lack perfect recall).

The primary goals of this detailed persona engineering:
1. **Counteracting Outcome Bias:** This was crucial. Models often use reported results to justify methodology. The persona instructions repeatedly emphasize that results _cannot_ be used to validate methods; methodology must be assessed independently based on scientific principles because a core principle of scientific review is to evaluate the soundness of the methodology independently of the claimed outcome. A flawed method cannot yield reliable results, regardless of claims.
2. **Encouraging Rigor:** The persona promotes detailed, critical output, explicitly setting the standard as equivalent to a high-stakes academic examination scenario, demanding meticulousness, clear justification, and proactive identification of potential issues.
A third aspect addresses handling proof-of-concept studies, where some deviations from academic rigor might be acceptable if justified (this aspect is elaborated upon in the main workflow instructions).

*(Disclaimer: No formal evaluation was conducted on the specific effects of using multiple role models versus a single one, nor was the optimal frequency of strategic repetition determined. These remain potential areas for prompt engineering research.)*

#### Final Instructions

The concluding **[V. Final Instructions for Interaction][Final Instructions]** section serves several key functions. Primarily, it reiterates crucial instructions from earlier sections, particularly reinforcing the core principles of the Persona (Section II) and critical constraints like independent methodological scrutiny (Section IV.A), ensuring these constituents are consistently applied throughout the interaction. It also defines the 'default' analysis workflow - the specific sequence of analysis steps (e.g., executing the full protocol analysis outlined in Section IV.D) that the model should perform automatically when given a general request like `Review this paper`, providing a standardized starting point. Finally, it provides output context guidelines, potentially including instructions on structuring the response, using Markdown effectively, citing sources appropriately, and explicitly stating assumptions, further ensuring the output meets the persona's rigorous standards.

### Formalizing the Review Process

A significant challenge involved translating the complex human task of scientific peer review into specific, executable instructions for the model. I approached this translation through reflection and generalization: I analyzed flaws in a specific test manuscript to articulate corresponding checks and analysis steps in a generic format applicable to other experimental chemistry papers. For development and testing, I selected a particular [publication][EnrichmentURL] (repo [copy with SI](Enrichment of H2 17O from Tap Water, Characterization of the Enriched Water, and Properties of Several 17O-Labeled Compounds.pdf)), which exhibited significant, demonstrable flaws, representing a remarkable example of a disastrous failure of the peer review process. (I am not sure which is more stunning: how ridiculous the main idea of the paper, how ineptly it was fabricated, how profoundly incompetent the PI on the paper is, or how on Earth this piece of work could ever reach reviewers, let alone get published in a good journal.) Because this paper is riddled with issues, it proved particularly helpful for developing relevant instructions via the reflect/generalize workflow and served as a challenging test case for the prompt's ability to guide critical analysis.

#### Main Result and Key Findings

Identifying the authors' main claimed result and key findings precisely is the crucial first step in the analysis workflow, as it defines the core assertions against which all evidence must be evaluated. While gapAI demonstrated a strong ability to extract this information, initial tests showed it sometimes returned peripheral points alongside the central claims, leading to variability. To improve stability and focus the starting point for the review, I refined the prompt instructions (Section IV.B) to narrow the model's search scope. Leveraging conventional manuscript structure, the prompt directs the model to identify the main result and key subsidiary findings based only on the information presented in the Title, Abstract, Introduction, and Conclusion sections. This focuses the initial analysis on the authors' explicitly stated primary contributions before delving into the detailed experimental support.

#### Multimodal Figure Analysis

Recognizing that Gemini _Advanced_ 2.5 supports multimodal analysis, I drafted Section Section [IV.C. Analyzing Figures][FigureAnalysis] to leverage this capability. The workflow requires an overall description of the figure's composition (panels, types) followed by a detailed description of each component. Section IV.C places significant emphasis on photographs, aiming to test the model's ability to truly interpret visual content and connect it to the text.

The effectiveness of this workflow was demonstrated on the test manuscript. For instance, the prompt reliably guided gapAI to identify the aluminum foil insulation in Figure S1 (not mentioned in the text) and to link visual elements in photographs to descriptions in schematics and text. A more ambitious goal, also achieved through generic instructions in Section IV.C, was to have the model infer scale and estimate dimensions. By prompting the model to compare visual sizes with known parameters (like the feed RBF volume mentioned in the text, allowing estimation of its diameter), it could then use that as a reference to estimate other dimensions, such as the length of the fractionation column. While the exact numerical estimates varied between runs, the resulting order-of-magnitude estimations were sufficient for assessing the potential efficiency of the described setup.









#### Experimental Protocol

The workflow for analyzing the experimental protocol is outlined in Section [IV.D. Analyzing the Experimental Protocol][Experimental]. Currently, this section is structured into two main parts: a general analysis (IV.D.1) and a detailed analysis focusing on the core experimental stages contributing to the main result (IV.D.2). While this provides distinct levels of scrutiny, the split adds complexity; defining different scopes of execution for a single, unified workflow might be a more streamlined approach for future refinement. For now, the described structure is used.

A key goal during the development of Section IV.D was to create generic instructions enabling the AI to perform quantitative feasibility checks. For instance, identifying the key processes (like the "pre-enrichment" evaporation and fractional distillation in the test case), finding appropriate theoretical models, extracting or estimating necessary parameters (from text, figures, or external knowledge), calculating expected outcomes (like maximum enrichment), and comparing these _a priori_ estimates against the authors' claims. _This goal is reflected in the sample analysis you provided (Section D.2, Stage A.F and B.F), where the prompt successfully guided the AI to perform idealized calculations (VPIE, Fenske) and compare the theoretical potential of the described methods to the authors' claims._

Furthermore, reflecting on the test case led to the inclusion of a specific "Plausibility Check" (corresponding to section D.2.5 in the sample analysis). This check involves assessing scenarios where:

- A study reports a setup performing significantly better than established analogs.
    
- A potentially disruptive result (e.g., cheap access to valuable material) is claimed.
    
- Conventional equipment/principles are used (perhaps with poor practices).
    
- No clear, innovative modifications enabling the result are presented or justified scientifically.
    

If these conditions are met, the prompt guides the AI to question the _a priori_ plausibility: is it likely such a straightforward path to a high-impact result would be undiscovered in an established field? _This check, directly inspired by the test case, instructs the AI to compare the claimed impact against the apparent simplicity/novelty of the method, flagging potential inconsistencies that demand extraordinary evidence, as seen clearly in the sample analysis conclusion (D.2.5)._




The workflow for analyzing the experimental protocol is detailed in Section [IV.D. Analyzing the Experimental Protocol][Experimental]. This section is currently structured in two parts:
- **IV.D.1 (General Analysis):** Provides a broad overview of the entire experimental workflow, assessing logical flow, completeness of reporting, contextual appropriateness (e.g., PoC vs. validation), and flagging general red flags (questionable methods, missing controls, safety issues) across all stages. 
- **IV.D.2 (Core Protocol Analysis):** Performs an in-depth, highly critical examination focused only on the specific experimental steps claimed to directly produce the main result.
This tiered structure allows for both a contextual overview and a focused deep analysis, although the split adds complexity. A potential refinement might involve defining different scopes of execution (e.g., 'overview', 'core analysis') for a single, unified workflow section.

A central goal during the development of Section IV.D was to embed instructions for performing quantitative feasibility checks based on fundamental principles - a critical aspect of rigorous scientific review. The prompt guides the AI to, for instance: identify key physical or chemical processes involved (like evaporation or distillation in the test case); select appropriate theoretical models (e.g., applying principles of phase equilibria, reaction kinetics, separation theory, or mass/energy balances); extract, estimate, or research necessary parameters (from text, figures, standard equipment specifications, or literature); calculate theoretically expected outcomes or limits (like maximum enrichment or theoretical yield) under idealized conditions; and crucially, compare these _a priori_, physics-based estimates against the authors' claims. The aim is to assess if the described method is fundamentally capable of achieving the claimed results, independent of whether the authors report success. This goal is reflected in the sample analysis provided (Section D.2, Stage A.F and B.F), where the prompt successfully guided the AI to perform idealized calculations (Vapor Pressure Isotope Effect, Fenske) and compare the theoretical potential of the described methods to the authors' claims.

Furthermore, reflecting on the test case led to the inclusion of a specific high-level "Plausibility Check" (corresponding to section IV.D.2.5). This functions as a sanity check, particularly relevant for potentially groundbreaking claims. It involves assessing scenarios where:
- A study reports performance significantly exceeding established benchmarks.
- A potentially disruptive result is claimed.
- The method relies on conventional equipment/principles, perhaps with custom modifications.
- No clear, scientifically justified innovative step is presented to explain the breakthrough.
If such a discrepancy between claimed impact and methodological basis exists, the prompt guides the AI to question the _a priori_ plausibility, considering the maturity of the field: is it likely such a straightforward path to a high-impact result would have been widely overlooked? This check, directly inspired by the test case, instructs the AI to compare the claimed impact against the apparent simplicity/novelty of the method, flagging potential inconsistencies that demand extraordinary corroborating evidence, as seen clearly in the sample analysis conclusion (D.2.5).
