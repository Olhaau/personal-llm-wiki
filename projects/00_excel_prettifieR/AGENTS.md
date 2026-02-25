## Purpose
This repository is an R package scaffold focused on extracting and recreating
Excel styles. Current code reads workbooks via openxlsx2 and serializes styling
metadata to JSON for inspection and reuse.

## Project Intent
- Build an R package that can copy styled Excel workbooks.
- Extract sheet-level styling metadata and apply it to regenerated workbooks.

## Required Skill
- Use the excel-operations skill for all Excel operations.
- Use R with openxlsx2 APIs for reading and writing .xlsx files.

## Scope
- Read workbook styles, sheet options, and cell formats.
- Write reconstructed workbooks from content + styling metadata.

## Functional Goals
- Capture fonts, fills, borders, alignment, number formats, column widths,
  row heights, merged cells, and sheet-level settings.
- Represent styling metadata in stable, serializable lists.
- Recreate styled workbooks with minimal drift from source.

## Proposed R Package API
- read_sheet_styles(path, sheet): returns styles, column widths, row heights,
  merged ranges, and sheet options.
- extract_workbook_styles(path): returns styling metadata for all sheets.
- write_styled_workbook(content, styles, output_path): rebuilds a styled file.
- validate_styles(styles): checks structure and required fields.

## Data Structures
- Use lists with components: sheets, styles, formats, merges, columns, rows,
  and sheet_options.
- Ensure every cell style maps to a stable style id for reuse.

## Repository Layout
- AGENTS.md: agent instructions and conventions.
- R/: package functions (currently `read_workbook_structure.R`).
- inputs/: sample assets (do not edit unless asked).
- output/: generated artifacts (keep uncommitted unless requested).
- .secret: private data (do not read or modify).

## Build / Lint / Test Commands
There is no automated test or lint configuration yet. Use these conventions
when adding package scaffolding or local checks:

- Build/check package: `R CMD check .`
- Install locally: `R CMD INSTALL .`
- Run all tests (testthat): `Rscript -e "testthat::test_dir('tests')"`
- Run a single test file: `Rscript -e "testthat::test_file('tests/testthat/test_<topic>.R')"`
- Lint a file (lintr): `Rscript -e "lintr::lint('R/<file>.R')"`
- Format a file (styler): `Rscript -e "styler::style_file('R/<file>.R')"`

If you add Makefile targets, update this section with canonical commands.

## Code Style Guidelines

### Imports and Dependencies
- Keep imports minimal and alphabetized in DESCRIPTION.
- Use openxlsx2 and jsonlite as the primary dependencies today.
- Load packages in scripts with `suppressPackageStartupMessages({ ... })`.
- Prefer CRAN packages; document GitHub remotes in DESCRIPTION/README.

### Formatting
- Use 2-space indentation for R.
- Keep line width <= 100 characters.
- Use native pipe `|>` for new code.
- Keep helper functions short and single-purpose.

### Naming Conventions
- Functions: `snake_case`.
- Variables: `snake_case`.
- Constants: `UPPER_SNAKE_CASE`.
- Avoid nonstandard abbreviations.

### Types and Data Structures
- Use tibbles for tabular data; lists for structured metadata.
- Preserve workbook metadata as plain lists for JSON serialization.
- Keep style specs keyed by stable ids (e.g., `style_12`).
- Validate inputs early; reject missing or invalid fields.

### Error Handling
- Use `stop()` with clear, contextual messages.
- Wrap IO with `tryCatch()` and surface readable errors.
- Avoid silent failures; return explicit values or raise errors.

### Excel-Specific Guidance
- Never hand-edit binary Excel files.
- Use openxlsx2 for reads/writes; openxlsx only if required.
- Keep output deterministic for regression checks.
- Reuse style ids to avoid style drift.

### Roxygen and Exports
- Place exported functions in `R/` with roxygen headers.
- Document parameters, return values, and side effects.
- Update NAMESPACE when new exports are added.

### File and Module Organization
- Group helpers under `# ----` section markers.
- Keep one responsibility per file.
- Prefer smaller helpers over deeply nested functions.

### JSON and Serialization
- Ensure JSON output is stable (ordered list keys, stable ids).
- Drop environments, functions, and external pointers before serialization.
- Use `jsonlite::write_json(..., auto_unbox = TRUE)` for consistent output.

## Cursor / Copilot Rules
- No Cursor rules found in `.cursor/rules/` or `.cursorrules`.
- No Copilot instructions found in `.github/copilot-instructions.md`.

## Notes for Agents
- Avoid reading or modifying `.secret`.
- Do not commit generated Excel files unless explicitly requested.
- Update this file when build/test tooling is added.
