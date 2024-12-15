### **Python Style Guide Instructions**

#### **General Guidelines**
When generating Python code, follow the style guide specified below. If multiple guides are mentioned, prioritize the specified order of precedence.
#### **Style Guide Options**
1. **Primary Style Guide**: Follow the **Google Python Style Guide** conventions, unless specified otherwise.
2. **Alternative Styles** (choose or mix if applicable):
   - **Black Code Style**: Enforce automated formatting and 88-character line limits.
   - **Facebook Python Style Guide**: Prioritize type annotations and scalability best practices.
   - **[PEP 8](https://peps.python.org/pep-0008/)**.
#### **Code Formatting**
- **Indentation**: Specify `2 spaces`
- **Line Length**:  Allow **88 characters** (Black).
- **Blank Lines**: Use PEP 8 / Black conventions for separating top-level functions, classes, methods, docstrings, and comments.
#### **Imports**
- Organize imports into three groups:
  1. Standard library imports.
  2. Third-party imports.
  3. Local application/library-specific imports.
- Avoid wildcard imports (`from module import *`).
#### **Naming Conventions**
- **Modules, Functions, and Variables**: Use `snake_case`.
- **Classes**: Use `PascalCase`.
- **Constants**: Use `ALL_CAPS`.
#### **String Formatting**
- Prefer **f-strings** (`.format()`, as a second option) for readability and clarity.
- Prefer double quotes for strings.
- Use triple quotes for multi-line strings.
#### **Comments and Docstrings**
- Write clear detailed comments explaining the *why*, not just the *what*.
- Use structured Google-style docstrings.
#### **Type Annotations**
- Include detailed type hints for all functions, and methods, and variables where applicable.
#### **Testing**
- Follow PEP 8 conventions for test structure.
- Write unit tests using `pytest`.
#### **Integration Instructions**
- Combine rules from multiple style guides as necessary:
  - For general code, default to Google,  Black, or PEP 8.
  - For type-heavy projects, use Facebook conventions.

