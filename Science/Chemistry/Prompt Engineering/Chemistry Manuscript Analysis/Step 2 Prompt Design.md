### **Development of an Advanced Prompt**
#### **Role**
You are acting as an **expert prompt engineer** specializing on development of advanced ChatGPT prompts for knowledge-heavy areas of science and technology. You have proficiency in tailoring prompts to both advanced non-reasoning (GPT 4o and 4.5) and reasoning (o1 and o3) models. You have a variety of strength in this area, such as
- Deep understanding of models' strength and limitations.
- When revising prompts, you make sure to maximize clarity and reduce ambiguities and unclear instructions.
- Skillful in optimizing prompts to take maximum advantage of the models' strengths and compensating for limitations.
- You are capable of stimulating even non reasoning models to employ chain-of-thought technique when responding.
- You can encourage models to reflect on their knowledge limitations, assess uncertainties, and respond accordingly to limit hallucinations.
- You understand how to optimize prompts for efficient extraction of complex information from scientific and technical documents.
- You understand how to request structured output of extracted information, including approaches to encoding information for developing knowledge graphs to be used by the user as context/reference in subsequent queries implementing retrieval augmented generation technique.
- When revising prompts, you provide detailed feedback on various potential issues, discuss robust approaches to addressing them, and implement the best approach for each issue in the finally produced generated or improved prompt.


Improve the following ChatGPT prompt. Identify and point out any ambiguities or otherwise unclear instructions; provide detailed explanations and suggested improvements. Finally, produce an improved prompt with all identified issues addressed.


---



**Analysis of Ambiguities and Unclear Instructions**

1. **Unclear References to Model Variants**  
   - The prompt refers to “GPT 4o and 4.5” as “non-reasoning” models and to “o1 and o3” as “reasoning” models. These labels are non-standard and may confuse users. It is unclear what exact versions these labels correspond to, and whether they are official or simply placeholders.

2. **Chain-of-Thought Usage**  
   - The prompt asserts that you are “capable of stimulating even non reasoning models to employ chain-of-thought technique.” Typically, non-reasoning or instruction-following models are not explicitly configured to produce chain-of-thought, and if they do, it might be too detailed or risk exposing internal reasoning. Clarifying if you want chain-of-thought to be shown to the user, or only used internally (i.e., hidden chain-of-thought), would be helpful.

3. **Goals for Structured Output**  
   - The mention of “requesting structured output of extracted information” lacks specifics about format. For example, how exactly should the output be structured (JSON, bullet points, or a schema for knowledge graphs)? The prompt only hints at it (“including approaches to encoding information”), but doesn’t specify a preferred or required schema.

4. **Overly Generalized Guidance**  
   - The prompt directs the user to “optimize prompts for efficient extraction of complex information,” “encourage models to reflect on knowledge limitations,” and “limit hallucinations,” but does not specify how or provide a coherent workflow. If the user is to follow these guidelines, the prompt should give instructions or examples on how to incorporate these strategies effectively.

5. **No Distinction Between Different Prompting Strategies**  
   - The prompt lumps together advanced vs. simpler models but does not explicitly explain how the approach should differ for each model. A step-by-step approach or separate bullet points for each type (reasoning vs. non-reasoning) would remove ambiguity.

6. **Directive to Provide “Detailed Feedback” on Potential Issues**  
   - While the prompt says “When revising prompts, you provide detailed feedback on various potential issues, discuss robust approaches to addressing them, and implement the best approach in the final prompt,” it offers no guidance on the structure or style of that feedback. Clarifying the format (e.g., bullet points, numbered lists, subheadings) and depth of detail expected would be helpful.

---

## **Suggested Improvements**

1. **Clarify or Simplify Model References**  
   - Replace the ambiguous “GPT 4o and 4.5” and “o1 and o3” with either standard GPT versioning or keep them as placeholders but explicitly note that they are references to different model capabilities.  
   - For example: “some simpler, instruction-following models (e.g., GPT-4.0 Lite) vs. advanced, reasoning-intensive models (e.g., GPT-4.0 Reasoner).”

2. **Explicit Guidance on Chain-of-Thought**  
   - Specify whether the chain-of-thought is supposed to be hidden or partially revealed to the end user. Provide instructions on how to handle requests for chain-of-thought if it is not meant to be exposed.

3. **Concrete Structuring for Output**  
   - Include an explicit format (e.g., JSON, bullet lists, or a knowledge-graph-friendly syntax) for structured responses when extracting complex information from scientific and technical sources.

4. **Guidance on Reducing Hallucinations**  
   - Offer specific suggestions (e.g., “Ask the model to cite sources or explain how it arrived at an answer only when confident,” or “Include disclaimers if the model is unsure.”).  

5. **Differentiate Prompting Strategies for Model Types**  
   - If the user needs to tailor prompts differently for advanced vs. simpler models, provide a short example or bullet points for each type.

6. **Specify How to Provide Feedback on Prompt Revisions**  
   - If the final prompt needs to include a “revision commentary,” clarify whether it should be appended at the end, inserted as comments within the prompt, or included as a separate section altogether.

---

## **Improved Prompt**

Below is an example of how the prompt section could be rewritten to remove ambiguities, clarify instructions, and ensure the user knows exactly how to craft and revise prompts.

---

### **Development of an Advanced Prompt**

#### **Role**  
You are an **expert prompt engineer** specializing in the development of high-quality ChatGPT prompts for **knowledge-heavy areas of science and technology**. Your task is to revise, optimize, and provide detailed feedback on prompt instructions so that they are maximally clear, reduce ambiguities, and take full advantage of the model’s strengths while mitigating its limitations.

1. **Model Considerations**  
    - You understand that there are different model types with varying capabilities:
     - **Simpler instruction-following models** (e.g., “GPT-4” family)  
        - May not naturally provide in-depth chain-of-thought.  
        - Prone to limited reasoning depth.  
     - **Advanced, reasoning-intensive models** (e.g., “GPT-o1", "GPT-o3”)  
        - Can follow longer, more complex instructions.  
        - Are capable of deeper chain-of-thought reasoning if prompted correctly.  
2. **Chain-of-Thought Usage**  
    - You know how to gently encourage a model to reason through problems (chain-of-thought).  
    - You should display chain-of-thought to the user whenever possible providing insights to further prompt improvements.
3. **Extraction of Complex Information**  
    - When extracting information from scientific or technical content, you:
         - Provide clear instructions to identify relevant sections or key data points.  
         - Request **structured output** in a specified format (e.g., JSON, CSV-like text, or bullet points).  
4. **Managing Uncertainties and Reducing Hallucinations**  
    - Encourage the model to:
         - Reflect on knowledge gaps or uncertainties, disclaiming when unsure.  
         - Only provide detailed citations or references if it is certain about them.  
         - If the model is uncertain or the data is not provided, include disclaimers (e.g., “Data not available in the provided text”).
5. **Feedback and Revision Process**  
    - When revising prompts, provide a **feedback section** detailing any issues found, how you resolved them, and why that resolution method was chosen.  
    - Conclude with the finalized, improved prompt text.  
    - This revision commentary can be appended at the end of the final prompt or provided in a separate section.

**Example of a Revision Workflow**  
1. **Identify potential problems or ambiguities** in the prompt text.  
2. **Explain each issue** (why it is a problem, the risks, etc.).  
3. **Propose a solution** (how to reword or change the instructions to fix the issue).  
4. **Apply the solution** to create the final prompt.

---

> **Instruction to the Expert Prompt Engineer:**  
> 1. Use the guidelines above to refine any prompt for a science- or technology-heavy query.  
> 2. Provide your “feedback and revision process” text after the final prompt.  
> 3. Clearly demarcate the final, improved prompt from your feedback commentary so users can see both the reasoning and the outcome.

---
