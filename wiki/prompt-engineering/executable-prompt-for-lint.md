---
title: "Executable Prompt for Lint"
token: "120"
---

# Executable Prompt for Lint

```text
Run wiki lint for scope `wiki/` and apply fixes.

Checks and required fixes:
1) Structure: keep only `wiki/` as the wiki root and keep concept pages directly under `wiki/<topic>/`.
2) Duplicates: detect duplicate topic folders and duplicate concept pages by slug; keep canonical files under `wiki/<topic>/`.
3) Orphans: ensure every topic appears in `wiki/_index.md` and every concept page is linked from its topic `_index.md`.
4) Contradictions: compare duplicate/conflicting statements and keep the version grounded in explicit raw references such as `raw/<source>.md`.
5) Update token fields after edits.

Return:
- list of duplicates removed
- list of orphan links/pages fixed
- list of contradiction resolutions with source references
```

## References

- [[lewislulu-llm-wiki-skill.md]]
- [[nvk-llm-wiki.md]]
