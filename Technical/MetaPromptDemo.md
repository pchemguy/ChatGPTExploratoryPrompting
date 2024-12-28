# Ask ChatGPT to help you generate, debug, and improve prompts

## Prompt generation - Meta-prompt

### Template generation

Since the relevance of ChatGPT responses substantially depend on the quality of prompts, and because ChatGPT seems to be good at  transformative and creative writing tasks, it appears to be a natural question to see if ChatGPT can improve its own prompts. I decided to develop template:

```
{INSTRUCTIONS}

Prompt do be improved

{TARGET PROMPT}
```

where `{INSTRUCTIONS}` direct ChatGPT to improve `{TARGET PROMPT}`. So, I put together an initial version #0 of `{INSTRUCTIONS}`:

<details>
<summary><b>{INSTRUCTIONS} - version #0</b></summary>  

```
Help me improve the following ChatGPT prompt. I want to make sure that I
- communicate my task / question / request to ChatGPT as clear as possible;
- resolve any ambiguities;
- provide sufficient details to generate a relevant answer;
- encourage ChatGPT to ask clarifying questions to further improve results;
- instruct ChatGPT to re-read the prompt and reflect on it before producing the answer to see if the question may include issues that make the question unanswerable directly, such as:
    - false premises / factual errors (misleading or loaded questions),
      Example: "Why are all cats black?"
      Example:  "Who was the first person to land on Mars?"
    - logical fallacies / contradictions,
      Example: "What kind of triangle has two right angles?"
    - insufficient information / lack of details or scope,
      Example: "Explain everything about physics."
    - vague or ambiguous information
      Example: "What is the best?"
    - nonsensical constructs
      Example: "What is the square root of happiness?"
- instruct ChatGPT to provide feedback / reflection on the problematic question instead of trying to generate a direct answer.
```  
</details>

The next step was to improve version #0 (which is itself a prompt) by substituting it as both `{INSTRUCTIONS}` and `{TARGET PROMPT}`:

<details>
<summary><b>ChatGPT prompt</b></summary>  
Help me improve the following ChatGPT prompt. I want to make sure that I
- communicate my task / question / request to ChatGPT as clear as possible;
- resolve any ambiguities;
- provide sufficient details to generate a relevant answer;
- encourage ChatGPT to ask clarifying questions to further improve results;
- instruct ChatGPT to re-read the prompt and reflect on it before producing the answer to see if the question may include issues that make the question unanswerable directly, such as:
    - false premises / factual errors (misleading or loaded questions),
      Example: "Why are all cats black?"
      Example:  "Who was the first person to land on Mars?"
    - logical fallacies / contradictions,
      Example: "What kind of triangle has two right angles?"
    - insufficient information / lack of details or scope,
      Example: "Explain everything about physics."
    - vague or ambiguous information
      Example: "What is the best?"
    - nonsensical constructs
      Example: "What is the square root of happiness?"
- instruct ChatGPT to provide feedback / reflection on the problematic question instead of trying to generate a direct answer.

#### Prompt to be improved

Help me improve the following ChatGPT prompt. I want to make sure that I
- communicate my task / question / request to ChatGPT as clear as possible;
- resolve any ambiguities;
- provide sufficient details to generate a relevant answer;
- encourage ChatGPT to ask clarifying questions to further improve results;
- instruct ChatGPT to re-read the prompt and reflect on it before producing the answer to see if the question may include issues that make the question unanswerable directly, such as:
    - false premises / factual errors (misleading or loaded questions),
      Example: "Why are all cats black?"
      Example:  "Who was the first person to land on Mars?"
    - logical fallacies / contradictions,
      Example: "What kind of triangle has two right angles?"
    - insufficient information / lack of details or scope,
      Example: "Explain everything about physics."
    - vague or ambiguous information
      Example: "What is the best?"
    - nonsensical constructs
      Example: "What is the square root of happiness?"
- instruct ChatGPT to provide feedback / reflection on the problematic question instead of trying to generate a direct answer.
</details>

The result

<details>
<summary><b>Meta-prompt template</b></summary>  

Help me improve this ChatGPT prompt ("Prompt to be improved" below) to ensure it achieves the following objectives:

1. **Clarity of Task or Request:**   
    - Clearly communicate the intended task, question, or request to ChatGPT in a precise and unambiguous manner.
2. **Resolution of Ambiguities:**
    - Eliminate potential misunderstandings by providing all necessary context, details, and scope to support a relevant and specific response.
3. **Detailed Input:**
    - Include sufficient information to guide ChatGPT’s response effectively, minimizing the need for assumptions or misinterpretation.
4. **Encouragement for Clarification:**
    - Prompt ChatGPT to ask clarifying questions if the input is incomplete, unclear, or likely to lead to suboptimal results.
5. **Re-Reading and Reflection:**
    - Instruct ChatGPT to carefully re-read the prompt before answering, ensuring it identifies and reflects on issues that could impede a direct or meaningful response. These issues may include:
        - **False Premises or Factual Errors:**  
            Examples:
            - "Why are all cats black?" (Incorrect assumption)
            - "Who was the first person to land on Mars?" (Factually incorrect event)
        - **Logical Fallacies or Contradictions:**  
            Example: "What kind of triangle has two right angles?" (Geometric impossibility)
        - **Insufficient Details or Scope:**  
            Example: "Explain everything about physics." (Overly broad)
        - **Vague or Ambiguous Information:**  
            Example: "What is the best?" (Unclear criteria)
        - **Nonsensical Constructs:**  
            Example: "What is the square root of happiness?" (Conceptual inconsistency)
6. **Feedback on Problematic Questions:**
    - Instruct ChatGPT to provide constructive feedback or reflection on problematic aspects of the prompt instead of attempting to generate a direct answer when such issues are detected.

**Final Request:** Please ensure the improved version of this prompt is optimized to encourage thoughtful, structured, and actionable responses from ChatGPT. Provide feedback on whether this revised version meets the stated objectives or suggest further refinements to improve it.

#### Prompt to be improved

`{TARGET PROMPT}`
</details>

 is also placed in the [MetaPromptTemplate] file.

---

### Extending / reverse engineering data application

Now this template can be used to generate improved prompts and, in fact, other prompt templates for specific tasks.

Given the model [problem #2][], I might want to do some programmatic manipulations involving the `*.asy` files containing text-based description of graphical primitives (such as lines and rectangles), representing a SPICE circuit element (resistor, capacitor, etc.). This file format can viewed in a text editor and has a fairly simple format. My initial approach was to decode the file format manually, create a detailed description of the file format in technical, but natural language, feed this description to ChatGPT and ask it to generate appropriate code. I realized later that this approach was not optimal, but here is the [source of the conversation][Graphical Primitives Design]. The code generation matter is actually beyond the current subject, but the actual focus is on the preparatory steps.

Basically, to generate certain code with ChatGPT, one generally needs to provide some kind of specification / description of the desired code. Preparing such a description is probably a fairly time consuming task as well. Here is an idea: assuming the authors of LTspice did not try to obfuscate the file format (which they did not), its format should be fairly intuitive, given the generic task of storing basic vector representation of graphical primitives. As it turned out, this idea is true, but, what is more important, these "intuition" is accessible to ChatGPT as well (sort of, but for the purposes of such data problems, let's just say that ChatGPT may possess / exhibit certain intuition).

But first things first: I needed to start somewhere. So I came up with the following ChatGPT prompt:

```
Teach me how to generate templates that describe the structure of my data. Both data and templates describing the data will be part of ChatGPT input. These templates need to help ChatGPT interpret the data, minimize ambiguities, and facilitate subsequent analysis / processing / transformation of data.
```

First, this prompt does not include any problem-specific information at all. Instead, it identifies a class of data focused reverse engineering problems. Second, it is also very concise, only defining a generic concept with the idea to seek early ChatGPT contributions. Now, rather than submitting this prompt to ChatGPT directly, it can be included as the target of the meta-prompt:

<details>
<summary><b>Data file prompt template generator (ChatGPT prompt)</b></summary>  

Help me improve this ChatGPT prompt ("Prompt to be improved" below) to ensure it achieves the following objectives:

1. **Clarity of Task or Request:**   
    - Clearly communicate the intended task, question, or request to ChatGPT in a precise and unambiguous manner.
2. **Resolution of Ambiguities:**
    - Eliminate potential misunderstandings by providing all necessary context, details, and scope to support a relevant and specific response.
3. **Detailed Input:**
    - Include sufficient information to guide ChatGPT’s response effectively, minimizing the need for assumptions or misinterpretation.
4. **Encouragement for Clarification:**
    - Prompt ChatGPT to ask clarifying questions if the input is incomplete, unclear, or likely to lead to suboptimal results.
5. **Re-Reading and Reflection:**
    - Instruct ChatGPT to carefully re-read the prompt before answering, ensuring it identifies and reflects on issues that could impede a direct or meaningful response. These issues may include:
        - **False Premises or Factual Errors:**  
            Examples:
            - "Why are all cats black?" (Incorrect assumption)
            - "Who was the first person to land on Mars?" (Factually incorrect event)
        - **Logical Fallacies or Contradictions:**  
            Example: "What kind of triangle has two right angles?" (Geometric impossibility)
        - **Insufficient Details or Scope:**  
            Example: "Explain everything about physics." (Overly broad)
        - **Vague or Ambiguous Information:**  
            Example: "What is the best?" (Unclear criteria)
        - **Nonsensical Constructs:**  
            Example: "What is the square root of happiness?" (Conceptual inconsistency)
6. **Feedback on Problematic Questions:**
    - Instruct ChatGPT to provide constructive feedback or reflection on problematic aspects of the prompt instead of attempting to generate a direct answer when such issues are detected.

**Final Request:** Please ensure the improved version of this prompt is optimized to encourage thoughtful, structured, and actionable responses from ChatGPT. Provide feedback on whether this revised version meets the stated objectives or suggest further refinements to improve it.

#### Prompt to be improved

Teach me how to generate templates that describe the structure of my data. Both data and templates describing the data will be part of ChatGPT input. These templates need to help ChatGPT interpret the data, minimize ambiguities, and facilitate subsequent analysis / processing / transformation of data.

</details>

ChatGPT generated a new structured 

<details>
<summary><b>Data file prompt template (ChatGPT answer to "Data file prompt template generator")</b></summary>  

Teach me how to create templates that effectively describe the structure of my data for use in ChatGPT inputs. These templates should achieve the following:

1. **Clarity and Precision:**
   - Clearly define the structure, format, and content of the data, ensuring that ChatGPT can interpret it without ambiguity.
   - Include examples of both the data and corresponding templates to illustrate the intended structure and purpose.

2. **Minimization of Ambiguities:**
   - Anticipate potential misunderstandings and provide specific guidance on how to format data fields, relationships, and categories.
   - Clarify any terms, abbreviations, or domain-specific concepts used in the data or template.

3. **Optimization for Processing and Analysis:**
   - Design templates to facilitate subsequent data analysis, transformation, and processing tasks.  
   - Ensure that the templates are adaptable to various scenarios and maintain consistency across different data inputs.

4. **Encouragement for ChatGPT Clarification:**
   - Prompt ChatGPT to ask clarifying questions if the provided data or templates are incomplete, unclear, or likely to lead to errors in interpretation or processing.

5. **Critical Review and Reflection:**
   - Request ChatGPT to carefully review the templates and data structure, ensuring they meet the stated objectives and identifying any potential issues. Such issues may include:
       - Ambiguities or insufficient details in the data description.
       - Logical inconsistencies or conflicting instructions.
       - Overly broad or vague template fields.
       - Examples or use cases that do not align with the intended structure.

6. **Feedback and Suggestions for Improvement:**
   - Instruct ChatGPT to provide constructive feedback on the templates and suggest ways to improve clarity, functionality, or adaptability for various use cases.

**Additional Context:** 
Provide guidance on how to:
   - Define hierarchical relationships in the data.
   - Specify optional and required fields.
   - Address data types (e.g., text, numbers, dates).
   - Include metadata or annotations to enhance interpretability.

**Final Request:** Please ensure the resulting instructions and templates are actionable, clear, and suitable for use in different contexts. Reflect on whether the guidance provided meets these criteria and suggest refinements where necessary.

---

</details>

Next step is to take the answer above and submit it as a new ChatGPT prompt, yielding a suggested recipe / format for a tool prompt:

<details>
<summary><b>Tool prompt recipe (ChatGPT answer to "Data file prompt template")</b></summary>  

To create templates that effectively describe the structure of your data for use in ChatGPT inputs, follow these comprehensive steps. Each step ensures clarity, minimizes ambiguities, optimizes processing, and encourages critical reflection and improvement.

---
#### **Step 1: Define a General Template Framework**
A general template structure should include the following:
1. **Title/Name:** A brief, descriptive name for the template.
2. **Purpose:** A short explanation of the template's intended use.
3. **Field Definitions:** Clearly define each field, including:
   - **Name**
   - **Description**
   - **Data Type** (e.g., text, number, date)
   - **Format** (if applicable, e.g., `YYYY-MM-DD` for dates)
   - **Required/Optional** Status
4. **Relationships and Hierarchies:** Indicate any relationships between fields.
5. **Examples:** Provide well-structured examples to clarify how data should look.
6. **Clarifications and Notes:** Address potential ambiguities or edge cases.
7. **Feedback Prompts:** Include explicit instructions for ChatGPT to identify potential issues or suggest improvements.

---
#### **Step 2: Template Example**
##### Template Name: **Customer Profile Data**
**Purpose:** This template defines the structure for storing customer information to enable personalized recommendations.

---
##### **Field Definitions:**

| **Field**         | **Description**                        | **Data Type** | **Format**         | **Required** |
| ----------------- | -------------------------------------- | ------------- | ------------------ | ------------ |
| `CustomerID`      | A unique identifier for the customer   | Integer       | N/A                | Yes          |
| `FirstName`       | Customer's first name                  | Text          | N/A                | Yes          |
| `LastName`        | Customer's last name                   | Text          | N/A                | Yes          |
| `Email`           | Customer's email address               | Text          | Valid email format | Yes          |
| `DateOfBirth`     | Customer's date of birth               | Date          | `YYYY-MM-DD`       | Optional     |
| `PurchaseHistory` | List of past purchases by the customer | Array         | See nested format  | Optional     |
| `VIPStatus`       | Whether the customer is a VIP          | Boolean       | `true` or `false`  | Optional     |

---
##### **Relationships and Hierarchies:**
- The `PurchaseHistory` field contains a nested structure:
    - Each entry includes:
      - `PurchaseID` (Integer): Unique ID for the purchase.
      - `Date` (Date): Date of purchase in `YYYY-MM-DD` format.
      - `Amount` (Float): Total amount spent.

---
##### **Examples:**

**Input Example 1 (Complete Data):**
```json
{
  "CustomerID": 12345,
  "FirstName": "John",
  "LastName": "Doe",
  "Email": "john.doe@example.com",
  "DateOfBirth": "1985-06-15",
  "PurchaseHistory": [
    {
      "PurchaseID": 9876,
      "Date": "2023-07-12",
      "Amount": 129.99
    },
    {
      "PurchaseID": 9877,
      "Date": "2023-08-02",
      "Amount": 79.50
    }
  ],
  "VIPStatus": true
}
```

**Input Example 2 (Minimal Data):**
```json
{
  "CustomerID": 67890,
  "FirstName": "Jane",
  "LastName": "Smith",
  "Email": "jane.smith@example.com"
}
```

---
##### **Clarifications and Notes:**
- `CustomerID` must always be unique.
- Ensure emails are validated before input.
- If `DateOfBirth` is omitted, age-related recommendations will not be possible.
- For `PurchaseHistory`, omit the field entirely if there are no purchases.

---
##### **Feedback Prompts for ChatGPT:**
1. Are there any ambiguous fields in this template?
2. Is the nested structure for `PurchaseHistory` clear and practical for analysis?
3. Do the examples align with the field definitions and purpose of the template?
4. Are there potential improvements for adaptability across different domains?

---
#### **Step 3: Anticipate Potential Ambiguities**
To minimize confusion:
- Clearly specify optional vs. required fields.
- Define data types and formats explicitly.
- Explain hierarchical relationships in detail.
- Provide notes on domain-specific terms or abbreviations (e.g., VIP, Array).

---
#### **Step 4: Optimize for Processing and Analysis**
- Ensure fields are standardized for easy parsing (e.g., use ISO formats for dates).
- Use consistent naming conventions.
- Include metadata if necessary (e.g., `CreatedBy`, `LastUpdated`).

---
#### **Step 5: Critical Review**
**Checklist for Review:**
- Are all fields clearly defined?
- Do examples match the intended format?
- Are edge cases accounted for (e.g., missing data)?
- Is the structure optimized for the intended purpose?

---
#### **Step 6: Request Feedback from ChatGPT**
Use prompts to get ChatGPT’s insights:
- "Does this template sufficiently clarify the data structure?"
- "What improvements can you suggest for these examples?"
- "Are there any logical inconsistencies in the template?"

---
#### **Step 7: Iterative Refinement**
Refine the template based on feedback and ensure it’s adaptable for new scenarios or datasets.

</details>

<!-- References -->

[MetaPromptTemplate]: https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/Technical/MetaPromptTemplate.md
[problem #2]: https://github.com/pchemguy/ChatGPTExploratoryPrompting/blob/main/README.md#2-ltspice-symbol-and-circuit-parsers
[Graphical Primitives Design]: https://chatgpt.com/share/676feb60-7df8-8004-b9e2-953d9b14f7c6