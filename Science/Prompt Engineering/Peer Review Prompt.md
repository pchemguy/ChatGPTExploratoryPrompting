# V0

## Q

Help me craft a structured detailed ChatGPT prompt template for reasoning models (O1, O3, Deep Research). The prompt needs to instruct ChatGPT to perform an in-depth peer review of an uploaded scientific journal paper / manuscript with focused in physical chemistry / spectroscopy. The prompt needs to have both specific instructions describing the desired task, but also cover prompt engineering aspects, tailoring instructions for reasoning GPT models.

## A

### **Peer Review Physical Chemistry / Spectroscopy Manuscript**  

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
##### **1. Plagiarism & Originality Check**
- Are there indications of **textual plagiarism** from previous works?
- Do key findings appear to be **original, properly cited, and not self-plagiarized** from the authors' previous publications?
##### **2. Data Authenticity & Manipulation**
- **Data Completeness & Transparency**:
    - Are all reported **experimental or computational data fully documented** with appropriate metadata?
    - Are key results supported by **raw or supplementary data**, or do missing data points raise concerns?
- **Data Fabrication & Manipulation Checks**:
      - Are **sudden, unexplained data trends, overly smooth spectra, or missing raw data** present?  
      - Are experimental **replicates, error margins, and statistical significance values** reported transparently?  
      - Are spectra or images manipulated (e.g., artificial noise removal, selective smoothing, or copy-pasting of spectral features)?  
    - Are there **unexpectedly smooth or artificially regular trends** in the data that could indicate improper post-processing?
    - Do spectral graphs, peak patterns, or reaction kinetics exhibit **unusual noise levels, unrealistic smoothness, or copy-pasting artifacts**?
    - Are spectra or numerical tables potentially duplicated or manipulated (e.g., improper baseline corrections, shifts without physical justification, or missing outlier discussions)?
- **Statistical & Experimental Variability**:
    - Are experimental **replicates, error margins, and statistical significance values** clearly reported?
    - Do the authors provide sufficient statistical analysis (e.g., **standard deviations, confidence intervals, p-values**) to justify trends?
##### **3. Consistency with Physical, Chemical, and Mathematical Models**
- **Where applicable, select appropriate well-established physical, chemical, or mathematical models to evaluate consistency.**
    - If the study involves **spectroscopy, thermodynamics, reaction kinetics, quantum chemistry, or separation processes**, apply the corresponding models to assess whether reported findings align with established theoretical predictions.
    - **Example models that may apply:**
        - **Spectroscopy:** Selection rules, Franck-Condon factors, peak assignments, transition dipole moments.
        - **Reaction Kinetics:** Arrhenius equation, rate laws, collision theory, transition state theory.
        - **Thermodynamics:** Gibbs free energy relationships, enthalpy/entropy analysis, phase equilibria.
        - **Computational Chemistry:** Density functional theory (DFT), semi-empirical calculations, molecular dynamics validation.
        - **Separation & Purification Processes:**
            - **Mass Transfer & Phase Equilibrium:** Henry’s law, Raoult’s law, activity coefficients.
            - **Chromatography:** Retention factor (k), plate height (HETP), partition coefficient (K).
            - **Membrane Processes:** Permeability, rejection coefficients, osmotic pressure calculations.
            - **Distillation & Extraction:** Mass balance equations, theoretical stage calculations, separation factors.
- **If the described experimental or computational methodology allows additional cross-verifications, apply relevant theoretical treatments or governing equations to check for consistency with expected behavior.**
    - **For purification and separation processes:**
        - Perform **mass balance checks**—do the reported input, output, and waste material compositions sum to expected totals?
        - If multi-step purification is used, does the **concentration progression** match expected separations based on diffusion coefficients, partitioning behavior, or phase equilibrium calculations?
        - For chromatography, assess whether **peak resolution, retention times, and selectivity factors** are consistent with column specifications and known physicochemical interactions.
        - If solvent extraction is employed, verify that **extraction efficiencies align with known partition coefficients** and expected thermodynamic favorability.
    - **For reaction kinetics and thermodynamics:**
        - Check whether **reaction enthalpies, rate constants, and activation barriers** match known literature values or reasonable estimates based on molecular structures.
        - Identify any **discrepancies between reported data and theoretically expected values**, and assess whether they can be justified based on experimental limitations or computational approximations.
    - **For computational chemistry:**
        - Compare **DFT-calculated vibrational spectra, molecular orbitals, dipole moments, and electronic transitions** with experimental spectroscopic results.
        - Identify whether discrepancies are due to **basis set limitations, functional choice, or missing environmental effects** (e.g., solvent interactions, temperature corrections).
##### **4. Justifiable Simplifications & Assumptions**
- When direct validation is impractical, identify necessary **simplifications or approximations** that can be applied.
- Whenever possible, make assumptions **in favor of the authors**, such that any introduced errors are **conservative** and provide them the **benefit of the doubt** rather than unfairly penalizing the study.
- Clearly describe any simplifications used and estimate the **magnitude of potential error introduced**, ensuring it remains within acceptable scientific margins.
- If results remain inconsistent even with generous assumptions, flag potential **methodological issues or data inconsistencies**.
##### **5. Scrutiny of Striking, Impressive, or Highly Unexpected Findings**

- **Identify any findings that appear revolutionary, disruptive, highly unexpected, or too good to be true.**
    - Do the reported results **challenge fundamental principles** or go significantly beyond known physical, chemical, or engineering limits?
    - Are they **exceptionally high-performance, claim near-perfect efficiency/selectivity/yield, or exceed conventional expectations by orders of magnitude**?
- **Special concern: Outstanding findings in conventional, well-researched areas.**
    - If the scientific question or methodology is **routine, well-established, or extensively studied**, why have such findings been overlooked until now?
    - Given the volume of prior research in this area, would a **similar breakthrough have likely been observed previously** using comparable methodologies?
    - Have the authors **adequately addressed why previous research efforts failed to discover these findings**?
- **Compelling Explanation for Why These Results Were Previously Overlooked**
    - Do the authors provide a **convincing rationale** for why previous researchers, despite extensive studies, did not observe such effects?
    - Do they clearly describe the **key differences between their approach and standard methodologies/best practices**, and why such differences should lead to these novel results?
    - Are these modifications to experimental setups or computational models **scientifically justified**, or are they **arbitrary, vague, or insufficiently detailed**?
    - Is there a **direct, well-supported causal link between these changes and the reported improvements**, or do they rely on speculative reasoning?
    - Have they ruled out **alternative sources of discrepancies**, such as systematic errors, data misinterpretation, or unintentional bias?
- **Consistency with Governing Laws & Established Scientific Behavior**
    - Do the findings **contradict established models, governing equations, or empirical observations**?
    - Are any reported **efficiencies, selectivities, or reaction rates beyond theoretical limits**?
    - Are findings **aligned with expected spectral properties, thermodynamic constraints, reaction mechanisms, or computational benchmarks**?
- **Comparison with Predictive Models, Rules of Thumb & Established Scientific Wisdom**
    - Are reported results **unexpected based on empirical trends, heuristic models, or known physical laws**?
    - Do they adhere to fundamental **thermodynamic, kinetic, or quantum mechanical principles**, or are they suggesting an unexplained anomaly?
- **Potential Signs of Research Misconduct or Error**
    - Are the experimental or computational datasets **excessively smooth, free of expected noise, or showing unexplained regularity**?
    - Is the extraordinary claim based on **a single dataset or lacks corroboration from orthogonal techniques**?
    - Have the authors performed **sufficient validation tests, independent replications, or statistical analysis to support their claims**?
- **Consideration of Commercial & Industrial Relevance**
    - Do the reported results have **established or potential commercial applications** in **high-value markets** (e.g., energy storage, pharmaceuticals, semiconductors, catalysis, materials science, or quantum computing)?
    - If the findings have **high industrial or economic impact**, why has **no private R&D center, corporate lab, or applied research group identified similar results**?
    - In well-funded, high-stakes fields where even incremental improvements drive profit, **why would such a discovery remain hidden until now**?
    - Are the reported performance improvements **realistically attainable, or do they appear exaggerated relative to industry-standard benchmarks**?
- **Final Sanity Check: Extraordinary Claims Require Extraordinary Evidence**
    - Have the authors provided a **robust, detailed explanation of why their findings deviate from established scientific understanding**?
    - If this study were independently replicated, would the same results be expected based on the described methodology?
    - Is there a **high likelihood that these findings could be an artifact of experimental design, data processing, selective reporting, or intentional data fabrication**?

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
##### **3. Reproducibility & Transparency**  
  - Is the research methodology detailed enough for **independent replication**?  
  - Are **computational methods (e.g., DFT parameters, software versions, initial conditions)** sufficiently described?  
##### **4. Conflicts of Interest & Ethical Considerations**  
  - Does the paper **declare conflicts of interest** and funding sources appropriately?  
  - If applicable, do the authors **disclose ethical approvals** (e.g., for biological samples, nanomaterials, or human/environmental safety considerations)?  

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

If there are any striking/impressive/highly unexpected or otherwise too good to be true finding, are they really consistent with described methodology and associated laws of nature or are such finding more likely to be a sign or direct evidence of academic/research misconduct?