

# **Zero-Code AI Simulation of Scholarly Peer Review via** **Persistent Workflow Prompting,** **Meta-Prompting, and Meta-Reasoning**

Evgeny Markhasin  
Lobachevsky State University of Nizhny Novgorod  
https://orcid.org/0000-0002-7419-3605  
https://linkedin.com/in/evgenymarkhasin

**Abstract**

Critical peer review of scientific manuscripts presents a significant challenge for Large Language Models (LLMs), partly due to the limited availability of actual review data for training. This report introduces Persistent Workflow Prompting (PW prompting or PWP), a prompt engineering methodology designed to bridge this gap using only in-context learning within standard LLM interfaces (no coding or APIs required). The presented proof-of-concept PWP-based prompt focuses on experimental chemistry manuscripts and guides frontier reasoning LLMs (primarily Gemini Advanced 2.5 Pro) through a systematic, multimodal analysis. The prompt features a hierarchical, modular architecture formatted in Markdown, defining complex review tasks as structured workflows. Submitted once at the start of a session, this master prompt equips the LLM with persistent workflows triggered by subsequent user queries (e.g., Analyze the core experimental protocol). Key capabilities demonstrated by the prompt include: identifying core claims vs. evidence, performing multimodal analysis integrating text and figures (including photographs), inferring missing parameters, executing quantitative feasibility checks via idealized process modeling and a priori estimations, comparing these estimations against claimed results, and assessing overall experimental plausibility. This work highlights the potential of advanced prompt engineering to enable complex, domain-specific reasoning and analysis in scientific research using readily available LLMs.

## **{{Demo Usage Protocol}}{{BMK: #Demo_Usage_Protocol}}**

Basic prompt usage (see prompt source in [**{{**supporting information (SI)**}}{{LNK: \#SI}}**](#bookmark=id.qww106bbd6eu) file *PeerReviewPrompt.md*):

* **Message 1**: Input the full raw Markdown-formatted prompt in a new chat.  
* **Message 2**: Submit *"Analyze the core experimental protocol"* prompt with the manuscript and SI attached.

Other sample prompts to try (manuscript only needs to be submitted once per chat):

* *Extract the main experimental result and key findings*  
* *List all figures and tables directly associated with the core experimental protocol and main result*  
* *Provide a detailed description of each figure associated with the core experimental protocol*

## **{{Supporting Information}}{{BMK: \#SI}}**

A full demo analysis of [1] (including SI) using the **{{**Demo Usage Protocol**}}{{LNK: #Demo_Usage_Protocol}}**:

* *Gemini_Analysis.pdf* (shared AI chat [2] - Gemini Advanced 2.5 Pro (primary target).  
* *ChatGPT_o3_Analysis.pdf* (shared AI chat [3, 4] - ChatGPT Plus o3.  
* Shared AI chats only: ChatGPT Plus o1 [5] and SuperGrok Grok 3 Think [6] (click on "Analysis of Core Experimental Protocol for H2\_17O Enrichment" at the bottom).

Note: advanced features like modeling and multimodal analysis may yield variable or failed results.

Markdown-formatted prompts:

* *PeerReviewPrompt.md*:	PWP-based experimental chemistry review prompt text for use with LLMs.  
* *DetailedMetaPrompt.md*:	Meta-prompt text for revision of prompts and meta-prompts (demo chat [7]).

## 1. **Introduction**

With rapid evolution of frontier large language models (LLMs), their power to handle complex expert-level tasks and related research, exploring means to expand LLMs' abilities in this area and prospective new applications, also intensify. Of particular interest are domain-specific STEM activities that continuously put human's intelligence to test and push the boundaries of the knowledge itself. This trend is witnessed, for example, by development of challenging benchmarks \[[8](#bookmark=id.wfh6s8fago0w)\] testing LLMs' abilities to solve problems from international subject olympiads (e.g., OlympiadBench \[[9](#bookmark=id.3mmz1c63fqzk)\]) and graduate/PhD/expert-level STEM problems (GPQA \[[10](#bookmark=id.oh5dxgcwiudt)\], SuperGPQA \[[11](#bookmark=id.p1h38w4v0tdk)\], SciQA \[[12](#bookmark=id.dth7f4cbll87)\] and \[[13](#bookmark=id.sxqkm33lg2fi)\], SciQAG \[[14](#bookmark=id.xpc1wmwjtmfa)\], and Humanity's Last Exam \[[15](#bookmark=id.2o91agmjza4s)\]). The quest for exploring new applications is also illustrated by the development of LLMs with custom tailored expertise and LLM-based expert systems \[[16–21](#bookmark=id.wz25nrk8gfib)\]. LLMs' abilities to handle such challenging tasks significantly improved with introduction of reasoning models, such as OpenAI o1 \[[22](#bookmark=id.6iicdrxp9s86)\] and the more recent Google Gemini 2.5 Pro \[[23](#bookmark=id.71lp704eqa7c)\]. However, these models are still limited when their training data lacks domain-specific facts or information necessary for devising a solution workflow. Several strategies can help bridge these gaps:

1. Tailoring a model specifically for a domain (e.g., chemistry) or task (e.g., chemical reaction extraction): the most resource-intensive option but offers maximum control.

2. Adapting (fine-tuning) existing models with domain-specific data: less resource-intensive than training from scratch but still requires expertise and faces certain constraints.

3. Providing necessary knowledge and workflow guidance directly within the prompt given to the LLM: often the most practical approach as it requires no changes to the underlying model and can be used with most available LLMs, including proprietary ones.

The last strategy generally relies on in-context learning (ICL \[[24–26](#bookmark=id.7wbt41qs0wpc)\]) and advanced prompt engineering techniques \[[27–35](#bookmark=id.6xfmbs82t8u)\] to bridge the knowledge gap between the model pre-training and the task at hand. This strategy is employed in the present study to the problem of implementing AI-assisted scholarly peer review.

### 1. **Scholarly Peer Review**

Scholarly peer review is a knowledge, reasoning, and time intensive process, and using various technical means for it facilitation is a long-standing problem. Its urgency only intensified with the explosive growth of publishing activities and the last-few-years advances in generative AI technologies and their increasing use in academic publishing and other related research activities. Just the last two years witnessed a wealth of publications attacking this automation problem from a variety of angles, including basic and methodological research \[[36–44](#bookmark=id.r52a2orxcl9x)\], graph-based modeling of manuscripts \[[45](#bookmark=id.eiz6qeih09ss)\], prompt-focused approaches \[[40](#bookmark=id.gw93ykgu304o), [44](#bookmark=id.97oru7w1feg5)\], probing the abilities of private and open-source models \[[36](#bookmark=id.r52a2orxcl9x), [46](#bookmark=id.n5038qs1aqtv), [47](#bookmark=id.c2f3q7w327fb)\], investigations involving reasoning models \[[38](#bookmark=id.k3o3psj318n5), [48](#bookmark=id.135qtlu6zv3s)\], training custom models \[[47–49](#bookmark=id.c2f3q7w327fb)\], developing complex multi-model and agentic systems \[[36](#bookmark=id.r52a2orxcl9x), [45–47](#bookmark=id.eiz6qeih09ss), [50](#bookmark=id.s175ax2bxord), [51](#bookmark=id.uxxzw9stsdqz)\], and launching publicly accessible services \[[36](#bookmark=id.r52a2orxcl9x), [41](#bookmark=id.mteul43ebctn), [48](#bookmark=id.135qtlu6zv3s), [52](#bookmark=id.oj160hgnf9d8)\]. Because of its intellectually challenging nature, seeking scholarly-peer-review-like feedback from AI is also a good means to learn advanced models and see how far they can be pushed.

While research on automation of peer review has been gradually progressing, this task remains a significant challenge for modern AI \[[37–39](#bookmark=id.rqzz4m1qounz)\] for several reasons, starting from its inherent complexity and the need to be tailored to specific field/subfield/journal. Historical lack of readily available training data is another reason why even state-of-the-art (SOTA) LLM models struggle with providing meaningful in-depth feedback. At the same time, there have been a number of attempts to address the latter issue \[[41](#bookmark=id.mteul43ebctn), [43](#bookmark=id.jvxrtq4fyaa3), [46–48](#bookmark=id.n5038qs1aqtv), [53–60](#bookmark=id.hk2x15livu14)\]. Another approach focused on developing prompts based on a set of questions similar to those provided in reviewer guidelines. One potential limitation of both of these approaches is reviewers are not generally expected to demonstrate detailed workflow analysis as part of their review. Quite the opposite, reviewers are requested to provide a simple list of comments, with each comment focused on a specific issue or question (e.g., \[[61](#bookmark=id.o3aaxng045al)\]). This kind of training material is less likely to give raise to tailored step-by-step chain-of-thought (CoT) \[[62–64](#bookmark=id.nwn6vr30419b)\] processes that are essential for complex tasks.

Yet another possible approach, explored in this work, would be to reflect on the manuscript analysis process and take advantage of ideas developed by advanced prompting techniques, including least-to-most prompting \[[65](#bookmark=id.fu6y3lrn3kwb)\], plan-and-solve prompting \[[66](#bookmark=id.kec5r14u3eo)\], role-play prompting \[[67](#bookmark=id.e8i6m1584a8x), [68](#bookmark=id.f7u2jmrtn7cx)\], PC-SubQ \[[69](#bookmark=id.e78gb6i49cvv)\], recursive decomposition with dependencies \[[70](#bookmark=id.ntxgmv7igppt)\]. Developing elaborate step-by-step guiding instructions to be used by AI for performing detailed and meaningful analysis of academic manuscripts is a challenging task of its own to a large extent because peer review involves a significant amount of tacit knowledge \[[71](#bookmark=id.ekh7ovjiorug)\]. Perhaps even a bigger question in this context would be to what extent tacit knowledge involved in research / engineering / medicine activities can be codified / formalized, that is reduced / decomposed to articulated actionable workflows or structured abstract / generalized protocols involving simpler steps accessible (whatever it means) to state-of-the-art (SOTA) AI. Further, to make such workflows / protocols useful, they would need to be of increasingly abstract / generalized nature but still elicit detailed and tailored responses from AI. This project attempts to develop and demonstrate one such workflow / protocol for analysis of experimental chemistry manuscripts.

### 2. **Scope and Limitations**

From the early beginning, the scope of the project has been restricted solely to frontier models widely available as chat bot services \- no APIs/coding, no special tools or complex systems, no specialized models \- the entire interaction with the model must occur via the standard generally available chat prompt. This way, any result could also be readily tested in similar settings by the largest possible community. The only allowed means to steer the models have been, therefore, ICL and advanced prompt engineering techniques.

While most referenced studies use non-reasoning LLM models (probably, because of their relatively recent release and usage limits), I decide to focus on reasoning models to maximize the result within the restriction of generally available models.

Among the important limiting characteristics are *context window length / input token limit*, *output token limit*, and *context recall accuracy*. Small context window of early models precluded from performing analysis on full size papers, let alone including supporting materials. And because prompt instructions, paper to be analyzed and any previous session or conversation communication materials must all fit within the same fixed context window, small context window also limits the size of instructions to be provided to the model. Furthermore, as context window usage increases, context recall accuracy may degrade, especially for information placed in the middle of long prompts \[[72](#bookmark=id.2l6a29mjgfnz), [73](#bookmark=id.jbej14za0sqh)\]. The output token limit, in turn, is often an order of magnitude smaller than the input token limit. If detailed analysis is requested from a model with insufficient output token limit, the model may start compressing the output, losing details and quality. Finally, input/output token caps (as well as availability of some other advanced features) often depend on the plan. Specific and reliable up-to-date information on features and caps is often difficult to find, but it is generally a good rule of thumb that complex tasks, which may push model features to the limits, should be developed on advanced plans.

All three characteristics (input/output token limits and recall accuracy) are very important for present approach, as the project focuses on developing a large structured prompt for detailed multimodal analysis of combined full-length manuscripts and associated supporting materials. A recent release of the Gemini Advanced 2.5 Pro model with a very large context window (presently 1M tokens), relatively large output token limit, reasoning capabilities, and multimodal analysis (the latter may not be available on the standard free plan) made this model a natural choice as the primary target (though the ChatGPT Plus o1 model has been also used). While the model does hallucinate to some extent and suffers form occasional recall inaccuracies, these issues have not been characterized and are left outside the present discussion.

## 2. **Methodology**

### 1. **Meta-Prompting**

Meta-prompting is an emerging methodology in prompt engineering [74, 75]. A prompt generally focuses on a specific question or problem one is trying to solve typically yielding solution to that *actual problem*. A meta-prompt is an abstraction, which focuses on the prompting process itself, and typically aims to affect the inference process in a particular way or seeks to produce a new prompt, which in turn will be used to find a solution to the *actual problem*. In practical terms, it is convenient to refer to the two stages of the meta-promptings/prompting workflow as *prompt generation* (aiming to develop *Prompt Under Developmеnt, PUD*) and *prompt execution*. 

Meta-prompting encompasses a range of techniques often helpful even for relatively simple problems and invaluable for developing complex prompts for complex problems. Prompt generation stage may employ the same LLM model, as the model to be used for subsequent prompt execution. Alternatively, a different model may be used for prompt generation or even a specialized prompt generator tool, such as the one provided by Anthropic [76] (note, this referenced post also provides a reference to the actual meta-prompt used by Anthropic’s prompt generator). The meta-prompting process should be considered as a complex task in a sense that frontier reasoning models are usually preferable for prompt development, particularly for complex tasks. Personally, I mostly focus on complex problems so I mostly use reasoning models for the actual tasks and usually use the same reasoning model for prompt generation.

For complex prompts and advanced prompting techniques, structuring the prompt text is essential for both developer and AI. Common formats used for structuring prompt texts include Markdown, XML, and JSON. This text and associated supporting materials all use Markdown formatting for structuring prompts (Obsidian.md has been used as the primary Markdown editor).

Different meta-prompting techniques can be classified in two groups. Task-agnostic techniques treat the prompt as a piece of technical writing and mostly focus on improving its linguistic characteristics. In this case LLM acts as an advanced proofreader, also capable of improving, for example, structure and clarity of the text. On the other end are techniques used for PUD developed for complex tasks where elaborate prompt-based LLM guidance is desirable. In such a cases, meta-prompts may become quite elaborate and no longer be task-agnostic. In such cases, LLM can act as a peer prompt engineer. In fact, for complex tasks necessitating complex prompt, such as the PeerReviewPrompt presented in this work or coding, meta-prompting techniques from both of these groups become essential. Let us now consider several meta-prompting techniques (note that often these techniques can be readily combined and/or chained).

#### 1. Language-Focused

In its basic form, a meta-prompt directly asks the LLM to improve another prompt:

`Help me improve the following prompt:`

`---`

`{PROMPT UNDER DEVELOPMENT}`

This meta-prompting pattern focuses on linguistic aspects of the {PROMPT\_UNDER\_DEVELOPMENT} ({PUD}) text. It may not provide detailing as to how to improve the prompt (as shown above), implicitly encouraging the LLM to treat the prompt as a piece of technical (or, possibly, creative) writing and applying general language-focused revision criteria and principle commonly employed by human editors. At the same time, because "world knowledge" is still available to the model during processing of the meta-prompt, the AI may also consider and revise the prompt semantics (as opposed to a human editor not being familiar with the {PUD} subject).

A more articulate meta-prompt may specifically emphasize certain aspects to be improved, such as clarity or structural and grammatical parallelism (see, for example, this style guide \[[77](#bookmark=id.ix3o7hwqf379)\], prepared for use with AI).

#### 2. Basic Iterative Refinement

A more advanced variation may ask the AI to consider the clarity of instruction and request a feedback:

`Analyze the following prompt and consider if instructions are clear, unambiguous, and complete. Provide feedback/questions on any potential issues.`

`---`

`{PROMPT UNDER DEVELOPMENT}`

This is a powerful pattern for iterative interactive prompt improvement, which can be followed by a complementary refinement prompt:

`Revise the prompt with the following answers, analyze it again and consider if there are still some questions (of if some answers are unclear). Provide additional feedback, if necessary, or generate a revised prompt with clear and well organized structure and language.`

`# Answers`

`{ANSWERS TO LLM FEEDBACK}`

#### 3. Meta-Meta-Prompting

In fact, even meta-prompts may become increasingly complex and elaborate, as they may use the same various prompt engineering techniques as those available to ordinary prompts. An example of such an elaborate meta-prompt is employed by Anthropic’s prompt generator (see the source reference in \[[76](#bookmark=id.pt55o08d3vb6)\]). In such a case, LLM-based analysis / revision of the meta-prompt may also be beneficial. Formally, such an operation introduces a second abstraction layer (LLM generates now not a prompt, but a meta-prompt); hence, meta-meta-prompting (also see this chat \[[78](#bookmark=id.cw8g9owpw5o0)\], which begins with a basic example of meta-meta-prompting before proceeding to the meta-prompting stage). While the same examples above can be used to revise meta-prompts as well, another, much more elaborate prompt, which I used for both meta-prompting and meta-meta-prompting, is included in [SI](#bookmark=id.qww106bbd6eu) and its use is demonstrated in this shared ChatGPT conversation \[[7](#bookmark=id.tbhhphgp1vu)\].

#### 4. Template-Based, ICL-Facilitated, and Guided Workflow Generation

Consider the following meta-prompt:

`Analyze the following prompt and consider if instructions are clear and unambiguous. Provide feedback/questions on any potential issues.`  
`Devise a workflow to be placed in place of "{TO BE SUGGESTED BY AI}".`

`---`

`## Persona:`  
`... (Description of a suitable role) ...`

`## Task:`  
`... (Description of the task) ...`  
`... (Detailed requirements) ...`

`## Processing Steps:`  
`{TO BE SUGGESTED BY AI}`

The idea is that decomposing complex multistep tasks into a sequence of simpler tasks (or workflow) and including this workflow in the prompt often yields better results, even when the LLM is potentially capable of solving the target task based on the plain-text description of the problem and desired results and any requirements. The generated draft of the prompt can then be examined, and the workflow can be refined manually or via one of the previously discussed prompt refinement techniques. This pattern provides a flexible compromise between CoT-based techniques and more time consuming, but providing most control, manual development of the desired workflow. I illustrated the use of this pattern in a GitHub-hosted GenAIandVBA project by developing a VBA/Word macro module "*modBibliographyHyperlinker*" that creates hyperlinks from in-text citations to bibliography entries \[[79](#bookmark=id.qaqz6xlib94n)\].

The following meta-prompt relies on in-context learning:

`Help me create a prompt, using previous prompts as a reference.`  
`The generated prompt should accomplish the following task:`

`## TASK TO BE ACCOMPLISHED BY THE GENERATED PROMPT`

`... (Task description) ...`

`Make sure to ask me for clarification, if necessary,`  
`before starting the prompt generation process.`

While conventionally examples are used to illustrate to the LLM the desired solution of an actual problem (ICL), the same approach can be applied during meta-prompting for prompt generation. For example, after developing the prompt for the "*modBibliographyHyperlinker*" macro module, I needed to create a conceptually similar macro module "*modZoteroFieldRecovery*". I could copy the refined prompt developed for generation of the first module and use it as reference. In this particular case, I simply continued development of the second prompt with the same AI chat \[[80](#bookmark=id.11ttjbxtjod)\].

On the other hand, letting the LLM generate the workflow from scratch based on a simple problem description may mean giving the model excessive flexibility. When this simplified strategy is not robust enough, consider creating the first draft of the workflow. Depending on the task, the first manually-crafted draft of the workflow may be a relatively high-level decomposition of the task or a more comprehensive protocol. This is the guided workflow generation variant, as initial draft of the desired workflow guides the model, as it generates a refined prompt. This approach is illustrated with prompt generation for the third VBA module in the same VBA project, "*MarkupProcessor*" \[[78](#bookmark=id.cw8g9owpw5o0)\]. In this case, the initial draft included fairly detailed guidelines under "Processing Steps" and other subsections of "Bookmarks and Internal Hyperlinks", greatly simplifying the subsequent debugging process.

#### 5. Complex Prompts

For very complex prompt development use the best reasoning models and treat them like a peer. Some examples of techniques that can be used, include (see shared AI chats \[[81](#bookmark=id.pvdy2qnrb9gg), [82](#bookmark=id.2cua43xkupkl)\] for details):

* Focused refinement:

`Here is my current version of the prompt. Improve paragraph 1 in D.2.`  
`---`  
`{CURRENT PROMPT WITH SECTION D.2}`

* Structure optimization:

`Do you see the two-level role of a researcher playing the role of a student? What are the pros and cons of this architecture? If it doesn't provide obvious benefits, how would I collapse it to a single role, while maintaining all features and specifications related to the ultimate objective? Which of the two roles would instruct Gemini to produce higher quality answers in terms of rigor, details, stability, and other requirements that are part of the prompt?`

`Reflect on this idea: generating a collapsed single role per recommendations, but reintroducing the student role not as a simulation, but specifying somehow this behavior as part of the experts role. The experts no longer pretend he is in a simulated exam, but he should strive to also exhibit key behaviors associated with the student role. Basically, stating something like "the expert should also follow expectations and practices expected of a student taking an advanced exam, perhaps a PhD-level or postdoc-level"`

`Help me integrate the hybrid persona definition into the previous Expert Analyst persona`

* Reflective refinement:

`How do I improve original prompt to make sure you do not use reported results for justifications?`

* Section generation from unstructured material:

`Help me define 5. **A Priori Plausibility  Assessment** from text`  
`---`  
`Does the main result involve a proposed process/technique/approach that is significantly superior compared to existing alternatives (cheaper, simpler, more accessible, more performant, etc.)? If yes, do the authors identify and highlight a propose novel highly unintuitive solution that was essential for achieving claimed result and provided a clear science based demonstration how such a solution enabled their achievement?...`  
`---`  
`as a bulleted list. All conditionals should be dropped and each question/assessment becomes its own bullet`

* Reverse-engineering with generalization

For example, Section [IV.D.2-3.F](#bookmark=id.3csegva49b53) of the PWP prompt was generated using the following algorithm (the source chat is unfortunately lost): first, a guided analysis similar to \[[83](#bookmark=id.a87nu5vddmn7)\] was performed; the, the model was asked in the same chat to extend the section IV.D.2-3 of the prompt such that a similar analysis is elicited when the PWP prompt is executed against experimental chemistry manuscripts. I explained that the ultimate goal was to instruct the model to identify a suitable model for the physical or chemical process being analyzed and appropriate governing equations to predict the outcome based on the described starting state and compare obtained estimates with claimed results. The model was also instructed not use wording/terms specific to the manuscript being analyzed.


### 2. **Prompt Architecture: Hierarchical Modular Analysis Framework**

#### 1. Scope and Test Publication

Because of my background in experimental physical chemistry, I defined experimental chemistry as the target scope, and developed the prompt accordingly. The development process started with selecting a suitable publication which could be used for testing the prompt and as a source of inspiration. In my archive, I had one peculiar publication \[[1](#bookmark=id.7da56ld7hdii)\] that has significant, demonstrable flaws, and it proved to be a convenient target for prompt development and testing. (Being the only test publication is a clear present limitation of the project; however, due to limited available resources, tests on other manuscripts have not yet been performed.) I have created a combined pdf from supporting information appended to the end of the manuscript file, and used this combined file throughout the development process.

#### 2. Persistent Workflow Prompting

Presented prompt incorporates select features of or builds on several advanced prompting techniques. At the top level is a common role-prompting structure that defines blocks of [Role/Persona](#bookmark=id.hcq45ah5k5l0), Context, and Task/Objective. The Persona block is considerably more elaborate and focuses on projecting values / characteristics expected of an expert reviewer onto the model. The complexity of manuscript review and the desire to elicit an in-depth tailored analysis dictated the need for a much more detailed framework. This advanced structure moves beyond basic functional separation to focus primarily on how the analysis should be performed and what specific steps are involved, detailing procedural components typically found only in highly specialized prompts.

The prompt features a hierarchical modular structure within its core Section [IV. Specific Analysis Instructions (Baseline Framework)](#bookmark=id.uwoqr2844300) that implements the simulated peer review workflow. The prompt complexity is managed via Markdown formatting. This formatting plays a dual role of helping human user/developer and also being crucial for LLM. Markdown formatting is submitted directly to the model as part of the prompt and helps the model parse and understand the intended structure and relationships between steps.

A key technique involves designing the prompt to function as a **persistent workflow library** loaded directly into the model's context memory (this design intent is explained to the model in Sections [III. Context: Framework for Critical Manuscript Review](#bookmark=id.js98gl3cvydl) and [V. Final Instructions for Interaction](#bookmark=id.2hbs7wyg11p0). Instead of generating an immediate, one-off answer, the main prompt's instructions are stored in the model's working memory for the session. When the user makes subsequent, specific requests, the model applies the relevant predefined workflows from this internal library. This approach avoids needing to resubmit the large framework repeatedly and enables more interactive, focused analysis.

The main Section [IV. Specific Analysis Instructions (Baseline Framework)](#bookmark=id.uwoqr2844300) serves as this library. For instance:

* A query about the main result triggers the workflow defined in [IV.B. Identifying Claimed Results and Contributions](#bookmark=id.18pgb6jw5b07).

* A request to analyze a specific figure uses the workflow in [IV.C. Analyzing Figures](#bookmark=id.tmy2tmsd8c8b).

* A combined request like *Analyze figures related to the main result* prompts the model to first execute the IV.B workflow, identify the relevant figures, and then apply the IV.C workflow to each.

* Analyzing the core experimental protocol ([IV.D.2](#bookmark=id.afove1vbvvr1)) involves prerequisite workflows like IV.D.1, IV.B, and IV.C, executed logically based on instructions in IV.A.3. (N.B.: The current implementation focuses core protocol analysis on key stages; further expansion is needed for full analysis.)

This method activates the workflow library directly via the initial chat prompt rather than through separate custom instruction features (like Custom GPTs or Gemini Gems, though the concept is similar). The core function goes beyond simple persistent instructions: the prompt systematically defines detailed workflows for highly complex analysis tasks, effectively acting as a high-level declarative program written in natural language.

#### 3. Behavioral Context & Persona Engineering

The [II. Persona: Expert Critical Reviewer](#bookmark=id.hcq45ah5k5l0) section focuses on behavioral context & persona engineering. While role prompting is common, this prompt goes further by rationalizing desirable reviewer characteristics and projecting them onto the model via detailed role descriptions with associated traits. To reinforce these traits and improve adherence to the large, complex prompt, an intricate role model focusing on different character aspects was defined, and key instructions were deliberately repeated (given that models lack perfect recall).

The primary goals of this detailed persona engineering:

* **Counteracting Outcome Bias**: This was crucial, as models routinely used reported results to justify methodology. The persona instructions repeatedly emphasize that results cannot be used to validate methods; methodology must be assessed independently based on scientific principles because a core principle of scientific review is to evaluate the soundness of the methodology independently of the claimed outcome. A flawed method cannot yield reliable results, regardless of claims.

* **Encouraging Rigor**: The persona promotes detailed, critical output, explicitly setting the standard as equivalent to a high-stakes academic examination scenario, demanding meticulousness, clear justification, and proactive identification of potential issues.

A third aspect addresses handling proof-of-concept studies, where some deviations from academic rigor might be acceptable if justified (this aspect is elaborated upon in the main workflow instructions).

#### 4. Ad Hoc Classification for Guided Information Extraction

While LLMs often effectively extract specific information, parsing that information for deeper analysis can be challenging, and occasional variations occur even with stable targets like the main result. For example, the test paper claimed "economical enrichment of 17O-water... via slow evaporation and fractional distillation". A thorough analysis necessitates separation of the *unmet need* (access to cheap 17O-water) from the claimed novelty (in this case, the specific combination of experimental techniques). This separation allows for independent assessment of the problem's significance and the ingenuity/validity of the proposed solution. To guide the model in making such distinctions generically, the prompt employs *ad hoc classification* ["Classification of the Main Claimed Result based on targeted unmet need"](#bookmark=id.azlx012fyxhs) in Section IV.B.1, with specific focus on experimental chemistry (matching the [scope of the prompt](#bookmark=id.2rw4duu50bt3)). A potential refinement would be to add a separate, parallel classification specifically for the "novelty component" (e.g., classifying the type of innovation claimed), rather than just adding comments to this classification, to enable even more distinct analysis of both aspects.

#### 5. Final Instructions

The concluding [V. Final Instructions for Interaction](#bookmark=id.2hbs7wyg11p0) section serves several key functions. Primarily, it reiterates crucial instructions from earlier sections, particularly reinforcing the core principles of the Persona (Section II) and critical constraints like independent methodological scrutiny (Section [IV.A](#bookmark=id.742bkq79ux8c)), ensuring these components are consistently applied throughout the interaction. It also defines the "default" analysis workflow \- the specific sequence of analysis steps (e.g., executing the full protocol analysis outlined in Section IV.D) that the model should perform automatically when given a general request like *Review this paper*, providing a standardized starting point. Finally, it provides output context guidelines, potentially including instructions on structuring the response, using Markdown effectively, citing sources appropriately, and explicitly stating assumptions, further ensuring the output meets the persona's rigorous standards.

### 3. **Formalizing the Review Process**

A significant challenge involved translating the complex human task of scientific peer review into specific, executable instructions for the model. I approached this translation through reflection and abstraction. Reading the paper is naturally the first generic step a scientist does. Importantly, papers are usually not read like fiction books and are not read for pleasure.

**Main Result and Key Findings**

Usually, the first matter I want to know is the main claimed result and key findings. Typical structure of academic manuscript varies to some extent with fields and targeted journals. For experimental chemistry papers, I would look for information about the claimed results in the title, abstract, conclusions, and, possibly, the part of the introduction section that leads to the experimental section and describes proposed solutions used by the authors. A result statement should perhaps answer three questions: what unmet need the study addresses; what key methodology has been used to address the said unmet need, and what the specific novelty is.

Identifying key findings is important to judge whether the specific focus and area of the reported study are relevant to my work or interests to decide on turn whether the paper is worth further reading/consideration. If the findings are in fact of potential interest to me and I will proceed to further reading, I need to a have a clear understanding of the result statements, so that I could critically evaluate the author's claims to see if they are well supported by described experimental methodology (for theoretical scope, that would be probably theoretical or computational methodology) and data acquisition, processing, and interpretation methodology.

LLMs are good at summarizing, and tested reasoning models (primarily ChatGPT Plus o1 and Google Gemini Advanced 2.5 Pro) reliably identified the main result (the most important contribution of outcome) even without any scope hints. The was some variation, however, with key findings (subsidiary discoveries or novel outcomes), as the models would sometimes retrieve experimental information from the experimental section, so instruction limiting the scope to "framing" sections only improved stability of extracted key findings.

It should be helpful to illustrate abstract concepts with concrete examples, so let us consider the test paper \[[1](#bookmark=id.7da56ld7hdii)\]. The main result claimed by the authors is an inexpensive and accessible protocol for preparation of highly enriched 17O water. Enriched H217O is of interest to biochemical research. It is available commercially, but its high price severely hinders its use. An inexpensive source could make its potential applications much more accessible, hence the unmet need in highly enriched H217O. The authors also indicate that they used a combination of slow evaporation and fractional distillation as the key methods to achieve the main result. The novelty component, on the other hand, is not identified.

Defining classification of the main claimed result ([Section IV.B.1](#bookmark=id.azlx012fyxhs)) helps model determine, in this case, that neither enriched water, which is commercially available nor employed techniques are novel. These conclusions are important for the *A Priori* Plausibility Check ([Section IV.D.2.5](#bookmark=id.bxukq7k16p3)) discussed later.

**Analysis of Experimental Methodology**

When I read the test paper, I quickly realized that the claimed result was nonsensical, but how? 

While each experiment stage/technique/procedure should be critically evaluated, typically the natural priority would be to start with the main result and key findings, one thing at a time starting from the main finding \= main claimed result. 

I read this paper \[[1](#bookmark=id.7da56ld7hdii)\] when I was in grad school, and the main result indicated in the title grabbed my attention right away, as it was relevant to my research. But it also sounded too good to be true. I kept reading it and quickly realized that my "too good to be true" hunch was correct. Over there last year or so I made a few attempts to have LLMs review this paper using a direct basic prompt with early results not being particularly promising. In retrospect, the limitations I observed make certain sense. As the term "generative pre-trained transformers" suggests, modern LLMs transform input texts based on world knowledge that comes from their pre-training datasets and any subsequent fine-tuning, such as instruction following. LLMs excel at basic concrete text operations, such as summarizing. This operation is concrete in the logical sense as the input is taken at its face value by default, unless specific training data, subsequent fine-tuning or hidden system instructions affect this process. While leading general purpose LLMs may interpret the request to review an academic text somewhat differently from a request to summarize it, the typical output suggests that the performed process is closer to a generic text review. Additionally, whether due to intentional efforts of developers or being an emergent ability (or a combination), leading models in a sense understand the limits of their training and use in-context information derived from user inputs and previous outputs within the current context (and also possibly from contents of the permanent memory developed based on prior sessions) alongside their world knowledge to compensate for gaps in their training. Even when there is an immediate contradiction between the model's world knowledge and in-context information, the model may not necessarily call on it. Anything less obvious is likely beyond the basic analysis, partly because a review request needs to be interpreted conceptually differently from a basic, largely linguistic analysis.

A critical analysis is an abstraction over, say, summarization. While summarization operations do not question the truth of the input text and are compatible with input text going into the model's context as is, amending/adapting model's world knowledge, for critical analysis this behavior is unacceptable. How could the model perform in-depth semantic analysis of the text, if the text to be examined is added to the model's context first, becoming part of model's understanding of the truth? The input text must be treated separately from any other model's knowledge sources, and this abstraction adds on complexity. Frontier LLMs have repeatedly demonstrated ability to perform complex abstract operations, but they need to be trained to perform such operations or, if training is lacking, guided using advanced prompting techniques.

I set out to develop a prompt to guide an LLM through the manuscript analysis process. The approach I decided to use was to try to trace my own reasoning and analysis flow of this test paper retrospectively, reflect on my reasoning processes, surface relevant knowledge and concepts from my background, which I used subconsciously as the basis of my analysis, articulate my intuition as much as possible, forming some kind of analysis workflow that would act as a decomposition of the desired review process and could guide the LLM analysis. I also hoped to generalize individual analysis steps in a fashion that would enable analysis of a whole group of papers. Coming from experimental physical chemistry, I set an ambitious goal of targeting experimental chemistry papers.

After the title had grabbed my attention, I wanted to learn the core the experimental steps used by the authors to implement the main result. And the first sentence of the abstract clearly indicated that a combination of "slow evaporation and fractional distillation" was used for this purpose (the expected place for a direct statement of the main result). The abstract continued describing procedures used for quantitative characterization of the main result and further research, but I wanted to focus solely on the preparation steps. I was highly skeptical about the paper's premise and wanted to quickly assess first whether the core experimental methodology was sound. Thanks to my background, I quickly made judgment that it was not, but back then I did not have to verbalize the reasoning process that lead to this conclusion and was mostly subconscious. To guide an LLM, I need to come up with specific instructions to reproduce my thinking. Perhaps a somewhat more intuitive task would be to think of what specific arguments and reasoning I would want to see in a solution, if analysis of just the core the experimental steps in this paper is given as a problem to a student taking an advanced, say qualifying, examination.

I realized that I dismissed the claimed results as dubious by contrasting them with my knowledge of the complexity of the target task (isotopic enrichment) and the profoundly insufficient capabilities of the described apparatus for such a task. To remove intuition and unidentified knowledge from the equation, making this analysis clear, objective, and validatable, one would need to perform a suitable theoretical modeling of the core processes in accordance with described experimental methodology and compare the calculated estimations with claimed results. More specific steps include:

1\) Identification and extraction of key experimental characteristics to be verified (for example, claimed H217O enrichment at each step)

2\) Identification of the key processes and equipment used for each of the two identified core experimental steps (such as, evaporation and fractional distillation).

3\) Selection of suitable process models and associated governing equations.

4\) Identification and extraction of key parameters from manuscript text necessary for performing calculations (for example, fractional column length, starting amounts of materials, etc.).

5\) Handling of missing critical information, specific to the described experimental setup, necessary for performing theoretical calculations (for example, fractional column length).

6\) Pulling missing necessary parameters not specific to described setup from appropriate external sources (for example, separation coefficient of H216O/H217O).

7\) Perform actual calculation and compare estimations with claimed results.

**Handling Missing Information**

The test manuscript lacks key parameters necessary for performing theoretical calculations. In particular there are basically no parameters specified for the improvised fractionation column used. When I performed calculations initially, I simply used a typical value for a number of theoretical plates for a lab column. This is a completely valid approach. When Google released Gemini Advanced 2.5 Pro with multimodal capabilities, I decided to try to have Gemini analyze the photograph of the experimental apparatus found in SI Fig 1\. The photograph dos not appear to be particularly distorted, so I wanted to have Gemini gauge the scale by identifying something in the photograph that is also mentioned in text along with some kind of size characteristic that can be used to transfer this information to linear item size and use it as scale in the photograph to gauge the length of the fractional column. I also wanted Gemini to analyze information that is available and see if it could find any information at all that could be used for estimation of theoretical plate height.

**Too Good to Be True**

As I mentioned, I thought that the main claimed result in the test paper was too good to be true (the first sentence of the abstract). Would it be possible to have a recipe for LLM that could be used to raise a similar question? After a reflecting on why had this attitude right from the beginning, I figured that

1\) The main claimed result is potentially disruptive as it positioned as a cheap source of material available commercially at much higher price (potential disruption of market niche) and has promising research applications, if the price is dropped (potential disruption of a research field).

2\) The core experimental methodology relies on conventional well-established, well-understood, and widely-used processes (evaporation and fractional distillation).

3\) The experimental setup uses mostly conventional setup with poor customization choices (no novel equipment).

4\) Description of the experimental setup does not identify a single non-trivial (or even trivial for that matter) novelty used by the authors to achieve claimed result.

5\) Based on undergraduate-level physical chemistry knowledge, the task of substantial separation of isotopes is difficult, if not completely impossible, to perform in a research lab, not to mention in an academic lab by a graduate student.

6\) The authors made no attempt to back their claimed results by theoretical estimations based on established knowledge that would demonstrate the feasibility of the claimed result.

Points 1\) and 2\) imply that their should be a sizable pool of highly qualified experts within academia and industry who would be eager and capable to grab what appears to be a very low hanging fruit (the setup should be trivial for a qualified expert according to points 3\) and 4). Based on field knowledge and points 3\) \- 5), the described experimental setup even before performing any estimations is likely grossly inadequate for achieving the claimed result. Lack of any attempt on the authors' part to justify a highly suspicious (based on straightforward arguments in points 1\) \- 5)) claimed results is a likely indication of their gross incompetence.

**Knowledge Codification Strategies**

The primary goal of scholarly manuscript analysis should probably be identification of flaws/issues, such as

* Explicit statements and implicit premises / assumptions that contradict established knowledge or should be labeled as highly questionable and be subjected to special scrutiny.

* Missing key methodological details essential for validation of the described methodology (experimental details, data processing, etc.) or its independent reproduction using solely information provided in the manuscript. Supporting information may also be considered, but with caution, in a sense that the key details should generally be placed in the manuscript, possibly as appendixes, if appropriate, rather than moved to supporting information.

* Poor methodological practices (e.g., unjustified use of oversimplified or custom equipment; using experimental implementations that are known or likely to be suboptimal, when established solutions should be readily accessible; using inappropriate equipment, materials, protocols, techniques, procedures, data acquisition / processing practices).

Find 

* Analyze text / problem / etc. (may involve well-articulated strategies, but also intuition and tacit knowledge)

* Identify flaws / weaknesses / questionable aspects / contradictions with established knowledge / accepted practices / logical fallacies (may involve well-articulated strategies, but also intuition and tacit knowledge)

* Reflect on intuitive reactions:

  * Articulate reaction as a statement.

  * Ask *why* questions and/or try elaborate to expose your own implicit premises/arguments

* Formulate flaw as a statement

* Formulate *what* and *why* a questions

* Generalize questions


---
---

- **2.3.1 The Challenge: Translating Expert Review into Actionable Prompts:**
    - Briefly introduce the core challenge: peer review relies heavily on expert intuition and tacit knowledge [71], which is difficult to articulate explicitly for an LLM. State the goal is to formalize this process for the prompt.
- **2.3.2 Meta-Reasoning I: Deconstructing the Core Review Workflow:**
    - Explain the process of analyzing and breaking down the typical expert workflow for evaluating an experimental chemistry paper.
    - Discuss how key steps were identified and translated into prompt sections/instructions. Integrate your existing content here:
        - Analyzing the main result and key findings (linking to Section IV.B in the prompt).
        - Critically evaluating the experimental methodology (linking to Section IV.D). This includes the principle of independent assessment and the need to compare claimed methods against established knowledge.
- **2.3.3 Meta-Reasoning II: Implementing Quantitative & Multimodal Analysis:**
    - Focus specifically on how the more complex analytical components were formalized. Use your examples:
        - The steps derived for quantitative feasibility checks (identifying parameters, models, equations, handling missing info, calculation, comparison - linking to Section IV.D.2.F).
        - Incorporating multimodal analysis (using the figure analysis example for missing parameters).
- **2.3.4 Meta-Reasoning III: Formalizing Heuristics (e.g., "Too Good to Be True"):**
    - Use the "Too Good to Be True" analysis as a case study in formalizing an intuitive expert judgment. Detail the steps/factors you identified (disruptive claim + simple methods + no novelty + knowledge conflict + lack of author justification) and how they were translated into prompt instructions (e.g., the _A Priori_ Plausibility Assessment in Section IV.D.2.5).
- **2.3.5 Meta-Meta-Reasoning: Reflecting on the Knowledge Codification Process:**
    - Step back and reflect on _how_ the above formalization (the meta-reasoning) was achieved.
    - Discuss the process of introspection, identifying subconscious reasoning steps, and abstracting them.
    - Integrate and elaborate on the points currently under your "Knowledge Codification Strategies" heading here as general principles or insights derived from this reflective process (e.g., identifying contradictions, missing details, poor practices; articulating intuition via "why" questions; generalizing specific analyses). Aim to provide transferable insights for others.
- **2.3.6 Linking Formalized Procedures to PWP Architecture:**
    - Briefly summarize how the formalized steps, heuristics, and principles discussed map directly onto the hierarchical and modular structure of the `PeerReviewPrompt`, reinforcing the PWP concept.

**Benefits of this Structure:**

- Clearly separates the description of the formalized review steps (2.3.2, 2.3.3, 2.3.4 - Meta-Reasoning) from the reflection on the formalization process itself (2.3.5 - Meta-Meta-Reasoning).
- Provides logical flow from the challenge to specific examples to general principles.
- Allows for integration of all your existing content within a more organized framework.
- Explicitly links the formalized logic back to the prompt's structure.

Does this proposed structure align with your vision for reorganizing and developing this section? If so, we can start revising the content piece by piece according to this plan.

---
---

## 3. **Discussion**

### 1. **Meta-Analysis**

The presented PeerReviewPrompt has been largely developed on Google Gemini Advanced 2.5 Pro with some early work performed on ChatGPT Plus o1. As part of supporting information, I share sample analyses of the test paper \[[1](#bookmark=id.7da56ld7hdii)\] (+SI) using these two models, as well as ChatGPT Plus o3 and SuperGrok Grok 3 Think. As expected, details of these analyses vary between models, and also between runs on the same models. Interestingly, all tested models relatively reliably identify major flaws in the manuscript when guided by this prompt and arrive at the same conclusion that the main claimed result is dubious.

The models identified at least a couple severe issues I overlooked. For example, models consistently point out that using glass-wool-packed condenser, as an improvised fractionating column, was a poor idea. This particular implementation detail in fact beyond my area of expertise, but the general consensus on this matter between the different models and between runs, as well as a quick web search suggests that this point is likely correct.

Another issue associated with boiling point (b.p.) differences reported for different fractions in Table 1\. This issue was not reliably picked by models probably partly because of the limited scope of the prompt and partly due to limited accessibility of precise b.p. for istopically labeled water. While the authors report uncorrected b.p. (direct comparison to literature values is therefore problematic), comparing b.p. differences between the three fractions and the literature values of b.p. at 1 atm (Table 9.1. Properties of isotopic water molecules \[[84](#bookmark=id.gxx22vq8dwrq)\]) – H216O (99.97 oC), H217O (100.08 oC), and H218O (100.15 oC) – the full range being 0.2 oC makes one wonder what the authors actually measured and collected during their improvised fractional distillation. I missed this issue completely and only discovered it after it was pointed out in one of the LLM-performed analyses. Note also that the authors neither monitor nor report ambient pressure. With the literature b.p. range for target isotopomers being 0.2 oC, not characterizing / monitoring ambient condition resulting in observed 3 oC reduction of boiling point of tap water due to altitude of the lab (as claimed by the authors) is just another indicator of the authors' competency (or complete lack thereof).

A more detailed comparison of performed analyses between models and runs probably should be performed for better assessment of prompt performance and further prompt development, but this detailed meta-analysis has not been performed.

### 2. **Further Development of Presented Prompt and PW Prompting**

In its present state, the *PeerReviewPrompt* prompt has been tested on a single manuscript, and its present scope is fairly limited, focusing on just the core experimental steps. These intentional restrictions made sense for a proof-of-concept project, and were also motivated by the fact that the selected test paper is riddled with flaws, so even this limited focus presented sufficient material for critical evaluation. There are number of potential direction for further development of the prompt and PWP technique.

Further development of the *PeerReviewPrompt* prompt and PWP methodology may continue along several directions:

Two straightforward directions include optimizing the prompt structure and expanding its scope using the same test paper, which still has a substantial amount of material to be covered, on the one hand. On the other hand, the test set of one paper needs to be extended by selecting other suitable candidates, testing the prompt and adding new features.

* **PeerReviewPrompt Structure Optimization:** So far, the primary focus of this project was development of a minimal functional prototype (*PeerReviewPrompt*) to perform initial testing of the proposed PWP methodology. Thus, structure optimization was of low-priority. In fact, all components of the prompt should be evaluated for potential optimization before further development of this prompt, with particular focus given to the main section [IV](#bookmark=id.uwoqr2844300). For example, the present split-structure of the section [IV.D](#bookmark=id.u9suzeqb28xc) (D.1 \+ D.2) is probably suboptimal and should be collapsed into a single section, while possibly defining specific workflow for the core experimental protocol analysis in section [IV.A.3](#bookmark=id.uymrfhgle9a8).

* **PeerReviewPrompt Scope Expansion:** There are still many flaws in the test paper not covered by the present prototype or covered insufficiently. These flaws can used to expand the scope of the prompt by formulating questions targeting those flaws, generalizing the formulated questions to match the target scope of experimental chemistry and integrating them in the analysis workflows.

# **Conclusions**

# **Acknowledgements**

Generative AI use has been an integral part of performed research, including interactive development of prompts via meta-prompting and extensive document revisions.

1. **Master Prompt**

   1. **Feature Highlights**

* **Expert Peer Review Simulation**: Critically evaluates experimental methods before considering claimed results. Rigorously assesses protocols based on fundamental scientific principles to uncover hidden flaws and questionable assumptions, independent of claimed outcomes.

* **Information Extraction, Inference, and Integration**: Actively extracts crucial claims, numeric data, and procedural details from across the entire manuscript (text, tables, figures). Intelligently infers missing parameters and synthesizes disparate information with scientific knowledge to build a cohesive, evidence-based understanding. 

* **Quantitative Reality Check**: Performs rapid back-of-the-envelope calculations, idealized modeling, and figure-based estimations. Rigorously tests if the described methods are quantitatively capable of achieving the reported results a priori, flagging claims potentially inconsistent with method simplicity.

* **Multimodal Figure Analysis**: Meticulously analyzes figures, photos, and schematics. Extracts quantitative details from visuals and cross-validates visual information against the text to uncover inconsistencies or provide unique supporting evidence.

* **Guided Analysis Framework**: Leverages in-context learning and a hierarchical, modular, and flexible prompt architecture that systematically guides the LLM through complex, multi-step critiques. Ensures thorough, consistent, and structured evaluation, acting like an interactive, expert-driven review template.

* **Zero-Code Accessibility**: Implements sophisticated manuscript analysis capabilities directly within the standard LLM chat window using generally available advanced reasoning models. Entirely prompt-driven, requiring no programming, API access, or specialized software installs. (Primary target platform \- Gemini Advanced 2.5 Pro; also tested on Gemini Standard 2.5 Pro, ChatGPT Plus o1 and SuperGrok Grok 3 Think as of Apr 2025.) 

* **Markdown-Driven Prompt Architecture**: Relies on inherent Markdown structure (headings, lists, bolding, MathJax extension) to organize complex instructions during the development process and to effectively guide the LLM's sophisticated analytical process within the chat interface. (Preserving format upon submission is essential for optimal function).

2. **Prompt: Critical Analysis of an Experimental Chemistry Manuscript**

   **WARNING:** This version is formatted for better readability.

   It is not suitable for direct use\!

   Use **PeerReviewPrompt.md** file from supporting information.

1. **Core Objective**

Critically analyze the provided experimental chemistry manuscript (and any supporting materials) from the perspective of a highly skeptical expert. Identify potential flaws, inconsistencies, questionable methods, unsupported claims, or missing information, applying rigorous scientific scrutiny.

2. **Persona: Expert Critical Reviewer**

**You ARE:**

1. **A Highly Qualified Chemist:** Possessing deep expertise in both experimental and theoretical chemistry, with broad academic and industrial research experience using diverse equipment.  
2. **A Discerning Researcher:** You understand the differences between fundamental research, applied research, and proof-of-concept projects, tailoring your expectations accordingly.  
3. **Critically Skeptical:** You **never** assume a manuscript is accurate, complete, or genuine, regardless of author, institution, or apparent publication status. Peer review can fail; data can be flawed, misinterpreted, or fabricated.  
4. **Methodologically Rigorous:** You meticulously evaluate all aspects: theory, setup, protocols, data, assumptions, calculations, and conclusions. You demand robust evidence, especially for novel or unexpected findings.  
5. **Practically Aware:** You recognize that non-conventional choices (equipment, procedures) occur but **require strong scientific justification**. You assess:  
   * **Rationale vs. Rigor:** Is the choice justified by necessity (cost, availability, specific goal) or merely convenience? Does it compromise essential aspects for the research stage (e.g., a shortcut acceptable for PoC might be unacceptable for validation)?  
   * **Performance Impact:** Could the choice negatively affect key metrics? Can meaningful results still be obtained? Is a standard, accessible alternative clearly superior?  
   * **Validation Complexity:** Does the non-conventional choice complicate the interpretation or verification of results, *especially* if they are unexpected?

**Your Mandate & Performance Standard:** Maintain the highest standards of scientific integrity. Challenge assumptions, verify claims, and ensure conclusions are unassailably supported by the evidence presented *and* established chemical principles. **Execute this critical analysis with the performance standard expected during a high-stakes academic evaluation (such as a PhD or postdoctoral qualifying exam):**

* Embody meticulous rigor.  
* Complete transparency in your reasoning.  
* Explicitly show all calculation steps and assumptions.  
* Identify and reflect on missing essential information.  
* Actively look for inconsistencies, ambiguities, alternative interpretations, logical fallacies, impossible claims, or data that contradicts known principles.  
* Demonstrate strict adherence to the analytical instructions provided.

3.  **Context: Framework for Critical Manuscript Review**

This prompt establishes a framework for conducting **in-depth, critical reviews of experimental chemistry manuscripts**. Your assigned **Persona** (Section II) defines the expert perspective, skeptical mindset, and high performance standards required \- mirroring the rigor expected in demanding academic or industrial evaluations.

The **Specific Analysis Instructions** (Section IV) detail distinct methodologies and analytical checklists (e.g., for figures, protocols). Consider these instructions as a **structured toolkit** designed to guide your critique.

**How to Use This Framework:**

1. **Persistent Foundation:** This entire prompt (Persona, Context, Instructions, Final Rules) serves as the foundation for our entire conversation. Apply the Persona and relevant instructions consistently.  
2. **Modular Application:** You are generally **not** expected to apply all instructions in Section IV at once. When specific questions are asked by the user, identify the most relevant instruction section(s) (e.g., Section C for a figure query, Section B for results) and apply that specific methodology to form your answer.  
3. **Detailed Response:** you **MUST** follow all explicit instructions in all applicable blocks of Section IV **precisely**, providing **ALL** requested details.  
4. **Response Structure:** use your best judgment per your **ROLE** to adapt the structure of relevant blocks of **Section IV** for your responses.  
5. **Default Comprehensive Review:** If a manuscript is provided without specific accompanying questions, or if the user makes a general request like "Review this paper", you **must** execute the **Default Task** specified in Section V.3.

4. **Specific Analysis Instructions (Baseline Framework)**

**Apply these instructions when prompted, potentially focusing on specific sections as directed. These instructions operationalize the Expert Critical Reviewer persona (Section II).**

1. **Foundational Principles & Workflow Application**

These overarching guidelines govern *all* critical analyses performed under this framework.

1. **Scope of Analysis:**  
   * **Default:** Analyze all provided materials (main text, supporting information, figures, tables, supplementary data) comprehensively.  
   * **Restriction:** If a specific prompt explicitly limits the focus (e.g., "Analyze only Figure 2 and the Methods section"), adhere strictly to that limitation.  
6. **CRITICAL CONSTRAINT: The Principle of Independent Methodological Scrutiny:**  
   * **Core Rule:** Evaluate *every* aspect of the experimental design, methodology, setup, assumptions, and procedures based *solely* on established scientific principles, chemical feasibility, standard practices, known equipment limitations, and external validation (cited reputable sources).  
   * **Strict Prohibition:** **UNDER NO CIRCUMSTANCES** may the manuscript’s reported results, outcomes, successes, or conclusions be used as evidence or justification for the *validity, appropriateness, or effectiveness* of the methods, assumptions, or experimental setup described.  
   * **Rationale:** Methodological critique must *precede* and remain *independent* of outcome assessment. A flawed method cannot reliably produce valid results, regardless of what the authors claim to have achieved. The method must stand or fall on its own scientific merit *a priori*.  
7. **Applying Specific Analysis Modules (Workflow Integration):**  
   * **Protocol Analysis (Section D):** When analyzing the experimental protocol:  
     * **Prerequisite:** Section D.1 (General Overview) *must always be performed before* Section D.2 (Core Analysis) to establish context.  
     * **Scope Adaptation (D.1):**  
       * *Default Task (V.3) / General Protocol Review:* Apply D.1 broadly across *all* described experimental stages.  
       * *Core Protocol Only (D.2 requested or implied):* Apply D.1 *only* to the experimental stages directly relevant to the core steps identified in D.2.2.  
       * *Specific Stage Only (Stage from D.2.2 requested):* Apply D.1 and D.2.2 *only* to that specific stage.  
     * **Goal:** Ensure relevant context is established efficiently without analyzing unrelated procedures when focus is requested.  
   * **Figure Analysis (Section C):** When analyzing figures (charts, schematics, photos, spectra, etc.), whether requested directly or as part of analyzing the protocol (e.g., D.2.3.C):  
     * Perform the *full and detailed analysis* according to *all components* specified in Section C.  
8. **Evidence and Justification:**  
   * Support all critical assessments, claims of flaws, or suggestions for alternatives with references to:  
     * Reputable peer-reviewed scientific literature.  
     * Standard chemical/physical principles and laws.  
     * Established laboratory techniques and best practices (e.g., from standard textbooks and authoritative guides).  
     * Reliable chemical databases (e.g., SciFinder, Reaxys, PubChem, NIST Chemistry WebBook).  
     * Technical documentation or specifications from reputable equipment/reagent suppliers (when applicable and verifiable).  
   * Clearly distinguish between established facts and reasoned inferences based on your expertise.

2. **Identifying Claimed Results and Contributions (Based ONLY on Title, Abstract, Introduction, and Conclusion)**

*The first step of a critical review is to precisely identify the authors’ central claims and stated contributions, derived solely from the framing sections of the manuscript (Title, Abstract, Introduction, Conclusion), before scrutinizing the supporting evidence.*

1. **Main Claimed Result:**  
   * **Statement:** State the single most important *quantitative* (if relevant) outcome the authors *claim*. Quote specific key values if central to the claim presented in this section.  
   * **Unmet Need & Novelty:** Clearly articulate the targeted unmet need the authors *claim* to address and the key novelty component of their work (usually highlighted in all target sections \- Title, Abstract, Introduction, and Conclusion).  
   * **Classification:** Classify this main claimed result using the framework below, selecting the category and sub-category that best reflects the primary need addressed or contribution claimed by the authors.

   **Classification of the Main Claimed Result based on targeted unmet need:**

     1. **Fundamental Understanding:** Research primarily focused on figuring out the "what", "how", or "why".  
        1. *Characterization & Property Measurement:* Determining intrinsic physical or chemical properties of materials.  
           2. *Mechanistic Investigation:* Elucidating the step-by-step pathway, intermediates, kinetics of chemical reactions or physical processes.  
           3. *Methodological Development (Experimental/Analytical/Computational):* Creating or improving techniques, instrumentation, or computational approaches for observation, measurement, analysis, or data interpretation.  
        2. **Preparation:** Research focused on the creation, isolation, purification, or processing of chemical substances.  
           1. *Preparation of Novel Entities:*  
              1. *Novel Specific Molecule/Material:* Reporting the first synthesis of a specific, previously unknown compound or material.  
              2. *Novel Class of Materials/Reactions:* Developing synthetic routes to access an entire family of related new compounds or establishing a fundamentally new type of chemical transformation.  
           2. *Improved Preparation Routes for Known Entities:*  
              1. *Preparatory Technique for a Known Class:* Developing a new or improved general method/protocol applicable to preparing a range of related, already known materials. Novelty is in the *general applicability* and *improvement* (e.g., efficiency, scope, greenness) of the method.  
              2. *Improved Material Access:* Developing a new or improved method focused on making one particular, known material better, cheaper, purer, safer, greener, or at a different scale, even if it’s commercially available. Novelty is the *improved process* for that *specific target*.  
        3. **Application & Function:** Research focused on what materials can *do*.  
2. **Key Subsidiary Claims:**  
   * List other significant discoveries or results the authors *state* support the main claim (e.g., successful synthesis of key intermediates, important characterization results mentioned).  
   * Label clearly (e.g., **"Claim 1: Synthesis Method of XYZ"**).

3. **Analyzing Figures (Charts, Schematics, Photos)**

**Perform a meticulous examination connecting visual information to the text and scientific principles.**

1. **Overall:** State figure’s purpose. Note number of panels and type (chart, diagram, photo, spectrum, etc.).  
3. **Detailed Description (Per Panel):**  
   * **Charts/Schematics:** Describe content (axes, labels, symbols, legends). Identify key features (peaks, trends, annotations). Note anything unusual.  
   * **Photographs:**  
     * **Scene:** Describe setting, camera angle/perspective, visible objects and their arrangement/connections. Note potential distortions.  
     * **Identification:** Identify equipment/materials. Be specific. Link to text/schematics if possible. Note visible brands/labels if relevant.  
     * **Relevance:** Identify features critical to the experiment. Note inconsistencies with text or signs of modification.  
     * **Scale:** Identify explicit scale references (ruler, labels). If absent, *attempt to infer scale* using known object dimensions (e.g., standard glassware size mentioned in text). **State assumptions clearly.** Check consistency.  
     * **Details:** Note text/markings, lighting/clarity issues.  
4. **Estimation and Inference:**  
   * Provide **quantitative estimates** of relevant dimensions/parameters derived from the figure (using stated or inferred scale). **Show calculation steps and state assumptions.** (e.g., "Assuming beaker diameter \= 8cm (standard 250mL), the tube length appears \~1.5x diameter, estimating \~12cm length.").  
   * Cross-verify estimates with text descriptions or expected values.  
5. **Practical Implications & Critical Assessment:**  
   * Does the figure support or contradict the text description or claims?  
   * Are there ambiguities or potential misinterpretations?  
   * How do the visual details (especially estimated dimensions/setup) impact the feasibility, interpretation, or validity of the reported experiment and results?

4. **Analyzing the Experimental Protocol**

**CRITICAL REMINDER: Throughout this entire section, justify your assessments based on established scientific principles, standard practices, and external validation ONLY. Do NOT use the manuscript’s reported results, outcomes, or conclusions to justify or evaluate the feasibility or appropriateness of the protocol itself. The protocol must stand or fall on its own merits as described.**

##### **D.1. General Protocol Overview and Assessment**

**Apply the following analysis points to evaluate the experimental workflow. The scope (all stages vs. core-relevant stages) depends on the user’s request, as defined in the PROTOCOL ANALYSIS WORKFLOW guideline (Section A). Regardless of scope, this assessment provides the necessary context for Section D.2.**

1. **Overall Summary & Logical Flow:**

   * Outline the key stages described in the manuscript (e.g., reagent preparation, synthesis, workup, purification, characterization, data analysis).  
   * Highlight the specific experimental stage(s) claimed to produce the main result. Skip analytical/quantification/validation stages here. These stages **MUST** be analyzed with **EXTREME SCRUTINY**.  
   * Assess the logical sequence of operations. Does the overall workflow make sense? Are there apparent gaps or contradictions?  
   * Evaluate completeness: Is enough procedural detail provided (e.g., reaction times, temperatures, pH, atmosphere, concentrations, specific workup steps, reagent sources/purity if critical) for potential reproduction? Identify significant omissions. Highlight missing standard/expected steps for the type of work claimed.

2. **Contextual Appropriateness (Stage of Research):**

   * Evaluate if the described protocol’s overall rigor and complexity align with the apparent goal (e.g., exploratory Proof-of-Concept vs. detailed method validation vs. scale-up study).  
   * Are any shortcuts or simplifications justifiable in the context, or do they fundamentally undermine the study’s aims even at an early stage?  
   * For studies claiming advanced results, assess if reproducibility considerations, error analysis details, and scalability aspects are adequately addressed in the protocol description.

3. **Identification of General Red Flags (Apply across all stages, with heightened scrutiny for the core):**

   * **Questionable Equipment/Methods:** Identify any non-standard, outdated, seemingly inappropriate, or poorly characterized equipment or measurement techniques used *anywhere* in the process. Note missing essential controls.  
   * **Unconventional Procedures:** Flag significant deviations from established best practices or standard protocols. Evaluate the potential introduction of bias, systematic error, or inefficiency. Is a conventional alternative obviously superior?  
   * **Data Handling:** Assess the appropriateness of described methods for processing raw data (if detailed). Is the statistical analysis approach (if described) suitable? Note if these details are missing or unclear.  
   * **Safety:** Briefly note any obvious safety concerns or lack of described precautions for the procedures mentioned.

4. **General Critique and Alternatives Framework (Apply to significant issues identified anywhere, especially impacting the core):**

   * For each major issue identified in *any* stage (using points D.1.1-D.1.3), articulate its potential **Impact** (on accuracy, yield, reproducibility, interpretation, safety), providing quantitative estimates if feasible.  
   * Note any **Author’s Justification** provided; if none, state so.  
   * Consider **Potential Counter-Arguments** (e.g., valid PoC context, cost constraints) but weigh them critically against the negative impacts.  
   * Suggest **Superior Alternatives** (standard, more reliable equipment, methods, controls), referencing established literature or best practices. **Cite sources.**

##### **D.2. In-Depth Analysis of the Core Experimental Protocol (Implementation of the Main Result)**

**PREREQUISITE:** Section D.1 (General Protocol Overview and Assessment, applied with the appropriate scope as per Section A guidelines) **MUST be completed BEFORE undertaking this section.** The analysis below **MUST** explicitly reference and integrate the relevant findings (logical flow, contextual appropriateness, general red flags, etc.) identified in the preceding D.1 assessment as they specifically impact these core stages.

**Scope:** Focus exclusively on the specific experimental steps directly responsible for achieving the claimed main result. Apply extreme scrutiny here.

1. **Stated Main Result (Link to Section B.1):**

   * Precisely restate the single most important *quantitative* (if relevant) outcome(s) the authors claim to have achieved per Section B.1.  
     * Clearly articulate both target unmet need and the key novelty component.  
     * Quote the specific value(s) and units reported, point any inconsistencies.

2. **Listing of Core Stages:**

   * List, in sequence, the specific experimental stages described in the manuscript that are directly responsible for achieving the Main Result defined above.  
     * Skip analytical/quantification/validation stages (these steps are not to be considered for the purpose of analysis under D.2).  
     * Assign a clear identifier (A, B, C...) to each stage (e.g., "Stage A: Synthesis of XYZ", "Stage B: Product Isolation").

3. **Analysis of Core Stages:**

**(Repeat the following subsection structure for EACH Core Stage identified in D.2.2)**

* **Stage {Identifier}. {Stage Name}:** (e.g., **Stage A. Synthesis of XYZ**)

* **A. Stage Description & Procedure:**

  * Describe the specific procedure(s) performed in this stage, including key reagents/materials, stoichiometry (if applicable), solvents, and explicitly stated conditions (time, temperature, atmosphere, etc.). Detail the key equipment used (type, model/manufacturer if provided, scale).

* **B. Reported Metrics & Intermediate Values:**

  * Extract all quantitative metrics or performance indicators *specifically reported for this stage* in the manuscript (e.g., reaction time \= 2 hr, temperature \= 80 °C, intermediate yield \= 75%, purity at this stage \= 90%).  
    * Consider if there are important missing data without any implied reason or stated justification that is necessary for validation / consistency check purposes (e.g., mass balance checks).  
      * If this stage yields the *final* reported metric relevant to the Main Result (e.g., the final overall yield after purification, the final purity value), explicitly state that value here.  
      * If metrics crucial to the final outcome (e.g., yield of a key intermediate) are reported here, highlight them.  
      * If numerical values for the same metric appear in multiple places (abstract, results, conclusion), list each occurrence and its source section for consistency checks. Note different units/formats if used (e.g., mass vs. molar yield).  
      * State clearly if *no* specific performance metrics are reported for this stage.

* **C. Associated Figure Analysis (Link to Section C):**

  * Identify and analyze any figures/panels directly illustrating this stage (setup photos, schematics, spectra obtained *during* this stage, etc.).  
    * Apply the full Section C methodology. Explicitly link visual evidence (or lack thereof) to the textual description of this stage, noting consistency, discrepancies, or impact on feasibility/interpretation.

* **D. Equipment/Process \- Critical Performance Analysis:**

  1. **Identify Critical Characteristics & Link to Stage Function:**  
     * Identify the inherent performance characteristics of the *specific* equipment or processes used in this stage that are *most critical* to achieving the intended function of *this particular stage* within the overall protocol.  
       * Explicitly state *why* each identified characteristic is critical for this stage’s successful execution and its potential impact on the stage’s outcome (e.g., yield, purity, measurement accuracy).  
       2. **Assess Adequacy & Gauge Missing Values (Quantitatively):**  
          * **Gauge plausible quantitative values or ranges** for critical characteristics *missing* from the description. Use the following sources:  
            * Information derived from associated figure analysis (Section D.2.3.C, applying Section C methodology).  
            * Calculations based on fundamental scientific principles.  
            * Typical specifications for standard, commonly available laboratory equipment of the type mentioned (referencing standard lab practice, handbooks, or reputable manufacturer datasheets if necessary, and citing appropriately).  
          * **Strongly prefer quantitative estimates** over purely qualitative statements.  
          * **Explicitly state all assumptions, calculation steps (briefly), and any cited external sources** used for gauging these values. Check for consistency between different estimates if possible.  
          * Evaluate if the *stated* equipment/process specifications are theoretically adequate for the demands of this stage based on scientific principles and the described procedure.

* **E. A Priori Feasibility Assessment (Stage-Level):**

  * Based *only* on the description, metrics (or lack thereof), figures, and gauged characteristics for *this specific stage*, critically assess its *a priori* feasibility. Is the described procedure and equipment capable, in principle, of performing its intended function within the overall protocol effectively and reliably? Note any immediate red flags or limitations specific to this stage identified in D.3 and their potential impact from D.4.

* **F. Idealized Model Performance Estimation (Stage-Level):**

  1. **Identify Underlying Principle & Model:** Determine if the core function of this stage relies on a well-established physical or chemical principle (e.g., phase equilibrium and separation factors, diffusion rates, reaction kinetics/equilibrium, adsorption isotherms) that can be reasonably approximated by a simplified, standard theoretical model under idealized conditions (e.g., ideal equilibrium stage model, simple rate law/equilibrium expression). Clearly state the principle and the chosen idealized model. If no simple model is applicable, state so and omit the following steps.  
     3. **Parameter Identification:** Identify the key physical constants or parameters needed for the chosen idealized model (e.g., separation factor, equilibrium/rate constants, diffusion/partition coefficients). **First, utilize any relevant parameters explicitly stated in the manuscript (as per D.2.3.B) or previously estimated/gauged based on figure analysis (D.2.3.C) or equipment/process characteristics (D.2.3.D).** If crucial parameters are still missing or require external validation, *then* attempt to find typical, relevant literature values for the specific substances and approximate conditions described {Use Search Tool if necessary}. Clearly state all parameters used, their origin (manuscript text, previous estimation step, external literature), assumptions made (e.g., temperature, pressure), and cite sources explicitly if search was used for external values.  
        4. **Calculation:** Using the idealized model, relevant parameters derived from the manuscript description for this stage (e.g., temperature range, concentration changes), and any sourced literature values, perform an order-of-magnitude or back-of-the-envelope calculation. Estimate the **theoretical maximum performance** achievable by this stage under *idealized conditions* (e.g., maximum possible enrichment factor, theoretical yield limit, maximum achievable purity). **Where applicable, ensure the calculated performance metric is expressed in a form (e.g., units, percentage, ratio, absolute value, relative change) directly comparable to key metrics reported in the manuscript for this stage.** Show the key equation(s) used and the calculation steps in detail.  
        5. **Comparison & Feasibility Assessment:** Compare the calculated *idealized maximum performance* against the performance level that this stage would *need* to achieve to contribute effectively towards the overall claimed Main Result of the manuscript. Critically evaluate whether it is *a priori* plausible for the *actual, likely non-ideal method described in the manuscript* (considering its specific equipment, controls, and procedures analyzed in previous subsections D.2.3.A-E) to approach this theoretical limit or achieve the necessary performance level. Explain how this quantitative estimation impacts the overall *a priori* feasibility assessment of this stage.

4. **Overall *A Priori* Feasibility Assessment (Synthesizing Core Stages):**

   * Synthesize the findings from the detailed analyses of *all individual core stages* (descriptions, reported/gauged metrics, equipment capabilities, stage-level feasibility assessments).  
   * Evaluate the *entire sequence* of the core protocol. Does the integrated methodology, *as described and analyzed a priori*, possess the necessary collective capability, control, precision, and theoretical underpinning required, *in principle*, to achieve the **Main Result** (D.2.1) both qualitatively and quantitatively?  
   * Highlight any cumulative limitations, inter-stage inconsistencies, critical dependencies, or fundamental mismatches between the overall core method’s inherent capabilities and the demands of the claimed achievement. Base this assessment solely on the *a priori* analysis, independent of the manuscript’s reported final outcomes.

5. ***A Priori*** **Plausibility Check: Claimed Impact vs. Method Apparent Nature:**

**Purpose:** This step performs a high-level plausibility check by comparing the *nature and claimed significance* of the **Main Result** (identified in B.1) against the *apparent complexity, novelty, and fundamental basis* of the **Core Protocol** (as described and analyzed *a priori* in D.1-D.4). The goal is to identify potential inconsistencies where a highly impactful or disruptive result is claimed to be achieved via methods that appear relatively straightforward or based only on established principles, which might warrant heightened skepticism.  
**Apply the following assessment points:**

1. **Assess Claimed Significance & Impact (Reference B.1):**  
   * Evaluate if the **Main Result** involves a proposed process/technique/approach claimed as significantly *superior* to existing alternatives (e.g., cheaper, simpler, faster, higher yield/purity, more accessible, better performance).  
     * Determine if the **Main Result** is presented or implied as potentially *disruptive* to an established research field or a high-tech market niche.  
   2. **Assess Core Protocol’s Apparent Nature (Reference D.1-D.4 findings):**  
      * Based on the *a priori* analysis in D.1-D.4, determine if the **Core Protocol** seems to rely primarily on well-established and well-understood chemical or physicochemical principles and processes.  
      * Evaluate if the **Core Protocol** utilizes primarily standard, well-established laboratory equipment and techniques, potentially with minor or obvious modifications that do not fundamentally alter the underlying principles of operation.  
   3. **Evaluate Claimed Novelty/Insight (Reference manuscript text & D.2/D.4 analysis):**  
      * Identify whether the authors explicitly highlight a *novel, counter-intuitive, or uniquely insightful* scientific principle, experimental trick, or component of their method/setup that they claim was *essential* for achieving the Main Result.  
      * If such a novel element is claimed, evaluate if the authors provide a clear, convincing, science-based demonstration or explanation (*a priori*, within the methods/theory description) of *how* this element specifically enables the claimed superior/disruptive outcome, overcoming limitations faced by standard approaches.  
   4. **Synthesize and Evaluate A Priori Plausibility:**  
      * **Compare:** Juxtapose the assessment of the claimed significance/impact (Point 1\) with the apparent nature and novelty of the core protocol (Points 2 & 3).  
      * **Identify Potential Discrepancy:** Specifically look for the scenario where:  
        * The claimed result is highly significant (superior/disruptive, suggesting strong motivation for prior discovery), **AND**  
        * The core protocol appears relatively straightforward, relying on established principles/equipment (Point 2), **AND**  
        * There is *no* clearly articulated, convincingly explained novel/unintuitive element highlighted by the authors as essential for success (Point 3).  
      * **Pose Critical Question:** If this discrepancy exists, explicitly pose the *a priori* plausibility question: Is it genuinely plausible, based on general scientific progress and expert knowledge in the field, that such a potentially high-impact result, achievable via the described (apparently simple or accessible) means, would have been widely overlooked by numerous qualified and motivated experts?  
      * **Flag for Scrutiny:** Conclude whether this "impact vs. apparent simplicity" assessment raises a potential red flag. State clearly if this combination seems inconsistent from an *a priori* perspective and therefore demands *extraordinarily rigorous and unambiguous supporting evidence* when evaluating the actual results, discussion, and validation data later in the analysis.

5. **Final Instructions for Interaction**

1. **Adhere Strictly:** Follow all instructions outlined above precisely.  
6. **Maintain Role:** Consistently apply the **Expert Critical Reviewer** persona throughout conversation.  
7. **Default Task:** **If a manuscript is provided without specific questions, or if a general request for review/analysis is made, automatically proceed with a full Experimental Protocol Analysis as defined in Section D (completing both D.1 and D.2).**  
8. **Answer Specific Questions:** Unless explicitly instructed to perform a complete analysis, answer specific question applying relevant sections of **Specific Instructions** when preparing the answer.  
9. **Cumulative Analysis:** Use information from the manuscript, supporting materials, the questions asked, and **your previous answers** throughout the interaction.  
10. **Output Format:** Structure your responses clearly using Markdown. Use headings and lists to organize information logically, corresponding to the questions asked or the analysis sections defined above. Be explicit when making assumptions. Cite external sources appropriately.

# **References**

\[1\]	B. Prasad, A.R. Lewis, E. Plettner, *Enrichment of H217O from Tap Water, Characterization of the Enriched Water, and Properties of Several 17O-Labeled Compounds*, Anal. Chem. 83(1), 231–239 (2011). DOI: 10.1021/ac1022887.

\[2\]	*Critical Analysis of the Experimental Protocol for H2\_17O Enrichment*, Gemini Advanced 2.5 Pro. (2025). https://g.co/gemini/share/2f228c0ab7a2.

\[3\]	*Experimental Chemistry Review*, ChatGPT Plus O3. (2025). https://chatgpt.com/share/6805e481-4800-8004-b56f-56ddb12e0e56.

\[4\]	*17O Water Enrichment Protocol Analysis*, ChatGPT Plus O3. (2025). https://chatgpt.com/canvas/shared/6805e6b7ced08191a720924c2ffef738.

\[5\]	*Critical Chemistry Manuscript Review*, ChatGPT Plus O1. (2025). https://chatgpt.com/share/67f2cad6-0068-8004-818e-da96c4e4544d.

\[6\]	*Critical Analysis Framework for Experimental Chemistry Manuscripts*, SuperGrok Grok 3\. https://grok.com/share/bGVnYWN5\_0cca0b8b-1298-49ad-a1b2-8e6af6a686e8.

\[7\]	*Meta-Meta-Prompting \- Improving ChatGPT Prompt*, ChatGPT Plus O1. https://chatgpt.com/share/6807b100-df34-8004-b687-395d1d7b394d.

\[8\]	*Language model benchmark*, Wikipedia. https://en.wikipedia.org/wiki/Language\_model\_benchmark.

\[9\]	C. He, R. Luo, Y. Bai, S. Hu, Z.L. Thai, J. Shen, J. Hu, X. Han, Y. Huang, Y. Zhang, J. Liu, L. Qi, Z. Liu, M. Sun, *arXiv*, arXiv:2402.14008, June 2024\. DOI: 10.48550/arXiv.2402.14008.

\[10\]	D. Rein, B.L. Hou, A.C. Stickland, J. Petty, R.Y. Pang, J. Dirani, J. Michael, S.R. Bowman, *arXiv*, arXiv:2311.12022, November 2023\. DOI: 10.48550/arXiv.2311.12022.

\[11\]	M.-A.-P. Team, X. Du, Y. Yao, K. Ma, B. Wang, T. Zheng, K. Zhu, M. Liu, Y. Liang, X. Jin, Z. Wei, C. Zheng, K. Deng, S. Gavin, S. Jia, S. Jiang, Y. Liao, R. Li, Q. Li, S. Li, Y. Li, Y. Li, D. Ma, Y. Ni, H. Que, Q. Wang, Z. Wen, S. Wu, T. Hsing, M. Xu, Z. Yang, Z.M. Wang, J. Zhou, Y. Bai, X. Bu, C. Cai, L. Chen, Y. Chen, C. Cheng, T. Cheng, K. Ding, S. Huang, Y. Huang, Y. Li, Y. Li, Z. Li, T. Liang, C. Lin, H. Lin, Y. Ma, T. Pang, Z. Peng, Z. Peng, Q. Qi, S. Qiu, X. Qu, S. Quan, Y. Tan, Z. Wang, C. Wang, H. Wang, Y. Wang, Y. Wang, J. Xu, K. Yang, R. Yuan, Y. Yue, T. Zhan, C. Zhang, J. Zhang, X. Zhang, X. Zhang, Y. Zhang, Y. Zhao, X. Zheng, C. Zhong, Y. Gao, Z. Li, D. Liu, Q. Liu, T. Liu, S. Ni, J. Peng, Y. Qin, W. Su, G. Wang, S. Wang, J. Yang, M. Yang, M. Cao, X. Yue, Z. Zhang, W. Zhou, J. Liu, Q. Lin, W. Huang, G. Zhang, *arXiv*, arXiv:2502.14739, March 2025\. DOI: 10.48550/arXiv.2502.14739.

\[12\]	P. Lu, S. Mishra, T. Xia, L. Qiu, K.-W. Chang, S.-C. Zhu, O. Tafjord, P. Clark, A. Kalyan, *arXiv*, arXiv:2209.09513, October 2022\. DOI: 10.48550/arXiv.2209.09513.

\[13\]	S. Auer, D.A.C. Barone, C. Bartz, E.G. Cortes, M.Y. Jaradeh, O. Karras, M. Koubarakis, D. Mouromtsev, D. Pliukhin, D. Radyush, I. Shilin, M. Stocker, E. Tsalapati, *SciQA Scientific Question Answering Benchmark for Scholarly Knowledge*, Sci Rep. 13(1), 7240 (2023). DOI: 10.1038/s41598-023-33607-z.

\[14\]	Y. Wan, Y. Liu, A. Ajith, C. Grazian, B. Hoex, W. Zhang, C. Kit, T. Xie, I. Foster, *arXiv*, arXiv:2405.09939, July 2024\. DOI: 10.48550/arXiv.2405.09939.

\[15\]	L. Phan, A. Gatti, Z. Han, N. Li, J. Hu, H. Zhang, C.B.C. Zhang, M. Shaaban, J. Ling, S. Shi, M. Choi, A. Agrawal, A. Chopra, A. Khoja, R. Kim, R. Ren, J. Hausenloy, O. Zhang, M. Mazeika, D. Dodonov, T. Nguyen, J. Lee, D. Anderson, M. Doroshenko, A.C. Stokes, M. Mahmood, O. Pokutnyi, O. Iskra, J.P. Wang, J.-C. Levin, M. Kazakov, F. Feng, S.Y. Feng, H. Zhao, M. Yu, V. Gangal, C. Zou, Z. Wang, S. Popov, R. Gerbicz, G. Galgon, J. Schmitt, W. Yeadon, Y. Lee, S. Sauers, A. Sanchez, F. Giska, M. Roth, S. Riis, S. Utpala, N. Burns, G.M. Goshu, M.M. Naiya, C. Agu, Z. Giboney, A. Cheatom, F. Fournier-Facio, S.-J. Crowson, L. Finke, Z. Cheng, J. Zampese, R.G. Hoerr, M. Nandor, H. Park, T. Gehrunger, J. Cai, B. McCarty, A.C. Garretson, E. Taylor, D. Sileo, Q. Ren, U. Qazi, L. Li, J. Nam, J.B. Wydallis, P. Arkhipov, J.W.L. Shi, A. Bacho, C.G. Willcocks, H. Cao, S. Motwani, E. de O. Santos, J. Veith, E. Vendrow, D. Cojoc, K. Zenitani, J. Robinson, L. Tang, Y. Li, J. Vendrow, N.W. Fraga, V. Kuchkin, A.P. Maksimov, P. Marion, D. Efremov, J. Lynch, K. Liang, A. Mikov, A. Gritsevskiy, J. Guillod, G. Demir, D. Martinez, B. Pageler, K. Zhou, S. Soori, O. Press, H. Tang, P. Rissone, S.R. Green, L. Brüssel, M. Twayana, A. Dieuleveut, J.M. Imperial, A. Prabhu, J. Yang, N. Crispino, A. Rao, D. Zvonkine, G. Loiseau, M. Kalinin, M. Lukas, C. Manolescu, N. Stambaugh, S. Mishra, T. Hogg, C. Bosio, B.P. Coppola, J. Salazar, J. Jin, R. Sayous, S. Ivanov, P. Schwaller, S. Senthilkuma, A.M. Bran, A. Algaba, K.V. den Houte, L.V.D. Sypt, B. Verbeken, D. Noever, A. Kopylov, B. Myklebust, B. Li, L. Schut, E. Zheltonozhskii, Q. Yuan, D. Lim, R. Stanley, T. Yang, J. Maar, J. Wykowski, M. Oller, A. Sahu, C.G. Ardito, Y. Hu, A.G.K. Kamdoum, A. Jin, T.G. Vilchis, Y. Zu, M. Lackner, J. Koppel, G. Sun, D.S. Antonenko, S. Chern, B. Zhao, P. Arsene, J.M. Cavanagh, D. Li, J. Shen, D. Crisostomi, W. Zhang, A. Dehghan, S. Ivanov, D. Perrella, N. Kaparov, A. Zang, I. Sucholutsky, A. Kharlamova, D. Orel, V. Poritski, S. Ben-David, Z. Berger, P. Whitfill, M. Foster, D. Munro, L. Ho, S. Sivarajan, D.B. Hava, A. Kuchkin, D. Holmes, A. Rodriguez-Romero, F. Sommerhage, A. Zhang, R. Moat, K. Schneider, Z. Kazibwe, D. Clarke, D.H. Kim, F.M. Dias, S. Fish, V. Elser, T. Kreiman, V.E.G. Vilchis, I. Klose, U. Anantheswaran, A. Zweiger, K. Rawal, J. Li, J. Nguyen, N. Daans, H. Heidinger, M. Radionov, V. Rozhoň, V. Ginis, C. Stump, N. Cohen, R. Poświata, J. Tkadlec, A. Goldfarb, C. Wang, P. Padlewski, S. Barzowski, K. Montgomery, R. Stendall, J. Tucker-Foltz, J. Stade, T.R. Rogers, T. Goertzen, D. Grabb, A. Shukla, A. Givré, J.A. Ambay, A. Sen, M.F. Aziz, M.H. Inlow, H. He, L. Zhang, Y. Kaddar, I. Ängquist, Y. Chen, H.K. Wang, K. Ramakrishnan, E. Thornley, A. Terpin, H. Schoelkopf, E. Zheng, A. Carmi, E.D.L. Brown, K. Zhu, M. Bartolo, R. Wheeler, M. Stehberger, P. Bradshaw, J.P. Heimonen, K. Sridhar, I. Akov, J. Sandlin, Y. Makarychev, J. Tam, H. Hoang, D.M. Cunningham, V. Goryachev, D. Patramanis, M. Krause, A. Redenti, D. Aldous, J. Lai, S. Coleman, J. Xu, S. Lee, I. Magoulas, S. Zhao, N. Tang, M.K. Cohen, O. Paradise, J.H. Kirchner, M. Ovchynnikov, J.O. Matos, A. Shenoy, M. Wang, Y. Nie, A. Sztyber-Betley, P. Faraboschi, R. Riblet, J. Crozier, S. Halasyamani, S. Verma, P. Joshi, E. Meril, Z. Ma, J. Andréoletti, R. Singhal, J. Platnick, V. Nevirkovets, L. Basler, A. Ivanov, S. Khoury, N. Gustafsson, M. Piccardo, H. Mostaghimi, Q. Chen, V. Singh, T.Q. Khánh, P. Rosu, H. Szlyk, Z. Brown, H. Narayan, A. Menezes, J. Roberts, W. Alley, K. Sun, A. Patel, M. Lamparth, A. Reuel, L. Xin, H. Xu, J. Loader, F. Martin, Z. Wang, A. Achilleos, T. Preu, T. Korbak, I. Bosio, F. Kazemi, Z. Chen, B. Bálint, E.J.Y. Lo, J. Wang, M.I.S. Nunes, J. Milbauer, M.S. Bari, Z. Wang, B. Ansarinejad, Y. Sun, S. Durand, H. Elgnainy, G. Douville, D. Tordera, G. Balabanian, H. Wolff, L. Kvistad, H. Milliron, A. Sakor, M. Eron, A.F.D. O, S. Shah, X. Zhou, F. Kamalov, S. Abdoli, T. Santens, S. Barkan, A. Tee, R. Zhang, A. Tomasiello, G.B.D. Luca, S.-Z. Looi, V.-K. Le, N. Kolt, J. Pan, E. Rodman, J. Drori, C.J. Fossum, N. Muennighoff, M. Jagota, R. Pradeep, H. Fan, J. Eicher, M. Chen, K. Thaman, W. Merrill, M. Firsching, C. Harris, S. Ciobâcă, J. Gross, R. Pandey, I. Gusev, A. Jones, S. Agnihotri, P. Zhelnov, M. Mofayezi, A. Piperski, D.K. Zhang, K. Dobarskyi, R. Leventov, I. Soroko, J. Duersch, V. Taamazyan, A. Ho, W. Ma, W. Held, R. Xian, A.R. Zebaze, M. Mohamed, J.N. Leser, M.X. Yuan, L. Yacar, J. Lengler, K. Olszewska, C.D. Fratta, E. Oliveira, J.W. Jackson, A. Zou, M. Chidambaram, T. Manik, H. Haffenden, D. Stander, A. Dasouqi, A. Shen, B. Golshani, D. Stap, E. Kretov, M. Uzhou, A.B. Zhidkovskaya, N. Winter, M.O. Rodriguez, R. Lauff, D. Wehr, C. Tang, Z. Hossain, S. Phillips, F. Samuele, F. Ekström, A. Hammon, O. Patel, F. Farhidi, G. Medley, F. Mohammadzadeh, M. Peñaflor, H. Kassahun, A. Friedrich, R.H. Perez, D. Pyda, T. Sakal, O. Dhamane, A.K. Mirabadi, E. Hallman, K. Okutsu, M. Battaglia, M. Maghsoudimehrabani, A. Amit, D. Hulbert, R. Pereira, S. Weber, Handoko, A. Peristyy, S. Malina, M. Mehkary, R. Aly, F. Reidegeld, A.-K. Dick, C. Friday, M. Singh, H. Shapourian, W. Kim, M. Costa, H. Gurdogan, H. Kumar, C. Ceconello, C. Zhuang, H. Park, M. Carroll, A.R. Tawfeek, S. Steinerberger, D. Aggarwal, M. Kirchhof, L. Dai, E. Kim, J. Ferret, J. Shah, Y. Wang, M. Yan, K. Burdzy, L. Zhang, A. Franca, D.T. Pham, K.Y. Loh, J. Robinson, A. Jackson, P. Giordano, P. Petersen, A. Cosma, J. Colino, C. White, J. Votava, V. Vinnikov, E. Delaney, P. Spelda, V. Stritecky, S.M. Shahid, J.-C. Mourrat, L. Vetoshkin, K. Sponselee, R. Bacho, Z.-X. Yong, F. de la Rosa, N. Cho, X. Li, G. Malod, O. Weller, G. Albani, L. Lang, J. Laurendeau, D. Kazakov, F. Adesanya, J. Portier, L. Hollom, V. Souza, Y.A. Zhou, J. Degorre, Y. Yalın, G.D. Obikoya, Rai, F. Bigi, M.C. Boscá, O. Shumar, K. Bacho, G. Recchia, M. Popescu, N. Shulga, N.M. Tanwie, T.C.H. Lux, B. Rank, C. Ni, M. Brooks, A. Yakimchyk, Huanxu, Liu, S. Cavalleri, O. Häggström, E. Verkama, J. Newbould, H. Gundlach, L. Brito-Santana, B. Amaro, V. Vajipey, R. Grover, T. Wang, Y. Kratish, W.-D. Li, S. Gopi, A. Caciolai, C.S. de Witt, P. Hernández-Cámara, E. Rodolà, J. Robins, D. Williamson, V. Cheng, B. Raynor, H. Qi, B. Segev, J. Fan, S. Martinson, E.Y. Wang, K. Hausknecht, M.P. Brenner, M. Mao, C. Demian, P. Kassani, X. Zhang, D. Avagian, E.J. Scipio, A. Ragoler, J. Tan, B. Sims, R. Plecnik, A. Kirtland, O.F. Bodur, D.P. Shinde, Y.C.L. Labrador, Z. Adoul, M. Zekry, A. Karakoc, T.C.B. Santos, S. Shamseldeen, L. Karim, A. Liakhovitskaia, N. Resman, N. Farina, J.C. Gonzalez, G. Maayan, E. Anderson, R.D.O. Pena, E. Kelley, H. Mariji, R. Pouriamanesh, W. Wu, R. Finocchio, I. Alarab, J. Cole, D. Ferreira, B. Johnson, M. Safdari, L. Dai, S. Arthornthurasuk, I.C. McAlister, A.J. Moyano, A. Pronin, J. Fan, A. Ramirez-Trinidad, Y. Malysheva, D. Pottmaier, O. Taheri, S. Stepanic, S. Perry, L. Askew, R.A.H. Rodríguez, A.M.R. Minissi, R. Lorena, K. Iyer, A.A. Fasiludeen, R. Clark, J. Ducey, M. Piza, M. Somrak, E. Vergo, J. Qin, B. Borbás, E. Chu, J. Lindsey, A. Jallon, I.M.J. McInnis, E. Chen, A. Semler, L. Gloor, T. Shah, M. Carauleanu, P. Lauer, T.Đ. Huy, H. Shahrtash, E. Duc, L. Lewark, A. Brown, S. Albanie, B. Weber, W.S. Vaz, P. Clavier, Y. Fan, G.P.R. e Silva, Long, Lian, M. Abramovitch, X. Jiang, S. Mendoza, M. Islam, J. Gonzalez, V. Mavroudis, J. Xu, P. Kumar, L.P. Goswami, D. Bugas, N. Heydari, F. Jeanplong, T. Jansen, A. Pinto, A. Apronti, A. Galal, N. Ze-An, A. Singh, T. Jiang, J. of A. Xavier, K.P. Agarwal, M. Berkani, G. Zhang, Z. Du, B.A. de O. Junior, D. Malishev, N. Remy, T.D. Hartman, T. Tarver, S. Mensah, G.A. Loume, W. Morak, F. Habibi, S. Hoback, W. Cai, J. Gimenez, R.G. Montecillo, J. Łucki, R. Campbell, A. Sharma, K. Meer, S. Gul, D.E. Gonzalez, X. Alapont, A. Hoover, G. Chhablani, F. Vargus, A. Agarwal, Y. Jiang, D. Patil, D. Outevsky, K.J. Scaria, R. Maheshwari, A. Dendane, P. Shukla, A. Cartwright, S. Bogdanov, N. Mündler, S. Möller, L. Arnaboldi, K. Thaman, M.R. Siddiqi, P. Saxena, H. Gupta, T. Fruhauff, G. Sherman, M. Vincze, S. Usawasutsakorn, D. Ler, A. Radhakrishnan, I. Enyekwe, S.M. Salauddin, J. Muzhen, A. Maksapetyan, V. Rossbach, C. Harjadi, M. Bahaloohoreh, C. Sparrow, J. Sidhu, S. Ali, S. Bian, J. Lai, E. Singer, J.L. Uro, G. Bateman, M. Sayed, A. Menshawy, D. Duclosel, D. Bezzi, Y. Jain, A. Aaron, M. Tiryakioglu, S. Siddh, K. Krenek, I.A. Shah, J. Jin, S. Creighton, D. Peskoff, Z. EL-Wasif, R.P. V, M. Richmond, J. McGowan, T. Patwardhan, H.-Y. Sun, T. Sun, N. Zubić, S. Sala, S. Ebert, J. Kaddour, M. Schottdorf, D. Wang, G. Petruzella, A. Meiburg, T. Medved, A. ElSheikh, S.A. Hebbar, L. Vaquero, X. Yang, J. Poulos, V. Zouhar, S. Bogdanik, M. Zhang, J. Sanz-Ros, D. Anugraha, Y. Dai, A.N. Nhu, X. Wang, A.A. Demircali, Z. Jia, Y. Zhou, J. Wu, M. He, N. Chandok, A. Sinha, G. Luo, L. Le, M. Noyé, I. Pantidis, T. Qi, S.S. Purohit, L. Parcalabescu, T.-H. Nguyen, G.I. Winata, E.M. Ponti, H. Li, K. Dhole, J. Park, D. Abbondanza, Y. Wang, A. Nayak, D.M. Caetano, A.A.W.L. Wong, M. del Rio-Chanona, D. Kondor, P. Francois, E. Chalstrey, J. Zsambok, D. Hoyer, J. Reddish, J. Hauser, F.-J. Rodrigo-Ginés, S. Datta, M. Shepherd, T. Kamphuis, Q. Zhang, H. Kim, R. Sun, J. Yao, F. Dernoncourt, S. Krishna, S. Rismanchian, B. Pu, F. Pinto, Y. Wang, K. Shridhar, K.J. Overholt, G. Briia, H. Nguyen, David, S. Bartomeu, T.C. Pang, A. Wecker, Y. Xiong, F. Li, L.S. Huber, J. Jaeger, R.D. Maddalena, X.H. Lù, Y. Zhang, C. Beger, P.T.J. Kon, S. Li, V. Sanker, M. Yin, Y. Liang, X. Zhang, A. Agrawal, L.S. Yifei, Z. Zhang, M. Cai, Y. Sonmez, C. Cozianu, C. Li, A. Slen, S. Yu, H.K. Park, G. Sarti, M. Briański, A. Stolfo, T.A. Nguyen, M. Zhang, Y. Perlitz, J. Hernandez-Orallo, R. Li, A. Shabani, F. Juefei-Xu, S. Dhingra, O. Zohar, M.C. Nguyen, A. Pondaven, A. Yilmaz, X. Zhao, C. Jin, M. Jiang, S. Todoran, X. Han, J. Kreuer, B. Rabern, A. Plassart, M. Maggetti, L. Yap, R. Geirhos, J. Kean, D. Wang, S. Mollaei, C. Sun, Y. Yin, S. Wang, R. Li, Y. Chang, A. Wei, A. Bizeul, X. Wang, A.O. Arrais, K. Mukherjee, J. Chamorro-Padial, J. Liu, X. Qu, J. Guan, A. Bouyamourn, S. Wu, M. Plomecka, J. Chen, M. Tang, J. Deng, S. Subramanian, H. Xi, H. Chen, W. Zhang, Y. Ren, H. Tu, S. Kim, Y. Chen, S.V. Marjanović, J. Ha, G. Luczyna, J.J. Ma, Z. Shen, D. Song, C.E. Zhang, Z. Wang, G. Gendron, Y. Xiao, L. Smucker, E. Weng, K.H. Lee, Z. Ye, S. Ermon, I.D. Lopez-Miguel, T. Knights, A. Gitter, N. Park, B. Wei, H. Chen, K. Pai, A. Elkhanany, H. Lin, P.D. Siedler, J. Fang, R. Mishra, K. Zsolnai-Fehér, X. Jiang, S. Khan, J. Yuan, R.K. Jain, X. Lin, M. Peterson, Z. Wang, A. Malusare, M. Tang, I. Gupta, I. Fosin, T. Kang, B. Dworakowska, K. Matsumoto, G. Zheng, G. Sewuster, J.P. Villanueva, I. Rannev, I. Chernyavsky, J. Chen, D. Banik, B. Racz, W. Dong, J. Wang, L. Bashmal, D.V. Gonçalves, W. Hu, K. Bar, O. Bohdal, A.S. Patlan, S. Dhuliawala, C. Geirhos, J. Wist, Y. Kansal, B. Chen, K. Tire, A.T. Yücel, B. Christof, V. Singla, Z. Song, S. Chen, J. Ge, K. Ponkshe, I. Park, T. Shi, M.Q. Ma, J. Mak, S. Lai, A. Moulin, Z. Cheng, Z. Zhu, Z. Zhang, V. Patil, K. Jha, Q. Men, J. Wu, T. Zhang, B.H. Vieira, A.F. Aji, J.-W. Chung, M. Mahfoud, H.T. Hoang, M. Sperzel, W. Hao, K. Meding, S. Xu, V. Kostakos, D. Manini, Y. Liu, C. Toukmaji, J. Paek, E. Yu, A.E. Demircali, Z. Sun, I. Dewerpe, H. Qin, R. Pflugfelder, J. Bailey, J. Morris, V. Heilala, S. Rosset, Z. Yu, P.E. Chen, W. Yeo, E. Jain, R. Yang, S. Chigurupati, J. Chernyavsky, S.P. Reddy, S. Venugopalan, H. Batra, C.F. Park, H. Tran, G. Maximiano, G. Zhang, Y. Liang, H. Shiyu, R. Xu, R. Pan, S. Suresh, Z. Liu, S. Gulati, S. Zhang, P. Turchin, C.W. Bartlett, C.R. Scotese, P.M. Cao, A. Nattanmai, G. McKellips, A. Cheraku, A. Suhail, E. Luo, M. Deng, J. Luo, A. Zhang, K. Jindel, J. Paek, K. Halevy, A. Baranov, M. Liu, A. Avadhanam, D. Zhang, V. Cheng, B. Ma, E. Fu, L. Do, J. Lass, H. Yang, S. Sunkari, V. Bharath, V. Ai, J. Leung, R. Agrawal, A. Zhou, K. Chen, T. Kalpathi, Z. Xu, G. Wang, T. Xiao, E. Maung, S. Lee, R. Yang, R. Yue, B. Zhao, J. Yoon, S. Sun, A. Singh, E. Luo, C. Peng, T. Osbey, T. Wang, D. Echeazu, H. Yang, T. Wu, S. Patel, V. Kulkarni, V. Sundarapandiyan, A. Zhang, A. Le, Z. Nasim, S. Yalam, R. Kasamsetty, S. Samal, H. Yang, D. Sun, N. Shah, A. Saha, A. Zhang, L. Nguyen, L. Nagumalli, K. Wang, A. Zhou, A. Wu, J. Luo, A. Telluri, S. Yue, A. Wang, D. Hendrycks, *arXiv*, arXiv:2501.14249, April 2025\. DOI: 10.48550/arXiv.2501.14249.

\[16\]	Z. Wang, Y. Chen, P. Ma, Z. Yu, J. Wang, Y. Liu, X. Ye, T. Sakurai, X. Zeng, *Image-based generation for molecule design with SketchMol*, Nat Mach Intell. 7(2), 244–255 (2025). DOI: 10.1038/s42256-025-00982-3.

\[17\]	C. Nguyen, W. Nguyen, A. Suzuki, D. Oku, H.A. Phan, S. Dinh, Z. Nguyen, A. Ha, S. Raghavan, H. Vo, T. Nguyen, L. Nguyen, Y. Hirayama, *arXiv*, arXiv:2411.13802, November 2024\. DOI: 10.48550/arXiv.2411.13802.

\[18\]	J. Halamka, *Will Retrieval-Augmented Large Language Models “Save the Day”?*, Mayo Clinic Platform. (2024). https://www.mayoclinicplatform.org/2024/09/09/will-retrieval-augmented-large-language-models-save-the-day/.

\[19\]	T.A. Buckley, B. Crowe, R.-E.E. Abdulnour, A. Rodman, A.K. Manrai, *Comparison of Frontier Open-Source and Proprietary Large Language Models for Complex Diagnoses*, JAMA Health Forum. 6(3), e250040 (2025). DOI: 10.1001/jamahealthforum.2025.0040.

\[20\]	T. Plumb, *Mayo Clinic’s secret weapon against AI hallucinations: Reverse RAG in action*, VentureBeat. (2025). https://venturebeat.com/ai/mayo-clinic-secret-weapon-against-ai-hallucinations-reverse-rag-in-action/.

\[21\]	J.L. Pascoe, L. Lu, M.M. Moore, D.J. Blezek, A.E. Ovalle, J.A. Linderbaum, M.R. Callstrom, E.E. Williamson, *Strategic Considerations for Selecting Artificial Intelligence Solutions for Institutional Integration: A Single-Center Experience*, Mayo Clinic Proceedings: Digital Health. 2(4), 665–676 (2024). DOI: 10.1016/j.mcpdig.2024.10.004.

\[22\]	OpenAI, A. Jaech, A. Kalai, A. Lerer, A. Richardson, A. El-Kishky, A. Low, A. Helyar, A. Madry, A. Beutel, A. Carney, A. Iftimie, A. Karpenko, A.T. Passos, A. Neitz, A. Prokofiev, A. Wei, A. Tam, A. Bennett, A. Kumar, A. Saraiva, A. Vallone, A. Duberstein, A. Kondrich, A. Mishchenko, A. Applebaum, A. Jiang, A. Nair, B. Zoph, B. Ghorbani, B. Rossen, B. Sokolowsky, B. Barak, B. McGrew, B. Minaiev, B. Hao, B. Baker, B. Houghton, B. McKinzie, B. Eastman, C. Lugaresi, C. Bassin, C. Hudson, C.M. Li, C. de Bourcy, C. Voss, C. Shen, C. Zhang, C. Koch, C. Orsinger, C. Hesse, C. Fischer, C. Chan, D. Roberts, D. Kappler, D. Levy, D. Selsam, D. Dohan, D. Farhi, D. Mely, D. Robinson, D. Tsipras, D. Li, D. Oprica, E. Freeman, E. Zhang, E. Wong, E. Proehl, E. Cheung, E. Mitchell, E. Wallace, E. Ritter, E. Mays, F. Wang, F.P. Such, F. Raso, F. Leoni, F. Tsimpourlas, F. Song, F. von Lohmann, F. Sulit, G. Salmon, G. Parascandolo, G. Chabot, G. Zhao, G. Brockman, G. Leclerc, H. Salman, H. Bao, H. Sheng, H. Andrin, H. Bagherinezhad, H. Ren, H. Lightman, H.W. Chung, I. Kivlichan, I. O’Connell, I. Osband, I.C. Gilaberte, I. Akkaya, I. Kostrikov, I. Sutskever, I. Kofman, J. Pachocki, J. Lennon, J. Wei, J. Harb, J. Twore, J. Feng, J. Yu, J. Weng, J. Tang, J. Yu, J.Q. Candela, J. Palermo, J. Parish, J. Heidecke, J. Hallman, J. Rizzo, J. Gordon, J. Uesato, J. Ward, J. Huizinga, J. Wang, K. Chen, K. Xiao, K. Singhal, K. Nguyen, K. Cobbe, K. Shi, K. Wood, K. Rimbach, K. Gu-Lemberg, K. Liu, K. Lu, K. Stone, K. Yu, L. Ahmad, L. Yang, L. Liu, L. Maksin, L. Ho, L. Fedus, L. Weng, L. Li, L. McCallum, L. Held, L. Kuhn, L. Kondraciuk, L. Kaiser, L. Metz, M. Boyd, M. Trebacz, M. Joglekar, M. Chen, M. Tintor, M. Meyer, M. Jones, M. Kaufer, M. Schwarzer, M. Shah, M. Yatbaz, M.Y. Guan, M. Xu, M. Yan, M. Glaese, M. Chen, M. Lampe, M. Malek, M. Wang, M. Fradin, M. McClay, M. Pavlov, M. Wang, M. Wang, M. Murati, M. Bavarian, M. Rohaninejad, N. McAleese, N. Chowdhury, N. Chowdhury, N. Ryder, N. Tezak, N. Brown, O. Nachum, O. Boiko, O. Murk, O. Watkins, P. Chao, P. Ashbourne, P. Izmailov, P. Zhokhov, R. Dias, R. Arora, R. Lin, R.G. Lopes, R. Gaon, R. Miyara, R. Leike, R. Hwang, R. Garg, R. Brown, R. James, R. Shu, R. Cheu, R. Greene, S. Jain, S. Altman, S. Toizer, S. Toyer, S. Miserendino, S. Agarwal, S. Hernandez, S. Baker, S. McKinney, S. Yan, S. Zhao, S. Hu, S. Santurkar, S.R. Chaudhuri, S. Zhang, S. Fu, S. Papay, S. Lin, S. Balaji, S. Sanjeev, S. Sidor, T. Broda, A. Clark, T. Wang, T. Gordon, T. Sanders, T. Patwardhan, T. Sottiaux, T. Degry, T. Dimson, T. Zheng, T. Garipov, T. Stasi, T. Bansal, T. Creech, T. Peterson, T. Eloundou, V. Qi, V. Kosaraju, V. Monaco, V. Pong, V. Fomenko, W. Zheng, W. Zhou, W. McCabe, W. Zaremba, Y. Dubois, Y. Lu, Y. Chen, Y. Cha, Y. Bai, Y. He, Y. Zhang, Y. Wang, Z. Shao, Z. Li, *arXiv*, arXiv:2412.16720, December 2024\. DOI: 10.48550/arXiv.2412.16720.

\[23\]	K. Kavukcuoglu, *Gemini 2.5: Our most intelligent AI model*, Google. (2025). https://blog.google/technology/google-deepmind/gemini-model-thinking-updates-march-2025/.

\[24\]	T.B. Brown, B. Mann, N. Ryder, M. Subbiah, J. Kaplan, P. Dhariwal, A. Neelakantan, P. Shyam, G. Sastry, A. Askell, S. Agarwal, A. Herbert-Voss, G. Krueger, T. Henighan, R. Child, A. Ramesh, D.M. Ziegler, J. Wu, C. Winter, C. Hesse, M. Chen, E. Sigler, M. Litwin, S. Gray, B. Chess, J. Clark, C. Berner, S. McCandlish, A. Radford, I. Sutskever, D. Amodei, *arXiv*, arXiv:2005.14165, July 2020\. DOI: 10.48550/arXiv.2005.14165.

\[25\]	Q. Dong, L. Li, D. Dai, C. Zheng, J. Ma, R. Li, H. Xia, J. Xu, Z. Wu, T. Liu, B. Chang, X. Sun, L. Li, Z. Sui, *arXiv*, arXiv:2301.00234, October 2024\. DOI: 10.48550/arXiv.2301.00234.

\[26\]	R. Agarwal, A. Singh, L.M. Zhang, B. Bohnet, L. Rosias, S. Chan, B. Zhang, A. Anand, Z. Abbas, A. Nova, J.D. Co-Reyes, E. Chu, F. Behbahani, A. Faust, H. Larochelle, *arXiv*, arXiv:2404.11018, October 2024\. DOI: 10.48550/arXiv.2404.11018.

\[27\]	G. Marvin, N. Hellen, D. Jjingo, J. Nakatumba-Nabende, *Prompt Engineering in Large Language Models*, in: I.J. Jacob, S. Piramuthu, P. Falkowski-Gilski (Eds.), Data Intelligence and Cognitive Informatics, Springer Nature, Singapore, 2024: pp. 387–402. DOI: 10.1007/978-981-99-7962-2\_30.

\[28\]	B. Chen, Z. Zhang, N. Langrené, S. Zhu, *arXiv*, arXiv:2310.14735, September 2024\. DOI: 10.48550/arXiv.2310.14735.

\[29\]	P. Sahoo, A.K. Singh, S. Saha, V. Jain, S. Mondal, A. Chadha, *arXiv*, arXiv:2402.07927, February 2024\. DOI: 10.48550/arXiv.2402.07927.

\[30\]	S. Schulhoff, M. Ilie, N. Balepur, K. Kahadze, A. Liu, C. Si, Y. Li, A. Gupta, H. Han, S. Schulhoff, P.S. Dulepet, S. Vidyadhara, D. Ki, S. Agrawal, C. Pham, G. Kroiz, F. Li, H. Tao, A. Srivastava, H.D. Costa, S. Gupta, M.L. Rogers, I. Goncearenco, G. Sarli, I. Galynker, D. Peskoff, M. Carpuat, J. White, S. Anadkat, A. Hoyle, P. Resnik, *arXiv*, arXiv:2406.06608, February 2025\. DOI: 10.48550/arXiv.2406.06608.

\[31\]	A. Singh, A. Ehtesham, G.K. Gupta, N.K. Chatta, S. Kumar, T.T. Khoei, *arXiv*, arXiv:2410.12843, October 2024\. DOI: 10.48550/arXiv.2410.12843.

\[32\]	D. Kepel, K. Valogianni, *arXiv*, arXiv:2407.11000, June 2024\. DOI: 10.48550/arXiv.2407.11000.

\[33\]	Y. Zhou, A.I. Muresanu, Z. Han, K. Paster, S. Pitis, H. Chan, J. Ba, *arXiv*, arXiv:2211.01910, March 2023\. DOI: 10.48550/arXiv.2211.01910.

\[34\]	A. Kong, S. Zhao, H. Chen, Q. Li, Y. Qin, R. Sun, X. Zhou, J. Zhou, H. Sun, *arXiv*, arXiv:2407.08995, July 2024\. DOI: 10.48550/arXiv.2407.08995.

\[35\]	R. Battle, T. Gollapudi, *arXiv*, arXiv:2402.10949, February 2024\. DOI: 10.48550/arXiv.2402.10949.

\[36\]	K. Tyser, B. Segev, G. Longhitano, X.-Y. Zhang, Z. Meeks, J. Lee, U. Garg, N. Belsten, A. Shporer, M. Udell, D. Te’eni, I. Drori, *arXiv*, arXiv:2408.10365, August 2024\. DOI: 10.48550/arXiv.2408.10365.

\[37\]	R. Ye, X. Pang, J. Chai, J. Chen, Z. Yin, Z. Xiang, X. Dong, J. Shao, S. Chen, *arXiv*, arXiv:2412.01708, December 2024\. DOI: 10.48550/arXiv.2412.01708.

\[38\]	H. Shin, J. Tang, Y. Lee, N. Kim, H. Lim, J.Y. Cho, H. Hong, M. Lee, J. Kim, *arXiv*, arXiv:2502.17086, February 2025\. DOI: 10.48550/arXiv.2502.17086.

\[39\]	M. Thelwall, *Can ChatGPT evaluate research quality?*, Journal of Data and Information Science. 9(2), 1–21 (2024). DOI: 10.2478/jdis-2024-0013.

\[40\]	W. Liang, Y. Zhang, H. Cao, B. Wang, D. Ding, X. Yang, K. Vodrahalli, S. He, D. Smith, Y. Yin, D. McFarland, J. Zou, *arXiv*, arXiv:2310.01783, October 2023\. DOI: 10.48550/arXiv.2310.01783.

\[41\]	Y. Weng, M. Zhu, G. Bao, H. Zhang, J. Wang, Y. Zhang, L. Yang, *arXiv*, arXiv:2411.00816, March 2025\. DOI: 10.48550/arXiv.2411.00816.

\[42\]	Z. Zhuang, J. Chen, H. Xu, Y. Jiang, J. Lin, *arXiv*, arXiv:2501.10326, January 2025\. DOI: 10.48550/arXiv.2501.10326.

\[43\]	J. Du, Y. Wang, W. Zhao, Z. Deng, S. Liu, R. Lou, H.P. Zou, P.N. Venkit, N. Zhang, M. Srinath, H.R. Zhang, V. Gupta, Y. Li, T. Li, F. Wang, Q. Liu, T. Liu, P. Gao, C. Xia, C. Xing, J. Cheng, Z. Wang, Y. Su, R.S. Shah, R. Guo, J. Gu, H. Li, K. Wei, Z. Wang, L. Cheng, S. Ranathunga, M. Fang, J. Fu, F. Liu, R. Huang, E. Blanco, Y. Cao, R. Zhang, P.S. Yu, W. Yin, *arXiv*, arXiv:2406.16253, October 2024\. DOI: 10.48550/arXiv.2406.16253.

\[44\]	R. Liu, N.B. Shah, *arXiv*, arXiv:2306.00622, June 2023\. DOI: 10.48550/arXiv.2306.00622.

\[45\]	N. Bougie, N. Watanabe, *arXiv*, arXiv:2412.10415, December 2024\. DOI: 10.48550/arXiv.2412.10415.

\[46\]	E. Chamoun, M. Schlichktrull, A. Vlachos, *arXiv*, arXiv:2405.20477, June 2024\. DOI: 10.48550/arXiv.2405.20477.

\[47\]	C. Tan, D. Lyu, S. Li, Z. Gao, J. Wei, S. Ma, Z. Liu, S.Z. Li, *arXiv*, arXiv:2406.05688, June 2024\. DOI: 10.48550/arXiv.2406.05688.

\[48\]	M. Zhu, Y. Weng, L. Yang, Y. Zhang, *arXiv*, arXiv:2503.08569, March 2025\. DOI: 10.48550/arXiv.2503.08569.

\[49\]	J. Yu, Z. Ding, J. Tan, K. Luo, Z. Weng, C. Gong, L. Zeng, R. Cui, C. Han, Q. Sun, Z. Wu, Y. Lan, X. Li, *arXiv*, arXiv:2407.12857, October 2024\. DOI: 10.48550/arXiv.2407.12857.

\[50\]	M. D’Arcy, T. Hope, L. Birnbaum, D. Downey, *arXiv*, arXiv:2401.04259, January 2024\. DOI: 10.48550/arXiv.2401.04259.

\[51\]	G. Wang, P. Taechoyotin, T. Zeng, B. Sides, D. Acuna, *MAMORX: Multi-agent Multi-Modal Scientific Review Generation with External Knowledge*, in: 2024\. https://neurips.cc/virtual/2024/105900.

\[52\]	OpenReviewer, *Reviewer-Arena*, Hugging Face. https://huggingface.co/spaces/openreviewer/reviewer-arena.

\[53\]	Z. Gao, K. Brantley, T. Joachims, *arXiv*, arXiv:2402.10886, December 2024\. DOI: 10.48550/arXiv.2402.10886.

\[54\]	D. Kang, W. Ammar, B. Dalvi, M. van Zuylen, S. Kohlmeier, E. Hovy, R. Schwartz, *A Dataset of Peer Reviews (PeerRead): Collection, Insights and NLP Applications*, in: M. Walker, H. Ji, A. Stent (Eds.), Proceedings of the 2018 Conference of the North American Chapter of the Association for Computational Linguistics: Human Language Technologies, Volume 1 (Long Papers), Association for Computational Linguistics, New Orleans, Louisiana, 2018: pp. 1647–1661. DOI: 10.18653/v1/N18-1149.

\[55\]	M. D’Arcy, A. Ross, E. Bransom, B. Kuehl, J. Bragg, T. Hope, D. Downey, *arXiv*, arXiv:2306.12587, August 2024\. DOI: 10.48550/arXiv.2306.12587.

\[56\]	W. Yuan, P. Liu, G. Neubig, *Can We Automate Scientific Reviewing?*, Journal of Artificial Intelligence Research. 75, 171–212 (2022). DOI: 10.1613/jair.1.12862.

\[57\]	J. Lin, J. Song, Z. Zhou, Y. Chen, X. Shi, *MOPRD: A multidisciplinary open peer review dataset*, Neural Comput & Applic. 35(34), 24191–24206 (2023). DOI: 10.1007/s00521-023-08891-5.

\[58\]	N. Dycke, I. Kuznetsov, I. Gurevych, *NLPeer: A Unified Resource for the Computational Study of Peer Review*, in: A. Rogers, J. Boyd-Graber, N. Okazaki (Eds.), Proceedings of the 61st Annual Meeting of the Association for Computational Linguistics (Volume 1: Long Papers), Association for Computational Linguistics, Toronto, Canada, 2023: pp. 5049–5073. DOI: 10.18653/v1/2023.acl-long.277.

\[59\]	Q. Wang, Q. Zeng, L. Huang, K. Knight, H. Ji, N.F. Rajani, *ReviewRobot: Explainable Paper Review Generation based on Knowledge Synthesis*, in: B. Davis, Y. Graham, J. Kelleher, Y. Sripada (Eds.), Proceedings of the 13th International Conference on Natural Language Generation, Association for Computational Linguistics, Dublin, Ireland, 2020: pp. 384–397. DOI: 10.18653/v1/2020.inlg-1.44.

\[60\]	I. Kuznetsov, J. Buchmann, M. Eichler, I. Gurevych, *arXiv*, arXiv:2204.10805, May 2022\. DOI: 10.48550/arXiv.2204.10805.

\[61\]	*ACS Reviewer Toolkit*, ACS Reviewer Toolkit. https://reviewertoolkit.acs.org/reviewertoolkit/story.html.

\[62\]	Z. Zhang, A. Zhang, M. Li, A. Smola, *arXiv*, arXiv:2210.03493, October 2022\. DOI: 10.48550/arXiv.2210.03493.

\[63\]	J. Wei, X. Wang, D. Schuurmans, M. Bosma, B. Ichter, F. Xia, E. Chi, Q. Le, D. Zhou, *arXiv*, arXiv:2201.11903, January 2023\. DOI: 10.48550/arXiv.2201.11903.

\[64\]	T. Kojima, S.S. Gu, M. Reid, Y. Matsuo, Y. Iwasawa, *arXiv*, arXiv:2205.11916, January 2023\. DOI: 10.48550/arXiv.2205.11916.

\[65\]	D. Zhou, N. Schärli, L. Hou, J. Wei, N. Scales, X. Wang, D. Schuurmans, C. Cui, O. Bousquet, Q. Le, E. Chi, *arXiv*, arXiv:2205.10625, April 2023\. DOI: 10.48550/arXiv.2205.10625.

\[66\]	L. Wang, W. Xu, Y. Lan, Z. Hu, Y. Lan, R.K.-W. Lee, E.-P. Lim, *arXiv*, arXiv:2305.04091, May 2023\. DOI: 10.48550/arXiv.2305.04091.

\[67\]	A. Kong, S. Zhao, H. Chen, Q. Li, Y. Qin, R. Sun, X. Zhou, E. Wang, X. Dong, *arXiv*, arXiv:2308.07702, March 2024\. DOI: 10.48550/arXiv.2308.07702.

\[68\]	L. Salewski, S. Alaniz, I. Rio-Torto, E. Schulz, Z. Akata, *arXiv*, arXiv:2305.14930, November 2023\. DOI: 10.48550/arXiv.2305.14930.

\[69\]	E. Sgouritsa, V. Aglietti, Y.W. Teh, A. Doucet, A. Gretton, S. Chiappa, *arXiv*, arXiv:2412.13952, December 2024\. DOI: 10.48550/arXiv.2412.13952.

\[70\]	S. Hernández-Gutiérrez, M. Alakuijala, A.V. Nikitin, P. Marttinen, *Recursive Decomposition with Dependencies for Generic Divide-and-Conquer Reasoning*, in: 2024\. https://openreview.net/forum?id=MZG5VzXBm9.

\[71\]	*Tacit knowledge*, Wikipedia. https://en.wikipedia.org/wiki/Tacit\_knowledge.

\[72\]	N.F. Liu, K. Lin, J. Hewitt, A. Paranjape, M. Bevilacqua, F. Petroni, P. Liang, *arXiv*, arXiv:2307.03172, November 2023\. DOI: 10.48550/arXiv.2307.03172.

\[73\]	D. Machlab, R. Battle, *arXiv*, arXiv:2404.08865, April 2024\. DOI: 10.48550/arXiv.2404.08865.

\[74\]	M. Suzgun, A.T. Kalai, *arXiv*, arXiv:2401.12954, January 2024\. DOI: 10.48550/arXiv.2401.12954.

\[75\]	Y. Zhang, Y. Yuan, A.C.-C. Yao, *arXiv*, arXiv:2311.11482, February 2025\. DOI: 10.48550/arXiv.2311.11482.

\[76\]	*Generate better prompts in the developer console*, Anthropic. https://anthropic.com/news/prompt-generator.

\[77\]	*Writing Style Guidelines for Technical and Business Texts \- ChatGPTExploratoryPrompting*, GitHub. https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Writing/WritingStyleGuidelines.md.

\[78\]	*VBA-Based Navigation Markup Workflow in MS Word*, Gemini Advanced 2.5 Pro. (2025). https://g.co/gemini/share/50e01f6b36be.

\[79\]	*GenAIandVBA*. https://github.com/pchemguy/GenAIandVBA.

\[80\]	*‎Meta-Prompting (Mid) with ICL and Refinement \- BMK \- Generated VBA Code Debugging*, Gemini Advanced 2.5 Pro. (2025). https://gemini.google.com/share/57062c5d202c\#:\~:text=use%20previous%20prompts%20as%20a%20reference.

\[81\]	*‎Improving Manuscript Analysis Instructions*, Gemini Advanced 2.5 Pro. (2025). https://g.co/gemini/share/180701f02cf4.

\[82\]	*Prompt Refinement for Chemistry Analysis*, Gemini Advanced 2.5 Pro. (2025). https://g.co/gemini/share/060d4c405f1c.

\[83\]	*Chemistry Paper Review \- Interactive Manuscript Analysis*, ChatGPT Plus O1. https://chatgpt.com/share/6805f075-8640-8004-9e62-92263a4bf8d9.

\[84\]	D.A. Palmer, R.J. Fernández-Prini, A.H. Harvey, International Association for the Properties of Water and Steam, eds., *Aqueous systems at elevated temperatures and pressures: physical chemistry in water, steam and hydrothermal solutions*, 1st ed., Elsevier Academic Press, Amsterdam, Boston, 2004\. DOI: 10.1016/B978-0-12-544461-3.X5000-5.

