---
title: "Extraction Methods Comparison"
token: "196"
---

# Extraction Methods Comparison

## Summary

Excel extraction methods differ primarily in structural fidelity, operational complexity, and output shape for retrieval [[raw/excel-extraction-methods-for-ai-knowledge.md]]. Choosing by target artifact type reduces rework: row objects for analytics, table elements for document pipelines, and markdown for text-native prompting [[raw/excel-extraction-methods-for-ai-knowledge.md]].

## Details

Practical mapping from method to workload:

- pandas: best when selected sheets/columns must become typed tabular data quickly, with broad engine support including legacy formats [[raw/excel-extraction-methods-for-ai-knowledge.md]].
- openpyxl: best when workbook semantics matter (formulas, comments, hyperlinks, merged ranges, sheet metadata) and large files require `read_only` patterns [[raw/excel-extraction-methods-for-ai-knowledge.md]].
- unstructured + LangChain loaders: best when ingestion already uses element documents and table HTML metadata in a common chunking/retrieval stack [[raw/excel-extraction-methods-for-ai-knowledge.md]].
- LlamaIndex PandasExcelReader: best when row-level `Document` units are preferred for direct indexing or per-row retrieval granularity [[raw/excel-extraction-methods-for-ai-knowledge.md]].
- MarkItDown: best when markdown output is the canonical intermediate for prompt-time context assembly [[raw/excel-extraction-methods-for-ai-knowledge.md]].

## Connected Concepts

- [[excel-ingestion.md]] - The topic overview explains how these methods fit in end-to-end ingestion architecture.
- [[wiki/prompt-engineering/prompt-engineering.md]] - Output format decisions influence prompt chunk structure and retrieval effectiveness.
- [[wiki/docling/docling-quickstart.md]] - Mixed-source pipelines can pair spreadsheet extraction with document conversion workflows.

## References

- [[raw/excel-extraction-methods-for-ai-knowledge.md]]
