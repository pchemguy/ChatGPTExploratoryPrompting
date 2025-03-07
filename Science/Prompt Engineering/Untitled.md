Below is a Pikchr diagram for a SQLite SELECT statement that includes CTE syntax. In this diagram:

- **Ovals** represent keywords.
- **Rectangles** represent macro blocks (such as the select list, table expressions, or subqueries).
- Optional or alternative elements are indicated with a “?” or “/” in the label.

```pikchr
/* SQLite SELECT statement railroad diagram with CTE syntax */

/* Optional CTE block */
oval "WITH?" fit;
arrow right;
oval "RECURSIVE?" fit;
arrow right;
box "CTE: name AS (subquery)" fit;
arrow right;
oval ", ...?" fit;   // Additional CTEs (optional)
arrow right;

/* Main SELECT statement */
oval "SELECT" fit;
arrow right;
oval "DISTINCT/ALL?" fit;  // Alternative: DISTINCT or ALL (optional)
arrow right;
box "Select List" fit;
arrow right;
oval "FROM?" fit;
arrow right;
box "Table Expression" fit;
arrow right;
oval "WHERE?" fit;
arrow right;
box "Expression" fit;
arrow right;
oval "GROUP BY?" fit;
arrow right;
box "Grouping Expression" fit;
arrow right;
oval "HAVING?" fit;
arrow right;
box "Expression" fit;
arrow right;
oval "ORDER BY?" fit;
arrow right;
box "Ordering Expression" fit;
arrow right;
oval "LIMIT?" fit;
arrow right;
box "Expression" fit;
```

### Diagram Explanation

- **CTE Section:**  
  The diagram starts with an optional CTE block. The `WITH` keyword is optional (denoted by “WITH?”), followed by an optional `RECURSIVE` keyword. Then a macro block represents a CTE definition (`name AS (subquery)`), with an oval labeled “, ...?” indicating that additional CTEs can follow.
  
- **Main SELECT Section:**  
  The main part of the query starts with the `SELECT` keyword. An optional modifier (`DISTINCT` or `ALL`) is shown as “DISTINCT/ALL?”. The macro block “Select List” represents the list of columns or expressions. Subsequent clauses—`FROM`, `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY`, and `LIMIT`—are each marked as optional (using a “?”) with their corresponding macro blocks for further details.

You can modify or extend this diagram to suit more specific details of your grammar as needed.