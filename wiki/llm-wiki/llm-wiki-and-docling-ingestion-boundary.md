---
title: "LLM Wiki and Docling Ingestion Boundary"
token: "168"
---

# LLM Wiki and Docling Ingestion Boundary

## Summary

Docling focuses on source parsing and structured conversion from heterogeneous inputs [[docling-docs.md]]. LLM wiki workflows focus on persistent synthesis, indexing, and maintenance after source normalization [[karpathy-llm-wiki-raw-idea-file.md]]. The operational boundary is the handoff from normalized source content to long-lived concept maintenance.

## Details

Document-processing tools produce stable markdown and metadata in `raw/`, and compile/query/lint operations then transform that evidence into interlinked concept pages [[nvk-llm-wiki.md]]. This separation keeps extraction concerns independent from knowledge curation concerns while still allowing shared tooling around ingestion and indexing [[docling-github.md]].

## Connected Concepts

- [[llm-wiki.md]] - The boundary defines which responsibilities belong to persistent wiki maintenance.
- [[docling.md]] - The boundary starts where Docling output becomes normalized source input.
- [[docling-and-llm-wiki-workflows.md]] - This page extends the same handoff model with operational examples.
- [[docling-pipeline-capabilities.md]] - Supported formats and exports determine source quality at handoff.
- [[operation-loop.md]] - The loop consumes normalized inputs after parsing and conversion.

## References

- [[docling-docs.md]]
- [[docling-github.md]]
- [[karpathy-llm-wiki-raw-idea-file.md]]
- [[nvk-llm-wiki.md]]
