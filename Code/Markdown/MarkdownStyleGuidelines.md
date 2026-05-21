---
url: https://chatgpt.com/c/6a0d7893-2310-83eb-93ab-dffa1cf4d564
---

# Markdown Structure Guidelines

Use Markdown as an information architecture tool, not as visual decoration. Headings should represent semantic hierarchy, not emphasis or spacing.

## Core Principles

Well-structured technical documents should:

* employ explicit structure, logical hierarchy, and navigational clarity;
* use headings as semantic and navigational constructs, not visual separators;
* reflect the conceptual structure of the material in the document hierarchy;
* maximize navigability, scannability, semantic cohesion, retrieval efficiency, reader orientation, and TOC usefulness.

In effective technical writing:

* headings function as information architecture;
* sections act as semantic containers;
* hierarchy supports both conceptual flow and efficient navigation.

## Heading Hierarchy

* Use a single `# H1` title for the document.
* Prefer shallow hierarchy:
    * `##` for major sections;
    * `###` for true subsections;
    * `####` only when clearly justified by document scale and complexity.
* Avoid heading levels deeper than H4 unless strongly justified.
* Do not skip heading levels.
* Use headings to communicate semantic structure, not visual emphasis.

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

## Section Design

Sections and subsections should:

* define clear semantic scopes;
* communicate cohesive units of material;
* meaningfully partition related concepts;
* justify their presence within the hierarchy;
* use titles accurately reflecting their contents and scope;
* form a hierarchy mirroring the conceptual decomposition of the subject matter;
* support efficient navigation, scanning, selective reading, and retrieval.

Prefer cohesive local structure over fragmented microsections.

Avoid:

* heading chains with minimal content;
* structurally insignificant subsections;
* headings used purely for visual separation;
* arbitrary hierarchy depth;
* TOC pollution caused by weak sectioning.

Bad:

```md
## Topic
sentence

### Subtopic
sentence
```

Better:

```md
## Topic

Cohesive multi-paragraph discussion...
```

## Lists vs Subsections

Prefer lists over subsections where:

* information can be communicated efficiently in compact form;
* items require little or no descriptive text;
* explicit TOC visibility is unnecessary.

Prefer subsections over lists where:

* items deserve dedicated analysis;
* significant explanatory text is required;
* readers benefit from explicit navigational structure and TOC discoverability.

Use tables for:

* comparisons;
* taxonomies;
* tradeoffs;
* capability matrices;
* structured attribute analysis.

Use bullet lists for:

* enumerations;
* constraints;
* architectural pillars;
* concise grouped information.

## Structural Anti-Patterns

Avoid:

* heading spam;
* excessive microsections;
* one-paragraph subsections lacking meaningful scope;
* visually fragmented structure;
* deeply nested hierarchy without strong justification;
* repetitive subsection patterns with minimal informational differentiation.

Poor structure is not defined by too many or too few headings, but by ineffective semantic partitioning.

## Formatting Conventions

* Use consistent ATX headings (`#`) throughout.
* Add blank lines around headings.
* Keep heading names concise, descriptive, and semantically scoped.
* Preserve plain-text readability as a primary goal.
* Prefer structurally coherent prose over formatting-heavy presentation.

## References

[1]: https://gitbook.com/docs/guides/docs-best-practices/documentation-structure-tips "How to structure technical documentation: information ..."
[2]: https://carpentry.library.ucsb.edu/R-markdown/03-headings-lists/index.html "R Markdown Syntax: Headings & Lists"
[3]: https://community.ibm.com/community/user/blogs/hiren-dave/2025/05/27/markdown-documentation-best-practices-for-document "Markdown Documentation: Best Practices for Documentation"
[4]: https://markdowntorichtext.com/blog/markdown-best-practices/ "Markdown Best Practices for Technical Writing"
[5]: https://www.markdownguide.org/basic-syntax/ "Basic Syntax"
[6]: https://talk.commonmark.org/t/markdown-best-practices/3115 "Markdown "best practices" - Spec"
[7]: https://www.mailslurp.com/blog/markdown-heading-sizes/ "Markdown heading sizes: H1-H6 syntax, hierarchy, and ..."
[8]: https://clickhelp.com/clickhelp-technical-writing-blog/toc-a-key-organizational-tool-for-readers/ "TOC: A Key Organizational Tool for Readers"



