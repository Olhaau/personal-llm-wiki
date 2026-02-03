# Spec-Kit Constitution

## Mission
Build an R package that bridges R and Excel to create reproducible, beautifully
formatted workbooks with openxlsx2. The package must faithfully adapt existing
formats to new data and enable creating fully specified Excel outputs from data
plus explicit formatting instructions (styles, merges, hyperlinks, layout, and
sheet options).

## Core Principles
1. **Fidelity over convenience**: Preserve visual and structural details with
   minimal drift from source templates.
2. **Determinism**: The same inputs must always yield the same output workbook.
3. **Explicit specification**: Formatting, merges, hyperlinks, widths, heights,
   and sheet options are represented as structured metadata, not ad hoc code.
4. **Single write entrypoint**: All workbook creation flows through one
   deterministic writer for consistent results.
5. **Validation first**: Fail early on malformed specs; provide clear errors.
6. **Separation of concerns**: Extraction and writing are distinct, composable
   operations.

## Scope
### In
- Read workbook metadata (styles, merges, row/column sizes, sheet options).
- Serialize workbook structure and style metadata for reuse.
- Apply metadata to new data to generate a styled workbook.
- Create fully specified workbooks from data + formatting spec.
- Support hyperlinks and internal navigation.

### Out
- Manual edits to binary Excel files.
- GUI or Shiny interfaces.
- External data sources beyond provided inputs.

## API Commitments
The package will expose four stable user-facing functions:
- `read_sheet_styles(path, sheet)`
- `extract_workbook_styles(path)`
- `write_styled_workbook(content, styles, output_path)`
- `validate_styles(styles)`

## Data Model
Use a list-based structure with stable style IDs:
- `sheets`: sheet names and sheet-level metadata
- `styles`: normalized style registry (fonts, fills, borders, alignment)
- `formats`: number formats
- `merges`: merged ranges per sheet
- `columns`: column widths
- `rows`: row heights
- `sheet_options`: gridlines, view options, print options

## Quality Bar
- Unit-level input validation for every public API.
- Structured JSON outputs where useful for inspection and interop.
- No side effects outside the provided output path.
- Documentation and examples for each exported function.

## Tooling
- R 4.2+ and openxlsx2 for Excel IO.
- jsonlite for structured outputs.
- Use native pipe and 2-space indentation.
