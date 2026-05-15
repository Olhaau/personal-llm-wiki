---
title: "Docling"
token: "223"
---

# Docling

## Summary

Docling is a document-intelligence toolkit used to convert files into structured outputs and to build downstream workflows such as extraction, chunking, and RAG pipelines [[raw/docling-examples.md]]. The examples and agent-skill materials focus on practical command-line workflows that can be reused directly in assistant-driven tasks [[raw/docling-agent-skill-docling-document-intelligence.md]].

## Details

The topic covers installation basics (`pip install docling docling-core`) and a minimal CLI path for converting sources to Markdown or JSON [[raw/docling-agent-skill-docling-document-intelligence.md]]. It also includes references for broader example groups such as conversion variants, information extraction, chunking, and framework integrations across LangChain, LlamaIndex, and Haystack [[raw/docling-examples.md]].

Articles in this topic:
- [[docling-installation.md]] - Installation-first setup guidance for getting Docling CLI ready.
- [[docling-quickstart.md]] - Minimal snippet-driven conversion flow for first successful runs.
- [[docling-agent-skill-workflow.md]] - Structured assistant skill bundle with convert -> evaluate -> refine loop.

## Connected Concepts

- [[docling-installation.md]] - Installation choices determine which CLI and evaluator commands are available in local workflows.
- [[docling-quickstart.md]] - Quickstart usage applies the installed CLI in a minimal end-to-end conversion snippet.
- [[docling-agent-skill-workflow.md]] - The agent-skill page defines the operational loop and file structure used to apply Docling in assistant-driven workflows.
- [[wiki/prompt-engineering/agent-skills-progressive-disclosure.md]] - Agent-skill triggering and layered context loading patterns align with how Docling skill bundles should stay lean and modular.

## References

- [[raw/docling-examples.md]]
- [[raw/docling-agent-skill-docling-document-intelligence.md]]
