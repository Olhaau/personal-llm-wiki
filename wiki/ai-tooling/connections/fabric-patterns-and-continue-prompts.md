---
title: "Fabric Patterns and Continue Prompts"
token: "0"
topic: "ai-tooling"
generated_at: "2026-05-15T12:53:33Z"
---

## Summary

Fabric and Continue both center workflow reuse on text instructions, but they package and invoke those instructions differently: Fabric uses task patterns while Continue uses prompt files and slash commands [[raw/fabric-readme.md]] [[raw/continue-prompts-deep-dive.md]]. The overlap supports cross-tool design where prompt intent can be shared while execution surfaces differ [[raw/fabric-readme.md]] [[raw/continue-prompts-deep-dive.md]].

## Details

Fabric describes reusable Markdown patterns for solving real tasks through a CLI, including piping content into pattern runs and URL-based analyses [[raw/fabric-readme.md]]. Continue describes reusable Markdown prompts where `invokable: true` exposes slash commands and supports direct CLI invocations with `cn --prompt` and headless execution using `cn -p --prompt` [[raw/continue-prompts-deep-dive.md]].

Both approaches encode repeatable AI behavior into portable prompt assets. A practical bridge is to align naming, expected inputs, and output checks so teams can mirror task intent between `fabric --pattern ...` and Continue prompt invocations [[raw/fabric-readme.md]] [[raw/continue-prompts-deep-dive.md]].

## Connected Concepts

- [[wiki/ai-tooling/concepts/fabric.md]] - Fabric defines the pattern-centric side of reusable AI task execution.
- [[wiki/prompt-engineering/concepts/continue-prompts.md]] - Continue prompt files define metadata and invokable command behavior.
- [[wiki/prompt-engineering/concepts/continue-cn-workflows.md]] - Continue CLI workflows show how prompts are run in TUI and headless modes.

## References

- [[raw/fabric-readme.md]]
- [[raw/continue-prompts-deep-dive.md]]
- https://github.com/danielmiessler/fabric
- https://docs.continue.dev/customize/deep-dives/prompts
