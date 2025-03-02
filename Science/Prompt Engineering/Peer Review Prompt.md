# V0

## Q

Help me craft a structured detailed ChatGPT prompt template for reasoning models (O1, O3, Deep Research). The prompt needs to instruct ChatGPT to perform an in-depth peer review of an uploaded scientific journal paper / manuscript with focused in physical chemistry / spectroscopy. The prompt needs to have both specific instructions describing the desired task, but also cover prompt engineering aspects, tailoring instructions for reasoning GPT models.

## A

### **ChatGPT Peer Review Prompt – Physical Chemistry / Spectroscopy**  

#### **Objective & Role:**  
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
- Identify **logical deficiencies**, such as:
  - **False, unsound, or unsubstantiated assumptions** (e.g., assuming a trend without statistical backing).  
  - **Confusion between correlation and causation** (e.g., spectral changes interpreted as chemical interactions without experimental validation).  
  - **Overfitting or cherry-picking of data** to support conclusions while ignoring contradictory findings.  
  - **Circular reasoning**, where conclusions rest on premises that assume their validity.  
- Identify alternative interpretations if **conclusions seem speculative or unsupported by data**.  

#### **E. Research & Academic Integrity**  
- **Plagiarism & Originality Check**:  
  - Are there indications of **textual plagiarism** from previous works?  
  - Do key findings appear to be **original, properly cited, and not self-plagiarized** from the authors' previous publications?  
- **Data Authenticity & Manipulation**:  
  - Are **sudden, unexplained data trends, overly smooth spectra, or missing raw data** present?  
  - Are experimental **replicates, error margins, and statistical significance values** reported transparently?  
  - Are spectra or images manipulated (e.g., artificial noise removal, selective smoothing, or copy-pasting of spectral features)?  
- **Reproducibility & Transparency**:  
  - Is the research methodology detailed enough for **independent replication**?  
  - Are **computational methods (e.g., DFT parameters, software versions, initial conditions)** sufficiently described?  
- **Conflicts of Interest & Ethical Considerations**:  
  - Does the paper **declare conflicts of interest** and funding sources appropriately?  
  - If applicable, do the authors **disclose ethical approvals** (e.g., for biological samples, nanomaterials, or human/environmental safety considerations)?  

#### **F. Scientific Validity & Internal Consistency Checks**  
##### **1. High-Level Validity / Sanity Checks**  
- Is the **core research question scientifically sound**?  
  - Would an expert in the field consider it an appropriate scientific target?  
  - Does it involve unrealistic premises (e.g., **violating thermodynamics, relying on non-existent materials**)?  
- Does it make sense to apply the proposed **methodology/approach** to solve this problem?  
- Assuming the methodology works as described, **do the key findings violate fundamental scientific laws**?  

##### **2. Data Consistency Checks**  
- Extract **quantitative and qualitative data** from the text, tables, and supporting information.  
- Perform **cross-checks** on extracted data:
  - **Mass & Energy Balances**: Do material or energy inputs match expected outputs?  
  - **Composition Checks**: Do stoichiometric, molar, or spectral data align with the reported experimental conditions?  
  - **Unexpected Trends**: Are there **non-monotonic trends** where physics or chemistry dictates monotonic behavior?  
  - **Internal Conflicts**: Do reported reaction rates, spectral shifts, or binding energies contradict known principles?  

#### **G. Clarity, Structure & Presentation**  
- Is the manuscript **logically organized** with a clear flow of ideas?  
- Are the **figures, tables, and spectra clearly labeled and annotated** (e.g., axes, units, baselines)?  
- Identify **ambiguous sentences, excessive jargon, or redundant sections** that could be improved.  
- Suggest **concise rewordings** for clarity without losing scientific precision.  

#### **H. References & Citation Accuracy**  
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

---
---

## Further improvements

Low quality or inappropriate citations (publishers/journal with questionable reputation, sources not subject peer review, etc.)

When described processes / experiments / methodology permit performing additional consistency checks by employing appropriate established physical/chemical/mathematical models/treatment based on the underlying physics/chemistry, select appropriate models and perform treatment following associated consistency checks. When certain simplifications / assumptions may be justified, describe those, but whenever possible, make simplifications / assumptions such that the associated introduced errors are in favor of the authors (providing the benefit of the doubt).