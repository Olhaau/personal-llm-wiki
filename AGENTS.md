# AGENTS.md - Multi-Language Development & Knowledge Workspace

## Project Overview
Knowledge curation and AI-assisted development workspace using OpenCode for content creation, R package development, data analysis projects, and technical documentation.

## Build/Test Commands
- **R Projects**: `Rscript test_[component].R` (single test), `Rscript projects/[project]/test_*.R` (project tests)  
- **Python Scripts**: `python3 .opencode/helpers/get_transcript.py [args]` (direct execution)
- **Shell Scripts**: `bash .opencode/command/test-*.sh` (validation scripts)
- **No traditional build** - Direct script execution and content validation

## Code Style Guidelines
### R Scripts
- **Naming**: Use `snake_case` for functions, `UPPER_CASE` for constants
- **Sections**: Use `# ----` (exactly 4 dashes) for major sections  
- **Documentation**: Include roxygen2 `#'` comments for exported functions
- **Pipes**: Use native `|>` pipe (R 4.1+), avoid magrittr `%>%`
- **Libraries**: Load with `library()` at top, use `suppressPackageStartupMessages()`
- **Error handling**: Use `stop()` with descriptive messages, validate inputs early

### Python Scripts  
- **Style**: Follow PEP 8, use docstrings for functions
- **Imports**: Standard library first, third-party second, local third
- **Error handling**: Use try/except with specific exceptions, descriptive messages
- **Functions**: Use `snake_case`, include type hints when beneficial

### Bash Scripts
- **Headers**: Include shebang `#!/bin/bash` and description comments
- **Error handling**: Use `set -e` for strict error handling when appropriate
- **Variables**: Use `"${VAR}"` for variable expansion to handle spaces

## Content & Documentation Standards
- **Articles**: Comprehensive markdown with footnoted external resources  
- **Resources**: Categorized links with descriptions in `resources/` directory
- **Documentation**: Clear, concise, actionable with code examples
- **Commit messages**: Follow conventional commits format