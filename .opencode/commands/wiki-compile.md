---
description: LLM Wiki compile raw into topic subwikis
---
Use the `llm-wiki-skill` and run the `compile` operation for `wiki/`.

Goal:
- Read `raw/` and group by `topic`.
- Build/update concept pages directly under `wiki/<topic>/`.
- Do not create `concepts/` or `connections/` subfolders; relationship pages are regular concepts.
- Preserve cross-topic links via concept page wiki-links.
- Rebuild each topic `index.md` and the master `wiki/index.md`.

Scope input: $ARGUMENTS

If `$ARGUMENTS` is empty, compile all topics.

Return:
- Topics compiled
- Files created/updated
- Cross-topic links represented in concept pages
- `## References` with raw/wiki paths used
