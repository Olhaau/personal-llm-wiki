---
title: "Agent Skills Progressive Disclosure"
token: "0"
---

# Agent Skills Progressive Disclosure

## Summary

Progressive disclosure in agent skills loads only lightweight metadata first, then full instructions, and finally deeper referenced resources as needed [[raw/anthropic-equipping-agents-for-the-real-world-with-agent-skills.md]]. This structure helps preserve context-window capacity while keeping complex workflows accessible during execution [[raw/anthropic-equipping-agents-for-the-real-world-with-agent-skills.md]].

## Details

The documented levels are: (1) `name` and `description` preloaded in the system prompt, (2) full `SKILL.md` loaded when a task appears relevant, and (3) linked files loaded selectively for subcases such as form handling [[raw/anthropic-equipping-agents-for-the-real-world-with-agent-skills.md]]. Skills can also include executable scripts so deterministic steps run as code rather than token-expensive generation, improving reliability for procedural operations [[raw/anthropic-equipping-agents-for-the-real-world-with-agent-skills.md]].

## Connected Concepts

- [[prompt-engineering.md]] - Progressive disclosure operationalizes core prompt-engineering goals for relevance, efficiency, and maintainability.
- [[wiki/docling/docling-agent-skill-workflow.md]] - The Docling skill bundle follows this pattern by separating high-level instructions from evaluator scripts and pipeline details.

## References

- [[raw/anthropic-equipping-agents-for-the-real-world-with-agent-skills.md]]
