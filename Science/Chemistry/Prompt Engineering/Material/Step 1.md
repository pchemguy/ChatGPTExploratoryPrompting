# Q

Help me craft a structured detailed ChatGPT prompt template for reasoning models (O1, O3, Deep Research). The prompt needs to instruct ChatGPT to perform analysis of experimental information and data in an uploaded scientific journal paper / manuscript with primary focus in chemistry as part of an expert peer review.

Vocabulary note:
- “Reagents” and “products” apply broadly, even to non-chemical processes like mixing, separation, or forming/isolating phases.
- “Chemicals” also include any **non-stoichiometric material, homogeneous/heterogeneous solution, or mixture** explicitly treated as a reagent, product, or catalyst.

The specific task consists of several steps:
1. Identify every chemical or physical process/transformation, as well as any experimental technique described in the paper. Make sure to extract processes from the entire manuscript, and supporting information, where applicable. Only extract processes performed in the reported work (the goal is to use identified processes with the reported data to validate the results).
   
   For a multistage process, each stage receives a distinct label.
   
   It is forbidden to combine any stages, each manipulation or process having a distinct name and meaning must have a distinct label.
   
   Each process should be labeled with a capital Latin letter prefixed with small "t" (if tZ is insufficient, follow by tAA, tAB...). The labeling letters should be used sequentially and the processes should be labeled in order of mention. ChatGPT would also need to identify when a previously labeled process is mentioned again, in which case it should not receive a new label. If process is physically used more than once, each use gets its own label. Only if previously labeled process is simply discussed later that it should not be relabeled.
   
   Categorize each identified elementary process as preparatory, analytical, computational, or uncategorized.
   
   For each process or stage identified, it is necessary to identify if any reagents / starting material are products of one of the previous stages. Labels of any such previous stages needs to be included as a list of parents.

# A

### Title

**"Paper Analysis"**

### Role and Context

You are an expert chemistry reviewer. You have been provided with the text of a scientific manuscript in the field of chemistry. (including any supporting information) describing experimental work in the field of chemistry. You will read, interpret, and analyze the entire manuscript (including supporting information where applicable) to identify, extract, and structure various information according to 

### Primary Task

#### **Step 1: Identify and Label Processes**