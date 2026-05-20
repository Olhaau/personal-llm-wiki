---
title: "PDF LLM Ingestion"
token: "236"
---

# PDF LLM Ingestion

## Summary

PDF-to-LLM ingestion combines text extraction, layout retention, and selective OCR so downstream retrieval keeps both semantic meaning and document context [[raw/pymupdf4llm-docs.md]]. Current tooling in this wiki spans extraction-first APIs, schema-guided information extraction, and element-based partitioning for mixed document types [[raw/docling-information-extraction.md]] [[raw/unstructured-partitioning.md]].

## Details

The topic focuses on a practical trade-off: whether to optimize for direct markdown throughput, richer structured outputs, or element-level control for chunking and retrieval [[raw/pymupdf4llm-docs.md]] [[raw/unstructured-partitioning.md]]. PyMuPDF and PyMuPDF4LLM emphasize fast local extraction with multiple output modes and robust handling of tables, images, and vectors for RAG preprocessing [[raw/artifex-rag-llm-pdf-enhanced-text-extraction.md]] [[raw/pymupdf4llm-docs.md]]. Docling extends the workflow with template-driven extraction (string, dict, or Pydantic model) that can validate and normalize extracted fields page-by-page [[raw/docling-information-extraction.md]].

Articles in this topic:
- [[extraction-tooling-comparison.md]] - Side-by-side view of extraction style, output structure, and ideal usage conditions.
- [[ocr-and-structure-strategies.md]] - OCR trigger behavior, strategy selection, and structure-preserving extraction decisions.

## Connected Concepts

- [[extraction-tooling-comparison.md]] - Tool choice determines output shape, dependencies, and retrieval preparation effort.
- [[ocr-and-structure-strategies.md]] - OCR and layout settings decide whether extraction keeps high-fidelity context or prioritizes speed.
- [[wiki/docling/docling.md]] - Docling conversion and extraction patterns integrate directly with PDF-focused ingestion pipelines.
- [[wiki/excel-ingestion/excel-ingestion.md]] - Mixed-source pipelines often combine PDF extraction with spreadsheet normalization before indexing.
- [[wiki/ai-tooling/ai-tooling.md]] - Tooling and automation strategy define how extraction components are packaged into repeatable workflows.

## References

- [[raw/pymupdf4llm-docs.md]]
- [[raw/docling-information-extraction.md]]
- [[raw/unstructured-partitioning.md]]
- [[raw/artifex-rag-llm-pdf-enhanced-text-extraction.md]]
