# AGENTS.md - Excel Conversion Project Guide

## 1. Repository Purpose
- Build tooling that extracts complete Excel workbook structure and formatting into JSON and regenerates workbooks from JSON.
- Ensure deterministic, automation-friendly outputs consumable by other agents, Shiny apps, or web clients.

## 2. Directory Layout
- `docs/requirements.md` – Product requirements and acceptance criteria.
- `docs/implementation_plan.md` – Step-by-step build plan and detailed task list.
- `examples/` – Sample `.xlsx` files for development, QA, and regression tests (treat as read-only fixtures).
- `scripts/` *(planned)* – R entry points such as `extract_excel_to_json.R` and `json_to_excel.R`.
- `output/` *(git-ignored, create locally)* – Generated JSON/Excel artefacts during development.

## 3. Environment Setup
- Use R version ≥ 4.2 with UTF-8 locale.
- Install required CRAN packages: `openxlsx2`, `jsonlite`, `xml2`, `cli`, `dplyr`, `purrr`, `readr`, `testthat` (for future tests), `lintr`, `styler`.
- Optional: initialise `renv` if reproducible environments are needed; commit `renv.lock` only when instructed.
- Avoid system-wide installs; prefer project library (`Sys.setenv(R_LIBS_USER=...)`).

## 4. Build & Execution Commands
- Extract Excel to JSON: `Rscript scripts/extract_excel_to_json.R --input examples/mineraloelerzeugnisse.xlsx --output output/mineraloelerzeugnisse.json`.
- Rebuild Excel from JSON: `Rscript scripts/json_to_excel.R --input output/mineraloelerzeugnisse.json --output output/mineraloelerzeugnisse_roundtrip.xlsx`.
- Compact JSON mode: add `--compact` flag to extraction command.
- Apply JSON modifications on rebuild: `Rscript scripts/json_to_excel.R --input data.json --apply-mods patches.json --output output/modified.xlsx`.

## 5. Linting & Formatting
- Run `Rscript -e "lintr::lint_dir('scripts')"` for full lint; `lintr::lint('scripts/<file>.R')` for a specific script.
- Format a file with `Rscript -e "styler::style_file('scripts/<file>.R')"`; inspect diffs before committing.
- Keep line width ≤ 100 characters; wrap arguments on new lines when needed.

## 6. Testing Strategy
- Smoke test extractor: `Rscript scripts/extract_excel_to_json.R --input <fixture> --output output/test.json`.
- Smoke test round-trip: run extractor then `json_to_excel` and compare workbook metadata (helper functions will be added).
- Placeholder for unit tests: `Rscript -e "testthat::test_file('tests/testthat/test_schema.R')"` for a single spec once tests land.
- Manual QA checklist lives in `docs/requirements.md` – follow for fonts, fills, colours, number formats, sheet order.

## 7. Logging & Error Handling
- Use `cli::cli_alert_info()` / `cli::cli_alert_success()` for user-facing progress; avoid noisy default prints.
- Wrap IO in `tryCatch()`; provide descriptive errors (`stop()` with actionable message) and include file path context.
- Prefer returning invisible structured results when functions are used as helpers to simplify testing.
- Exit scripts with explicit status codes (`quit(status = 0L, runLast = FALSE)` on success, non-zero on failure).

## 8. JSON Schema Guidelines
- Store schema definitions alongside code (`schemas/` or inline constants). Document any schema change in `docs/schema.md`.
- Include `schema_version`, `generator`, and `generated_at` fields in every JSON output.
- Preserve deterministic ordering for arrays: sheets by index, rows by ascending coordinate, styles by internal ID.
- Expose reconstruction hints such as default renderer, theme palette, and layout tokens.

## 9. Excel Handling Rules
- Never hand-edit `.xlsx` fixtures; extract via `openxlsx2` only.
- When adding new fixtures, place them in `examples/` and note provenance in commit body.
- Use `openxlsx2::wb_load()` / `wb_save()` with `overwrite = TRUE` only on generated outputs inside `output/`.
- Validate workbook properties, defined names, tables, and conditional formats when performing round-trip checks.

## 10. Code Style (R)
- Naming: `snake_case` for functions/variables, `UPPER_CASE` for constants, S3 classes in CamelCase.
- Imports: collect at top inside `suppressPackageStartupMessages({ library(openxlsx2); library(jsonlite); ... })` sorted alphabetically.
- Use native pipe `|>`; avoid magrittr `%>%` unless interacting with legacy helpers.
- Functions should return explicit objects; avoid reliance on side effects beyond logging and output files.
- Prefer `list()` or `tibble::tibble()` for structured data; document list schemas with comments.
- Validate inputs early (`stopifnot()` only for simple invariant checks; otherwise raise informative `stop()` messages).
- Document exported helpers with `#'` roxygen comments if they may be re-used.

## 11. Type & Data Conventions
- Represent cell coordinates as `list(row = integer, col = integer, address = character)`.
- Store colour values as hex ARGB strings (`"FF004B76"`); provide RGB fallback when necessary.
- Use ISO-8601 timestamps (`format(Sys.time(), '%Y-%m-%dT%H:%M:%SZ')`).
- Represent booleans with `TRUE`/`FALSE`; avoid integers-as-bools.
- For enumerations (sheet state, border style), document allowed values in schema constants.

## 12. JSON-to-Excel Implementation Notes
- Validate schema version compatibility before attempting reconstruction.
- Map style IDs to newly created workbook styles using dedicated registries to avoid duplicates.
- Apply row heights, column widths, and outline levels before writing cell data.
- Recreate tables, conditional formats, data validations, and defined names after values are populated to respect range dependencies.

## 13. CLI UX Expectations
- Provide `--help` output describing flags and examples.
- Support `--quiet` or `--verbose` (planned) to toggle logging levels.
- Print summary (sheet count, cell count, styles captured) on success; print remediation hints on failure.

## 14. Documentation Duties
- Update `docs/requirements.md` and `docs/implementation_plan.md` whenever scope or sequencing changes.
- Record schema revisions and upgrade steps in `docs/schema.md` (to be created alongside implementation).
- Maintain changelog entries in commit bodies; optional `docs/CHANGELOG.md` if scope grows.

## 15. Git Workflow
- Follow Conventional Commits (`feat:`, `fix:`, `docs:`, `refactor:`). Use `docs:` for documentation-only updates.
- Keep commits scoped: docs, extractor changes, reconstruction changes, and tests in separate commits where practical.
- Do not commit generated JSON/Excel outputs unless reviewers explicitly request them.
- Avoid rewriting history (`git rebase -i`, `git push --force`) unless instructed.
- Use feature branches (`feature/<topic>` or `fix/<bug>`) when developing larger changes.

## 16. Testing & QA Cadence
- For each new feature, run extractor and reconstruction against all files in `examples/`.
- Capture QA findings in PR descriptions: sheet parity, formatting observations, JSON size comparisons.
- Consider adding automated diff tooling (future work) comparing JSON outputs to golden files.

## 17. Collaboration Guidelines
- Leave concise inline comments for non-obvious transformations (style mapping, schema migrations).
- Share reusable utilities (e.g., style parsers) as standalone functions in `scripts/lib/` to support reuse.
- Coordinate schema changes with downstream consumers before merging breaking updates.

## 18. Security & Data Handling
- Redact personal or proprietary data before adding new fixtures.
- Avoid embedding secrets or credentials in JSON outputs; ingest environment variables via `Sys.getenv()` when needed.
- Validate user-supplied paths to prevent directory traversal when future CLI flags are introduced.

## 19. Future Enhancements (Reference)
- Planned: add `tests/` directory with `testthat` specs for schema validation and round-trip fidelity.
- Investigate integration with `pkgdown` or `quarto` for documentation as project matures.
- Explore Shiny prototype that visualises JSON structure for manual QA.

## 20. Quick Reference Commands
- `Rscript scripts/extract_excel_to_json.R --input examples/erzeugerpreise.xlsx --output output/erzeugerpreise.json`
- `Rscript scripts/json_to_excel.R --input output/erzeugerpreise.json --output output/erzeugerpreise_roundtrip.xlsx`
- `Rscript -e "lintr::lint('scripts/extract_excel_to_json.R')"`
- `Rscript -e "styler::style_dir('scripts')"`
- `Rscript -e "testthat::test_dir('tests')"`

## 21. Data QA Checklist
- Regenerate the Excel workbook and confirm sheet count matches source.
- Validate tab order and hidden sheet states against original fixture.
- Spot-check representative cells for value parity and number format fidelity.
- Inspect conditional formatting outputs (colors, icon sets) for parity with inputs.
- Document discrepancies in `docs/qa_checklist.md` before sign-off.

## 22. Performance Notes
- Optimise extraction by streaming `sheet_data$cc`; avoid loading redundant XML.
- Cache shared styles and strings across sheets to prevent repeated parsing.
- Benchmark large workbooks (>200k populated cells) and capture timing in PR notes.
- Use `profvis` or `bench` during refactors to track hotspots.
- Defer expensive JSON pretty-printing when `--compact` flag is set.

## 23. Support & Escalation
- Record blocking issues in the project issue tracker referencing this guide section.
- Escalate schema-breaking discussions to maintainer group before merging.
- Coordinate with downstream consumers prior to changing JSON field semantics.
- Maintain an internal contact list for Excel schema experts (to be documented).

## 24. Known Limitations
- Embedded objects (OLE, charts) are currently out of scope; log if encountered.
- Macro-enabled `.xlsm` files may load but VBA projects are not exported.
- Shiny/web renderers do not yet cover pivot tables; mark gaps in documentation.
- Locale-specific number formats beyond German/US require additional mapping.

## 25. Tooling Tips
- Use `openxlsx2::wb_color()` helpers to convert RGB values to ARGB strings.
- Leverage `xml2::read_xml()` for direct inspection of workbook parts during debugging.
- Apply `jsonlite::stream_in()` when analysing large JSON outputs programmatically.
- Store repeatable QA steps as RMarkdown logs for reviewer transparency.
- Capture screenshots of Excel outputs when verifying complex formatting.

## 26. FAQ for Agents
- **Where do I log schema changes?** Update `docs/schema.md` and mention in PR descriptions.
- **How do I add a new CLI flag?** Extend the argument parser, document usage, and add tests or QA steps.
- **What if lintr/styler disagree?** Follow styler output, then re-run lintr to ensure compliance.
- **Can I commit generated JSON?** Only when reviewers request artefacts for debugging.
- **How do I test only one sheet?** Provide `--sheet` flag support or run helper functions interactively.

## 27. Revision History
- 2026-01-28: Initial agent handbook created for Excel conversion project.
- Update this section with future significant changes so agents can understand context quickly.

---
- Keep this guide near 150 lines; prune or update sections as the codebase evolves.
