### **Definition: Context-Setting Prompt**

A **Context-Setting Prompt** is the initial, user-submitted prompt at the commencement of a new, distinct conversational session with an AI. It is delivered "in-band" through the standard user chat interface, not through a separate, dedicated API field (like a technical `system` prompt) or a persistent feature (like `Custom Instructions`).

The primary function of a Context-Setting Prompt is to establish a comprehensive framework of operational instructions that governs the AI's behavior for the entire duration of that specific conversation. These instructions can include, but are not limited to:

- **Persona or Role:** Assigning the AI a specific character, profession, or personality (e.g., "Act as a skeptical scientist").
- **Rules of Engagement:** Defining constraints, boundaries, or specific rules the AI must follow (e.g., "Only ask questions in your responses," "Do not use emojis").
- **Tone and Style:** Specifying the desired communication style (e.g., "Your tone should be formal and academic," "Be witty and concise").
- **Goal and Objective:** Outlining the primary purpose or goal of the conversation (e.g., "Our goal is to brainstorm ideas for a marketing campaign").
- **Output Format:** Instructing the AI to structure its responses in a particular way (e.g., "Provide all answers in a JSON format").

Essentially, the Context-Setting Prompt acts as a "mission briefing" for the AI. Because it is the first input the model receives in the conversation's memory, it strongly influences all subsequent turns of dialogue. Its effects are session-specific and are not retained in subsequent new conversations.