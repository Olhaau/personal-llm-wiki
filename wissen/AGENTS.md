# Wissen Wiki Rules

## Scope
- This wiki root is `wissen/`.
- Intake starts in `inbox/`, normalized sources live in `raw/public/`, and compiled public knowledge lives in `wiki_public/`.
- Private intake and private normalized sources live in `inbox_intern/` and `raw/intern/`.
- `tools/` and `AGENTS.md` are shared governance and automation for both `wiki_public/` and `wiki_intern/`.

## Required Structure
- `inbox/_index.md`: intake ledger with source, location, and time metadata.
- `inbox_intern/`: private intake folder (contents gitignored).
- `raw/public/_index.md`: registry of normalized markdown sources.
- `raw/intern/`: private normalized sources folder (contents gitignored).
- `wiki_public/_index.md`: master index for public topic subwikis.
- `wiki_public/<topic>/_index.md`: topic-local index.
- `wiki_public/<topic>/concepts/`: extracted concept pages.
- `wiki_public/<topic>/connections/`: extracted relationships and cross-topic links.
- `wiki_public/<topic>/concepts/<topic>.md`: core concept page named exactly after the topic slug.
- `wiki_intern/_index.md`: master index for private topic subwikis.
- `wiki_intern/`: private compiled content section.

## Ingest Rules
- Every intake item is logged in `inbox/_index.md` first.
- Every normalized source in `raw/public/` must include YAML frontmatter with:
  - `title`
  - `token`
  - `source_link`
  - `topic`
  - `tags`
  - `generated_at`
- Every markdown file in `raw/public/`, `wiki_public/`, and `wiki_intern/` must include YAML frontmatter with a `token` field.
- `token` is the token count of the markdown file content and must be refreshed after edits.
- Raw source files should contain only YAML frontmatter and the original article content.
- For Docling-based PDF ingest:
  - Save the source PDF under `inbox/` first.
  - Write extracted output directly into `raw/public/` as `.md` only (no `.json`/`.txt`).
  - Include standard YAML frontmatter (`title`, `source_link`, `topic`, `tags`, `generated_at`).
  - For publicly available web sources, include tags `source/web` and `privacy/public`.
- For web sources with images (only when explicitly requested by the user):
  - Download images into `inbox/images/`.
  - Use stable, source-specific filenames (for example, `<slug>-<n>.<ext>`).
  - Replace image references in `raw/public/*.md` with Obsidian wiki image links: `![[inbox/images/<file>]]`.
  - Keep non-image hyperlinks unchanged.
- Default behavior is text-first ingest for performance: do not download or relink images unless explicitly requested.

## Compile Rules
- Extract concepts and connections from `raw/public/` into `wiki_public/<topic>/`.
- Cross-topic links are allowed in `connections/` pages.
- Every concept/connection page must include explicit Obsidian wiki-link connections to related concepts/pages.
- Keep `wiki_public/_index.md`, `wiki_intern/_index.md`, and each topic `_index.md` up to date.
- Content in `wiki_public/` must never reference `wiki_intern/`.
- Content in `wiki_intern/` may reference `wiki_public/`.

## Lint Operation
- Run lint after compile and before commit whenever `wiki_public/` or `wiki_intern/` changes.
- Structure check:
  - Topic subwikis must live only under `wiki_public/` or `wiki_intern/`.
- Duplicate check:
  - Detect duplicate topic folders with the same slug across locations.
  - Detect duplicate concept/connection pages for the same topic slug.
  - Keep `wiki_public/<topic>/` as canonical for public content and remove or merge non-canonical duplicates.
- Orphan check:
  - Every topic in `wiki_public/` must be linked from `wiki_public/_index.md`.
  - Every concept/connection page must be linked from its topic `_index.md`.
  - Remove stale links or add missing index entries so no orphan pages remain.
- Contradiction check:
  - Compare duplicate pages and conflicting statements in concept/connection pages for the same topic.
  - Resolve by keeping claims grounded in `[[raw/public/...]]` sources and deleting stale conflicting duplicates.

## Prompt Operation
- `prompt-save-chat` stores relevant concepts from the current conversation as an internal raw source.
- Output path must be `raw/intern/chat-<topic>-<timestamp>.md` with UTC timestamp format `YYYYMMDDTHHMMSSZ`.
- Use homogeneous YAML frontmatter with at least: `title`, `token`, `source_link`, `topic`, `tags`, `generated_at`.
- Add tags `source/chat` and `privacy/internal`; include the used model name in frontmatter as `model`.
- Update `raw/intern/_index.md` with the new chat source entry.

## Query Rules
- Query starts at section indexes (`wiki_public/_index.md`, optionally `wiki_intern/_index.md`).
- Then traverse into related topic `_index.md` pages and linked concept/connection pages.
- Query answers must be grounded in relevant wiki pages and include `## References`.
- Default query scope is `wiki_public/`; internal content is optional and must never be referenced from public pages.

## Reference Rules
- All factual outputs include a `## References` section.
- References must point to concrete local paths and/or original URLs.
- In `wiki_public/` and `wiki_intern/` pages, references to normalized sources must use explicit Obsidian wiki-links to raw files, for example `[[raw/public/fdz-terms-of-use.md]]`.
- Claims in `wiki_public/` concepts and connections must be grounded in cited `raw/public/` sources; do not leave uncited factual assertions.

## Workflow Rules
- After updating files in `raw/public/`, `wiki_public/`, or `wiki_intern/`, create a git commit and push to remote on the same day.
