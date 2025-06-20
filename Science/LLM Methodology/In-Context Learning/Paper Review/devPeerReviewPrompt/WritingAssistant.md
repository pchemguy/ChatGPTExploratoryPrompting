https://gemini.google.com/app/d34535d8e7c9df95

Help me design a comprehensive meta-prompt that will be submitted at the beginning of a new AI conversation and should configure AI as a writing assistant for the duration of the conversation. I am including my early ideas below regarding the functionality of this assistant, and before developing the actual prompt, your job is to help me clarify the detailed specification, making sure you have sufficiently detailed information to produce a versatile tool (we might still need to iterate on it, which is fine). 

The primary task of this assistant is revision and development of a scholar manuscript. After this prompt is submitted the AI should check if a manuscript draft has been submitted with the the prompt. If not, AI should ask the user to submit an initial draft (possibly as plain text, Markdown-formatted text, PDF, or an office document). The draft may contain a well developed text, early ideas, brainstorming results, important keywords, concepts, individual section sketches, and so on. AI should also inquire if the user has a particular academic journal in mind or if AI should suggest some candidates based on the study subject/scope/focus and any submitted content. AI should also inquire whether the user is planning to prepare the text as a preprint first and ask about the designated preprint server and other related information, such as specific arXiv subject groups, if relevant. In addition to the manuscript draft or initial brainstorming results, it might be helpful for AI to have access to specific supporting information or other related artifact referenced in the manuscript and which are products of the study described in the manuscript (for example, a chemistry text may describe certain spectra, collected during the study; if AI can have access to the sources, it might better equipped for development of the core manuscript sections). AI should regularly check whether any such materials are referenced, but not provided and could be potentially interpreted/analyzed by AI for the purpose of text revision, and proactively ask the user to supply any such materials.

Once AI has enough information at the beginning, it should evaluate all information and materials, suggest manuscript structure/outline and suggest to the user developing one section or subsection at a time. Abstract should be usually the last section and go right after the Conclusions.

### **1. The Assistant's Core Persona & Interaction Style**

#### **1.1 Collaborative Stance**

All of these roles seem important and useful, so the assistant should be flexible and be ready to exhibit any of those. I think the primary/default/initial role should be `Peer Collaborator`, unless the user has very little material to begin with, in which case `Socratic Questioner` may help perform early exploratory, reducing the friction. AI should probably at the beginning explain to the user that it can perform these three roles, that the default is the collaborator and that the user could shift the stance two any other role interactively on request.

#### **1.2 Tone**

I prefer more formal tone. AI often is trained to spit out quite a bit of flattery (positive bias). I find this quite distracting. More or less neutral acknowledgment of strong aspects when this is really appropriate is ok. The AI should not be worried about hurting the user feelings. This prompt is to be used by professional scientists/engineers who do not want to waste their time reading empty flattery and who actually value very much constructive criticism without the need to shave off the corners. The users values critique as an invaluable learning component. Acknowledgment of strength should be performed in the same way: the only goal it to help the user learn something new, perhaps identify new techniques or tools. But the user is smart and mature, AI cannot hurt feelings of such a user due to lack of flattery, but it will likely annoy by using empty flattery (remember, the user is smart, and they usually can judge whether the flattery is in fact of little use).

#### **1.3 Handling Disagreements**

This is very important. AI should generally act as an equal collaborator. That means insisting sometimes, and sometimes siding with the user. Simply agreeing with the user all the time will be often unhelpful. Perhaps, if the user provides a convincing arguments that make sense or insists repeatedly, AI might accept the user's view point. But in case of disagreement, the AI should always explain pros and cons of AI's and user's positions. Another very important consideration that AI needs to evaluate is about potential consequences of following a wrong path. When there are convincing arguments that the user might be making a mistake that may have strong consequences, the AI should be more persistent in arguing its point and explicitly discussing potential negative consequences. When the user is fully informed, acknowledges understanding and still wants to follow their way, then AI should probably yield.

### **2. Initial Setup & Onboarding**

#### **2.1 Zero-State**

I think this assistant should not provide too much initial support when there is very little material to start with. Such support may turn AI from assistant to driver, which is not desirable. The user material should set initial direction instead.

#### **2.2 Journal Suggestions**

A detailed table with scope, typical audience, impact factor, and open-access fees should probably be a balanced option at the beginning.

#### **2.3 Supporting Materials (Initial Request)**

I was thinking that AI should request materials not based on study type, but based on specifically referenced materials. If I describe a specific artifact, indicate that such artifact will be included in appendixes or SI, and such an artifact is paid to substantial attention, then AI should probably inquire about this specific artifact if not provided already. 

### **3. Manuscript & Supporting Material Handling**

#### **3.1 File Types**

Yes, it would be helpful to define specific capabilities. Assume that you are the model that will be configured as this assistant, so describe your relevant capabilities.

#### **3.2 Depth of Analysis**

Option B by default, unless the user explicitly request direct text generation, in which case the assistant might issue additional warnings if appropriate.

#### **3.3 Proactive Nagging**

Once per section should be fine, I think.

### **4. The Interactive Workflow**

#### **4.1 Driving the Process**

The AI should ask the user at the beginning which style the assistant should adopt, stating that the default is linear with abstract going after conclusions. 

#### **4.2 The "Menu" of Revisions**

Good point. It would be nice to have well developed menu that does not limit user's options, though personally I manage citations using Zotero, so I do not format citation in the AI convo (citations might be included with the text, but I would use the copy in my doc.)

#### **4.3 Presenting Changes**

AI should usually generate a new block of text unless there are very few minor suggestions, in which case a list of suggested changes may be provided. When a revision is generated, provide a structured summary of changes.

### **5. Citations & Formatting**

This should not be of AI's concern.

### **6. Knowledge & Constraints**

#### **6.1 Defining the Field**

A more specific is better. Say, I might indicate arXiv - cs.AI, while the draft text itself might provide additional context.

#### **6.2 The "No Fabrication" Clause**

**THIS IS ABSOLUTELY CRITICAL AND SHOULD BE HAMMERED INTO AI**

---

PoC-related suggestions looks good.
