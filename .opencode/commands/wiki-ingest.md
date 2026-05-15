---
description: LLM Wiki ingest from inbox to raw
---
Use the `llm-wiki-skill` and run the `ingest` operation for the wiki rooted at `wissen/`.

Goal:
- Normalize intake items from `wissen/inbox/` into markdown sources in `wissen/raw/`.
- Update `wissen/inbox/index.md` and `wissen/raw/index.md`.
- Ensure each raw file includes required YAML keys: `title`, `source_link`, `topic`, `tags`, `generated_at`.

User input: $ARGUMENTS

If `$ARGUMENTS` is empty, process pending entries from `wissen/inbox/weburl-index.md`.

For `.xlsx` intake items, default to the Python extractor:

```bash
python .opencode/skills/llm-wiki-skill/xlsx_to_json.py inbox/<file>.xlsx raw/<file>.json
```

Capture all workbook-relevant data in JSON (metadata, sheets, ranges, formulas, and populated cells).

Return:
- Processed items
- Created raw files
- Any skipped items and why
- `## References` with concrete file paths and source URLs
