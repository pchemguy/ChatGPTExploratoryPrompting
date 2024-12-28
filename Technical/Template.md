## **Prompt Improvement**

Help me improve this ChatGPT prompt to ensure it achieves the following objectives:

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

### Prompt to be improved

Teach me how to generate templates that describe the structure of my data. Both data and templates describing the data will be part of ChatGPT input. These templates need to help GhatGPT interpret the data, minimize ambiguities, and facilitate subsequent analysis / processing / transformation of data.

---

## **Improved Prompt:**

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
---

## **ChatGPT answer**

To create templates that effectively describe the structure of your data for use in ChatGPT inputs, follow these comprehensive steps. Each step ensures clarity, minimizes ambiguities, optimizes processing, and encourages critical reflection and improvement.

---
### **Step 1: Define a General Template Framework**
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
### **Step 2: Template Example**
#### Template Name: **Customer Profile Data**
**Purpose:** This template defines the structure for storing customer information to enable personalized recommendations.

---
#### **Field Definitions:**

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
#### **Relationships and Hierarchies:**
- The `PurchaseHistory` field contains a nested structure:
    - Each entry includes:
      - `PurchaseID` (Integer): Unique ID for the purchase.
      - `Date` (Date): Date of purchase in `YYYY-MM-DD` format.
      - `Amount` (Float): Total amount spent.

---
#### **Examples:**

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
#### **Clarifications and Notes:**
- `CustomerID` must always be unique.
- Ensure emails are validated before input.
- If `DateOfBirth` is omitted, age-related recommendations will not be possible.
- For `PurchaseHistory`, omit the field entirely if there are no purchases.

---
#### **Feedback Prompts for ChatGPT:**
1. Are there any ambiguous fields in this template?
2. Is the nested structure for `PurchaseHistory` clear and practical for analysis?
3. Do the examples align with the field definitions and purpose of the template?
4. Are there potential improvements for adaptability across different domains?

---
### **Step 3: Anticipate Potential Ambiguities**
To minimize confusion:
- Clearly specify optional vs. required fields.
- Define data types and formats explicitly.
- Explain hierarchical relationships in detail.
- Provide notes on domain-specific terms or abbreviations (e.g., VIP, Array).

---
### **Step 4: Optimize for Processing and Analysis**
- Ensure fields are standardized for easy parsing (e.g., use ISO formats for dates).
- Use consistent naming conventions.
- Include metadata if necessary (e.g., `CreatedBy`, `LastUpdated`).

---
### **Step 5: Critical Review**
**Checklist for Review:**
- Are all fields clearly defined?
- Do examples match the intended format?
- Are edge cases accounted for (e.g., missing data)?
- Is the structure optimized for the intended purpose?

---
### **Step 6: Request Feedback from ChatGPT**
Use prompts to get ChatGPT’s insights:
- "Does this template sufficiently clarify the data structure?"
- "What improvements can you suggest for these examples?"
- "Are there any logical inconsistencies in the template?"

---
### **Step 7: Iterative Refinement**
Refine the template based on feedback and ensure it’s adaptable for new scenarios or datasets.

---
---

## **Narrowing Prompt**

Let's focus on a more specific case. I have a plain-text file containing serialized representation of graphical primitives. Here is the entire contents of a sample file:

Version 4
SymbolType BLOCK
LINE Normal -224 32 -224 -32
LINE Normal -128 48 -176 48 2
LINE Normal 67 -14 -61 -14 3
RECTANGLE Normal -112 -32 -192 -64
RECTANGLE Normal 184 -107 137 -139 3
RECTANGLE Normal 73 82 25 18 3
CIRCLE Normal -256 -48 -288 -64
CIRCLE Normal 152 11 130 -7 3
ARC Normal -114 -22 46 74 0 0 -57 -5
ARC Normal -239 -175 -144 -121 -219 -155 -185 -118 3
ARC Normal 700 300 1100 500 1000 500 800 300
TEXT 247 94 VLeft 5 qqQ q
PIN -176 16 NONE 7
PINATTR PinName d
PINATTR SpiceOrder 1
PIN 0 -112 VRIGHT 8
PINATTR PinName q
PINATTR SpiceOrder 2
PIN 32 160 RIGHT 0
PINATTR PinName aq
PINATTR SpiceOrder 3

## **ChatGPT answer**

To effectively parse and work with the serialized graphical primitives from your plain-text file, we can design a template that meets your needs for clarity, precision, and adaptability. Here’s how you can structure your data template:

---
### **Template Name:** Serialized Graphical Primitives

**Purpose:** This template describes the structure of a plain-text file representing graphical primitives. It ensures accurate parsing and facilitates analysis, transformation, or rendering of the primitives.

---
### **Field Definitions:**

| **Field**    | **Description**                                                                    | **Data Type**      | **Format**                                                 | **Required** |
| ------------ | ---------------------------------------------------------------------------------- | ------------------ | ---------------------------------------------------------- | ------------ |
| `Version`    | The version of the serialized file format                                          | Integer            | A single integer (e.g., `Version 4`)                       | Yes          |
| `SymbolType` | Specifies the type of symbol                                                       | Text               | A single keyword following `SymbolType` (e.g., `BLOCK`)    | Yes          |
| `Primitive`  | The graphical primitive (e.g., `LINE`, `RECTANGLE`, `CIRCLE`, etc.)                | Text               | A line starting with the primitive type                    | Yes          |
| `Attributes` | Specific attributes of each primitive, defined in a space-separated format         | Mixed              | Attributes vary based on primitive type                    | Yes          |
| `TEXT`       | Text-based primitive with position, alignment, and content                         | Text + Coordinates | Format: `TEXT <x> <y> <Alignment> <Size> <Content>`        | Optional     |
| `PIN`        | Describes connection points, with position, orientation, and additional attributes | Text + Coordinates | Format: `PIN <x> <y> <Orientation> <ElectricalAttributes>` | Optional     |
| `PINATTR`    | Attributes for the previous PIN                                                    | Key-Value Pair     | Format: `PINATTR <AttributeName> <Value>`                  | Optional     |

---

### **Details for Key Primitives:**

#### 1. **LINE**
   - **Format:** `LINE <Style> <x1> <y1> <x2> <y2> [<Width>]`
   - **Fields:**
     - `Style`: Line style, e.g., `Normal`
     - `x1, y1, x2, y2`: Start and end coordinates (integer)
     - `Width`: Optional width of the line
#### 2. **RECTANGLE**
   - **Format:** `RECTANGLE <Style> <x1> <y1> <x2> <y2> [<LineWidth>]`
   - **Fields:**
     - `Style`: Rectangle style, e.g., `Normal`
     - `x1, y1, x2, y2`: Two opposite corners (integer)
     - `LineWidth`: Optional line thickness
#### 3. **CIRCLE**
   - **Format:** `CIRCLE <Style> <x1> <y1> <x2> <y2> [<LineWidth>]`
   - **Fields:**
     - `Style`: Circle style, e.g., `Normal`
     - `x1, y1`: Center coordinates
     - `x2, y2`: A point on the circumference
     - `LineWidth`: Optional line thickness
#### 4. **ARC**
   - **Format:** `ARC <Style> <x1> <y1> <x2> <y2> <cx1> <cy1> <cx2> <cy2> [<LineWidth>]`
   - **Fields:**
     - `Style`: Arc style, e.g., `Normal`
     - `x1, y1`: Start point
     - `x2, y2`: End point
     - `cx1, cy1, cx2, cy2`: Control points for the curve
     - `LineWidth`: Optional line thickness
#### 5. **TEXT**
   - **Format:** `TEXT <x> <y> <Alignment> <FontSize> <Content>`
   - **Fields:**
     - `x, y`: Coordinates of the text position
     - `Alignment`: Alignment of the text, e.g., `VLeft`, `VRight`
     - `FontSize`: Size of the text
     - `Content`: The actual text string
#### 6. **PIN**
   - **Format:** `PIN <x> <y> <Orientation> <ElectricalAttributes>`
   - **Fields:**
     - `x, y`: Coordinates of the pin
     - `Orientation`: Direction of the pin, e.g., `RIGHT`, `VRIGHT`
     - `ElectricalAttributes`: Electrical properties, such as `NONE`
#### 7. **PINATTR**
   - **Format:** `PINATTR <AttributeName> <Value>`
   - **Fields:**
     - `AttributeName`: Name of the attribute, e.g., `PinName`
     - `Value`: Value assigned to the attribute

---
### **Examples:**

#### Complete File Example:
```plaintext
Version 4
SymbolType BLOCK
LINE Normal -224 32 -224 -32
LINE Normal -128 48 -176 48 2
RECTANGLE Normal -112 -32 -192 -64
CIRCLE Normal -256 -48 -288 -64
ARC Normal -114 -22 46 74 0 0 -57 -5
TEXT 247 94 VLeft 5 qqQ q
PIN -176 16 NONE 7
PINATTR PinName d
PINATTR SpiceOrder 1
```
#### Explanation of Example:
- **Header Fields:** `Version 4`, `SymbolType BLOCK` define the format version and symbol type.
- **LINE Primitive:** A normal line from (-224, 32) to (-224, -32).
- **RECTANGLE Primitive:** A rectangle spanning two opposite corners (-112, -32) and (-192, -64).
- **TEXT Primitive:** Text at (247, 94) aligned vertically left, font size 5, with content `qqQ q`.
- **PIN and PINATTR:** A pin at (-176, 16) with no electrical attributes, followed by attributes `PinName d` and `SpiceOrder 1`.

---
### **Feedback Prompts for ChatGPT:**
1. Are all the fields and formats clear for parsing and processing?
2. Do the examples align with the defined formats for the primitives?
3. Are there ambiguities in the way hierarchical relationships (e.g., PIN and PINATTR) are defined?
4. Are there potential improvements for adaptability to new primitives or additional attributes?
