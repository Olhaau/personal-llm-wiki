---
title: "llm-wiki"
token: "198"
---

# llm-wiki

## Summary

LLM wiki is a persistent, compounding knowledge-base pattern where an LLM incrementally compiles and maintains interlinked pages between users and raw sources [[karpathy-llm-wiki-raw-idea-file.md]]. The central shift is from query-time rediscovery to ongoing synthesis, maintenance, and traceable updates [[karpathy-llm-wiki-gist.md]]. Community implementations extend the base idea with compile/audit routines and stronger operational guardrails [[lewislulu-llm-wiki-skill.md]].

## Details

The operating model keeps normalized evidence in `raw/` and continuously updates topic pages through ingest, compile, query, and lint/audit cycles, so each iteration improves future answers [[nvk-llm-wiki.md]]. This approach reduces repetitive retrieval work and strengthens provenance because claims stay attached to concrete source files [[karpathy-llm-wiki-gist.md]].

## Connected Concepts

- [[persistent-wiki-pattern.md]] - Persistent synthesis is the core architectural principle behind the model.
- [[operation-loop.md]] - The loop defines how content stays current and internally consistent.
- [[runtime-and-skill-packaging.md]] - Packaging decisions determine portability of operations across agents.
- [[local-search-and-retrieval-tooling.md]] - Local search helps navigate growing page sets efficiently.
- [[implementations-comparison.md]] - Implementation differences show alternative operational trade-offs.
- [[llm-wiki-and-docling-ingestion-boundary.md]] - The boundary clarifies where parsing ends and curation begins.
- [[docling.md]] - Docling is a common upstream parser feeding normalized source files.

## References

- [[karpathy-llm-wiki-gist.md]]
- [[karpathy-llm-wiki-raw-idea-file.md]]
- [[lewislulu-llm-wiki-skill.md]]
- [[nvk-llm-wiki.md]]
