---
title: "Executable Prompt for Query"
token: "71"
---

# Executable Prompt for Query

```text
Answer the question using this wiki only: <question>

Workflow:
1) Start at `wiki/_index.md`.
2) Traverse relevant topic `_index.md` pages and linked concept pages.
3) Synthesize only grounded claims.
4) Include a final section named exactly "## References" with concrete wiki paths and/or source URLs.
5) If evidence is missing, state the gap and propose a targeted ingest item.
```

## References

- [[karpathy-llm-wiki-gist.md]]
- [[opencode-skills-docs.md]]
