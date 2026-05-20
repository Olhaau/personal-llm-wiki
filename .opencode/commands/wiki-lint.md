---
description: LLM Wiki lint structure and links
---
Use the `llm-wiki-skill` and run the `lint` operation for `wiki/`.

Checks:
- `inbox/_index.md` coverage for intake items
- `raw/_index.md` coverage + required YAML keys in raw files
- Topic subwiki shape: concept pages directly in `wiki/<topic>/` with topic `index.md`
- No `concepts/` or `connections/` subfolders in topic directories
- Master index coverage in `wiki/index.md`
- Dead links and orphan pages

Focus: $ARGUMENTS

If `$ARGUMENTS` is empty, run full lint across `wiki/`.

Return:
- Issues found
- Fixes applied
- Remaining manual actions
- `## References` with paths checked
