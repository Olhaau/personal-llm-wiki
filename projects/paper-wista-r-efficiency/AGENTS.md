# AGENTS.md - WISTA Academic Paper Project

## Project Overview
Quarto book project for German academic paper "Effizienzanalyse statistischer Verfahren in der amtlichen Statistik" with empirical analysis using R.

## Build/Test Commands
- **Full Build**: `quarto render` (generates PDF book in `_book/`)
- **Development**: `quarto preview` (live preview with auto-reload)
- **Single Section**: `quarto render sections/methodology.qmd` or `quarto render sections/results.qmd`
- **Check Output**: View generated PDF in `_book/Effizienzanalyse-statistischer-Verfahren-in-der-amtlichen-Statistik.pdf`

## Code Style Guidelines
### R Code Chunks
- **Libraries**: Load at chunk start with `library(ggplot2)`, `library(dplyr)` etc.
- **Chunk Labels**: Use descriptive labels like `#| label: fig-evaluation-framework`
- **Captions**: Include German captions with `#| fig-cap:` and `#| tbl-cap:`
- **Echo/Warning**: Use `#| echo: false` and `#| warning: false` for clean output
- **Functions**: Use `snake_case`, include proper error handling with `stop()`

### Quarto Documents (.qmd)
- **Language**: Primary German (`lang: de` in `_quarto.yml`), with English abstract
- **Cross-references**: Use `@sec-methodology`, `@tbl-performance`, `@fig-scaling` format
- **Citations**: BibTeX format with `[@eurostat2021quality]` syntax
- **Math**: LaTeX equations with `$$` for display math, `$` for inline
- **Section Headers**: Use `{#sec-name}` anchors for main sections

### Data & Analysis Standards
- **Reproducibility**: Use fixed seeds for random data generation
- **Documentation**: Comment complex calculations and statistical procedures
- **German Terms**: Use proper German statistical terminology consistently
- **Academic Style**: Formal academic writing, proper methodology descriptions