# Wissen Wiki Rules

## Scope
- Intake starts in `inbox/`, normalized sources live in `raw/`, and compiled knowledge lives in `wiki/`.
- This is a single public wiki intended for open sharing; no separate internal/private structure is used.
- `tools/` and `AGENTS.md` define shared governance and automation for this single wiki.

## Required Structure
- `inbox/_index.md`: intake ledger with source, location, and time metadata.
- `raw/_index.md`: registry of normalized markdown sources.
- All normalized source markdown files live directly in `raw/` (no nested topic/privacy subfolders).
- `wiki/_index.md`: master index for topic subwikis.
- `wiki/<topic>/_index.md`: topic-local index.
- `wiki/<topic>/`: concept pages live directly in topic root (no `concepts/` or `connections/` subfolders).
- `wiki/<topic>/<topic>.md`: core concept page named exactly after the topic slug.

## Ingest Rules
- Every intake item is logged in `inbox/_index.md` first.
- For Docling-based web/PDF ingest workflows, use the `docling-document-intelligence` skill at `.opencode/skills/docling-document-intelligence/SKILL.md` as the default operating guide.
- Every normalized source in `raw/` must include YAML frontmatter with:
  - `title`
  - `token`
  - `source_link`
  - `topic`
  - `tags`
  - `generated_at`
- Every markdown file in `raw/` and `wiki/` must include YAML frontmatter with a `token` field.
- `token` is the token count of the markdown file content and must be refreshed after edits.
- Raw source files should contain only YAML frontmatter and the original article content.
- For Docling-based PDF ingest:
  - Save the source PDF under `inbox/` first.
  - Write extracted output directly into `raw/` as `.md` only (no `.json`/`.txt`).
  - Include standard YAML frontmatter (`title`, `source_link`, `topic`, `tags`, `generated_at`).
  - For publicly available web sources, include tags `source/web` and `privacy/public`.
- For web sources with images (only when explicitly requested by the user):
  - Download images into `inbox/images/`.
  - Use stable, source-specific filenames (for example, `<slug>-<n>.<ext>`).
  - Replace image references in `raw/*.md` with Obsidian wiki image links: `![[inbox/images/<file>]]`.
  - Keep non-image hyperlinks unchanged.
- Default behavior is text-first ingest for performance: do not download or relink images unless explicitly requested.

## Compile Rules
- Extract concepts from `raw/` into `wiki/<topic>/`; relationship pages are also treated as concepts.
- Cross-topic links are allowed between any concept pages.
- Every concept page must include explicit Obsidian wiki-link connections to related concept pages.
- Every concept page must include these sections:
  - `## Summary` (2-3 sentences)
  - `## Details` (specifics such as code examples, formulas, or detailed explanation)
  - `## Connected Concepts` (one bullet per link with a one-sentence relation description)
  - `## References`
- Avoid self-referential phrasing such as "this concept" or "topic-level concept" in concept page prose.
- Keep `wiki/_index.md` and each topic `_index.md` up to date.

## Lint Operation
- Run lint after compile and before commit whenever `wiki/` changes.
- Structure check:
  - Topic subwikis must live only under `wiki/`.
- Duplicate check:
  - Detect duplicate topic folders with the same slug within `wiki/`.
  - Detect duplicate concept pages for the same topic slug.
  - Keep a single canonical `wiki/<topic>/` location and remove or merge duplicates.
- Orphan check:
  - Every topic in `wiki/` must be linked from `wiki/_index.md`.
  - Every concept page must be linked from its topic `_index.md`.
  - Remove stale links or add missing index entries so no orphan pages remain.
- Contradiction check:
  - Compare duplicate pages and conflicting statements in concept pages for the same topic.
  - Resolve by keeping claims grounded in `[[raw/...]]` sources and deleting stale conflicting duplicates.

## Prompt Operation
- `prompt-save-chat` stores relevant concepts from the current conversation as a raw source.
- Output path must be `raw/chat-<topic>-<timestamp>.md` with UTC timestamp format `YYYYMMDDTHHMMSSZ`.
- Use homogeneous YAML frontmatter with at least: `title`, `token`, `source_link`, `topic`, `tags`, `generated_at`.
- Add tags `source/chat` and `privacy/public`; include the used model name in frontmatter as `model`.
- Update `raw/_index.md` with the new chat source entry.

## Query Rules
- Query starts at `wiki/_index.md`.
- Then traverse into related topic `_index.md` pages and linked concept pages.
- Query answers must be grounded in relevant wiki pages and include `## References`.
- Default query scope is the single `wiki/` tree.

## Reference Rules
- All factual outputs include a `## References` section.
- References must point to concrete local paths and/or original URLs.
- In `wiki/` pages, references to normalized sources must use explicit Obsidian wiki-links to raw files, for example `[[raw/fdz-terms-of-use.md]]`.
- Claims in `wiki/` concept pages must be grounded in cited `raw/` sources; do not leave uncited factual assertions.
- Cite sources directly in the prose where claims are made (for example `[[raw/file.md]]`), not only in the final references section.

## Workflow Rules
- After updating files in `raw/` or `wiki/`, create a git commit and push to remote on the same day.
