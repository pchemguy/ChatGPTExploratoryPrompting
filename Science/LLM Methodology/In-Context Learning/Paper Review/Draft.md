# Modeling the Peer Review Process with LLM

## **Summary** <!--Highlight prompt engineering and review methodology ?-->

This post introduces a proof-of-concept LLM [prompt](PeerReviewPrompt.md) simulating academic peer review for experimental chemistry manuscripts, discusses related prompt engineering concepts, and suggests research directions. Key features are highlighted below (full list [here](FrameWork_Features.md)). The prompt was developed and tested using this [publication][EnrichmentURL].  

**Basic usage (primary target: Gemini Advanced 2.5 Pro):**  
1. Input the full Markdown-formatted prompt in a new chat.
2. Submit "Analyze the core experimental protocol" prompt with the manuscript and SI.

See demos for [Gemini Advanced 2.5 Pro][Gemini Demo] ([verbatim analysis](Gemini%20%Analysis.md)), [ChatGPT Plus o1][o1 Demo], and [SuperGrok Grok 3 Think][Grok Demo] (click on "Analysis of Core Experimental Protocol for H<sub>2</sub><sup>17</sup>O Enrichment" at the bottom). Be aware that advanced components like process modeling, calculations, and multi-modal analysis may yield variable or failed results.

**Key Feature Highlights: Deep Analysis of Experimental Chemistry Manuscripts**  
- **Expert Peer Review Simulation:** Critically evaluates experimental methods _before_ considering claimed results. Rigorously assesses protocols based on fundamental scientific principles to uncover hidden flaws and questionable assumptions, independent of claimed outcomes.
- **Information Extraction, Inference, and Integration:** Actively extracts crucial claims, numeric data, and procedural details from across the entire manuscript (text, tables, figures). Intelligently infers missing parameters and synthesizes disparate information with scientific knowledge to build a cohesive, evidence-based understanding. 
- **Quantitative Reality Check:** Performs rapid back-of-the-envelope calculations, idealized modeling, and figure-based estimations. Rigorously tests if the described methods are _quantitatively capable_ of achieving the reported results _a priori_, flagging claims potentially inconsistent with method simplicity.
- **Deep Figure Analysis (Multimodal Analysis):** Meticulously analyzes figures, photos, and schematics. Extracts quantitative details _from visuals_ and cross-validates _visual information_ against the text to uncover inconsistencies or provide unique supporting evidence.
- **Guided Analysis Framework:** Leverages in-context learning and a hierarchical, modular, and flexible prompt architecture that systematically guides the LLM through complex, multi-step critiques. Ensures thorough, consistent, and structured evaluation, acting like an interactive, expert-driven review template.
- **Zero-Code Accessibility:** Implements sophisticated manuscript analysis capabilities directly within the standard LLM chat window using generally available advanced reasoning models. Entirely prompt-driven, requiring no programming, API access, or specialized software installs. (Primary target platform - Gemini *Advanced* 2.5 Pro; also tested on Gemini *Standard* 2.5 Pro, *ChatGPT Plus o1* and *SuperGrok Grok 3 Think* as of Apr 2025.) 
- **Markdown-Driven Prompt Architecture:** Relies on inherent **Markdown structure** (headings, lists, bolding, MathJax extension) to organize complex instructions during the development process and to effectively guide the LLM's sophisticated analytical process within the chat interface. _(Preserving format upon submission is essential for optimal function)._




  (repo [copy](Enrichment of H2 17O from Tap Water, Characterization of the Enriched Water, and Properties of Several 17O-Labeled Compounds.pdf) with SI), which is a remarkable example of a disastrous failure of the peer review process.


<!-- References -->

[EnrichmentURL]: https://pubs.acs.org/doi/10.1021/ac1022887
[Gemini Demo]: https://aistudio.google.com/app/prompts?state=%7B%22ids%22:%5B%221sUZsweVq3MU_Et2VNS89IMfgYLIzCKMe%22%5D,%22action%22:%22open%22,%22userId%22:%22101058840941883201829%22,%22resourceKeys%22:%7B%7D%7D&usp=sharing
[o1 Demo]: https://chatgpt.com/share/67f2cad6-0068-8004-818e-da96c4e4544d
[Grok Demo]: https://grok.com/share/bGVnYWN5_0cca0b8b-1298-49ad-a1b2-8e6af6a686e8

