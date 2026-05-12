---
title: "Executable Prompt for Compile"
token: 86
---

# Executable Prompt for Compile

```text
Compile wiki content for topic <topic-slug> from raw/public sources.

Requirements:
1) Read raw/public/_index.md and all relevant raw/public/*.md for the topic.
2) Build or update `wiki_public/<topic-slug>/_index.md`.
3) Build or update concept pages in `wiki_public/<topic-slug>/concepts/`.
4) Build or update connection pages in `wiki_public/<topic-slug>/connections/`.
5) Ensure every page has YAML frontmatter with title and token.
6) Ground claims with [[raw/public/...]] references.
7) Add or refresh cross-links between related concepts.
8) Return a list of updated files.
```

## References

- [[raw/public/karpathy-llm-wiki-gist.md]]
- [[raw/public/nvk-llm-wiki.md]]
