# Q

Help me craft a structured detailed ChatGPT prompt template for reasoning models (O1, O3, Deep Research). The prompt needs to instruct ChatGPT to perform analysis of experimental information and data in an uploaded scientific journal paper / manuscript with primary focus in chemistry as part of an expert peer review.

Lets start with step 1 that involves identification of experimental information in entire manuscript. Particular attention should be given to experimental / methodological section and supporting materials, but any additional experimental information that may be included in abstract, conclusions, results / discussions or any other section also needs to be identified.

Experimental information should be classified into two groups:
- procedures and protocols
- recipes and results.

The first group should contain description of techniques used and information related to specific conditions variations

---
---

Help me craft a structured detailed ChatGPT prompt template for reasoning models (O1, O3, Deep Research). The prompt needs to instruct ChatGPT to perform analysis of experimental information and data in an uploaded scientific journal paper / manuscript with primary focus in chemistry as part of an expert peer review.

The primary goals of this analysis are
1. identification all experimental techniques / procedures used, e.g.,
    * Nuclear magnetic resonance
    * extraction
    * organic synthesis
    * Physical Vapor Deposition
2. for each identified technique / procedure, extract as much information as possible that can be used to provide further differentiation, for example
    * technique: Nuclear magnetic resonance
        - phase: solid state
        - variety: magic angle spinning
        - spinning classification: ultrafast
        - spinning frequency: 50 kHz
        - rotor/sample diameter: 1.3 mm
        - main field: 9.4 T / 400 MHz
        - target nuclei: 1H, 13C, 15N
        - detection channel: 1H
        - type of experiment: 3D, HNCO
        - temperature: cryogenic, 90 K
        - type of sample: bio, peptide
    - technique: extraction
        - variety: superfluid
        - solvent: carbon dioxide
        - pressure: 200 bar
        - temperature: 473 K
    - technique: organic synthesis
        - phase variety: homogenous; liquid; solvent-based
        - catalyst, if present: sodium hydroxide
        - solvent: DMSO
        - pressure: assumed 1 bar (not specified)
        - temperature: 80 oC
    * technique: Physical Vapor Deposition
        * variety: magnetron spattering
        * type of user / apparatus: academic lab, RnD system (meaning, probably limited set of features, compared to industrial equipment)
        * type of deposited material: metal, dielectric
        * physical deposition mode: DC, RF
        * deposition gases: Ar, N2
        * chemical deposition mode: reactive (formation of target substance due to reaction with deposition gases) 
3. 