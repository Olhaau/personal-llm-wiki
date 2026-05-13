---
title: "LLM Wiki and Docling Ingestion Boundary"
token: "90"
---

# LLM Wiki and Docling Ingestion Boundary

## Summary

Docling focuses on source parsing and structured conversion from heterogeneous inputs [[raw/docling-docs.md]]. LLM wiki workflows focus on persistent synthesis, indexing, and maintenance after source normalization [[raw/karpathy-llm-wiki-raw-idea-file.md]]. The operational boundary is the handoff from normalized source content to long-lived concept maintenance.

## Details

Document-processing tools produce stable markdown and metadata in `raw/`, and compile/query/lint operations then transform that evidence into interlinked concept pages [[raw/nvk-llm-wiki.md]]. This separation keeps extraction concerns independent from knowledge curation concerns while still allowing shared tooling around ingestion and indexing [[raw/docling-github.md]].

## Connected Concepts

- [[llm-wiki]] - The boundary defines which responsibilities belong to persistent wiki maintenance.
- [[docling]] - The boundary starts where Docling output becomes normalized source input.
- [[Docling and LLM Wiki Workflows]] - This page extends the same handoff model with operational examples.
- [[Docling Pipeline Capabilities]] - Supported formats and exports determine source quality at handoff.
- [[Operation Loop]] - The loop consumes normalized inputs after parsing and conversion.

## References

- [[raw/docling-docs.md]]
- [[raw/docling-github.md]]
- [[raw/karpathy-llm-wiki-raw-idea-file.md]]
- [[raw/nvk-llm-wiki.md]]
