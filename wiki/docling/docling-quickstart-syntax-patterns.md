---
title: "Docling Quickstart Syntax Patterns"
token: "72"
---

# Docling Quickstart Syntax Patterns

Docling quickstart usage follows a small conversion pattern: instantiate converter, convert source, then export or post-process the resulting document object.

## Python example

```python
from docling.document_converter import DocumentConverter

converter = DocumentConverter()
doc = converter.convert("https://arxiv.org/pdf/2408.09869").document

markdown = doc.export_to_markdown()
print(markdown)
```

## CLI examples

```bash
docling https://arxiv.org/pdf/2206.01062
```

```bash
docling --pipeline vlm --vlm-model granite_docling https://arxiv.org/pdf/2206.01062
```

## Connected Concepts

- [[docling.md]]
- [[docling-integrations-and-usage-modes.md]]
- [[docling-pipeline-capabilities.md]]

## References

- [[docling-quickstart.md]]
