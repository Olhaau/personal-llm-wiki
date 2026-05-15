---
title: "Prompt Engineering"
token: "189"
---

# Prompt Engineering

## Summary

Agent-skill prompting extends general agents with reusable procedural knowledge by packaging instructions, scripts, and references into discoverable skill folders [[raw/anthropic-equipping-agents-for-the-real-world-with-agent-skills.md]]. Effective prompt engineering in this model focuses on trigger quality (`name` and `description`) and on-demand context expansion instead of dumping all instructions up front [[raw/anthropic-equipping-agents-for-the-real-world-with-agent-skills.md]].

## Details

The article emphasizes iterative skill development: evaluate real tasks, identify capability gaps, then encode targeted guidance and code into skill bundles [[raw/anthropic-equipping-agents-for-the-real-world-with-agent-skills.md]]. It also recommends separating mutually exclusive or rarely co-needed guidance into referenced files to reduce token usage and improve precision, while still allowing deeper context when required [[raw/anthropic-equipping-agents-for-the-real-world-with-agent-skills.md]].

Articles in this topic:
- [[agent-skills-progressive-disclosure.md]] - Shows how to keep prompts lean while enabling deeper context when the task requires it.

## Connected Concepts

- [[agent-skills-progressive-disclosure.md]] - Progressive disclosure is the mechanism that keeps skill prompts scalable while preserving depth.
- [[wiki/docling/docling-agent-skill-workflow.md]] - The Docling skill is a concrete example of prompt-engineered procedural packaging for conversion and evaluation tasks.
- [[wiki/ai-tooling/fabric-pattern-workflow-bridge.md]] - Fabric's CLI and pattern runtime provide an execution surface for modular prompt-engineering practices.

## References

- [[raw/anthropic-equipping-agents-for-the-real-world-with-agent-skills.md]]
