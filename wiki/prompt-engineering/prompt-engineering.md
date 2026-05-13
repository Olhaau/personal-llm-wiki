---
title: "prompt-engineering"
token: "175"
---

# prompt-engineering

## Summary

Prompt engineering here means operation-specific prompts that an agent can execute directly with minimal interpretation overhead [[lewislulu-llm-wiki-skill.md]]. The prompt set mirrors recurring operations such as ingest, compile, lint, query, and chat capture to keep workflows reproducible [[karpathy-llm-wiki-gist.md]]. This structure turns process expectations into executable text artifacts that can be versioned and refined [[nvk-llm-wiki.md]].

## Details

A practical prompt pattern includes explicit inputs, ordered steps, output constraints, and reference requirements so generated updates remain auditable [[opencode-skills-docs.md]]. Operation-specific prompts reduce ambiguity and improve consistency when maintaining long-lived markdown knowledge bases [[karpathy-llm-wiki-gist.md]].

## Connected Concepts

- [[executable-prompt-for-ingest.md]] - Ingest prompts standardize source normalization and index updates.
- [[executable-prompt-for-compile.md]] - Compile prompts define the rules for concept-page generation and linking.
- [[executable-prompt-for-lint.md]] - Lint prompts enforce structural quality and consistency checks.
- [[executable-prompt-for-query.md]] - Query prompts constrain answers to sourced wiki evidence.
- [[executable-prompt-for-save-chat.md]] - Save-chat prompts persist reusable conversation knowledge into `raw/`.
- [[llm-wiki.md]] - Prompt design operationalizes the maintenance loop used by the wiki model.

## References

- [[karpathy-llm-wiki-gist.md]]
- [[lewislulu-llm-wiki-skill.md]]
- [[nvk-llm-wiki.md]]
