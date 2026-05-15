---
title: "Docling Quickstart"
token: "148"
---

# Docling Quickstart

## Summary

The documented quickstart demonstrates a minimal Docling CLI workflow: install packages, convert a source, and optionally evaluate output quality [[raw/docling-agent-skill-docling-document-intelligence.md]]. This gives a practical first run that produces either Markdown or JSON artifacts for further processing [[raw/docling-agent-skill-docling-document-intelligence.md]].

## Details

A simple quickstart snippet from the source:

```bash
pip install docling docling-core
docling https://arxiv.org/pdf/2408.09869 --output /tmp/
```

The same quick-start block also includes JSON conversion (`--to json`) and an optional evaluator command for quality feedback loops, with `--pipeline vlm` available for vision-model pipelines when needed [[raw/docling-agent-skill-docling-document-intelligence.md]].

## Connected Concepts

- [[docling-installation.md]] - Installation prepares the environment required by quickstart conversion commands.
- [[docling-agent-skill-workflow.md]] - The workflow expands the quickstart into a repeatable convert -> evaluate -> refine process.
- [[docling.md]] - The topic page links quickstart usage to the broader Docling examples ecosystem.

## References

- [[raw/docling-agent-skill-docling-document-intelligence.md]]
