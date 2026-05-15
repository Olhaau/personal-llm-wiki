---
title: "Continue Prompts"
token: "0"
topic: "prompt-engineering"
generated_at: "2026-05-15T12:53:33Z"
---

## Summary

Continue prompts are Markdown assets used to initiate work in Agent, Plan, and Chat modes [[raw/continue-prompts-deep-dive.md]]. A prompt becomes a slash command when its frontmatter sets `invokable: true`, which makes it callable from the IDE extensions and CLI [[raw/continue-prompts-deep-dive.md]].

## Details

Prompt definitions include metadata such as `name` and `description`, and can embed detailed execution guidance for repeated tasks, as shown in the Supabase function-generation example [[raw/continue-prompts-deep-dive.md]]. Continue also supports prompt reuse from references like `uses: supabase/create-functions` in configuration [[raw/continue-prompts-deep-dive.md]].

The model treats prompts as user messages, which makes them suitable for operational playbooks where instructions must be repeatedly combined with local context from a branch or selected code [[raw/continue-prompts-deep-dive.md]].

## Connected Concepts

- [[wiki/prompt-engineering/concepts/continue-cn-workflows.md]] - CLI execution modes consume prompt definitions for interactive and headless runs.
- [[wiki/prompt-engineering/connections/continue-prompts-to-fabric-patterns.md]] - Prompt reuse strategy maps to Fabric's reusable pattern strategy across topics.

## References

- [[raw/continue-prompts-deep-dive.md]]
- https://docs.continue.dev/customize/deep-dives/prompts
