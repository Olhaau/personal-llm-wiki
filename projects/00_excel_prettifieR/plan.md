# Implementation Plan

## Phase 1: Package scaffolding
- Verify DESCRIPTION fields and add Package/Title/Version/Imports as needed.
- Add minimal NAMESPACE and document exported functions with roxygen2.
- Create `R/` directory structure and core function placeholders.

## Phase 2: Workbook structure extraction
- Implement a workbook loader using `openxlsx2::wb_load()`.
- Capture `str(wb)` output for debugging and inspection.
- Add JSON serialization via `jsonlite::write_json()`.
- Provide a simple CLI-friendly example script for running against
  `inputs/Wohnen_in_Deutschland_2022.xlsx`.

## Phase 3: Style metadata model
- Define the canonical list structure for styles, formats, merges, columns,
  rows, and sheet options.
- Build `validate_styles()` to enforce required fields and data types.
- Add JSON schema notes in documentation for manual inspection.

## Phase 4: Style extraction
- Implement `read_sheet_styles(path, sheet)` to extract per-sheet metadata.
- Implement `extract_workbook_styles(path)` for all sheets.
- Add error handling and deterministic ordering of style IDs.

## Phase 5: Styled workbook creation
- Implement `write_styled_workbook(content, styles, output_path)`.
- Support merges, hyperlinks, row/column sizing, and sheet options.
- Ensure stable style ID mapping across sheets.

## Phase 6: Documentation and examples
- Add README with usage examples for extraction and writing.
- Provide a minimal vignette-like walkthrough in `README` or `docs/`.
- Document limitations and known openxlsx2 gaps.

## Phase 7: QA checklist
- Run structure extraction on sample input workbook.
- Compare sheet counts and merged ranges between source and output.
- Verify deterministic output using file hashes across repeated runs.
