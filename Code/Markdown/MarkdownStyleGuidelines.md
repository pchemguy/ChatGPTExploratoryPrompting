---
url: https://chatgpt.com/c/6a0d7893-2310-83eb-93ab-dffa1cf4d564
---
## Markdown Structure Guidelines for Long Technical Analysis

Use Markdown as an information architecture tool, not as visual decoration. Headings should represent semantic hierarchy, not emphasis or spacing. ([gitbook.com][1])

### Core Rules

* Follow well-established rules for effective technical writing.
* Use a single `# H1` title for the document.
* Prefer shallow hierarchy:
    * `##` for major sections
    * `###` for true subsections only
    * `####` for larger technical documents, if justified.
* Use H4 (`####`) sparingly when clearly justified. Do not go beyond H4.
* Never create heading chains with only 1–2 sentences under each heading.
* Do not use headings merely to visually separate thoughts.
* Prefer continuous prose with dense local cohesion.
* Use tables for comparison-heavy material.
* Use bullets for:
    * enumerations,
    * taxonomies,
    * constraints,
    * architectural pillars,
    * tradeoffs.
* Avoid excessive fragmentation:
    * bad:

    ```md
    ## Topic
    sentence

    ### Subtopic
    sentence
    ```

    * better:

    ```md
    ## Topic

    cohesive multi-paragraph discussion...
    ```

### Preferred Structure for Systems Analysis

Preferred pattern:

```md
# Topic

Short framing introduction.

## Architectural Landscape

Continuous analysis...

| System | Focus | Strength |
|---|---|---|

## Context Engineering

Discussion...

### Cache-Aware Prompt Construction

Discussion...

### Multi-Agent Partitioning

Discussion...

## Strategic Trends

Discussion...
```

Avoid:

```md
# Topic

## One Sentence

text

## Another Sentence

text

### Tiny Subsection

text
```

### Heading Discipline

Headings define hierarchy, not styling. Do not skip levels or use deep nesting casually. ([carpentry.library.ucsb.edu][2])

Good:

```md
# Title

## Major Section

### Subsection
```

Bad:

```md
# Title

#### Random Deep Heading
```

### Density and Flow

For advanced technical subjects:

* prefer fewer headings,
* larger coherent sections,
* stronger narrative continuity,
* denser comparative prose.

Long-form systems analysis benefits more from:

* conceptual flow,
* architectural grouping,
* comparative matrices,
  than from excessive sectionalization.

### Practical Limits

Recommended maximums:

* 2–3 heading depths for most documents. ([IBM Community][3])
- Prefer:
    * lists over subsections where they:
        * effectively communicate the information,
        * contain little or no descriptive text per item,
        * do not benefit from explicit TOC visibility;
    * subsections over lists where:
        * items deserve dedicated analysis,
        * significant explanatory text is required,
        * readers benefit from explicit navigational structure and TOC discoverability.

Use headings to represent semantic hierarchy and document structure, not visual emphasis. ([mailslurp.com][7])

### Formatting Principles

* Keep heading naming concise and semantic.
* Use consistent ATX headings (`#`) throughout. ([Markdown2RichText][4])
* Add blank lines around headings. ([Markdown Guide][5])
* Preserve plain-text readability as a primary goal. ([CommonMark Discussion][6])

Bias toward:

* architectural taxonomies,
* comparison tables,
* clustered discussions,
* layered analysis,
* concise subsectioning,
* continuous technical prose.

Avoid:

* heading spam,
* excessive microsections,
* one-paragraph subsections,
* visually fragmented output.

### References

[1]: https://gitbook.com/docs/guides/docs-best-practices/documentation-structure-tips "How to structure technical documentation: information ..."
[2]: https://carpentry.library.ucsb.edu/R-markdown/03-headings-lists/index.html "R Markdown Syntax: Headings & Lists"
[3]: https://community.ibm.com/community/user/blogs/hiren-dave/2025/05/27/markdown-documentation-best-practices-for-document "Markdown Documentation: Best Practices for Documentation"
[4]: https://markdowntorichtext.com/blog/markdown-best-practices/ "Markdown Best Practices for Technical Writing"
[5]: https://www.markdownguide.org/basic-syntax/ "Basic Syntax"
[6]: https://talk.commonmark.org/t/markdown-best-practices/3115 "Markdown "best practices" - Spec"
[7]: https://www.mailslurp.com/blog/markdown-heading-sizes/ "Markdown heading sizes: H1-H6 syntax, hierarchy, and ..."

