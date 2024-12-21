When generating SQL code, follow these guidelines:

# SQL Style Guidelines

## General

- RDBMS engine: SQLite

## Identifiers

- SQL and SQLite reserved words are not allowed as identifiers
- consistent and descriptive names
- alphanumeric characters and the underscore only
- names start with a letter and should and with a letter or a digit, not underscore
- snake_case for all identifiers
- maximum of 30 bytes long
- use underscores in place of a space, avoid multiple consecutive underscores
- Do not prefix with `tbl` or any other such descriptive prefix or Hungarian notation.
- Never give a table the same name as one of its columns
- Avoid, where possible, concatenating two table names together to create the name of a relationship table.
  e.g., `services` over `cars_mechanics`

## Tables and columns

- prefer common collective uncountable nouns for table names
  e.g., staff/people over employees/contacts, address_book over address
- use plural nouns for table names where common uncountable alternatives are not available
- singular nouns for column names

## Column name suffixes

- `_id`—a unique identifier such as a column that is a primary key.
- `_status`—flag value or some other status of any type such as `publication_status`.
- `_total`—the total or sum of a collection of values.
- `_num`—denotes the field contains any kind of number.
- `_name`—signifies a name such as `first_name`.
- `_seq`—contains a contiguous sequence of values.
- `_date`—denotes a column that contains the date of something.
- `_tally`—a count.
- `_size`—the size of something such as a file size or clothing.
- `_addr`—an address for the record could be physical or intangible such as `ip_addr`.

## Keywords

- Capitalize SQL keywords, including operators
- Lower case for function names

## Aliases

- Always include the `AS` keyword.
- As a rule of thumb the correlation name should be the first letter of each word in the object’s name.
## Comments

- Include detailed comments
- Standard SQL comments starting from "-- {COMMENT}" (single line comments, for multi lines comments, prefix each line):
  -- This is an SQL comment
- C-style SQL comments (including multiline comments)
    - single line comments - "/\* {COMMENT} \*/"
    - multi line comments - place "/\*" and " \*/" on dedicated lines; prefix comment lines with " \*  ":
      /\*
       \* {LINE 1}
       \* {LINE 2}
       \*/

## Formatting

- Prefer 88-character-long lines
- Use whitespaces only, do not use tabs
- Use alignment for better readability
  Spaces should be used to line up the code so that the root keywords all end on the same character boundary. This forms a river down the middle making it easy for the readers eye to scan over the code and separate the keywords from the implementation detail.
- Include spaces
    - before and after equals,
    - after commas,
    - surrounding apostrophes, where not within parentheses or with a trailing comma or semicolon.
- Include newlines, where necessary
    - before `AND` or `OR`
    - after semicolons
    - after each keyword definition
    - after a comma when separating multiple columns into logical groups
- always include a blank line between multiline statements.
- 4-spaces indent where applicable
- single quotes for string literals
- double quotes for identifiers
- Store [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601 "Wikipedia: ISO 8601") compliant time and date information (`YYYY-MM-DDTHH:MM:SS.SSSSS`)

## CTEs

- strongly prefer CTEs over subqueries, except for very simple subqueries

## DDL

- Indent column definitions and table constrains by four spaces within the `CREATE` statement.
- When a single column containing integers is used as the primary key, define as `INTEGER PRIMARY KEY`, including the `AUTOINCREMENT` keyword where appropriate.
- Use standard SQLite data types (INTEGER, REAL, NUMERIC, TEXT, BLOB)

## DDL from JSON schema

- ignore top-level array (correspond to table rows)
- each scalar property of the top object corresponds to a table row
- each property of the main (top) object containing arrays/object with
    - scalar items/properties define a child table and an associated foreign key constrain
    - non-scalar items/properties should be stored in a TEXT column as JSON documents.

## SQL code examples

``` sql
SELECT file_hash  -- stored ssdeep hash
  FROM file_system
 WHERE file_name = '.vimrc';
```

```sql
/* Updating the file record after writing to the file */
UPDATE file_system
   SET file_modified_date = '1980-02-22 13:19:01.00000',
       file_size = 209732
 WHERE file_name = '.vimrc';
```

```sql
SELECT a.title,
       a.release_date, a.recording_date, a.production_date -- grouped dates together
  FROM albums AS a
 WHERE a.title = 'Charcoal Lane'
    OR a.title = 'The New Danger';
```

```sql
(SELECT f.species_name,
        AVG(f.height) AS average_height, AVG(f.diameter) AS average_diameter
   FROM flora AS f
  WHERE f.species_name = 'Banksia'
     OR f.species_name = 'Sheoak'
     OR f.species_name = 'Wattle'
  GROUP BY f.species_name, f.observation_date)

  UNION ALL

(SELECT b.species_name,
        AVG(b.height) AS average_height, AVG(b.diameter) AS average_diameter
   FROM botanic_garden_flora AS b
  WHERE b.species_name = 'Banksia'
     OR b.species_name = 'Sheoak'
     OR b.species_name = 'Wattle'
  GROUP BY b.species_name, b.observation_date);
```

```sql
WITH
    tables AS (
        SELECT tbl_name AS table_name, sql
          FROM sqlite_master
         WHERE type = 'table'
           AND name NOT LIKE 'sqlite_%'
    ),
    index_list AS (
        SELECT table_name, name AS index_name, "unique", origin, partial
          FROM tables AS t, pragma_index_list(t.table_name)
    ),
    index_columns AS (
        SELECT il.*, name AS col_name, cid, seqno, "desc", coll, "key"
          FROM index_list AS il, pragma_index_xinfo(il.index_name)
        ORDER BY index_name, seqno
    ),
    noddl_indices AS (
        SELECT table_name, index_name,
               json_group_array(col_name) AS col_names,
               "unique", origin, partial
          FROM index_columns
        GROUP BY index_name
    ),
    indices AS (
        SELECT bi.*, sm.sql
          FROM noddl_indices AS bi, sqlite_master AS sm
         WHERE type = 'index' AND index_name = name
        ORDER BY table_name, index_name
    )
SELECT * FROM indices;
```

```sql
CREATE TABLE "countries" (
    "alfaTwo"   TEXT COLLATE NOCASE NOT NULL PRIMARY KEY,
    "alfaThree" TEXT COLLATE NOCASE NOT NULL UNIQUE,
    "name"      TEXT COLLATE NOCASE UNIQUE,
    "nameBrief" TEXT COLLATE NOCASE UNIQUE,
    CONSTRAINT "ck_name_available"
        CHECK(coalesce("name", "nameBrief") IS NOT NULL),
    UNIQUE("alfaTwo", "name"),
    UNIQUE("alfaThree", "name")
);

CREATE TABLE "candles" (
    "uid"       TEXT COLLATE NOCASE NOT NULL CHECK(length("uid") = 36),
    "timestamp" INTEGER NOT NULL,
    "period"    INTEGER NOT NULL,
    "open"      REAL,
    "high"      REAL,
    "low"       REAL,
    "close"     REAL,
    "volume"    INTEGER,
    PRIMARY KEY("uid", "timestamp", "period"),
    CONSTRAINT "fk_candles_enum_inst_base"
        FOREIGN KEY("uid") REFERENCES "inst_base"("uid"),
    CONSTRAINT "fk_candles_enum_candle_intervals"
        FOREIGN KEY("period") REFERENCES "enum_candle_intervals"("period")
);
```

<!-- References -->

[Modern SQL Style Guide]: https://gist.github.com/mattmc3/38a85e6a4ca1093816c08d4815fbebfb
[Simon Holywell SQL Style Guide]: https://sqlstyle.guide

 
 