---
title: "Excel Ingestion"
token: "198"
---

# Excel Ingestion

## Summary

Excel ingestion for AI knowledge pipelines can be implemented at different abstraction levels, from DataFrame extraction to cell-level workbook parsing and markdown conversion [[raw/excel-extraction-methods-for-ai-knowledge.md]]. Method choice should follow the retrieval target: analysis tables, metadata-preserving archives, or text-first RAG corpora [[raw/excel-extraction-methods-for-ai-knowledge.md]].

## Details

The method set includes: pandas (`read_excel`) for sheet and column selection, openpyxl for workbook internals and optimized streaming modes, Unstructured and LangChain for element-based document outputs, LlamaIndex for row-to-document conversion, and MarkItDown for markdown-first conversions [[raw/excel-extraction-methods-for-ai-knowledge.md]].

Pipeline design typically separates extraction, normalization, and chunking. For example, a workbook can be parsed with openpyxl to preserve formulas and metadata, normalized to JSON rows, then transformed into semantically chunked text for indexing [[raw/excel-extraction-methods-for-ai-knowledge.md]]. In contrast, if only analytical values are required, direct pandas extraction with strict `usecols` and schema mapping is usually faster and easier to maintain [[raw/excel-extraction-methods-for-ai-knowledge.md]].

## Connected Concepts

- [[extraction-methods-comparison.md]] - The comparison page maps extraction methods to common AI ingestion goals and trade-offs.
- [[wiki/docling/docling.md]] - Docling complements spreadsheet extraction when mixed document formats are ingested into one knowledge base.
- [[wiki/ai-tooling/ai-tooling.md]] - AI tooling decisions affect whether ingestion favors markdown-first or structured JSON-first artifacts.

## References

- [[raw/excel-extraction-methods-for-ai-knowledge.md]]
