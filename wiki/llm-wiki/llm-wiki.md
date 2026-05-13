---
title: "llm-wiki"
token: "87"
---

# llm-wiki

## Summary

LLM wiki is a persistent, compounding knowledge-base pattern where an LLM incrementally compiles and maintains interlinked pages between users and raw sources [[raw/karpathy-llm-wiki-raw-idea-file.md]]. The central shift is from query-time rediscovery to ongoing synthesis, maintenance, and traceable updates [[raw/karpathy-llm-wiki-gist.md]]. Community implementations extend the base idea with compile/audit routines and stronger operational guardrails [[raw/lewislulu-llm-wiki-skill.md]].

## Details

The operating model keeps normalized evidence in `raw/` and continuously updates topic pages through ingest, compile, query, and lint/audit cycles, so each iteration improves future answers [[raw/nvk-llm-wiki.md]]. This approach reduces repetitive retrieval work and strengthens provenance because claims stay attached to concrete source files [[raw/karpathy-llm-wiki-gist.md]].

## Connected Concepts

- [[Persistent Wiki Pattern]] - Persistent synthesis is the core architectural principle behind the model.
- [[Operation Loop]] - The loop defines how content stays current and internally consistent.
- [[Runtime and Skill Packaging]] - Packaging decisions determine portability of operations across agents.
- [[Local Search and Retrieval Tooling]] - Local search helps navigate growing page sets efficiently.
- [[Implementations Comparison]] - Implementation differences show alternative operational trade-offs.
- [[LLM Wiki and Docling Ingestion Boundary]] - The boundary clarifies where parsing ends and curation begins.
- [[docling]] - Docling is a common upstream parser feeding normalized source files.

## References

- [[raw/karpathy-llm-wiki-gist.md]]
- [[raw/karpathy-llm-wiki-raw-idea-file.md]]
- [[raw/lewislulu-llm-wiki-skill.md]]
- [[raw/nvk-llm-wiki.md]]
