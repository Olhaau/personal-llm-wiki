---
description: LLM Wiki ingest from inbox to raw
---
Use the `llm-wiki-skill` and run the `ingest` operation for this repository.

Goal:
- Ingest URL inputs into `raw/` using `tools/ingest_web.py`.
- Update `inbox/_index.md` and `raw/_index.md` for every processed item.
- Ensure each raw file includes required YAML keys: `title`, `token`, `source_link`, `topic`, `tags`, `generated_at`.

User input: $ARGUMENTS

Behavior:
- If `$ARGUMENTS` contains one or more URLs, ingest each URL with `tools/ingest_web.py`.
- If `$ARGUMENTS` is empty, process pending `web` intake entries from `inbox/_index.md`.
- Default to text-first ingest (do not download images unless explicitly requested).
- Write output Markdown directly to `raw/*.md`.
- Use stable slugs for output names and avoid overwriting unrelated files.

Command template:

```bash
python3 tools/ingest_web.py "<url>" --output "raw/<slug>.md"
```

After each ingest:
- Ensure frontmatter is present and includes `token`.
- Add or update matching rows in `inbox/_index.md` and `raw/_index.md`.
- Keep tags consistent for public web sources (at minimum `source/web` and `privacy/public`).

Return:
- Processed items
- Created raw files
- Any skipped items and why
- `## References` with concrete file paths and source URLs
