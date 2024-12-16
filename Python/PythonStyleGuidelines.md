### **Python Style Guidelines**

1. **General Guidelines**  
   - Strive to generate Pythonic code using
       - clean, idiomatic, and efficient Python practices;
       - standard library functions where appropriate;
       - the Zen of Python guidelines.
   - When generating Python code, follow the style guide specified below. If multiple guides are mentioned, prioritize the specified order of precedence.
   - If a conflict arises between style guides, default to Black for formatting and to Google or Facebook for structural and type-related decisions.

2. **Style Guide Options**  
   - **Primary Style Guide**: Follow the **Google Python Style Guide** conventions, unless specified otherwise.
   - **Alternative Styles** (in order of preference):
       - **Black Code Style**: Enforce automated formatting and 88-character line limits.
       - **Facebook Python Style Guide**: Prioritize type annotations and scalability best practices.
       - **[PEP 8](https://peps.python.org/pep-0008/)**.

3. **Code Formatting**  
   - **Indentation**: Use an indentation of `2 spaces`.
   - **Line Length**: Limit line length to **88 characters** (Black).
   - **Blank Lines**: Use PEP 8 / Black conventions for separating top-level functions, classes, methods, docstrings, and comments.

4. **Imports**  
   - Organize imports into three groups, in the following order:
      1. Standard library imports.
      2. Third-party imports.
      3. Local application/library-specific imports.
   - Avoid wildcard imports (`from module import *`).
   - Example:
     ```python
     # Standard library imports
     import os
     import sys

     # Third-party imports
     import numpy as np

     # Local imports
     from my_project.module import my_function
     ```

5. **Naming Conventions**  
   - **Modules, Functions, and Variables**: Use `snake_case`.
   - **Classes**: Use `PascalCase`.
   - **Constants**: Use `ALL_CAPS`.

6. **String Formatting**  
   - Prefer **f-strings** for readability; use `.format()` as a secondary option.
   - Prefer double quotes for strings.
   - Use single quotes for strings containing double quotes to avoid escaping characters.
   - Use triple quotes for multi-line strings.

7. **Comments and Docstrings**  
   - Write clear detailed comments explaining the *why*, not just the *what*.
   - Use structured Google-style docstrings. For example:
     ```python
     def add(a: int, b: int) -> int:
         """
         Adds two integers.

         Args:
             a (int): The first integer.
             b (int): The second integer.

         Returns:
             int: The sum of the two integers.

         Raises:
             ValueError: If either of the inputs is negative.
         """
         if a < 0 or b < 0:
             raise ValueError("Inputs must be non-negative")
         return a + b
     ```

8. **Type Annotations**  
   - Include detailed type hints for all functions, methods, and variables where applicable.

9. **Testing**  
   - Follow PEP 8 conventions for test structure.
   - Write unit tests using `pytest`.
   - Use descriptive test function names (e.g., `test_add_positive_numbers`).
