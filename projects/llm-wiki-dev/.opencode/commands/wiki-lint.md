---
description: LLM Wiki lint structure and links
---
Use the `llm-wiki-skill` and run the `lint` operation for `wissen/`.

Checks:
- `wissen/inbox/index.md` coverage for intake items
- `wissen/raw/index.md` coverage + required YAML keys in raw files
- Topic subwiki shape: `concepts/`, `connections/`, `index.md`
- Master index coverage in `wissen/wiki/index.md`
- Dead links and orphan pages

Focus: $ARGUMENTS

If `$ARGUMENTS` is empty, run full lint across `wissen/`.

Return:
- Issues found
- Fixes applied
- Remaining manual actions
- `## References` with paths checked
