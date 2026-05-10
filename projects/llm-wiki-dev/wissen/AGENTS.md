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

## Compile Rules
- Extract concepts and connections from `raw/` into `wiki/<topic>/`.
- Cross-topic links are allowed in `connections/` pages.
- Keep `wiki/index.md` and each topic `index.md` up to date.

## Reference Rules
- All factual outputs include a `## References` section.
- References must point to concrete local paths and/or original URLs.
