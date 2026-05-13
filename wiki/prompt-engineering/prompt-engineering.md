---
title: "prompt-engineering"
token: "59"
---

# prompt-engineering

## Summary

Prompt engineering here means operation-specific prompts that an agent can execute directly with minimal interpretation overhead [[raw/lewislulu-llm-wiki-skill.md]]. The prompt set mirrors recurring operations such as ingest, compile, lint, query, and chat capture to keep workflows reproducible [[raw/karpathy-llm-wiki-gist.md]]. This structure turns process expectations into executable text artifacts that can be versioned and refined [[raw/nvk-llm-wiki.md]].

## Details

A practical prompt pattern includes explicit inputs, ordered steps, output constraints, and reference requirements so generated updates remain auditable [[raw/opencode-skills-docs.md]]. Operation-specific prompts reduce ambiguity and improve consistency when maintaining long-lived markdown knowledge bases [[raw/karpathy-llm-wiki-gist.md]].

## Connected Concepts

- [[Executable Prompt for Ingest]] - Ingest prompts standardize source normalization and index updates.
- [[Executable Prompt for Compile]] - Compile prompts define the rules for concept-page generation and linking.
- [[Executable Prompt for Lint]] - Lint prompts enforce structural quality and consistency checks.
- [[Executable Prompt for Query]] - Query prompts constrain answers to sourced wiki evidence.
- [[Executable Prompt for Save Chat]] - Save-chat prompts persist reusable conversation knowledge into `raw/`.
- [[llm-wiki]] - Prompt design operationalizes the maintenance loop used by the wiki model.

## References

- [[raw/karpathy-llm-wiki-gist.md]]
- [[raw/lewislulu-llm-wiki-skill.md]]
- [[raw/nvk-llm-wiki.md]]
