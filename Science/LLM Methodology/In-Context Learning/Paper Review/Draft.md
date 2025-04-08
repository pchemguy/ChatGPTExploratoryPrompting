# Modeling the Peer Review Process with LLM: AI-Powered Manuscript Critique Framework

## Summary 

I am sharing a proof-of-concept LLM [prompt](PeerReviewPrompt.md) that models the academic peer review process for experimental chemistry manuscripts. I also discuss select LLM and prompt engineering concepts and potential research directions. The key features of the presented prompт are highlighted below, with an extended list of features available [here](FrameWork_Features.md). The prompt has been developed and tested on a single [publication](https://pubs.acs.org/doi/10.1021/ac1022887). The basic use of this prompt:
1. Submit the prompt at the beginning of a new LLM conversation (the primary target model is Gemini Advanced 2.5 Pro)  
2. Su

 with 
  (repo [copy](Enrichment of H2 17O from Tap Water, Characterization of the Enriched Water, and Properties of Several 17O-Labeled Compounds.pdf) with SI), which is a remarkable example of a disastrous failure of the peer review process.

==N.B: Highlight prompt engineering and review methodology==

**Key Feature Highlights: Deep Analysis of Experimental Chemistry Manuscripts**  
- **Expert Peer Review Simulation:** Critically evaluates experimental methods _before_ considering claimed results. Rigorously assesses protocols based on fundamental scientific principles to uncover hidden flaws and questionable assumptions, independent of claimed outcomes.
- **Information Extraction, Inference, and Integration:** Actively extracts crucial claims, numeric data, and procedural details from across the entire manuscript (text, tables, figures). Intelligently infers missing parameters and synthesizes disparate information with scientific knowledge to build a cohesive, evidence-based understanding. 
- **Quantitative Reality Check:** Performs rapid back-of-the-envelope calculations, idealized modeling, and figure-based estimations. Rigorously tests if the described methods are _quantitatively capable_ of achieving the reported results _a priori_, flagging claims potentially inconsistent with method simplicity.
- **Deep Figure Analysis (Multimodal Analysis):** Meticulously analyzes figures, photos, and schematics. Extracts quantitative details _from visuals_ and cross-validates _visual information_ against the text to uncover inconsistencies or provide unique supporting evidence.
- **Guided Analysis Framework:** Leverages in-context learning and a hierarchical, modular, and flexible prompt architecture that systematically guides the LLM through complex, multi-step critiques. Ensures thorough, consistent, and structured evaluation, acting like an interactive, expert-driven review template.
- **Zero-Code Accessibility:** Implements sophisticated manuscript analysis capabilities directly within the standard LLM chat window using generally available advanced reasoning models. Entirely prompt-driven, requiring no programming, API access, or specialized software installs. (Primary target platform - Gemini *Advanced* 2.5 Pro; also tested on Gemini *Standard* 2.5 Pro, *ChatGPT Plus o1* and *SuperGrok Grok 3 Think* as of Apr 2025.) 
- **Markdown-Driven Prompt Architecture:** Relies on inherent **Markdown structure** (headings, lists, bolding, MathJax extension) to organize complex instructions during the development process and to effectively guide the LLM's sophisticated analytical process within the chat interface. _(Preserving format upon submission is essential for optimal function)._
