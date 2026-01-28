# Implementation Plan: Excel Metadata to JSON Extractor

1. Confirm Environment
   - Verify R >= 4.2 is available and install `openxlsx2`, `jsonlite`, and `xml2` packages.
   - Ensure `examples/` directory contains reference `.xlsx` files and create an `output/` directory for JSON artefacts.

2. Define JSON Schema
   - Document the hierarchical structure for workbook, sheets, cells, styles, and ancillary metadata.
   - Specify required versus optional fields and enforce deterministic ordering rules.
   - Include schema annotations that describe how downstream clients (Excel writer, Shiny/web renderer) can reconstruct layouts, styles, and data interactions.

3. Load Workbook Safely
   - Implement CLI argument parsing for `--input`, `--output`, and formatting flags (pretty vs compact).
   - Use `openxlsx2::wb_load()` with error handling for missing files, invalid extensions, or load failures.

4. Extract Workbook-Level Metadata
   - Capture document properties, defined names, workbook views, calculation settings, theme, and style catalogue references.
   - Normalise raw XML fragments (e.g., tableStyles) into structured R lists suitable for JSON serialisation.

5. Extract Worksheet Structures
   - Iterate through `wb$worksheets` preserving sheet order and state (visible, hidden, veryHidden).
   - Record dimensions, sheet properties, freeze panes, filters, merged cells, tables, and data validation ranges.
   - Parse column width and row height definitions into numeric values with default flags.

6. Extract Cell Contents and Styles
   - Traverse sheet `sheet_data$cc` cache to gather addresses, shared string indices, formulas, inline strings, and numeric values.
   - Resolve shared strings and style indices (`cellXfs`) to their full formatting definitions (font, fill, border, alignment, number format, protection).
   - Include conditional formatting rules and data validation types linked to affected cells.

7. Assemble JSON Payload
   - Combine workbook, sheet, cell, and style data into a nested list matching the schema.
   - Serialise with `jsonlite::toJSON()` ensuring ordered arrays and UTF-8 encoding; support pretty printing toggle.
   - Embed schema versioning and reconstruction hints (e.g., render priorities, layout tokens) needed by visual clients.

8. Implement Logging and Exit Codes
   - Add progress messages for major stages and return informative errors via `stop()`.
   - Exit with status code `0` on success and `1` (or other non-zero) on failure.

9. Build JSON-to-Excel Reconstruction Script
   - Implement R script that consumes the JSON schema, validates version compatibility, and rebuilds workbooks using `openxlsx2`.
   - Support optional modification overlays defined in the JSON before writing the Excel file.

10. Validate with Example Workbooks
   - Run the script against each file in `examples/` and store outputs under `output/`.
   - Inspect JSON sections (sheets, styles, validations) for completeness and deterministic ordering.
   - Specifically verify captured styling fields: font family, font size, colour values, fill/background definitions, and border specifications for representative cells.
   - Prototype a minimal round-trip check (e.g., regenerate a sheet layout via `openxlsx2` or a Shiny table) to confirm the JSON contains enough detail for visual reconstruction.

11. Document Usage
    - Update repository README or dedicated usage guide with CLI examples, dependency installation, and troubleshooting tips.
    - Record QA checklist results and note limitations (e.g., unsupported embedded objects).

12. Prepare for Future Automation
    - Outline unit-test scaffolding (e.g., `testthat`) to verify schema integrity.
    - Suggest CI steps to run extractor on sample files and diff JSON outputs for regression detection.

## Detailed Task List
1. **Environment Bootstrap**
   - Verify R >= 4.2 availability and install required packages (`openxlsx2`, `jsonlite`, `xml2`, plus supporting tidy helpers if needed).
   - Create or confirm `output/` directory is git-ignored and writable.

2. **Repository Scaffolding**
   - Add `R/` or `scripts/` subdirectory for the extractor script if not already present.
   - Create placeholder files for schema documentation (`docs/schema.md`) and QA checklist (`docs/qa_checklist.md`) to be populated during development.

3. **CLI Interface Implementation**
   - Implement argument parsing helper supporting `--input`, `--output`, `--compact`, and `--schema-version` flags.
   - Add validation for file existence, extension, and output directory creation.

4. **Workbook Loader Module**
   - Encapsulate `openxlsx2::wb_load()` call with try/catch to return informative errors.
   - Extract workbook-level metadata (properties, theme, sheet order) into dedicated list constructors.

5. **Styles Catalogue Extractor**
   - Parse `styles_mgr` components (numFmts, fonts, fills, borders, cellXfs, cellStyles, tableStyles, colours).
   - Normalise each style element into JSON-ready lists with explicit IDs and references.

6. **Shared Strings and Inline Text Handler**
   - Convert shared strings XML into UTF-8 character vectors with metadata for rich text segments where present.
   - Handle inline strings (`is`) and formulas, including shared formula anchors.

7. **Worksheet Walker**
   - Iterate sheets preserving order and visibility, capturing sheet properties (dimension, views, freeze panes, protection, gridlines).
   - Collect structural features: merged cells, tables, filters, data validations, conditional formatting, defined names (local scope).

8. **Cell Matrix Extraction**
   - Traverse `sheet_data$cc` to assemble rows with address, indices, value type, raw value, formatted value, formula metadata, style references, hyperlink targets, comment references.
   - Include row/column attributes (height, width, hidden state, outline levels) and ensure deterministic sorting.

9. **Schema Assembly & Serialization**
   - Compose workbook-level list with embedded schema versioning and reconstruction hints (e.g., default renderer priorities, layout tokens).
   - Serialise using `jsonlite::toJSON()` respecting pretty/compact mode, ensuring deterministic ordering and UTF-8 encoding.

10. **JSON-to-Excel Reconstruction Pipeline**
    - Implement dedicated script/module that reads JSON, validates schema version, and instantiates a new workbook mirroring sheets, cells, and formatting using `openxlsx2`.
    - Support modification overlays (e.g., adjusted values/styles) encoded in JSON before writing the output file.
    - Provide hooks for alternative renderers (Shiny/web) by exposing reconstruction helpers.

11. **Round-Trip Validation Harness**
    - Automate extractor→JSON→Excel round-trip tests on sample files, comparing sheet count/order, key formatting attributes, and representative cell values.
    - Optionally scaffold Shiny prototype (table/metadata view) to confirm web rendering viability.

12. **Documentation & QA**
    - Populate schema documentation with field definitions, data types, and usage notes for downstream consumers.
    - Update QA checklist with manual verification steps (fonts, fills, borders, conditional formatting) and log test runs against `examples/` workbooks.

13. **Future Automation Hooks**
    - Draft `testthat` scaffolding for schema shape assertions and round-trip smoke tests (to be implemented later).
    - Outline CI job steps (run extractor, compare JSON diff, optional rebuild) for future integration.
