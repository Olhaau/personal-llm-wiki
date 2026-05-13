---
title: "Persistent Wiki Pattern"
token: "93"
---

# Persistent Wiki Pattern

The core pattern describes a persistent, LLM-maintained wiki that sits between users and raw sources. Instead of answering by repeatedly re-retrieving raw chunks, the system incrementally compiles knowledge into interlinked markdown pages.

Key properties in the source material:
- accumulation over time (knowledge compounds),
- explicit synthesis and cross-references,
- maintenance operations that track contradictions and updates,
- human role focused on curation and direction rather than filing/bookkeeping.

## Connected Concepts

- [[llm-wiki.md]]
- [[operation-loop.md]]
- [[runtime-and-skill-packaging.md]]
- [[local-search-and-retrieval-tooling.md]]
- [[implementations-comparison.md]]

## References

- [[karpathy-llm-wiki-gist.md]]
- [[karpathy-llm-wiki-raw-idea-file.md]]
- https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
