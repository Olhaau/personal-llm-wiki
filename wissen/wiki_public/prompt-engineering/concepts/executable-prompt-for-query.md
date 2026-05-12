---
title: "Executable Prompt for Query"
token: 77
---

# Executable Prompt for Query

```text
Answer the question using this wiki only: <question>

Workflow:
1) Start at `wiki_public/_index.md` (and optionally `wiki_intern/_index.md` for internal scope).
2) Traverse relevant topic _index.md pages and linked concept/connection pages.
3) Synthesize only grounded claims.
4) Include a final section named exactly "## References" with concrete wiki paths and/or source URLs.
5) If evidence is missing, state the gap and propose a targeted ingest item.
```

## References

- [[raw/public/karpathy-llm-wiki-gist.md]]
- [[raw/public/opencode-skills-docs.md]]
