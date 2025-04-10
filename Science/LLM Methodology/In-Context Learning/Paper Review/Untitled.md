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

#### C. Ad Hoc Classification for Guided Information Extraction

While gapAI effectively extracts specific information, parsing that information for deeper analysis can be challenging, and occasional variations occur even with stable targets like the main result. For example, the test paper claimed "economical enrichment of 17O-water... via slow evaporation and fractional distillation". A thorough analysis requires separating the _unmet need_ (access to cheap 17O-water) from the _claimed novelty_ (the specific combination of methods). This separation allows for independent assessment of the problem's significance and the ingenuity/validity of the proposed solution. To guide the model in making such distinctions generically, the prompt employs _ad hoc classification_. This involves defining categories tailored to the document type (experimental chemistry) and the specific analytical goals. For instance, Section IV.B.1 includes a "Classification of the Main Claimed Result based on targeted unmet need". This classification helps distinguish the problem being addressed. A potential refinement would be to add a separate, parallel classification specifically for the 'novelty component' (e.g., classifying the type of innovation claimed), rather than just adding comments, to enable even more distinct analysis of both aspects.

#### D. Behavioral Context & Persona Engineering

The **[II. Persona: Expert Critical Reviewer][Persona]** section focuses on behavioral context & persona engineering. While role prompting (instructing the model to act as a character) is common, this prompt goes further by rationalizing desirable reviewer characteristics and projecting them onto the model via detailed role descriptions with associated traits. To reinforce these traits and improve compliance within the large, complex prompt, multiple role models focusing on different character aspects were defined, and key instructions were intentionally repeated (given that models lack perfect recall).

The primary goals of this detailed persona engineering:
1. **Counteracting Outcome Bias:** This was crucial. Models often use reported results to justify methodology. The persona instructions repeatedly emphasize that results _cannot_ be used to validate methods; methodology must be assessed independently based on scientific principles because a core principle of scientific review is to evaluate the soundness of the methodology independently of the claimed outcome. A flawed method cannot yield reliable results, regardless of claims.
2. **Encouraging Rigor:** The persona promotes detailed, critical output, explicitly setting the standard as equivalent to a high-stakes academic examination scenario, demanding meticulousness, clear justification, and proactive identification of potential issues.
A third aspect addresses handling proof-of-concept studies, where some deviations from academic rigor might be acceptable if justified (this aspect is elaborated upon in the main workflow instructions).

*(Disclaimer: No formal evaluation was conducted on the specific effects of using multiple role models versus a single one, nor was the optimal frequency of strategic repetition determined. These remain potential areas for prompt engineering research.)*


#### E. Final Instructions & Default Workflow (`[V. Final Instructions for Interaction][Final Instructions]`)

[V. Final Instructions for Interaction][Final Instructions] primarily serves to reiterate crucial instructions, define the "default" analysis workflow triggered by general requests, and provide output context guidelines.

### 4. Prompt Development Process & Test Case

So, gapAI did not know what reviewing a paper meant. Perhaps, I could actually give it specific step-by-step instructions that gapAI could understand and execute and that would implement some kind of an equivalent of a review process, except what those instructions would be?... So I decided to resort to some reflection and generalization exercise: I started considering the various issues with the test paper and trying to articulate checks / analysis instructions targeting those issues in a generalized way.

#### Test Publication

For development and testing, I have used this [publication][EnrichmentURL] (repo [copy](Enrichment of H2 17O from Tap Water, Characterization of the Enriched Water, and Properties of Several 17O-Labeled Compounds.pdf) with SI), which is a remarkable example of a disastrous failure of the peer review process. (Actually, I am not sure which is more stunning: how ridiculous the main idea of the paper, how ineptly it was fabricated, how profoundly incompetent the PI on the paper is, or how on Earth this piece of work could ever reach reviewers, let alone get published in a good journal.) Well, at least I had an interesting specimen for my little AI project...

### 5. Formalizing Key Review Components in the Prompt

_(This section describes the specific analysis components defined within the prompt's framework, developed based on the process above)_

#### Main Result and Key Findings

The first logical step was to have the gapAI identify the main result and key findings. It turned out that gapAI could extract this information remarkably well. There was some variability, but it was not a big deal. However, from time to time, gapAI would return too much. To make this result more stable, I narrowed the search scope by taking advantage of conventional manuscript structure: the main result is often included in the title, and the main result and subsidiary key findings must be present in the abstract, conclusions, and, often, in the second part of introduction leading to the experimental section.

#### Multimodal Figure Analysis

Gemini _Advanced_ 2.5 Pro supports multimodal figure analysis, so I drafted the Section [IV.C. Analyzing Figures (Charts, Schematics, Photos)][FigureAnalysis] focused on figure analysis. The workflow involves overall description of the figure (which may include, for example, a schematic of experimental setup and a photograph) composition as the first step. The second step is detailed description of individual figure components. The Section IV.C intentionally places significant emphasis on photographs, as I wanted to push and test the model abilities, and, at the same time, to see that the model truly interprets the content of photos by comparing produced output with the actual photographs.

For example, in case of the present test manuscript, the prompt reliably identifies the aluminum foil (which is not mentioned anywhere in text) in figure S1 wrapped around the fractionating column. Instructions also specifically request to link visual information in pictures to information in schematics and text. Equally interesting (or even more), I wanted gapAI to gauge the scale on the figure by comparing the visual size of the feed RBF and its volume as described in text, gauge the flask diameter, and then use it as reference to estimate the size of the factional column, and I wanted have it all done without a single specific word - the instructions would need to remain generic as presented in Section IV.C. From run to run, the estimated relative size guessed by gapAI varies some, but for subsequent order of magnitude estimation of potential column efficiency the observed variation is irrelevant.

#### Experimental Protocol

The workflow for analyzing the experimental protocol is outlined in Section [IV.D. Analyzing the Experimental Protocol][Experimental]. Currently, this section is structured into two main parts: a general analysis (IV.D.1) and a detailed analysis focusing on the core experimental stages contributing to the main result (IV.D.2). While this provides distinct levels of scrutiny, the split adds complexity; defining different scopes of execution for a single, unified workflow might be a more streamlined approach for future refinement. For now, the described structure is used.

A key goal during the development of Section IV.D was to create generic instructions enabling the AI to perform quantitative feasibility checks. For instance, identifying the key processes (like the "pre-enrichment" evaporation and fractional distillation in the test case), finding appropriate theoretical models, extracting or estimating necessary parameters (from text, figures, or external knowledge), calculating expected outcomes (like maximum enrichment), and comparing these _a priori_ estimates against the authors' claims. _This goal is reflected in the sample analysis you provided (Section D.2, Stage A.F and B.F), where the prompt successfully guided the AI to perform idealized calculations (VPIE, Fenske) and compare the theoretical potential of the described methods to the authors' claims._

Furthermore, reflecting on the test case led to the inclusion of a specific "Plausibility Check" (corresponding to section D.2.5 in the sample analysis). This check involves assessing scenarios where:

- A study reports a setup performing significantly better than established analogs.
    
- A potentially disruptive result (e.g., cheap access to valuable material) is claimed.
    
- Conventional equipment/principles are used (perhaps with poor practices).
    
- No clear, innovative modifications enabling the result are presented or justified scientifically.
    

If these conditions are met, the prompt guides the AI to question the _a priori_ plausibility: is it likely such a straightforward path to a high-impact result would be undiscovered in an established field? _This check, directly inspired by the test case, instructs the AI to compare the claimed impact against the apparent simplicity/novelty of the method, flagging potential inconsistencies that demand extraordinary evidence, as seen clearly in the sample analysis conclusion (D.2.5)._