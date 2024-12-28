When generating SQL code directly or via an intermediate script, use the following guidelines.

# **SQL Style Guidelines**

## **1. General**

- **RDBMS Engine**: SQLite
- Maintain consistency and readability throughout the code.

---

## **2. Identifiers**

- **Reserved Words**: Avoid using SQL/SQLite reserved words as identifiers.
- **Naming Rules**:
  - Use **consistent** and **descriptive** names.
  - Only **alphanumeric characters** and underscores are allowed.
  - Names must start with a **letter** and end with a letter or digit (not an underscore).
  - Follow **snake_case** for all identifiers.
  - Limit names to a maximum of **30 bytes**.
  - Use underscores instead of spaces; avoid multiple consecutive underscores.
- **Prohibited Naming Practices**:
  - Do not prefix names with `tbl` or other descriptive prefixes (e.g., Hungarian notation).
  - Avoid using the same name for a table and one of its columns.
  - Avoid concatenating two table names for relationship tables (e.g., prefer `services` over `cars_mechanics`).

---

## **3. Tables and Columns**

- **Table Names**:
  - Prefer **collective uncountable nouns** (e.g., `staff`, `address_book`).
  - Use **plural nouns** where uncountable alternatives are unavailable.
- **Column Names**:
  - Use **singular nouns**.

---

## **4. Column Name Suffixes**

Standardize column name suffixes for clarity:
- **_id**: Unique identifier (e.g., primary key).
- **_status**: Status or flag value (e.g., `publication_status`).
- **_total**: Total or sum of values.
- **_num**: Numeric field (e.g., `order_num`).
- **_name**: Names (e.g., `first_name`).
- **_seq**: Contiguous sequence of values.
- **_date**: Date fields.
- **_tally**: Count fields.
- **_size**: Sizes (e.g., `file_size`).
- **_addr**: Addresses (e.g., `ip_addr`).

---

## **5. Keywords**

- **SQL Keywords**: Write all SQL keywords and operators in **uppercase**.
- **Function Names**: Use **lowercase**.

---

## **6. Aliases**

- Always include the `AS` keyword.
- Use **descriptive correlation names** (e.g., first letters of object words).

---

## **7. Comments**

- Include detailed comments for clarity.
- Use **single-line comments** (`--`) or **C-style comments** (`/* */`).
- For multiline comments, format with aligned prefixes:
  ```sql
  /*
   * Line 1
   * Line 2
   */
  ```

---

## **8. Formatting**

- Limit lines to **88 characters**.
- Use **spaces**, not tabs.
- **Alignment**:
  - Align root keywords vertically for readability.
  - Ensure readability with consistent spacing around symbols (e.g., `=`).
- **Spacing**:
  - Add spaces before and after equals (`=`).
  - Add spaces after commas.
  - Surround single quotes (e.g., `'value'`) with spaces where appropriate.
- **Newlines**:
  - Before `AND`/`OR`.
  - After semicolons.
  - After each root keyword in multiline statements.
  - Between logical column groups.
- Indent with **4 spaces**.
- Use **single quotes** for string literals and **double quotes** for identifiers.
- Store date/time in **ISO 8601** format (`YYYY-MM-DDTHH:MM:SS.SSSSS`).

---

## **9. CTEs (Common Table Expressions)**

- Prefer CTEs over subqueries for clarity, except in simple cases.

---

## **10. Data Definition Language (DDL)**

When generating schemas or DDL code, enforce the following formatting rules:

### **Data Types**
- Stick to SQLite data types: **INTEGER**, **REAL**, **NUMERIC**, **TEXT**, **BLOB**.

### **Identifier Quoting**
- All identifiers (table names, column names, constraint names) must be enclosed in double quotes (`"identifier"`) to ensure compatibility with reserved keywords or special characters.  

### **Column Definitions Alignment**
- Align column definitions after the column names for consistent readability. Example:

```sql
CREATE TABLE "example_table" (
  "column_one"   TEXT    NOT NULL,
  "column_two"   INTEGER NOT NULL UNIQUE,
  "column_three" TEXT    DEFAULT 'default_value'
);
```

### **Detailed Comments**
- Provide detailed comments for
    - each column definition.
    - any triggers and views.
- Comments should align with the column definitions and use `/* */` or `--`.   
- Example:

```sql
CREATE TABLE "example_table" (
  "id"           INTEGER PRIMARY KEY,  -- Unique identifier for the row
  "name"         TEXT    NOT NULL,     -- Name of the entity
  "description"  TEXT                  -- Optional description field
);

/* Keeps FTS data in synch with message data, making sure that the latter is available for full-text search */
CREATE TRIGGER email_messages_fts_insert AFTER INSERT ON email_messages
BEGIN
    INSERT INTO email_messages_fts (
        message_id, from_addr, to_addrs, cc_addrs,
        bcc_addrs, subject, body_text, body_html
    )
    VALUES (
        NEW.message_id, NEW.from_addr, NEW.to_addrs, NEW.cc_addrs,
        NEW.bcc_addrs, NEW.subject, NEW.body_text, NEW.body_html
    );
END;
```

### **Primary and Unique Constraints**
- **Single-column UNIQUE and PRIMARY KEY constraints**:
  - Always include them as part of the column definition, using bare keywords (`UNIQUE` or `PRIMARY KEY`).
  - Do not define these constraints as standalone table constraints for single columns.
  - Use `INTEGER PRIMARY KEY` with `AUTOINCREMENT` for single-column integer primary keys.
  - Example:

```sql
CREATE TABLE "example_table" (
    "id"   INTEGER PRIMARY KEY,  -- Unique identifier for the row
    "code" TEXT    UNIQUE        -- Unique code for the entity
);
```

### **Other Single-Column Constraints**
- For constraints other than `UNIQUE` and `PRIMARY KEY`:
  - Include them at the end of the column definition.
  - Provide descriptive constraint names.
  - Place each constraint on a new line and indent by four spaces relative to the column name.
  - Example:

```sql
CREATE TABLE "example_table" (
    "id"   INTEGER PRIMARY KEY,  -- Unique identifier
    "age"  INTEGER NOT NULL
              CONSTRAINT "ck_age_positive" CHECK ("age" > 0)
);
```

### **Multi-Column Table Constraints**
- Include documenting comments for all constraints other than `PRIMARY KEY`.
- Include descriptive names for all constraints other than `PRIMARY KEY` and `UNIQUE`.
- Align constraint naming part with column names and place the definition part on the following line with additional 4-space indent.
- Example:

```sql
CREATE TABLE borrowing_records ( 
    isbn        TEXT    NOT NULL, -- Part of the foreign key 
    copy_number INTEGER NOT NULL, -- Part of the foreign key 
    borrower_id INTEGER NOT NULL
                    REFERENCES borrowers (borrower_id) ON DELETE CASCADE, -- Foreign key 
    borrow_date TEXT    NOT NULL DEFAULT CURRENT_DATE, 
    return_date TEXT, 
    PRIMARY KEY (isbn, copy_number, borrower_id), -- Multi-column natural key 
    CONSTRAINT "fk_checked_out"
        FOREIGN KEY (isbn, copy_number) REFERENCES book_copies (isbn, copy_number) ON DELETE CASCADE, 
    FOREIGN KEY (borrower_id) 
);
```

### **Alignment and Spacing**
- Use 4 spaces for indentation.
- Align column definitions for readability.
- Include a newline between logical column groups if the schema is complex.
- Align column comments.

### Updated Example: CREATE TABLE
Here is a full example incorporating the new formatting rules:

```sql
CREATE TABLE "employees" (
    "employee_id"  INTEGER PRIMARY KEY,                  -- Unique identifier for each employee
    "first_name"   TEXT    NOT NULL,                     -- Employee's first name
    "last_name"    TEXT    NOT NULL,                     -- Employee's last name
    "email"        TEXT    NOT NULL UNIQUE,              -- Unique email address
    "salary"       REAL    NOT NULL
                     CONSTRAINT "ck_salary_positive" CHECK ("salary" > 0), -- Salary must be positive
    "hire_date"    TEXT    DEFAULT CURRENT_DATE          -- Date of hire
);
```

---

## **11. DDL from JSON Schema**

- Top-level arrays correspond to table rows.
- Scalar properties of the root object become table columns.
- Arrays/objects as properties with
  - scalar items only define child tables with foreign key constraints.
  - non-scalar items are stored as JSON in a **TEXT** column of the main table.

---

## **12. SQL Code Examples**

### **SELECT Example**
```sql
SELECT file_hash  -- stored ssdeep hash
  FROM file_system
 WHERE file_name = '.vimrc';
```

### **UPDATE Example**
```sql
/* Update file record after modification */
UPDATE file_system
   SET file_modified_date = '1980-02-22T13:19:01.00000',
       file_size = 209732
 WHERE file_name = '.vimrc';
```

### **Using Aliases**
```sql
SELECT a.title,
       a.release_date,
       a.recording_date,
       a.production_date
  FROM albums AS a
 WHERE a.title IN ('Charcoal Lane', 'The New Danger');
```

### **CTE Example**
```sql
WITH
    filtered_flora AS (
        SELECT species_name,
               AVG(height) AS average_height,
               AVG(diameter) AS average_diameter
          FROM flora
         WHERE species_name IN ('Banksia', 'Sheoak', 'Wattle')
         GROUP BY species_name
    )
SELECT * FROM filtered_flora;
```

### **CREATE TABLE Example**
```sql
CREATE TABLE "countries" (
    "alfa_two"   TEXT COLLATE NOCASE NOT NULL PRIMARY KEY,
    "alfa_three" TEXT COLLATE NOCASE NOT NULL UNIQUE,
    "name"       TEXT COLLATE NOCASE UNIQUE,
    "name_brief" TEXT COLLATE NOCASE UNIQUE,
    CONSTRAINT "ck_name_available"
        CHECK(coalesce("name", "name_brief") IS NOT NULL),
    UNIQUE("alfa_two", "name"),
    UNIQUE("alfa_three", "name")
);
```


<!-- References -->

[Modern SQL Style Guide]: https://gist.github.com/mattmc3/38a85e6a4ca1093816c08d4815fbebfb
[Simon Holywell SQL Style Guide]: https://sqlstyle.guide
