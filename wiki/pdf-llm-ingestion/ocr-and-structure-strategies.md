---
title: "OCR and Structure Strategies"
token: "238"
---

# OCR and Structure Strategies

## Summary

OCR and layout strategy should be applied selectively: default to native text extraction, then escalate to OCR only for pages with missing or corrupted text layers [[raw/pymupdf4llm-docs.md]]. Structure-aware extraction quality depends on preserving page elements, coordinates, and table boundaries so chunks remain meaningful for retrieval [[raw/unstructured-partitioning.md]] [[raw/artifex-rag-llm-pdf-enhanced-text-extraction.md]].

## Details

PyMuPDF4LLM uses auto-OCR behavior to trigger OCR only when pages lack selectable text or when text quality is unreadable, and supports forced or disabled OCR depending on trust in the source document layer [[raw/pymupdf4llm-docs.md]]. Unstructured offers PDF partition strategies (`auto`, `fast`, `hi_res`, `ocr_only`) so pipelines can balance throughput and extraction fidelity by document profile [[raw/unstructured-partitioning.md]]. Docling extraction workflows complement these choices when post-conversion output must conform to explicit field templates and validated schema contracts [[raw/docling-information-extraction.md]].

For operational tuning, a robust baseline is: start with native extraction plus layout retention, inspect retrieval misses, then apply OCR or higher-fidelity partition strategies only where evidence shows degraded recall [[raw/pymupdf4llm-docs.md]] [[raw/unstructured-partitioning.md]].

## Connected Concepts

- [[pdf-llm-ingestion.md]] - The topic overview defines why OCR and structure choices are central to PDF-to-LLM quality.
- [[extraction-tooling-comparison.md]] - Tool comparison clarifies which engines expose the required OCR and structure controls.
- [[wiki/docling/docling-quickstart.md]] - Quickstart conversion is a lightweight baseline before adding schema extraction and OCR refinements.
- [[wiki/excel-ingestion/extraction-methods-comparison.md]] - Structure-preservation trade-offs in PDF extraction mirror similar decisions in spreadsheet extraction.

## References

- [[raw/pymupdf4llm-docs.md]]
- [[raw/unstructured-partitioning.md]]
- [[raw/docling-information-extraction.md]]
- [[raw/artifex-rag-llm-pdf-enhanced-text-extraction.md]]
