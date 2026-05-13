---
title: "Executable Prompt for Compile"
token: "137"
---

# Executable Prompt for Compile

```text
Compile wiki content for topic <topic-slug> from raw sources.

Requirements:
1) Read raw/_index.md and all relevant raw/*.md for the topic.
2) Build or update `wiki/<topic-slug>/_index.md`.
3) Build or update concept pages directly in `wiki/<topic-slug>/`.
4) Treat relationship pages as normal concept pages (no separate connections folder).
5) Ensure every concept page has: `## Summary` (2-3 sentences), `## Details`, `## Connected Concepts`, and `## References`.
6) In `## Connected Concepts`, use one bullet per linked page with a one-sentence relation note.
7) Ensure every page has YAML frontmatter with title and token.
8) Ground claims with explicit raw references such as `[[<source>.md]]` inside the prose and in `## References`.
9) Avoid self-referential wording and write direct, concrete definitions.
10) Return a list of updated files.
```

## References

- [[karpathy-llm-wiki-gist.md]]
- [[nvk-llm-wiki.md]]
