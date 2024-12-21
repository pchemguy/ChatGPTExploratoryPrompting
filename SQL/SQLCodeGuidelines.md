## Q: Tell me about top SQL style guides

<details>
<summary>ChatGPT answer</summary>
Several widely recognized SQL style guides provide best practices for writing clean, readable, and maintainable SQL code. Here are some of the top SQL style guides:

### 1. **SQL Style Guide by Simon Holywell**
   - **Focus**: Readability and consistency in SQL queries.
   - **Key Features**:
     - Use uppercase for SQL keywords (e.g., `SELECT`, `FROM`).
     - Use lowercase for table and column names.
     - Always include the `AS` keyword in column aliases for clarity.
     - Prefer explicit `JOIN` statements over implicit joins for readability.
     - Place each column in a `SELECT` statement on a new line.

### 2. **Google SQL Style Guide**
   - **Focus**: Scalability and large-scale collaboration.
   - **Key Features**:
     - Align SQL keywords and table names for visual clarity.
     - Avoid using `SELECT *`; explicitly name columns.
     - Use fully qualified table names (e.g., `database.schema.table`).
     - Indent subqueries for better readability.
     - Use consistent aliasing conventions.

### 3. **SQL Style Guide by GitLab**
   - **Focus**: Collaboration and code reviews.
   - **Key Features**:
     - Use snake_case for table and column names.
     - Prefix temporary tables with `temp_` for clarity.
     - Use single quotes for string literals.
     - Document complex queries with comments.
     - Enforce column order for logical grouping.

### 4. **Airbnb SQL Style Guide**
   - **Focus**: Data analysis and analytics workflows.
   - **Key Features**:
     - Group related `WHERE` conditions for better understanding.
     - Include comments for complex transformations.
     - Use consistent indentation for nested queries.
     - Avoid magic numbers; use named parameters or constants.
     - Use meaningful table aliases.

### 5. **PostgreSQL Style Guide by Citus Data**
   - **Focus**: PostgreSQL-specific practices.
   - **Key Features**:
     - Use consistent naming conventions for schemas, tables, and indexes.
     - Define constraints explicitly with descriptive names.
     - Utilize PostgreSQL features such as Common Table Expressions (CTEs) for readability.
     - Favor indexed columns in `WHERE` clauses.
     - Use enums or small lookup tables for categorical data.

### Common Recommendations Across Style Guides:
   - **Indentation**: Consistent indentation (typically 2 or 4 spaces).
   - **Capitalization**: Uppercase for keywords, lowercase for identifiers.
   - **Commenting**: Use comments to explain complex logic or assumptions.
   - **Joins**: Explicitly define joins for clarity.
   - **Testing**: Test queries for performance and edge cases.

These guides emphasize consistency, collaboration, and readability to ensure SQL code remains maintainable, especially in team environments.
</details>
