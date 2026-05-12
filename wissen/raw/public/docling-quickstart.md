---
title: "Docling Quickstart"
token: 192
source_link: "https://docling-project.github.io/docling/getting_started/quickstart/"
topic: "docling"
tags: [ingest, web, docling, quickstart, syntax, fetched]
generated_at: "2026-05-11T00:00:00Z"
---

# Docling Quickstart

The quickstart presents a minimal conversion workflow with both Python and CLI usage.

Core flow:
- Create a `DocumentConverter`.
- Convert a file path or URL.
- Work with the resulting `DoclingDocument`.
- Export to markdown (or other supported formats in the wider docs).

Python syntax pattern shown in the source:

```python
from docling.document_converter import DocumentConverter

source = "https://arxiv.org/pdf/2408.09869"  # file path or URL
converter = DocumentConverter()
doc = converter.convert(source).document

print(doc.export_to_markdown())
```

CLI syntax pattern shown in the source:

```bash
docling https://arxiv.org/pdf/2206.01062
```

VLM pipeline example from the quickstart:

```bash
docling --pipeline vlm --vlm-model granite_docling https://arxiv.org/pdf/2206.01062
```

The page also points to next steps: supported formats, architecture, examples, and CLI reference for additional options.
