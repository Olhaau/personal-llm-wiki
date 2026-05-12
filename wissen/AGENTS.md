# Wissen Wiki Rules

## Scope
- This wiki root is `wissen/`.
- Intake starts in `inbox/`, normalized sources live in `raw/public/`, and compiled public knowledge lives in `wiki/public/`.
- Private intake and private normalized sources live in `inbox_intern/` and `raw/intern/`.

## Required Structure
- `inbox/_index.md`: intake ledger with source, location, and time metadata.
- `inbox_intern/`: private intake folder (contents gitignored).
- `raw/public/_index.md`: registry of normalized markdown sources.
- `raw/intern/`: private normalized sources folder (contents gitignored).
- `wiki/_index.md`: master index of all topic subwikis.
- `wiki/public/_index.md`: master index for public topic subwikis.
- `wiki/public/<topic>/_index.md`: topic-local index.
- `wiki/public/<topic>/concepts/`: extracted concept pages.
- `wiki/public/<topic>/connections/`: extracted relationships and cross-topic links.
- `wiki/public/<topic>/concepts/<topic>.md`: core concept page named exactly after the topic slug.
- `wiki/intern/`: private compiled content section.

## Ingest Rules
- Every intake item is logged in `inbox/_index.md` first.
- Every normalized source in `raw/public/` must include YAML frontmatter with:
  - `title`
  - `token`
  - `source_link`
  - `topic`
  - `tags`
  - `generated_at`
- Every markdown file in `raw/public/` and `wiki/` must include YAML frontmatter with a `token` field.
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
- Extract concepts and connections from `raw/public/` into `wiki/public/<topic>/`.
- Cross-topic links are allowed in `connections/` pages.
- Every concept/connection page must include explicit Obsidian wiki-link connections to related concepts/pages.
- Keep `wiki/_index.md`, `wiki/public/_index.md`, and each topic `_index.md` up to date.
- Content in `wiki/public/` must never reference `wiki/intern/`.
- Content in `wiki/intern/` may reference `wiki/public/`.

## Query Rules
- Query starts at `wiki/_index.md` first.
- Then traverse into related section indexes (for example `wiki/public/_index.md`).
- Then traverse into related topic `_index.md` pages and linked concept/connection pages.
- Query answers must be grounded in relevant wiki pages and include `## References`.
- Default query scope is `wiki/public/`; internal content is optional and must never be referenced from public pages.

## Reference Rules
- All factual outputs include a `## References` section.
- References must point to concrete local paths and/or original URLs.
- In `wiki/` pages, references to normalized sources must use explicit Obsidian wiki-links to raw files, for example `[[raw/public/fdz-terms-of-use.md]]`.
- Claims in `wiki/` concepts and connections must be grounded in cited `raw/public/` sources; do not leave uncited factual assertions.

## Workflow Rules
- After updating files in `raw/public/` or `wiki/`, create a git commit and push to remote on the same day.
