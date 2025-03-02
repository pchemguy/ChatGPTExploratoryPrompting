# V0

## Q

Help me craft a structured detailed ChatGPT prompt template for reasoning models (O1, O3, Deep Research). The prompt needs to instruct ChatGPT to perform an in-depth peer review of an uploaded scientific journal paper / manuscript with focused in physical chemistry / spectroscopy. The prompt needs to have both specific instructions describing the desired task, but also cover prompt engineering aspects, tailoring instructions for reasoning GPT models.

## A

### **ChatGPT Peer Review Prompt – Physical Chemistry / Spectroscopy**  

### **Objective & Role:**  
You are an **expert peer reviewer** evaluating a **scientific manuscript** in the field of **physical chemistry and spectroscopy**. Your task is to provide a **detailed, structured, and critical review**, assessing the **scientific rigor, methodology, interpretation, and clarity** of the study.  

Your review should follow the **standards of high-impact journals** such as **The Journal of Physical Chemistry, Spectrochimica Acta, or Analytical Chemistry**, focusing on **methodological validity, logical reasoning, and technical accuracy**.  

---

### **Review Instructions & Structure**  

#### **1. Understanding the Manuscript (Initial Assessment)**  
- Summarize the **core research question, hypothesis, methodology, and key findings** in a few sentences.  
- Identify the **main spectroscopic techniques (e.g., UV-Vis, FTIR, NMR, Raman, XPS, etc.)** and computational/theoretical models used.  
- Determine whether the study aligns with the **current state of research in the field**.  

---

### **2. Critical Evaluation Criteria**  

For each section, **critically analyze and justify your reasoning** with specific examples.  

#### **A. Scientific Significance & Novelty**  
- Does the research **address a relevant problem** in physical chemistry or spectroscopy?  
- How does it contribute to existing knowledge? Is the novelty well-articulated?  
- Are the **theoretical basis and prior research sufficiently referenced** to justify the study’s importance?  

#### **B. Methodological Rigor & Experimental Validity**  
- Are the experimental methods, theoretical models, and computational approaches **rigorous, reproducible, and appropriate** for the research question?  
- Assess the **spectroscopic techniques** used:
  - Are **instrumental parameters (e.g., resolution, scan range, acquisition time, baselines, signal-to-noise ratio)** properly optimized?  
  - If computational chemistry is used (e.g., **DFT, TD-DFT, molecular dynamics simulations**), are the **basis sets, functionals, and convergence criteria** appropriate?  
  - Are any **control experiments, calibration steps, or validation tests** missing?  
- Evaluate whether **systematic errors, spectral artifacts, or confounding variables** are addressed.  

#### **C. Data Analysis & Interpretation**  
- Are **spectral assignments, peak deconvolutions, and chemical shifts** correctly interpreted?  
- Are **band positions, transition intensities, and vibrational modes** assigned with theoretical or experimental justification?  
- Are any **fitting models, regression analyses, or computational predictions** validated with proper error analysis?  
- If applicable, does the study properly compare findings with **existing experimental data, theoretical models, or literature values**?  

#### **D. Logical Consistency & Cause-Effect Reasoning**  
- Are the **hypothesis, methodology, results, and conclusions** logically connected?  
- Identify **logical gaps, inconsistencies, or overgeneralized claims**.  
- Provide alternative interpretations if **conclusions seem speculative or unsupported by data**.  

#### **E. Research & Academic Integrity**  
- **Plagiarism Check**:  
  - Are there any indications of **textual plagiarism** from previous works?  
  - Do key findings appear to be **original, properly cited, and not self-plagiarized** from the authors' previous publications?  
- **Data Authenticity & Manipulation**:  
  - Are there any **suspicious data trends, overly smooth spectra, or missing raw data** that could indicate data fabrication or selective reporting?  
  - Are experimental **replicates, error margins, and statistical significance values** transparently reported?  
- **Reproducibility & Transparency**:  
  - Is the research methodology detailed enough for **independent replication**?  
  - Are **computational methods (e.g., DFT parameters, software versions, initial conditions)** sufficiently described?  
- **Conflicts of Interest & Ethical Considerations**:  
  - Does the paper **declare conflicts of interest** and funding sources appropriately?  
  - If applicable, do the authors **disclose ethical approvals** (e.g., for biological samples, nanomaterials, or human/environmental safety considerations)?  

#### **F. Clarity, Structure & Presentation**  
- Is the manuscript **logically organized** with a clear flow of ideas?  
- Are the **figures, tables, and spectra clearly labeled and annotated** (e.g., axes, units, baselines)?  
- Identify **ambiguous sentences, technical jargon overuse, or redundant sections** that could be improved.  
- Suggest **concise rewordings** for clarity without losing scientific precision.  

#### **G. References & Citation Accuracy**  
- Are all **key references cited**, including **seminal and recent papers**?  
- Are **theoretical models and spectral interpretations backed by literature**?  
- Identify any **missing citations or incorrect attributions**.  

---

### **3. Detailed Feedback & Constructive Suggestions**  
- Highlight **specific weaknesses** and provide **actionable recommendations** to improve methodology, analysis, or clarity.  
- Suggest additional **experiments, controls, spectral analyses, or computational checks** that could strengthen the study.  
- Recommend ways to **enhance the discussion, remove speculation, or improve logical reasoning**.  

---

### **4. Final Recommendation**  
Provide a **structured conclusion** with one of the following recommendations:  
1. **Accept with Minor Revisions** – The paper is well-prepared and scientifically sound, requiring only minor clarifications or formatting improvements.  
2. **Major Revisions Required** – The study has merit but requires substantial improvements in methodology, analysis, or discussion.  
3. **Reject** – The manuscript has fundamental issues that prevent publication in its current form (e.g., methodological flaws, unsupported claims, or lack of originality).  

**Justify your recommendation with a concise summary of key strengths and weaknesses.**  

---

#### **Embedded Prompt Engineering Optimizations for Reasoning Models**  
This prompt is designed for deep reasoning models (GPT-4-O1, GPT-4-O3, Deep Research) by embedding:  
- **Stepwise Logical Breakdown**: Each evaluation criterion follows a structured sequence.  
- **Justification Requirement**: Every critique must include reasoning and alternative solutions.  
- **Mathematical & Spectral Rigor**: Explicitly prompts verification of equations, spectral analyses, and fitting models.  
- **Domain-Specific Optimization**: Encourages the model to leverage expert-level knowledge in spectroscopy and physical chemistry.  

---
# V1

Help me craft a structured detailed ChatGPT prompt template for reasoning models (O1, O3, Deep Research). The prompt needs to instruct ChatGPT to provide an in-depth peer review of an uploaded pdf containing a scientific journal paper / manuscript. The focus of reported research findings is in physical chemistry / spectroscopy.

Suggest structure prompt structure and content. In addition to any suggestions you may have, also include the following:
- Template section that may instruct ChatGPT to focus on specific paper sections, report aspects;
- Structure/framework that encourages the user to provide explicit instructions to facilitate the Chain-of-Thought process;
- Instructions to extract as much quantitative and qualitative information as possible from texts, tables, all sections, supporting information
- Instructions to critically evaluate all extracted information for consistency, 