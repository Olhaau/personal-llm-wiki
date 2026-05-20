---
title: "Continue cn Workflows"
token: "0"
topic: "prompt-engineering"
generated_at: "2026-05-15T12:53:33Z"
---

## Summary

Continue CLI supports prompt-driven workflows in both interactive TUI mode and headless Continuous AI mode [[raw/continue-prompts-deep-dive.md]]. Prompt references passed with `--prompt` and optional `-p` flags enable reusable execution for recurring engineering tasks [[raw/continue-prompts-deep-dive.md]].

## Details

In TUI mode, `cn --prompt ...` starts a session with a selected prompt and allows extra task instructions to be appended inline [[raw/continue-prompts-deep-dive.md]]. In headless mode, `cn -p --prompt ...` starts an autonomous workflow that checks out the current branch, explores code, and drafts an implementation for review [[raw/continue-prompts-deep-dive.md]].

The documented examples focus on generating Supabase functions, but the same execution pattern applies to any standardized prompt package where repeated requirements and contextual interpretation are needed [[raw/continue-prompts-deep-dive.md]].

## Connected Concepts

- [[wiki/prompt-engineering/continue-prompts.md]] - Prompt definitions provide the reusable instructions consumed by `cn` workflows.
- [[wiki/prompt-engineering/continue-prompts-to-fabric-patterns.md]] - Prompt-driven CLI execution mirrors Fabric pattern execution in cross-tool workflows.
- [[wiki/ai-tooling/fabric.md]] - Fabric offers a parallel CLI model for reusable task execution with prompt-like pattern units.

## References

- [[raw/continue-prompts-deep-dive.md]]
- [[raw/fabric-readme.md]]
- https://docs.continue.dev/customize/deep-dives/prompts
- https://github.com/danielmiessler/fabric
