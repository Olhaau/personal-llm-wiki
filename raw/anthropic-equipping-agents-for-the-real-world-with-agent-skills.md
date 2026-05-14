---
title: "Equipping agents for the real world with Agent Skills"
token: "364"
source_link: "https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills"
topic: "prompt-engineering"
tags: ["source/web", "privacy/public", "ingest", "agent-skills", "anthropic"]
generated_at: "2026-05-13T23:51:08Z"
---

# Equipping agents for the real world with Agent Skills

Published Oct 16, 2025.

Anthropic presents Agent Skills as organized folders of instructions, scripts, and resources that agents can discover and load dynamically. The article frames skills as a way to package procedural knowledge and organizational context so general-purpose agents can perform specialized work more reliably.

## Core ideas

- A skill is a directory containing `SKILL.md`.
- `SKILL.md` begins with YAML frontmatter including required metadata: `name` and `description`.
- Agents preload only skill metadata first, then load full `SKILL.md` when relevant.
- Skill folders can include additional files (for example `reference.md`, `forms.md`) that are loaded on demand.
- Skills can include scripts that agents execute, enabling deterministic operations and reducing token-heavy reasoning for procedural tasks.

## Progressive disclosure model

The article describes progressive disclosure in levels:

1. Metadata (`name`, `description`) loaded at startup.
2. Full `SKILL.md` loaded only when a task seems relevant.
3. Linked files and additional resources loaded only as needed.

This design keeps baseline context small while allowing large, detailed skill bundles.

## Context-window and execution behavior

The article outlines a sequence where an agent starts with the system prompt plus skill metadata, then reads `SKILL.md`, optionally reads referenced files, and proceeds with task execution with the additional guidance.

For code execution, bundled scripts can be run without loading all script contents or all source documents into context, supporting repeatable and deterministic workflows.

## Authoring guidance

- Start from evaluation of real tasks and observed gaps.
- Split large `SKILL.md` files into referenced subfiles when context grows.
- Optimize skill `name` and `description`, because they drive skill triggering.
- Iterate based on observed agent behavior and capture successful patterns.

## Security guidance

The article recommends installing skills from trusted sources. For less-trusted sources, audit bundled files, dependencies, scripts, and instructions that may access external networks or cause data exfiltration.

## Related references from the article

- Agent Skills standard: https://agentskills.io/
- Anthropic Skills announcement: https://www.anthropic.com/news/skills
- Claude Skills docs: https://docs.claude.com/en/docs/agents-and-tools/agent-skills/overview
- Skills cookbook: https://github.com/anthropics/claude-cookbooks/tree/main/skills
