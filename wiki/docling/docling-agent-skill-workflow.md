---
title: "Docling Agent Skill Workflow"
token: "169"
---

# Docling Agent Skill Workflow

## Summary

The Docling agent skill packages conversion guidance, pipeline references, and evaluation scripts inside a skill folder for assistants [[raw/docling-agent-skill-docling-document-intelligence.md]]. Its purpose is to close the gap between raw conversion and measurable quality by adding an explicit evaluation loop [[raw/docling-agent-skill-docling-document-intelligence.md]].

## Details

The documented bundle includes `SKILL.md`, `pipelines.md`, `EXAMPLE.md`, an optional improvement log, and `scripts/docling-evaluate.py` with requirements [[raw/docling-agent-skill-docling-document-intelligence.md]]. The quick-start flow installs `docling` and `docling-core`, converts documents to Markdown or JSON with the CLI, then evaluates output quality and refines settings such as pipeline choice (for example VLM) when needed [[raw/docling-agent-skill-docling-document-intelligence.md]].

## Connected Concepts

- [[docling.md]] - The core Docling page positions the agent skill as one of the main practical workflows inside the examples ecosystem.
- [[wiki/prompt-engineering/agent-skills-progressive-disclosure.md]] - The skill's modular file structure maps directly to progressive-disclosure guidance for scalable agent context loading.
- [[wiki/ai-tooling/ai-tooling.md]] - Fabric-style CLI setup patterns provide a practical runtime layer for executing document workflows.

## References

- [[raw/docling-agent-skill-docling-document-intelligence.md]]
