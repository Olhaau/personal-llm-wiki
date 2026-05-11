---
title: "Docling GitHub"
source_link: "https://github.com/docling-project/docling"
topic: "docling"
tags: [ingest, web, docling, github, fetched]
generated_at: "2026-05-11T00:00:00Z"
---

<p align="center">
  <a href="https://github.com/docling-project/docling">
    ![[inbox/images/docling-github-1.png]]
  </a>
</p>

# Docling

<p align="center">
  ![[inbox/images/docling-trendshift.svg]]
</p>

![[inbox/images/docling-docs-1.svg]]
![[inbox/images/docling-github-1.svg]]
![[inbox/images/docling-docs-2.svg]]
![[inbox/images/docling-docs-3.svg]]
![[inbox/images/docling-docs-4.svg]]
![[inbox/images/docling-docs-5.svg]]
![[inbox/images/docling-docs-6.svg]]
![[inbox/images/docling-github-2.svg]]
![[inbox/images/docling-docs-8.svg]]
![[inbox/images/docling-docs-9.svg]]
![[inbox/images/docling-github-3.svg]]
![[inbox/images/docling-docs-10.svg]]
![[inbox/images/docling-docs-11.svg]]
![[inbox/images/docling-docs-12.svg]]
![[inbox/images/docling-docs-13.svg]]

## What is Docling ?

Docling simplifies document processing, parsing diverse formats — including advanced PDF understanding — and providing seamless integrations with the gen AI ecosystem.

## Features

- 🗂️ Parsing of [multiple document formats][supported_formats] incl. PDF, DOCX, PPTX, XLSX, HTML, WAV, MP3, WebVTT, images (PNG, TIFF, JPEG, ...), LaTeX, plain text, and more
- 📑 Advanced PDF understanding incl. page layout, reading order, table structure, code, formulas, image classification, and more
- 🧬 Unified, expressive [DoclingDocument][docling_document] representation format
- ↪️ Various [export formats][supported_formats] and options, including Markdown, HTML, WebVTT, [DocTags](https://arxiv.org/abs/2503.11576) and lossless JSON
- 📜 Support of several application-specifc XML schemas incl. [USPTO](https://www.uspto.gov/patents) patents, [JATS](https://jats.nlm.nih.gov/) articles, and [XBRL](https://www.xbrl.org/) financial reports.
- 🔒 Local execution capabilities for sensitive data and air-gapped environments
- 🤖 Plug-and-play [integrations][integrations] incl. LangChain, LlamaIndex, Crew AI & Haystack for agentic AI
- 🔍 Extensive OCR support for scanned PDFs and images
- 👓 Support of several Visual Language Models ([GraniteDocling](https://huggingface.co/ibm-granite/granite-docling-258M))
- 🎙️ Audio support with Automatic Speech Recognition (ASR) models
- 🔌 Connect to any agent using the [MCP server](https://docling-project.github.io/docling/usage/mcp/)
- 💻 Simple and convenient CLI

### What's new

- 📤 Structured [information extraction][extraction] \[🧪 beta\]
- 📑 New layout model (**Heron**) by default, for faster PDF parsing
- 🔌 [MCP server](https://docling-project.github.io/docling/usage/mcp/) for agentic applications
- 💼 Parsing of XBRL (eXtensible Business Reporting Language) documents for financial reports
- 💬 Parsing of WebVTT (Web Video Text Tracks) files and export to WebVTT format
- 💬 Parsing of LaTeX files
- 📝 Parsing of plain-text files (`.txt`, `.text`) and Markdown supersets (`.qmd`, `.Rmd`)
- 📝 Chart understanding (Barchart, Piechart, LinePlot): converting them into tables, code or adding detailed descriptions

### Coming soon

- 📝 Metadata extraction, including title, authors, references & language
- 📝 Complex chemistry understanding (Molecular structures)

## Quickstart

### 1. Install

```bash
pip install docling
```

> **Note:** Python 3.9 support was dropped in docling version 2.70.0. Please use Python 3.10 or higher.

Works on macOS, Linux and Windows environments. Both x86_64 and arm64 architectures.

More [detailed installation instructions](https://docling-project.github.io/docling/installation/) are available in the docs.

## 2. Convert a document (CLI)

```bash
docling https://arxiv.org/pdf/2206.01062
```

This generates a .md file in the current directory containing structured document content.

You can also use 🥚[GraniteDocling](https://huggingface.co/ibm-granite/granite-docling-258M) and other VLMs via Docling CLI:

```bash
docling --pipeline vlm --vlm-model granite_docling https://arxiv.org/pdf/2206.01062
```

## 3. Python usage (recommended)

```python
from docling.document_converter import DocumentConverter

source = "https://arxiv.org/pdf/2408.09869"  # document per local path or URL
converter = DocumentConverter()
result = converter.convert(source)
print(result.document.export_to_markdown())  # output: "## Docling Technical Report[...]"
```

More advanced [usage](https://docling-project.github.io/docling/usage/) and [configuration](https://docling-project.github.io/docling/installation/) options.

## Documentation

Check out Docling's [documentation](https://docling-project.github.io/docling/), for details on
installation, usage, concepts, recipes, extensions, and more.

## Examples

Go hands-on with our [examples](https://docling-project.github.io/docling/examples/),
demonstrating how to address different application use cases with Docling.

## Integrations

To further accelerate your AI application development, check out Docling's native
[integrations](https://docling-project.github.io/docling/integrations/) with popular frameworks
and tools.

## Get help and support

Please feel free to connect with us using the [discussion section](https://github.com/docling-project/docling/discussions).

## Technical report

For more details on Docling's inner workings, check out the [Docling Technical Report](https://arxiv.org/abs/2408.09869).

## Contributing

Please read [Contributing to Docling](https://github.com/docling-project/docling/blob/main/CONTRIBUTING.md) for details.

## References

If you use Docling in your projects, please consider citing the following:

```bib
@techreport{Docling,
  author = {Deep Search Team},
  month = {8},
  title = {Docling Technical Report},
  url = {https://arxiv.org/abs/2408.09869},
  eprint = {2408.09869},
  doi = {10.48550/arXiv.2408.09869},
  version = {1.0.0},
  year = {2024}
}
```

## License

The Docling codebase is under MIT license.
For individual model usage, please refer to the model licenses found in the original packages.

## LF AI & Data

Docling is hosted as a project in the [LF AI & Data Foundation](https://lfaidata.foundation/projects/).

### IBM ❤️ Open Source AI

The project was started by the AI for knowledge team at IBM Research Zurich.

[supported_formats]: https://docling-project.github.io/docling/usage/supported_formats/
[docling_document]: https://docling-project.github.io/docling/concepts/docling_document/
[integrations]: https://docling-project.github.io/docling/integrations/
[extraction]: https://docling-project.github.io/docling/examples/extraction/
