# Wissen Wiki Rules

## Scope
- This wiki root is `wissen/`.
- Intake starts in `inbox/`, normalized sources live in `raw/`, compiled knowledge lives in `wiki/`.

## Required Structure
- `inbox/index.md`: intake ledger with source, location, and time metadata.
- `raw/index.md`: registry of normalized markdown sources.
- `wiki/index.md`: master index of all topic subwikis.
- `wiki/<topic>/index.md`: topic-local index.
- `wiki/<topic>/concepts/`: extracted concept pages.
- `wiki/<topic>/connections/`: extracted relationships and cross-topic links.

## Ingest Rules
- Every intake item is logged in `inbox/index.md` first.
- Every normalized source in `raw/` must include YAML frontmatter with:
  - `title`
  - `source_link`
  - `topic`
  - `tags`
  - `generated_at`
- Raw source files should contain only YAML frontmatter and the original article content.
- For web sources with images (only when explicitly requested by the user):
  - Download images into `inbox/images/`.
  - Use stable, source-specific filenames (for example, `<slug>-<n>.<ext>`).
  - Replace image references in `raw/*.md` with Obsidian wiki image links: `![[inbox/images/<file>]]`.
  - Keep non-image hyperlinks unchanged.
- Default behavior is text-first ingest for performance: do not download or relink images unless explicitly requested.

## Compile Rules
- Extract concepts and connections from `raw/` into `wiki/<topic>/`.
- Cross-topic links are allowed in `connections/` pages.
- Keep `wiki/index.md` and each topic `index.md` up to date.

## Reference Rules
- All factual outputs include a `## References` section.
- References must point to concrete local paths and/or original URLs.

## Workflow Rules
- After updating files in `raw/` or `wiki/`, create a git commit and push to remote on the same day.
