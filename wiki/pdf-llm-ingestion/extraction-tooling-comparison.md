---
title: "Extraction Tooling Comparison"
token: "234"
---

# Extraction Tooling Comparison

## Summary

PyMuPDF4LLM, Docling extraction templates, and Unstructured partitioning solve different parts of PDF ingestion rather than being strict replacements for one another [[raw/pymupdf4llm-docs.md]] [[raw/docling-information-extraction.md]] [[raw/unstructured-partitioning.md]]. Choosing by target output contract and required metadata quality is more reliable than choosing only by raw extraction speed [[raw/artifex-rag-llm-pdf-enhanced-text-extraction.md]].

## Details

Practical mapping from tool to workload:

- PyMuPDF4LLM: best when fast local extraction to Markdown, JSON, or TXT is required with built-in layout support, optional header/footer suppression, and direct LangChain/LlamaIndex integration [[raw/pymupdf4llm-docs.md]].
- Docling information extraction: best when output fields must follow an explicit schema template (string, dict, or Pydantic) and extraction results need validation-ready structure per page [[raw/docling-information-extraction.md]].
- Unstructured partitioning: best when ingestion relies on element classes (`Title`, `NarrativeText`, `ListItem`, and others), broad file-type routing, and strategy-based PDF partition modes like `fast`, `hi_res`, or `ocr_only` [[raw/unstructured-partitioning.md]].
- PyMuPDF ecosystem framing: strong choice for retrieval preprocessing where table/image/vector extraction and high-volume document handling are primary constraints [[raw/artifex-rag-llm-pdf-enhanced-text-extraction.md]].

## Connected Concepts

- [[pdf-llm-ingestion.md]] - Topic overview explains where each tool class fits in pipeline architecture.
- [[ocr-and-structure-strategies.md]] - OCR and structure decisions influence whether the selected extraction tool preserves needed context.
- [[wiki/docling/docling-agent-skill-workflow.md]] - Docling extraction templates map naturally into convert -> evaluate -> refine assistant workflows.
- [[wiki/ai-tooling/fabric-pattern-workflow-bridge.md]] - Tool selection affects how extraction routines are packaged into repeatable command-driven operations.

## References

- [[raw/pymupdf4llm-docs.md]]
- [[raw/docling-information-extraction.md]]
- [[raw/unstructured-partitioning.md]]
- [[raw/artifex-rag-llm-pdf-enhanced-text-extraction.md]]
