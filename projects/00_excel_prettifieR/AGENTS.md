## Purpose
This repository is a placeholder for an R package focused on copying, adapting, and creating styled Excel workbooks. It currently contains minimal files and no executable code.

## Project Intent
- Build an R package for copying, adapting, and creating well-formatted Excel workbooks.
- Focus on extracting Excel sheet styling metadata and recreating styled workbooks from content and styling inputs.

## Required Skill
- Use the modify-excel-with-r skill for all Excel operations.
- Use R with openxlsx / openxlsx2 APIs to read and write Excel files.

## Scope
- Provide functions to read Excel styling metadata from a sheet.
- Provide a function that accepts content and styling metadata and writes a new Excel file.

## Functional Goals
- Extract styling metadata (fonts, fills, borders, alignment, number formats, column widths, row heights, merged cells, and sheet-level settings).
- Represent styling metadata in a structured R object suitable for serialization.
- Recreate a styled workbook from content and styling metadata with minimal drift from the source.

## Proposed R Package API
- read_sheet_styles(path, sheet): returns a list with cell styles, column widths, row heights, merged ranges, and sheet options.
- extract_workbook_styles(path): returns styling metadata for all sheets.
- write_styled_workbook(content, styles, output_path): creates a new workbook from provided content and styling metadata.
- validate_styles(styles): checks structure and required fields.

## Data Structures
- Use a list with components: sheets, styles, formats, merges, columns, rows, and sheet_options.
- Ensure every cell style maps to a stable style id that can be reused in the output workbook.

## Implementation Notes
- Prefer openxlsx2 for style fidelity and modern API coverage.
- Keep all Excel writes in a single function entrypoint to maintain reproducibility.
- Avoid manual edits to binary Excel files.
- Keep outputs deterministic for regression checks.

## Non-Goals
- No GUI or Shiny interface.
- No support for external data sources beyond provided content.

## Repository Layout
- AGENTS.md: agent instructions, project intent, and high-level API goals.
- inputs/: sample text input assets.
- .secret: private data (do not read or modify).

## Build / Lint / Test Commands
There are no build, lint, or test scripts in this repository yet.

When the R package structure is added, prefer commands like these:
- Build/check package: `R CMD check .`
- Install local package: `R CMD INSTALL .`
- Run all tests (testthat): `Rscript -e "testthat::test_dir('tests')"`
- Run a single test file: `Rscript -e "testthat::test_file('tests/testthat/test_<topic>.R')"`
- Lint a file (lintr): `Rscript -e "lintr::lint('R/<file>.R')"`
- Format a file (styler): `Rscript -e "styler::style_file('R/<file>.R')"`

If you add a Makefile or CI, update this section with canonical commands.

## Code Style Guidelines

### Imports and Dependencies
- Use `suppressPackageStartupMessages({ ... })` when loading packages in scripts.
- Keep package lists alphabetical and minimal.
- Prefer CRAN packages; document any GitHub remotes in README or DESCRIPTION.

### Formatting
- Use 2-space indentation for R.
- Keep line width <= 100 characters.
- Use native pipe `|>` for new code.
- Keep helper functions short and focused.

### Naming Conventions
- Functions: `snake_case`.
- Variables: `snake_case`.
- Constants: `UPPER_SNAKE_CASE`.
- Avoid abbreviations unless standard in the domain.

### Types and Data Structures
- Use tibbles for tabular data.
- Use lists for structured metadata (e.g., styles, merges, sheet options).
- Validate inputs early; reject invalid types or missing fields.

### Error Handling
- Use `stop()` with clear, contextual messages for invalid inputs.
- Wrap IO operations (read/write Excel) in `tryCatch()` and surface errors.
- Avoid silent failures; return explicit results or errors.

### Excel-Specific Guidance
- Never hand-edit binary Excel files.
- Use `openxlsx` or `openxlsx2` for all reads/writes.
- Preserve styling metadata when copying or recreating sheets.
- Keep output deterministic to support regression checks.

### File and Module Organization
- Place exported functions in `R/` with roxygen headers.
- Group related helpers under `# ----` section markers.
- Keep one responsibility per file when possible.

### Documentation
- Use roxygen2 for exported functions.
- Keep README updated with usage and example workflows.
- Document any new dependencies and setup steps.

## Cursor / Copilot Rules
- No Cursor rules found in `.cursor/rules/` or `.cursorrules`.
- No Copilot instructions found in `.github/copilot-instructions.md`.

## Notes for Agents
- Avoid reading or modifying `.secret`.
- Update this file when build/test tooling or package structure is added.
