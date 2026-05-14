---
name: docling-document-intelligence
description: Use when converting PDFs and documents to Markdown/JSON with Docling, evaluating conversion quality, choosing standard vs VLM pipelines, or setting OCR and chunking options.
---

# Docling Document Intelligence

Use this skill for document conversion and evaluation workflows based on Docling.

## When to use

- Convert files or URLs to Markdown or JSON with `docling` CLI.
- Decide between standard and VLM pipelines.
- Run an evaluation pass after conversion.
- Troubleshoot OCR-heavy or layout-sensitive documents.

## Quick workflow

1. Install toolchain.
2. Convert to target format.
3. Evaluate quality.
4. Refine pipeline and rerun.

## Commands

```bash
pip install docling docling-core

# Markdown conversion
docling <input-path-or-url> --output <output-dir>

# JSON conversion
docling <input-path-or-url> --to json --output <output-dir>
```

## Evaluation loop

Use a convert -> evaluate -> refine loop:

- Convert to JSON (and optionally Markdown).
- Run a quality evaluator script if available.
- Adjust pipeline/OCR settings and rerun until output quality is acceptable.

Example evaluator invocation from the Docling agent skill docs:

```bash
python3 scripts/docling-evaluate.py <output.json> --markdown <output.md>
```

## Pipeline selection

- Prefer standard pipeline for common digital text PDFs.
- Prefer VLM pipeline for visually complex layouts, embedded diagrams, or when baseline extraction quality is poor.
- Prefer explicit OCR configuration when scans or mixed-language pages are involved.

## References

- https://docling-project.github.io/docling/examples/agent_skill/docling-document-intelligence/
- https://docling-project.github.io/docling/reference/cli/
- https://docling-project.github.io/docling/usage/vision_models/
