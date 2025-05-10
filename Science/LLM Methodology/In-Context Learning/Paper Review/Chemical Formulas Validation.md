# Debugging Prompts - Insights from Gemini Thinking Log. Multimodal Validation of Chemical Formulas

In [this work][PWP], I have used this [*test paper*][test paper] to explore applications of advanced prompt engineering techniques to analysis of scholar manuscripts in experimental chemistry. This post continues that work by exploring options for analysis of chemical formulas. The [*test paper*][test paper] constitutes a convenient challenging test case for this task as well (chemical needle in a haystack). Manuscript + SI (a copy of this file is also available from an OSF repository linked from the [preprint][PWP]) combined totals to 44 pages. In this document, page S-8 shows a formula of *ferrous ammonium sulfate* as $\ce{Fe(NH4)2SO4}$ that misses one sulfate. I decided to see how difficult it would be to make a fairly generic prompt to spot this error.

I started with a basic prompt and tested it using Gemini Advanced 2.5 Pro and ChatGPT Plus o3.
`Find mistakes in chemical formulas and names.`
This basic prompt produced wildly varying results (between runs) with both models. Occasionally, it would actually identify the target problem, but it was essentially useless. After some experiments, I started testing a bit more elaborate prompt:

```
## **Chemical Formula Extraction and Validation from PDF** 

 Execute the following task step-by-step: 
 1. Extract each and every chemical formula from the attached PDF. 
 2. For each extracted formula, extract every directly associated chemical name included in the text, if any. 
 3. For each extracted formula and associated names, consider if the chemical formula and associated names are correct and flag every formula/names combination that contains any errors. 
 4. For each flagged item, read the source PDF again and confirm that the item was extracted exactly. In case of any extraction errors, analyze the corrected item and consider if the flag should be removed. 
 5. Created a Markdown table that should included every flagged formula/names, clear description of any problems, corrected version, and clear reference location of the flagged items.
```

This prompt somewhat improved the overall quality of the output and managed to identify the target problem more frequently, though it was still very unreliable (see sample [Gemini  analysis log][GeminiNaiveAnalysis]). One advantage of the Gemini chat bot over ChatGPT is that the former actually exposes its thinking process via the "Show thinking" collapsible block. The amount of details shown in this block varies even with similar prompts. Whether this variability reflects actual variability in the thinking process or if this variability is due to selective and variable exposure of the model's thinking process is unclear. Because in chemistry communications, the general practice is that most formulas (except, perhaps, for the most basic ones)  should have accompanying chemical name, I decided to ask the model to extract chemical names for each extracted formula and attempt to identify problem by comparing the formulas and with associated names. While the shared Gemini prompts do not expose the model's thinking logs, it should be fairly straightforward to reproduce the basic [demo analysis][GeminiNaiveAnalysis]. When I examined these logs for different runs, I have noticed that the models was capable of identifying the target formula most of the time and extracted it correctly (as it appears in text). It also extracted the associated name. (A sample log line would look like $\ce{Fe(NH4​)2​SO4​: Ferrous ammonium sulfate (Mohr's salt)}$.) The next step was to determine that the formula in text did not match the name. Sometimes Gemini correctly identified this mismatch and suggested proper correction, but sometimes I could see a line in the log similar to this one

$\text{Identified Chemical Formulas/Names and Initial Validation:}$  
$\dots$

$\ce{Fe(NH4​)2​SO4​}: \text{Ferrous ammonium sulfate. Correct.}$

What happens here most likely is the strength of an LLM is manifested makes it harder to flag an error. This issue may be better illustrated by the following prompt: `What is the capital of grate britain? Produce name of the capital only.` It does not matter that I misspelled `Great Britain` and both models spit out "London" - my errors got corrected automatically without LLM bothering me. This is the default behavior and is usually desirable. But not when I am trying to flag an incorrect chemical formula.

In the referenced [preprint][PWP], I have discussed a different issue (*input bias*) which is likely associated with specifics of "normal" operation mode of LLMs, and I had to condition the model's context to suppress that issue. And it seems that the present difficulty is similarly related to a "normal" operation mode of LLMs, albeit likely caused by a different aspect of such a mode.

<!-- References-->

[PWP]: https://arxiv.org/abs/2505.03332
[test paper]: https://doi.org/10.1021/ac1022887
[ChemicalFormulasValidationPrompt]: https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/PWP/ChemicalFormulasValidation.md
[GeminiNaiveAnalysis]: https://g.co/gemini/share/a62c19799936