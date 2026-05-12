---
title: "Spec Kit Supported AI Coding Agent Integrations"
token: 128
source_link: "https://github.github.io/spec-kit/reference/integrations.html"
topic: "prompt-engeneering"
tags: [ingest, web, prompt-engeneering, github, spec-kit, integrations, source/web, privacy/public, fetched]
generated_at: "2026-05-12T06:22:13Z"
---

# Supported AI Coding Agent Integrations

The Specify CLI supports a wide range of AI coding agents. Running `specify init` sets up command files, context rules, and directory structures for the chosen agent.

## Selected source content

- Claude Code integration key: `claude` (skills-based integration; installs skills in `.claude/skills`).
- Codex CLI integration key: `codex` (skills-based integration; installs skills into `.agents/skills` and invokes them as `$speckit-<command>`).
- Generic integration supports custom command directory via `--integration-options="--commands-dir <path>"`.

## Selected CLI operations from the source

```bash
specify integration list
specify integration install <key>
specify integration uninstall [<key>]
specify integration switch <key>
specify integration use <key>
specify integration upgrade [<key>]
```

The documentation also describes multi-install safety, default integration behavior, and rollback behavior for partial installation failures.

## References

- https://github.github.io/spec-kit/reference/integrations.html
