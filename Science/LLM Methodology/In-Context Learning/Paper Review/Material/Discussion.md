## Discussion and Outlook

### Further prompt development

- **Testing**:
    The prompt has been developed and tested using a single publication, so testing it on other experimental chemistry manuscripts (and associated further development) is essential.  
- **Structure:**
    There are probably a number of ways to optimize the current prompt structure. One of the obvious candidates is Section IV.D which is split in two parts as described in methodology section.  This division introduces extra complexity that very well may not be justifiable. Perhaps, the two sections should be collapsed into one to be used for all targets. Scope definition already present in Section IV.A may need to be optimized and extended to provide various analysis options, such as targeting the core experimental protocol only (present focus of Section IV.D.2) or some other component.
- **Scope**:  
    While I attempted to generalize the prompt text, presently it only attempts to cover in detail only the core experimental protocol (in case of the test manuscript, evaporation + distillation stages), which directly implement the main result. Extending the prompt to cover other experimental parts of the manuscript is one of the natural next steps.  

### Prompt engineering

- **Benchmarking:**
    I have not performed any formal benchmarking of the prompt except for generating referenced analyses. How to approach this task, especially considering the rapid evolution of the AI models, I presently do not know. There are a number of common [LLM benchmarks](https://en.wikipedia.org/wiki/Language_model_benchmark), but I do not know whether any of those might be suitable here.
- **Persona Engineering:**
    Role prompting is one of the common techniques used to steer LLMs toward desirable output. It relies on the user's ability to identify a suitable role character and on the model's correct interpretation of the user's intent. In this sense, this technique might be somewhat more opaque, compared, for example to explicit description of the desired behavior. One of the problems with explicit description, however, is that it might be difficult to verbalize the desired behavior to replace an identified well-suitable persona (though in such a case it might be a valid question to ask whether the model will pick the intent that is difficult to express for human). In rather simple cases a persona might as well just be used. For complex domain-specific STEM tasks, here there might be a room for improvement. In the presented version, I have used multiple personas with explicit projected qualities (Section II). Whether such a design is optimal for complex domain-specific STEM problems is an open question.
- **Meta-prompting / meta-reasoning / meta-learning:**
    Automatic/Automated prompt engineering is another interesting topic. Say, given a set of good detailed reviews of experimental chemistry papers, will AI generate a good persona section and reconstruct a generic workflow instruction something in line with (Section IV)? Or something even better for guiding AI through the review process (in place of the chemistry paper review process can be a different scope or task altogether, of course).
- **Multimodal analysis:**
    Multimodal analysis is one of the relatively younger features (or so I think). The first application that came to my mind was analysis of manuscript figures, extraction of information and its integration with information from others parts of the manuscript. As of April 2025, this feature only worked with Gemini Advanced 2.5 Pro. It did not work with the standard version Gemini 2.5 Pro, that is on the free plan. It did not work with either ChatGPT Plus o1 nor SuperGrok Grok 3 Think. While image analysis might work with, for example, GPT-4o, non-reasoning models are not considered for the tasks of interest. This may change soon, of course.  
    
    gapAI repeatedly identified aluminum foil around the fractionation column in photo of the figure S1 of the test manuscript, which was not mentioned anywhere in text. It also identified water hoses connected to the tilted condenser. Finally, I managed to persuade it (see prompt and analysis) to identify an object in the photo whose size could be estimated based on the information in text (that was 1 L round bottom flask) and use this information to estimate the critical for the modeling length of the fractionation column. While the estimation varied form run-to-run anywhere from 25-30 cm to 40-50 cm, this range was actually completely sufficient for the purpose of capping system efficiency.  
    
    Further investigation of this feature may focus on probing model's ability to extract ever more details, improving prompt for more complex photo/figure assessment. Identifying a suitable benchmark or assessment protocol is also important. There are some [benchmarks](https://en.wikipedia.org/wiki/Language_model_benchmark) used for language models that include multimodal testing. May be new approaches would be necessary, perhaps domain tailored testing. It would be important to probe model's accuracy, potential hallucinations, and particularly issues related to integration. For example, a model may "hallucinate" convincingly by including in photo description information inferred from text or related diagrams.  

### LLM models  

- **Workflow Tuning:**
    Instruction tuning is one of the standard features of leading general-purpose models. However, because one of the central ideas behind AI is that it supposed to figure on its own how to transform the input to output, the instructions generally have descriptive / declarative nature, that is they focus on **what** the user wants rather than on **how** to arrive there. More advanced prompting techniques, such as chain-of-thought do shift focus towards the transformation process to some extent. On the other hand, memorized instructions is nothing new either. In this case, there is a very strong emphasis on the transformation process, manifested as elaborate workflows with hierarchical architecture to be stored in working memory and invoked for related user input for subsequent prompts. All tested models demonstrated at least certain capability to follow this pattern, though additional focused research is necessary to see if there are any specific limitations other than, say, context window length, and whether additional tuning of foundational models specifically for this persistent-workflow-based pattern might be desirable.
- **Context Recall**
    LLMs do not have a perfect memory. Information provided to models in prompt is transformed and, for models supporting "working/context memory", can be retrieved/recalled/reused in subsequent prompts within the session/conversation. However, the process of recalling is [imperfect](https://arxiv.org/abs/2404.08865). Special [language model benchmarks](https://en.wikipedia.org/wiki/Language_model_benchmark) have been developed to [characterize](https://en.wikipedia.org/wiki/Language_model_benchmark#Context_length) this limitation. To what extent imperfect recall may affect persistent workflows pattern, particularly with large complex workflows, and how to counteract this problem (perhaps via repeating instructions?) is another open question.

### Framework extension

- **Knowledge codification methodology:**
    As I discussed in the methodology sections, the way I approached the process of translating the practical knowledge of analysis was by analyzing specific issues of the test paper, posing questions targeting identified issues, and generalizing them. This process necessitates field experts (extensive reviewing experience is desirable) with developed advanced meta-reasoning skills. The LLM might also be able to facilitate this process, but the relevant experience also needs to be acquired. Probably, other approaches can be used for achieving the same goal as well. 
- **Workflow Libraries:**
    Extending the prompt (or creating a separate version) to cover, for instance, theoretical and computational chemistry, as well as developing versions for other science and engineering areas present a significant interest. This direction necessitates direct involvement for field experts for efficient development processes.  
- **Modular Architecture:**
    Prompt sections for certain workflow blocks, such as extraction and classification of key findings or detailed figure analysis, may be developed and updated independently and included in a task snippet library (analogs of programming libraries providing routines for common operations). Complex workflows including respective tasks then will be able to simply include the necessary blocks, if available, focusing development on integration and higher level functionality.
- **Applications:**
    Preliminary results presented in this work suggest that at the present stage of development, leading AI models may be capable of performing meaningful in-depth analysis of manuscripts. More mature prompts, targeting such analysis may facilitate 
     - Review process by providing assistance to reviewers
     - Field-specific literature research
     - Preparation of subject reviews (particularly in combination with Deep Research functionality) 

  

  



  



Presented prompt is an early-stage prototype, and, as such, it has a number of obvious limitations (development opportunities).

There are also a number of immediate questions related to the underlying methodology, including its limits and exploring potential variations and further application to research and engineering tasks.


---
---
