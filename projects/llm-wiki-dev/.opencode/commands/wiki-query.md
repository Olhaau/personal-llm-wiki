---
description: LLM Wiki query with mandatory references
---
Use the `llm-wiki-skill` and run the `query` operation against `wissen/wiki/`.

Question: $ARGUMENTS

Behavior:
- Start from `wissen/wiki/index.md`.
- Prefer topic-local concepts and connections first.
- Traverse cross-topic connection links if needed.
- If evidence is insufficient, state the gap and suggest what to ingest.

Return:
- A concise answer
- `## References` section (mandatory) with exact paths/URLs used
