---
title: "Executable Prompt for Anthropic Skills"
token: "86"
---

# Executable Prompt for Anthropic Skills

```text
Create or update a Claude Code skill for <skill-name>.

Requirements:
1) Create folder `.claude/skills/<skill-name>/` and `SKILL.md`.
2) Add YAML frontmatter with `name` and `description`.
3) Add explicit, executable instructions in markdown.
4) If user-only invocation is required, set `disable-model-invocation: true`.
5) If arguments are needed, support `$ARGUMENTS` or named arguments.
6) Keep the skill body concise and move long references to supporting files.
7) Return created paths and one direct invocation example: `/<skill-name> <args>`.
```

## References

- [[raw/anthropic-claude-code-skills.md]]
