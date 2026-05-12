---
description: LLM Wiki compile raw into topic subwikis
---
Use the `llm-wiki-skill` and run the `compile` operation for `wissen/`.

Goal:
- Read `wissen/raw/` and group by `topic`.
- Build/update `wissen/wiki/<topic>/concepts/` and `wissen/wiki/<topic>/connections/`.
- Allow and preserve cross-topic connections.
- Rebuild each topic `index.md` and the master `wissen/wiki/index.md`.

Scope input: $ARGUMENTS

If `$ARGUMENTS` is empty, compile all topics.

Return:
- Topics compiled
- Files created/updated
- Connection pages linking across topics
- `## References` with raw/wiki paths used
