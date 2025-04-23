Abstract: section on methodology

---

Title: ... and via LLM-assisted prompt engineering

---

Methodology - limitations - test paper

---

Methodology

**Acs peer review**  

**A note on peer review**  

Scholar peer review is knowledge and reasoning intensive process involving complex workflows that need to be tailored to specific field/subfield/journal. The inherent complexity of this process is only one reason why peer review is a challenging task for ai systems. Limit availability of review examples that could be used for model training is another reason, though a number of specialized data sets have used for training and testing purposes []. Another

Structured systematic analysis and complex workflows are crucial for preparation of high quality peer reviews. But **these activities largely really on mostly tacit knowledge of high-level experts and are generally time-intensive.**

Perhaps a bigger question would be to what extent tacit knowledge involved in research/engineering/medicine activities can be codified/formalized, that is reduced/decomposed to actionable workflows/structured abstract/generalized protocols involving simpler steps accessible (whatever it means) to SOTA AI.

Problem of generating increasingly abstracting protocols that still elicit detailed and tailored response

Meta-reasoning meta-learning meta-research

   even for state-of-the-art (SOTA) LLM models

Two common strategies for a complex problem, and associated workflows

https://researcher-resources.acs.org/publish/peer_reviews
https://reviewertoolkit.acs.org/reviewertoolkit/story.html

---

**LLM-assisted PE**

https://gemini.google.com/app/59e84d4879cebb1c
https://gemini.google.com/app/efb8c56cfe127897
https://gemini.google.com/app/d2c4bde3d736612e
https://gemini.google.com/app/6d2be1cb7165c2e2
https://gemini.google.com/app/3228c100823b1c62
https://gemini.google.com/app/c0bbf5c426b3f66a
https://gemini.google.com/app/df57ae1b7998afd1
https://gemini.google.com/app/ea9bea57348f2876
https://chatgpt.com/c/674ef0cb-665c-8004-b7d0-fb28e7a9af12

---

Idealized model

[https://gemini.google.com/app/1f630e421bf874e8](https://gemini.google.com/app/1f630e421bf874e8)  
[https://gemini.google.com/app/ea9bea57348f2876](https://gemini.google.com/app/ea9bea57348f2876)  

Multimodal capabilities

Google Gemini ADVANCED 2.5 Pro (but not the "standard" version available without subscription) repeatedly demonstrated ability to analyze and understand images and integrated extracted and inferred information. In particular, it consistently identified aluminum foil around the fractionation column in the SI Fig. 1 [§], and this information was not present anywhere in text. It has also inferred scale information based on text description per instructions and used this information for subsequent analysis of the underlying physical processes.

While OpenAI has indicated that their recent o3 reasoning model is capable of performing multimodal analysis, in my limited testing of this feature, I have not observed strong evidences of this capability. Furthermore, OpenAI, as opposed to Google, hides ChatGPT's reasoning models' thought process, so direct verification of OpenAI's claims is also problematic.


[https://openai.com/index/thinking-with-images](https://openai.com/index/thinking-with-images)

---

For very complex prompt development use the best reasoning models and treat it like a peer. I have been using ChatGPT Plus o1 and Google Gemini Advanced 2.5 Pro. The o1 Pro version might have provided additional advantage, it but requires more substantial financial commitment. The problem with o1 Plus is its restrictive use limit: with 50 prompts per week, it is very limited in practice. Now the o3 model is out, and it is likely to be even more restrictive. Input/output token limits are two other important characteristics that motivated my switching from OpenAI to Google.

  

The general strategy is start small by drafting initial prompt. In fact, when developing something new, don't bother about having a prompt at all.
