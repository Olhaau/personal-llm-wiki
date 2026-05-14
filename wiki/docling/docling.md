---
title: "Docling"
token: "0"
---

# Docling

## Summary

Docling provides document-conversion workflows across multiple example groups, including conversion, extraction, chunking, and RAG integrations [[raw/docling-examples.md]]. The examples page highlights practical end-to-end patterns rather than only API fragments, making it useful as an implementation catalog [[raw/docling-examples.md]].

## Details

The examples collection spans standard conversion, multimodal pipelines, GPU-optimized variants, and integrations with retrieval stacks such as LangChain, Haystack, and LlamaIndex [[raw/docling-examples.md]]. It also points to an agent-skill workflow that packages instructions and helper scripts for assistants, enabling consistent convert -> evaluate -> refine cycles with the `docling` CLI and evaluator tooling [[raw/docling-agent-skill-docling-document-intelligence.md]].

## Connected Concepts

- [[docling-agent-skill-workflow.md]] - The agent-skill page defines the operational loop and file structure used to apply Docling in assistant-driven workflows.
- [[wiki/prompt-engineering/agent-skills-progressive-disclosure.md]] - Agent-skill triggering and layered context loading patterns align with how Docling skill bundles should stay lean and modular.

## References

- [[raw/docling-examples.md]]
- [[raw/docling-agent-skill-docling-document-intelligence.md]]
