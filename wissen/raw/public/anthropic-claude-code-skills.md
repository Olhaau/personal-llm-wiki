---
title: "Anthropic Claude Code Skills"
token: 217
source_link: "https://docs.anthropic.com/en/docs/claude-code/skills"
topic: "prompt-engeneering"
tags: [ingest, web, prompt-engeneering, anthropic, skills, source/web, privacy/public, fetched]
generated_at: "2026-05-12T06:22:13Z"
---

# Extend Claude with skills

Skills extend what Claude can do. Create a `SKILL.md` file with instructions, and Claude adds it to its toolkit. Claude uses skills when relevant, or a user can invoke one directly with `/skill-name`.

## Core concepts from the source

- Skills are instruction artifacts with YAML frontmatter plus markdown body.
- Skills can be personal, project, enterprise, or plugin scoped.
- Invocation can be controlled with frontmatter such as `disable-model-invocation` and `user-invocable`.
- Skills support argument substitution (`$ARGUMENTS`, `$0`, named arguments).
- Skills support dynamic context injection with shell blocks and command interpolation.
- Skills can run in a subagent context using `context: fork` and optional `agent` selection.
- Tool behavior can be constrained via `allowed-tools` and permission rules.

## Frontmatter examples from the source

```yaml
---
name: my-skill
description: What this skill does
disable-model-invocation: true
allowed-tools: Read Grep
---
```

## Selected source excerpt

"Create a skill when you keep pasting the same instructions, checklist, or multi-step procedure into chat... Unlike CLAUDE.md content, a skill's body loads only when it's used."

"Both you and Claude can pass arguments when invoking a skill... `$ARGUMENTS` placeholder gets replaced with whatever follows the skill name."

"Add `context: fork` to your frontmatter when you want a skill to run in isolation."

## References

- https://docs.anthropic.com/en/docs/claude-code/skills
