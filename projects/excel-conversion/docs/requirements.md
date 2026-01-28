# Excel Metadata to JSON Extractor Requirements

## Overview
- Purpose: Provide a command-line R utility that captures complete workbook structure, data, and formatting details from Excel `.xlsx` files and serialises the result to JSON for downstream automation.
- Stakeholders: Data engineering team, QA analysts needing deterministic workbook diffs, automation workflows that require machine-readable Excel metadata.
- Out of scope: Editing Excel files, support for legacy `.xls` formats, binary embedded objects, or macro extraction.

## Objectives
- Load Excel workbooks using `openxlsx2` without modifying source files.
- Gather sheet-level information (names, visibility, dimensions, tab colours, gridline settings).
- Record cell-level content, formulas, data types, and formatting attributes (styles, number formats, fills, fonts, borders, alignment, merge ranges).
- Capture workbook resources (defined names, data validations, conditional formats, tables, column widths, row heights, pivot caches) when available.
- Output a deterministic JSON document preserving hierarchy and preserving ordering for reproducible comparisons.
- Provide a simple CLI entry point accepting an input path and optional output destination.

## Functional Requirements
- `extract_excel_to_json.R` script callable via `Rscript extract_excel_to_json.R --input path/to/file.xlsx [--output path/to/file.json]`.
- Validate file existence and `.xlsx` extension before processing; fail with descriptive errors otherwise.
- Read workbook with `openxlsx2::wb_load()` and keep workbook unmutated.
- For each worksheet capture:
  - Metadata: name, index, state, tab colour, row/column counts, freeze panes.
  - Column widths and row heights (default vs. custom).
  - Tables, filters, merged cells, defined names scoped to sheet.
  - Cell matrix including row/column index, address, value, data type, formula, style reference, and resolved style attributes.
- For styles capture font, fill, border, alignment, number format, protection flags, conditional format references.
- Include workbook-level settings: properties, theme references, defined names, data validation rules, conditional formats, pivot caches.
- Serialise to JSON using `jsonlite` with pretty formatting unless `--compact` flag is provided.
- Return exit status `0` on success and non-zero on failure; print progress with `cat()`.

## Non-Functional Requirements
- Deterministic ordering for lists (sheets, styles, cells) to support diffing.
- Handle workbooks up to 50 MB with at least 200k populated cells without exhausting memory.
- Complete extraction within 60 seconds for typical 5-sheet workbooks on baseline hardware.
- Use UTF-8 encoding and ensure JSON output is portable across systems.
- Provide informative error messages and avoid silent failures.

## Inputs & Outputs
- Inputs: Valid `.xlsx` files located in `examples/` directory or supplied via CLI argument.
- Outputs: JSON file mirroring workbook structure. Default output path `output/<filename>.json` if not provided.
- Logs: Console messages indicating processing stages and summary statistics.

## Dependencies
- R (>= 4.2).
- CRAN packages: `openxlsx2`, `jsonlite`, `xml2`.

## Testing & Validation
- Provide sample invocation in documentation demonstrating extraction from each workbook in `examples/`.
- Unit tests (future scope) to verify JSON schema for representative elements (styles, data validations, merged cells).
- Manual QA checklist: run extractor against supplied examples and confirm JSON diff contains expected sections (sheets, styles, cells).

## Acceptance Criteria
- Script runs via CLI with documented flags.
- JSON output includes sheets, cells, and style metadata for provided examples.
- Errors are descriptive, and script exits cleanly on invalid input.
- Documentation updated with usage instructions and dependency setup.
