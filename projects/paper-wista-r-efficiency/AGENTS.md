# AGENTS.md - WISTA Academic Paper Project

## Project Overview
Quarto book project for German academic paper on R efficiency analysis in official statistics. Includes synthetic BTP (Business-Tax-Panel) data generator for benchmarking.

## Build/Test Commands
- **Quarto**: `quarto render` (full build), `quarto preview` (live), `quarto render sections/[file].qmd` (single section)
- **R Scripts**: `Rscript dev/experiment/synth_btp.R` (direct execution), `Rscript dev/experiment/test_synth_btp.R` (full test suite)
- **Single Test**: `cd dev/experiment && Rscript -e "source('synth_btp.R'); synth_btp(obs=100, seed=42)"`

## Code Style Guidelines
### R Scripts (synth_btp.R)
- **Naming**: `snake_case` functions, `UPPER_CASE` constants; roxygen2 `#'` docs for exported functions
- **Sections**: Use `# ----` (4 dashes) for major sections; `#' @keywords internal` for helpers
- **Pipes**: Use native `|>` (R 4.1+); load libraries with `suppressPackageStartupMessages(library())`
- **Data**: Use `data.table` for large data; CSV for config (not RDS); year-specific probabilities in `btp_obs_distribution.csv`
- **Error handling**: Validate inputs early with `stop()`; provide fallback defaults if config missing

### Quarto Documents (.qmd)
- **Language**: German primary (`lang: de`), formal academic style; `@sec-name`, `@tbl-name`, `@fig-name` for cross-refs
- **Code chunks**: `#| label: fig-name`, `#| echo: false`, `#| warning: false`; `library()` at chunk start
- **Tables**: `kableExtra::kbl()` with `kable_styling(latex_options = c("hold_position"), full_width = TRUE)`
- **Includes**: Sections via `{{< include sections/XX-name.qmd >}}` in index.qmd

### LaTeX/Typography
- **WISTA colors**: `wistaBlue`, `wistaDarkGray`, `wistaLightGray`
- **Bullets**: `>` (black, scaled 0.35x0.95); arrows: `\ding{247}` (blue pifont)
- **Bibliography**: Full-width one-column; polyglossia for German/English
