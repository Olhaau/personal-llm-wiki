# Agent Guide for Excel Round-Trip Skill

## Repository Orientation
- Focus: preserve Excel formatting, hyperlinks, and layout across JSON round-trips using R.
- Primary entry points: `complete_formatting_fix.R` (full workflow) and `working_hyperlinks_demo.R` (navigation demo).
- Legacy research lives inside `archive/`; treat as reference-only and do not rewrite without need.
- The `code/` folder holds exploratory helpers; review before reusing to avoid duplicate logic.
- `corporate-design/` captures brand assets; keep files immutable unless updating style guides deliberately.
- Generated spreadsheets and JSON land in `output/`; directory stays git-ignored, so supply artifacts manually when reviewers ask.
- Binary fixtures under `output/` feed regression checks; never edit them by hand.
- No repo-level Cursor or Copilot rule files exist as of 2026-01-29; follow guidance here plus OpenCode defaults.
- Keep paths relative to the repo root to maintain portability across agents.
- Run commands from `/home/oli/newwork/dev/projects/skill_modify_excel_with_r` unless noted.

## Environment Setup
- Preferred runtime: R 4.2 or newer with UTF-8 locale enabled.
- Install CRAN dependencies once per machine: `Rscript -e "install.packages(c('openxlsx2','jsonlite','readxl','tidyr','dplyr','purrr','stringr','glue','lintr','styler'))"`.
- Use project-local libraries via `renv::init()` only if the workflow grows; document lockfile updates in commits.
- Keep scripts shebang-friendly (`#!/usr/bin/env Rscript`) to enable direct execution.
- Avoid system-level package installs without coordinator approval; prefer user libraries (`R_LIBS_USER`).
- Verify `output/` write permissions before running converters to prevent silent failures.
- Use `Sys.setlocale("LC_CTYPE", "en_US.UTF-8")` temporarily if local shell defaults differ.
- Refresh packages periodically with `Rscript -e "update.packages(ask = FALSE)"`, but never inside automated scripts.
- If new CRAN packages become required, append them to the install command above and document in this file.
- Capture additional setup nuances in pull request descriptions for downstream agents.

## Core Execution Commands
- Full round-trip (default paths): `Rscript complete_formatting_fix.R`.
- Convert custom workbook to JSON: `Rscript -e "source('complete_formatting_fix.R'); excel_to_json_complete('input.xlsx','output/structure.json')"`.
- Rebuild Excel from JSON: `Rscript -e "source('complete_formatting_fix.R'); json_to_excel_complete('output/structure.json','output/recreated.xlsx')"`.
- Generate hyperlink demo: `Rscript working_hyperlinks_demo.R`.
- Run exploratory analyzer on Statistischer Bericht: `Rscript code/analyze_statistischer_bericht.R`.
- Produce clinical-to-statistischer conversion: `Rscript code/clinical_to_statistischer_bericht.R`.
- Extract workbook structure baseline: `Rscript code/extract_excel_to_json.R`.
- Always inspect console logs for ✓ markers; they confirm key restoration steps executed.
- When generating large workbooks, prefer explicit output filenames to avoid overwriting fixture comparisons.
- Log command usage in PRs so reviewers can reproduce quickly.

## Testing Strategy
- Ad-hoc validation scripts reside under `archive/tests/`; treat them as executable smoke tests.
- System regression check: `Rscript archive/tests/test_roundtrip_system.R` (reads fixture, converts, validates grid lines).
- Formatting preservation probe: `Rscript archive/tests/test_formatting_preservation_fixed.R`.
- Navigation sanity check: `Rscript archive/tests/spec_kit_complete_test.R`.
- Run a single targeted script by invoking `Rscript path/to/test_script.R`; no testthat harness is required.
- For interactive checks, source the main script inside R and call helpers manually (see commands above).
- After regenerating outputs, compare workbook metadata with `openxlsx2::wb_load()` plus manual inspection.
- Consider adding new tests alongside existing scripts; name files descriptively and keep them non-interactive.
- Document empirical findings (sheet counts, hyperlink samples) in commit messages for traceability.
- Avoid committing generated Excel or JSON unless reviewers demand artifacts for debugging.

## Linting and Formatting
- Static lint: `Rscript -e "lintr::lint('complete_formatting_fix.R')"`.
- Folder-wide lint: `Rscript -e "lintr::lint_dir('code')"` for exploratory helpers.
- Style a single file: `Rscript -e "styler::style_file('working_hyperlinks_demo.R')"`.
- Batch style cautiously: `Rscript -e "styler::style_dir('.', exclude_dirs = c('archive','output'))"`.
- Review diffs after styler runs; do not auto-format archive snapshots without justification.
- Keep line width at or below 100 characters to stay CLI-friendly.
- Avoid trailing whitespace; configure editors to trim on save.
- Prefer spaces for indentation (two spaces) to match existing scripts.
- Reserve comment blocks for non-obvious logic or workflow maps; skip redundant commentary.
- Ensure scripts remain executable (`chmod +x`) when editing the shebang line.

## Data and Output Handling
- `output/` is the only approved location for generated Excel and JSON artifacts.
- Never modify source Excel fixtures inside `code/` or `archive/`; duplicate before experimenting.
- Preserve German umlauts by keeping encoding defaulted to UTF-8 across read/write operations.
- When exporting new assets, include dates in filenames (e.g., `output/structure_2026-01-29.json`).
- Clean up large temporary files to avoid bloating the workspace; document deletions if manual.
- Do not commit anything from `output/`; rely on reviewers to recreate locally.
- Store reusable configuration inside R scripts rather than editing binary templates.
- Use CSV snapshots for diffable comparisons when investigating data transformations.
- Keep sample data sets lightweight; large fixtures belong under a dedicated storage solution, not this repo.
- Validate workbook integrity with `openxlsx2::wb$worksheets` introspection before shipping changes.

## Coding Style Essentials
- Use snake_case for functions (`excel_to_json_complete`) and variables (`sheet_name`).
- Keep object names descriptive; avoid single-letter variables except in tight loops (`i`, `ws`).
- Place `library()` calls at the top of each script, alphabetized where practical; avoid repeated attaches mid-script.
- Prefer explicit imports over `tidyverse` umbrella packages to limit load time.
- Declare helper constants near usage sites to minimize global scope.
- Leverage native pipe `|>` in new code; existing `%>%` should not expand in this repo.
- Keep functions short and focused; break out helpers for repeated patterns like worksheet traversal.
- Return informative objects (lists, data frames) instead of relying solely on side effects when feasible.
- Maintain deterministic output ordering to ease regression checks.
- Write roxygen comments (`#'`) only when exposing helpers for reuse; otherwise keep headers concise.

## Excel API Practices
- Use `openxlsx2` high-level helpers (`wb$add_data`, `wb$add_fill`, `wb$add_hyperlink`) instead of legacy `openxlsx` calls.
- Restore view settings with `wb$set_grid_lines()` and apply manual tweaks when XML parsing is pending.
- Store styles via the workbook `styles_mgr`; capture `font`, `fill`, `border`, and `numfmt` when exporting to JSON.
- Treat sheet names as UTF-8; when building hyperlinks, wrap names with `#'Sheet'!A1` syntax to survive special characters.
- When parsing XML fragments (`sheetData`, `mergeCells`), prefer `xml2` if deeper inspection becomes necessary.
- Always add worksheets before writing data; guard with `if (!sheet_name %in% wb$get_sheet_names())` when iterating.
- Maintain column width settings through `wb$set_col_widths()` rather than manual XML edits.
- Hide grid lines explicitly after adding worksheets to avoid default toggles.
- Confirm hyperlinks exist by checking `wb$worksheets[[index]]$hyperlinks` prior to saving.
- Save workbooks with `wb_save(wb, path, overwrite = TRUE)`; never rely on implicit defaults for overwriting.

## Logging and Error Handling
- Emit progress via `cat()` with clear section headers (e.g., `=== STEP TITLE ===`).
- Use `tryCatch()` around workbook reads (`wb_to_df`) to degrade gracefully on corrupt sheets.
- When catching errors, surface readable context (`cat("Warning: Could not extract data from", sheet_name)`), then continue.
- Avoid `stop()` unless recovery is impossible; prefer returning informative lists or `NULL` otherwise.
- Guard file-system operations with `if (!file.exists(path))` and message users before early exit.
- Timestamp conversions with `Sys.time()` to aid debugging of stale artifacts.
- For long loops, print incremental status (sheet names, counts) to keep CLI feedback flowing.
- Redirect verbose debug output behind a boolean flag if repeated runs become noisy.
- Keep logs ASCII-only to avoid encoding surprises in CI transcripts.
- Remove stray `print()` and `str()` calls before merging unless they are part of diagnostics scripts.

## Contribution Workflow
- Branch naming: `feature/<topic>`, `fix/<topic>`, or `docs/<topic>` per OpenCode convention.
- Reference related task IDs inside commit bodies when applicable.
- Summarize manual QA in PR descriptions, including commands run and output filenames reviewed.
- Seek pair review for major changes to Excel generation logic or style managers.
- Avoid rewriting archived experiments unless turning them into supported utilities; document motive when you do.
- Keep README updates in sync with new capabilities exposed to users.
- Mention added dependencies both here and in README to maintain onboarding clarity.
- Ensure scripts remain cross-platform; avoid hard-coded absolute paths or backslashes.
- Prefer additive changes over in-place rewrites so history remains digestible.
- Capture post-merge learnings in this file to help the next agent ramp quickly.

## Quality Assurance Checklist
- Verify regenerated Excel files open without warnings in Excel or LibreOffice.
- Confirm hyperlink targets navigate correctly using Excel or `openxlsx2` inspection.
- Check grid line state on key sheets after round-trip operations.
- Compare worksheet counts and names between source and recreated workbooks.
- Inspect style manager lengths (`length(wb$styles_mgr$styles)`) for regression signals.
- Review JSON exports for expected keys: `metadata`, `worksheets`, `styles_mgr`, `global_settings`.
- On bug fixes, reproduce the issue first and capture console logs before applying patches.
- Use git diffs to ensure only intended scripts changed; generated outputs should remain unstaged.
- When in doubt, rerun `test_complete_roundtrip()` to exercise the end-to-end pipeline.
- Record QA notes alongside commits or in PR discussions for auditability.

## Knowledge Transfer
- Read `HYPERLINK_FIX_SUMMARY.md` for deep technical context on hyperlink handling and grid line fixes.
- Review `PROJECT_CLEANUP_SUMMARY.md` and `archive/` notes before pruning legacy files.
- Keep `complete_formatting_fix.R` as the single source of truth for export/import logic; avoid diverging forks.
- When introducing new helpers, colocate them near existing `excel_to_json_complete` or `json_to_excel_complete` functions for discoverability.
- Document any workbook schema assumptions (sheet ordering, required columns) inside code comments adjacent to enforcement logic.
- Encourage future contributors to promote shared utilities into `.opencode` when repeated across repos.
- Capture unusual Excel behaviors (e.g., conditional formatting edge cases) in this section for institutional memory.
- Share learnings about `openxlsx2` issues upstream via issue trackers when time permits.
- Flag library deprecations proactively to avoid last-minute fire drills.
- Archive superseded scripts instead of deleting outright to preserve investigative breadcrumbs.

## Support Channels
- Surface blockers in repository issues referencing section titles from this guide for quick context.
- Coordinate dependency upgrades or shared tooling changes with workspace maintainers before execution.
- When encountering encoding problems, verify locale, workbook XML, and JSON serialization, then document findings here.
- For massive workbooks that strain memory, explore chunked processing and outline approach in this guide prior to shipping.
- Raise security concerns (PII, credentials) immediately and stop automation until resolved.
- Keep communication logs concise but comprehensive to aid asynchronous collaboration.
- Revisit this document every significant milestone to ensure guidance stays near the target 150 lines and up to date.
- Treat this file as living documentation; propose edits whenever patterns shift.
- Encourage agents to append lessons learned to prevent repeated dead ends.
- Thank your future self by leaving clear bread crumbs throughout the repo.
