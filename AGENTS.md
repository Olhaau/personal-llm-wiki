# AGENTS.md - Agentic Skill Tests Repository Guide

## Workspace Purpose
- Repository hosts reproducible R workflows that generate Destatis-style Excel reports as part of agentic skill evaluations.
- Agents operate inside `/home/oli/newwork/dev/projects/agentic-skill-tests` with shared tooling from `/home/oli/newwork/dev/.opencode`.
- Keep outputs deterministic to support regression checks across skills and downstream documentation.
- Avoid modifying files outside this project unless instructions explicitly route you to `.opencode` resources.

## Directory Map
- Root files: `create_destatis_cars_report.R`, `destatis_sample.xlsx`, `output/` for generated artefacts.
- External helpers: `.opencode/examples/excel-r-examples.R` supplies reusable Excel routines sourced by the main script.
- There are no `.cursor` or `.github/copilot` rule files; follow this document and upstream OpenCode defaults.
- Treat `destatis_sample.xlsx` as read-only fixture data; never commit hand-edited spreadsheets.
- Ensure `output/` remains git-ignored unless explicitly asked to deliver artefacts.

## Dependencies
- R 4.2+ recommended; script relies on native pipe, tidyverse-style verbs, and openxlsx2 APIs.
- Required libraries: `openxlsx2`, `dplyr`, `tidyr`, `forcats`, `lubridate`; helper file also pulls `openxlsx`, `readxl`, `gt`, `yaml`.
- Use `suppressPackageStartupMessages()` when loading packages to maintain quiet logs, matching existing pattern.
- When adding packages, update onboarding instructions here and provide installation snippets in Setup section.
- Prefer CRAN versions; note down any GitHub remotes in this file and in commit messages to keep reproducibility clear.

## Environment Setup
- Install dependencies with `Rscript -e "install.packages(c('openxlsx2','dplyr','tidyr','forcats','lubridate','readxl','gt','yaml'))"`.
- Create an isolated library via `renv::init()` if long-lived experimentation is expected; capture lockfile changes deliberately.
- Load helper examples by keeping relative paths intact; do not relocate scripts without updating `source('../../.opencode/...')` calls.
- Use UTF-8 locale to avoid encoding drift in German labels; avoid Excel exports outside this charset.
- Confirm write access to `output/` before running scripts to prevent silent failures from `wb$save()` calls.

## Quick Execution Commands
- Generate the standard report: `Rscript create_destatis_cars_report.R` (non-interactive run, writes `output/statistischer_bericht_kraftfahrzeuge.xlsx`).
- Run a specific function without full script: `Rscript -e "source('create_destatis_cars_report.R'); create_destatis_statistical_report('output/custom.xlsx')"`.
- Preview data prep interactively: `Rscript -e "source('create_destatis_cars_report.R'); head(prepare_cars_for_destatis())"`.
- Trace helper availability: `Rscript -e "source('../../.opencode/examples/excel-r-examples.R')"` executed from repo root.
- Use `Rscript -e "openxlsx2::openXL('output/statistischer_bericht_kraftfahrzeuge.xlsx')"` locally to open the generated workbook for QA (do not commit changes).

## Testing & Validation
- No automated tests ship with this repository; agents should validate by re-running report generation and inspecting console output.
- To add targeted tests, scaffold `tests/testthat/test_<topic>.R` and execute `Rscript -e "testthat::test_file('tests/testthat/test_<topic>.R')"` for a single spec.
- For broader suites, run `Rscript -e "testthat::test_dir('tests')"`; update this document once such suites land in git.
- Validate Excel integrity with `Rscript -e "source('.opencode/examples/excel-r-examples.R'); analyze_excel_file('output/<file>.xlsx')"`.
- Record manual QA steps in PR descriptions until automated checks exist.

## Linting & Formatting
- Use `Rscript -e "lintr::lint('create_destatis_cars_report.R')"` for quick feedback; configure `lintr` settings via `.lintr` if introduced.
- Apply `styler` for formatting: `Rscript -e "styler::style_file('create_destatis_cars_report.R')"`; review diffs carefully before committing.
- Avoid automated formatters on helper files sourced from `.opencode` unless you own those shared resources.
- Keep line width ≤ 100 characters to preserve readability inside CLI editors.
- Retain `# ----` section markers; they double as navigation anchors for agents.

## Excel Workflow Rules
- **ALL Excel modifications must use the `excel-operations` skill** located at `.opencode/skills/excel-operations/`; never hand-edit binary files.
- When generating new spreadsheets, prefer programmatic generation through `openxlsx2` helpers and log filenames in commit messages.
- Store configuration-driven behaviour (colours, metadata) inside R code or YAML configs; avoid ad hoc constants scattered across files.
- Document any new Excel templates within this guide and the skill instructions to keep reviewers aligned.
- When debugging Excel output, export additional diagnostics as CSV via `readr::write_csv()` rather than editing the workbook manually.

## R Coding Style
- Functions use `snake_case`; keep exported helpers documented with `#'` roxygen preambles when they leave this repo.
- Group related helpers under clear `# ----` headers; order sections Setup → Data Prep → Output → Helpers → Execution.
- Imports stay at top inside a single `suppressPackageStartupMessages({ ... })` block; list packages alphabetically for discoverability.
- Prefer tidyverse verbs (`mutate`, `summarise`, `pivot_longer`) with explicit `dplyr::` prefixes only when namespace clashes occur.
- Use native pipe `|>` for new code; existing `%>%` sequences in shared files may remain for compatibility but avoid introducing more.
- For constants, declare uppercase names (e.g., `DESTINATIONS <- c(...)`) and place near usage to minimise global scope.
- Manage factor ordering with `forcats` utilities; avoid manual numeric encodings where labelled factors improve clarity.
- Inline German text should stay in UTF-8 plain strings; wrap long paragraphs across multiple entries like the methodology vector.
- Validate inputs early using `stop()` with contextual messages; convert `if` checks to `stopifnot()` only when messages are self-explanatory.
- Rely on `tryCatch()` with informative `error = function(e)` branches when handling IO or Excel operations.

## Data Handling
- Use built-in `cars` dataset for reproducibility; note any dataset swaps in this guide and commit messages.
- Conversions must leverage explicit multipliers (mph→km/h, feet→meters) with rounding handled via `round()` to one decimal as the script shows.
- Keep reporting period fields in ISO `YYYY-MM` format; avoid locale-dependent month abbreviations in persisted outputs.
- Sequence IDs (`laufende_nummer`) should remain 1-indexed and gapless; recalculate after filtering to prevent join artefacts.
- When extending categorisations, update both labels and downstream pivot tables to keep the workbook consistent.

## Logging & Messaging
- Use `cat()` for user-facing CLI messages and `message()` for diagnostic output discoverable via `suppressMessages`.
- Prepend progress indicators (e.g., `✓`, `✗`) to align with existing helper feedback style.
- Wrap long status updates across multiple `cat()` calls instead of embedding newline escapes inside a single string.
- Ensure interactive checks print actionable next steps; e.g., prompt to open output file or rerun with different filename.
- When errors are expected (missing file, package), surface them with descriptive `stop()` text rather than silent returns.

## Git & Workflow Expectations
- Branch naming: `feature/<topic>`, `fix/<bug>`, or `docs/agents-update` for documentation tweaks like this file.
- Commit messages follow Conventional Commits (`docs: update agent handbook`, `feat: add test harness`).
- Never rewrite history on shared branches; prefer `git revert` for rollbacks.
- Exclude generated Excel files from commits unless a reviewer explicitly asks for artefacts.
- Reference related issues or tasks in commit bodies so downstream automation can link context.

## Documentation & Reporting
- Maintain this `AGENTS.md` as the single source of truth for agent operations; update sections whenever workflows change.
- Provide step-by-step reproduction instructions in PR descriptions, including commands from the Quick Execution section.
- When adding new scripts, document their purpose, invocation, and outputs here under a fresh subsection.
- Record manual QA in `docs/` or within PR checklists to build an audit trail.
- Keep German terminology consistent with Destatis standards; cross-check against official style guides when unsure.

## Collaboration Patterns
- Use pair review for significant Excel template changes; mention which agent validated the output.
- Annotate complex transformations with short inline comments only when the logic is non-obvious; avoid restating code behaviour.
- Prefer modular helper functions over deeply nested pipelines to keep review overhead manageable.
- Share reusable snippets inside `.opencode/examples/` so other repositories can consume improvements.
- Document known limitations (e.g., charting gaps in openxlsx2) before shipping features that depend on them.

## Future Automation Hooks
- Plan for CI by scripting `Rscript create_destatis_cars_report.R` and verifying the Excel file existence plus sheet count.
- Consider integrating `lintr::lint_package()` once package scaffolding exists; document configuration within this file.
- Explore CSV diffs for key tables stored alongside Excel output to enable text-based regression tests.
- Track dependency updates using `renv::snapshot()` and summarise notable changes here.
- Expose CLI flags (e.g., `--output`) via `optparse` if the script grows more complex; document usage once implemented.

## Support & Escalation
- For shared tooling issues, inspect `.opencode/` scripts and coordinate updates with workspace maintainers.
- Raise blockers in repository issues referencing section titles from this guide for quick discovery.
- When encountering missing packages, note installation commands and versions in the Dependencies section during updates.
- Capture lessons learned after major edits under a new subsection within this file to inform future agents.
- Keep this document near 150 lines; prune obsolete guidance when adding new material to preserve clarity.

## Data QA Checklist
- Regenerate the Excel workbook and confirm five worksheets exist: index, raw data, summary stats, crosstab, methodology.
- Spot-check converted columns (`geschwindigkeit_kmh`, `bremsweg_meter`) against manual calculations for two sample rows.
- Verify category labels remain ordered logically by calling `unique()` on factor columns inside an R console session.
- Ensure reporting period strings match the current month in `YYYY-MM` everywhere they appear.
- Save console output from validation runs in PR discussions for traceability.

## Performance Notes
- Current workflow handles the built-in `cars` dataset instantly; document any scalability testing with larger frames.
- When optimising, prefer vectorised dplyr verbs over manual loops to keep Excel generation fast.
- Cache expensive external data loads upstream; avoid writing temporary files outside `output/`.
- Reuse workbook style helpers instead of recreating styles in tight loops to reduce `openxlsx2` overhead.
- Profile new pipelines with `Rprof()` or `profvis` before merging substantive refactors.

## Security & Privacy
- Do not embed credentials or personal data inside the Excel output or supporting scripts.
- Review third-party package licenses before adding dependencies and note approvals in commit bodies.
- Keep generated artefacts out of version control unless explicitly required for review.
- Sanitise any external datasets by stripping identifiers prior to integrating with this pipeline.
- Validate paths received from users to prevent directory traversal when extending file IO helpers.

## Tooling Tips
- Use `wb$set_properties()` to tag workbooks with descriptive metadata for auditors.
- Lean on `analyze_excel_file()` from `.opencode/examples/` to inspect sheet structure without opening Excel manually.
- Leverage `openxlsx2::wb_color()` helpers to centralise colour palettes for Destatis branding.
- Prefer `readxl::read_excel()` for ingestion, then convert to tibble for consistent downstream handling.
- Store reusable style constructors near the top of the script to make theme adjustments easier.

## FAQ for Agents
- **Where do I add new sheets?** Extend `create_destatis_statistical_report()` and mirror the pattern in helper functions.
- **How do I change the colour scheme?** Update `create_destatis_styles()` once and propagate using shared style objects.
- **Can I switch datasets?** Yes, wrap the loader in a new helper and document dataset provenance in this guide.
- **What if Excel export fails?** Wrap `wb$save()` inside `tryCatch()` and surface the error with context for reviewers.
- **Is there a CI pipeline?** Not yet; note any manual verification steps inside PR descriptions.

## Revision History
- 2026-01-22: Expanded guide to cover execution, style, validation, and collaboration norms for Destatis Excel workflow.
- Update this table manually with future significant changes so agents can understand context quickly.
