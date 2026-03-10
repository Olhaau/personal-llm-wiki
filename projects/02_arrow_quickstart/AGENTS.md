# AGENTS.md - 02_arrow_quickstart guide for coding agents

## Scope
- This guide applies to `/home/oli/newwork/dev/projects/02_arrow_quickstart`.
- Repository focus: R scripts for CSV/Parquet/DTA conversion and benchmarking.
- Prefer deterministic, scriptable workflows over ad hoc interactive steps.

## Project layout
- `csv_to_parquet.R`: baseline CSV -> Parquet converter.
- `csv_to_parquet_with_int64_fix.R`: memory-aware type detection + int64-safe conversion.
- `parquet_to_dta.R`: Parquet -> Stata `.dta` conversion with optional Stata `compress`.
- `benchmark_csv_to_parquet.sh`: benchmark harness for runtime/RAM/file size.
- `data/`: sample inputs and generated outputs used for local validation.

## External rules check
- Cursor rules: none found in `.cursor/rules/`.
- Cursor rules file: none found at `.cursorrules`.
- Copilot instructions: none found at `.github/copilot-instructions.md`.

## Environment and dependencies
- R: 4.2+ recommended.
- Required R packages:
  - `arrow`
  - `haven` (for `.dta` export)
  - `tidyselect` (used by streaming type inference)
- Optional quality tools:
  - `lintr`
  - `styler`
  - `testthat`

Install core packages:
- `Rscript -e "install.packages(c('arrow','haven','tidyselect'))"`

Install optional dev tools:
- `Rscript -e "install.packages(c('lintr','styler','testthat'))"`

## Build and run commands
- There is no package build system (`DESCRIPTION`/`NAMESPACE` absent).
- Treat this as a script project; validation is command-based.

Run baseline converter:
- `Rscript -e "source('csv_to_parquet.R'); convert_csv_to_parquet('data/example.csv')"`

Run int64-safe converter:
- `Rscript -e "source('csv_to_parquet_with_int64_fix.R'); convert_csv_to_parquet_int64_safe('data/int_overflow_example.csv')"`

Run Parquet -> DTA converter:
- `Rscript -e "source('parquet_to_dta.R'); convert_parquet_to_dta('data/int_overflow_example.parquet')"`

Run benchmark (default 1e7 rows):
- `./benchmark_csv_to_parquet.sh`

Run benchmark with custom rows:
- `./benchmark_csv_to_parquet.sh 1000000`

## Testing commands
- No formal `tests/` suite exists yet.
- Use script-level smoke tests plus data/schema assertions.

Smoke test baseline conversion:
- `Rscript -e "source('csv_to_parquet.R'); out <- convert_csv_to_parquet('data/example.csv'); stopifnot(file.exists(out))"`

Smoke test int64 detection:
- `Rscript -e "source('csv_to_parquet_with_int64_fix.R'); info <- detect_csv_arrow_types('data/int_overflow_example.csv'); stopifnot('big_count' %in% info$overflow_columns)"`

Smoke test DTA export:
- `Rscript -e "source('parquet_to_dta.R'); res <- convert_parquet_to_dta('data/int_overflow_example.parquet', use_stata_compress = FALSE); stopifnot(file.exists(res$dta_path))"`

If/when a testthat suite is added:
- Run all tests:
  - `Rscript -e "testthat::test_dir('tests/testthat')"`
- Run a single test file:
  - `Rscript -e "testthat::test_file('tests/testthat/test_csv_to_parquet.R')"`
- Run a filtered test subset:
  - `Rscript -e "testthat::test_dir('tests/testthat', filter = 'int64')"`

## Lint and formatting
- Lint one script:
  - `Rscript -e "lintr::lint('csv_to_parquet_with_int64_fix.R')"`
- Lint all top-level R scripts:
  - `Rscript -e "lintr::lint(c('csv_to_parquet.R','csv_to_parquet_with_int64_fix.R','parquet_to_dta.R'))"`
- Format one script:
  - `Rscript -e "styler::style_file('parquet_to_dta.R')"`

## Coding style guidelines

### Naming and API shape
- Use `snake_case` for functions and variables.
- Keep function names explicit and action-oriented (`convert_*`, `detect_*`, `infer_*`).
- Prefer returning named lists for multi-value outputs.
- Keep existing function signatures backward compatible unless asked to break them.

### Imports and namespaces
- Prefer `pkg::fn()` calls rather than broad `library()` imports in scripts.
- Use `requireNamespace(..., quietly = TRUE)` checks in user-facing entry functions.
- Keep package usage minimal and justified.

### Types and schema handling
- Prefer explicit Arrow schema creation for controlled conversion logic.
- Promote integer-like columns to `int64` when values can exceed int32 range.
- Preserve textual columns as `utf8` when numeric parsing is ambiguous.
- For large CSVs, process one column at a time for inference stability.

### Memory and performance
- Avoid loading full CSV as all-string data frames for large inputs.
- Use Arrow read options (`block_size`, chunked access) for scalable scanning.
- Keep benchmark artifacts in `data/` local-only unless user requests commit.

### Formatting
- Keep lines <= 100 chars when practical.
- Use double quotes consistently for strings.
- Use early returns and small helpers to keep logic readable.
- Add comments only for non-obvious behavior.

### Error handling
- Validate file existence before reading.
- Validate required package availability with actionable install hints.
- Use `stop()` for hard failures and `warning()` for lossy/coercive paths.
- Include contextual details in errors (file path, column name, status code).

### Numeric safety
- Explicitly guard integer precision boundaries:
  - int32 threshold: `2147483647`
  - double exact integer threshold: `2^53 - 1`
- Warn when converting `integer64` to double for Stata interoperability.

### Shell script conventions
- Use `#!/usr/bin/env bash` and `set -euo pipefail`.
- Quote variable expansions in paths.
- Keep benchmark scripts idempotent (reuse generated data if present).

## Data and outputs
- Treat `data/` as a working area for examples/benchmarks.
- Do not commit large generated files unless explicitly requested.
- Prefer deterministic sample generation (`set.seed(...)`) in benchmarks.

## Git hygiene for agents
- Keep commits focused to a single feature/fix.
- Avoid touching unrelated files in sibling projects.
- Do not rewrite history unless explicitly requested.

## Recommended validation sequence before handoff
- 1) Run smoke test for changed script.
- 2) Verify output file exists and schema looks correct.
- 3) Run lint on touched files (if lintr is installed).
- 4) Provide concise notes on warnings, tradeoffs, and limitations.
