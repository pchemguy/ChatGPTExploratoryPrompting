# Debugging Prompts - Insights from Gemini Thinking Log. Multimodal Validation of Chemical Formulas

In [this work][PWP], I have used this [*test paper*][test paper] to explore applications of advanced prompt engineering techniques to analysis of scholar manuscripts in experimental chemistry. This post continues that work by exploring options for analysis of chemical formulas. The [*test paper*][test paper] constitutes a convenient challenging test case for this task as well (chemical needle in a haystack). Manuscript + SI combined totals to 44 pages. In this document, page S-8 shows a formula of ferrous ammonium sulfate as "Fe(NH<sub>4</sub>)<sub>2</sub>SO<sub>4</sub>" that misses one sulfate. I decided to see how difficult it would be to make a fairly generic prompt to spot this error.

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

This prompt somewhat improved the overall quality of the output and managed to identify the target problem more frequently, though it was still very unreliable. One advantage of the Gemini chat bot over ChatGPT is that the former actually exposes its thinking process via the "Show thinking" collapsible block. The amount of details shown in this block varies even with similar prompts. Whether this variability reflects actual variability in the thinking process or if this variability is due to selective and variable exposure of the model's thinking process is unclear. When I examined the model's thinking logs for different runs, I have noticed that the models was capable identify the target formula most of the time and extract it correctly (as it appears in text). Because in chemistry communications, the general practice is that most formulas (except, perhaps, for the most basic ones)  should have accompanying chemical name, I decided to ask the model to extract chemical names for each extracted formula and attempt to identify problem by comparing the formulas and with associated names. While the shared Gemini prompts do not expose the thinking logs

<!-- References-->

[PWP]: https://arxiv.org/abs/2505.03332
[test paper]: https://doi.org/10.1021/ac1022887
[ChemicalFormulasValidationPrompt]: https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/PWP/ChemicalFormulasValidation.md
