---
title: "Executable Prompt for Lint"
token: 115
---

# Executable Prompt for Lint

```text
Run wiki lint for scope `wiki_public/` and `wiki_intern/` and apply fixes.

Checks and required fixes:
1) Structure: keep only `wiki_public/` and `wiki_intern/` as wiki roots.
2) Duplicates: detect duplicate topic folders and duplicate concept/connection pages by slug; keep canonical files under `wiki_public/<topic>/` for public content.
3) Orphans: ensure every topic appears in `wiki_public/_index.md` and every concept/connection page is linked from its topic `_index.md`.
4) Contradictions: compare duplicate/conflicting statements and keep the version grounded in [[raw/public/...]] references.
5) Update token fields after edits.

Return:
- list of duplicates removed
- list of orphan links/pages fixed
- list of contradiction resolutions with source references
```

## References

- [[raw/public/lewislulu-llm-wiki-skill.md]]
- [[raw/public/nvk-llm-wiki.md]]
