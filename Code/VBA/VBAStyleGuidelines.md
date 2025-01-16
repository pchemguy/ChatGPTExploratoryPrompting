When generating VBA code directly or via an intermediate script, use the following guidelines.

# **VBA Style Guidelines**

Here are commonly followed VBA (Visual Basic for Applications) style guidelines to write clean, maintainable, and readable code. These guidelines ensure consistency and make the code easier to understand and debug.

---

### **0. Platform**
- **Version**: Use VBA6.
- **Host Application**: Microsoft Excel 2002/XP.

---

### **1. General Guidelines**
- **Use Option Explicit:** Always include `Option Explicit` at the top of modules. This forces variable declaration and helps avoid typos.
- **Comment Generously:** Provide comments to explain the purpose of your code, logic, and any non-obvious parts.
- **Modularize Code:** Break complex tasks into smaller, reusable procedures and functions.

---

### **2. Naming Conventions**
- **Variables:**
  - Use meaningful names that describe their purpose (e.g., `customerName`, `totalAmount`).
  - Use `camelCase` or `PascalCase` (consistent across the project).
  - Prefix with the type when helpful, especially for frequently used data types:
    - `int` for integers: `intCounter`
    - `str` for strings: `strFirstName`
    - `rng` for ranges: `rngData`
  
- **Procedures and Functions:**
  - Use descriptive names that indicate their action or result (e.g., `CalculateTotal`, `FormatReport`).
  - Start with a verb for actions (e.g., `GetData`, `SetParameters`).

- **Constants:**
  - Use all uppercase with underscores (e.g., `MAX_ROWS`, `ERROR_MESSAGE`).

- **Classes and Objects:**
  - Use PascalCase (e.g., `CustomerInfo`, `DataProcessor`).

---

### **3. Indentation and Spacing**
- Indent code blocks with 4 spaces (or a single Tab).
- Use blank lines to separate logical sections of code.
- Avoid overly long lines. Break complex statements into multiple lines for readability.

---

### **4. Variable Declaration**
- Declare all variables explicitly using `Dim`, `Static`, or `Const`.
- Use specific data types instead of the generic `Variant` for better performance and clarity (e.g., `Dim counter As Integer` instead of `Dim counter`).

---

### **5. Error Handling**
- Always include error-handling routines for robustness:
  ```vba
  On Error GoTo ErrorHandler
  ' Your code here
  Exit Sub

  ErrorHandler:
  MsgBox "An error occurred: " & Err.Description
  ```

---

### **6. Strings and Concatenation**
- Use `&` for string concatenation instead of `+`.
- Use `vbCrLf` or `vbNewLine` for newlines in strings.

---

### **7. Loops and Conditions**
- Use `For Each` for iterating over collections where possible.
- Always include an `Exit For` or `Exit Do` condition in loops to avoid infinite loops.
- Use meaningful condition checks:
  ```vba
  If counter > MAX_ROWS Then
      Exit Sub
  End If
  ```

---

### **8. Avoid Hardcoding**
- Use constants or configuration tables instead of hardcoding values directly in the code.

---

### **9. Formatting and Alignment**
- Align assignment operators and key sections of the code for better readability:
  ```vba
  Dim total      As Double
  Dim subtotal   As Double
  Dim taxPercent As Double
  ```

---

### **10. Reusability**
- Write reusable functions and procedures instead of duplicating code.
- Avoid tightly coupling code with specific worksheets or ranges; use parameters to pass data dynamically.

---

### **11. Object Usage**
- Use `With` blocks to simplify repeated references to the same object:
  ```vba
  With ActiveSheet
      .Cells(1, 1).Value = "Header"
      .Cells(1, 2).Value = "Value"
  End With
  ```

---

### **12. Best Practices for Excel Automation**
- Avoid using `.Select` or `.Activate`:
  ```vba
  ' Avoid this:
  Worksheets("Sheet1").Select
  Range("A1").Select
  Selection.Value = "Data"

  ' Use this:
  Worksheets("Sheet1").Range("A1").Value = "Data"
  ```

- Optimize performance for large operations by disabling screen updates and calculations:
  ```vba
  Application.ScreenUpdating = False
  Application.Calculation = xlCalculationManual

  ' Your code here

  Application.Calculation = xlCalculationAutomatic
  Application.ScreenUpdating = True
  ```

---

### **13. Commenting**
- Document the purpose of each module, function, or subroutine.
- Include `TODO` or `FIXME` tags to highlight areas needing attention.

---

### **Example: Well-Formatted VBA Code**
```vba
Option Explicit

' Constants
Const MAX_ROWS As Integer = 100

Sub ProcessData()
    Dim ws As Worksheet
    Dim rng As Range
    Dim counter As Integer

    ' Initialize
    Set ws = ThisWorkbook.Sheets("Data")
    Set rng = ws.Range("A1:A" & MAX_ROWS)
    counter = 0

    ' Process data
    For Each cell In rng
        If IsNumeric(cell.Value) Then
            cell.Value = cell.Value * 2
        End If
        counter = counter + 1
        If counter >= MAX_ROWS Then Exit For
    Next cell

    ' Clean up
    MsgBox "Processing complete."
End Sub
```

