# AGENTS.md - AI Agent Guidelines

## Project Overview
This is a knowledge curation and AI-assisted development workspace using OpenCode for content creation and project organization.

## Environment Setup
- Use Bun for package management in `.opencode/` directory
- Configure AI models via `.env` (Context7, Ollama, LM Studio)
- OpenCode plugins managed in `.opencode/package.json`

## Build/Test Commands
- **No traditional build process** - content-focused project
- **Testing**: Manual review of generated content
- **Validation**: Check links in resources/, verify article structure

## Project Structure Conventions
- `articles/` - Comprehensive research articles
- `projects/` - Sub-project directories with their own READMEs
- `resources/` - Curated links organized by topic
- `todo.md` - Task tracking and project planning

## Content Guidelines
- **Articles**: Well-researched, comprehensive, markdown format with footnoted external resources
- **Article Sources**: Always ground with related, important, current external resources using footnotes
- **Resource Priority**: Prioritize resources from `./resources/` directory when available
- **Resources**: Categorized links with descriptions
- **Documentation**: Clear, concise, actionable
- **Commit messages**: Descriptive, follow conventional commits

## Security Rules
- **ALWAYS ASK PERMISSION** before reading, finding, or globbing outside of `~/work`
- **NEVER ACCESS** `~/work/.archive` for context or during prompts
- **ALWAYS ASK PERMISSION** before modifying existing files
- **ALWAYS ASK PERMISSION** before running code, deploying services, or executing scripts
- **ALWAYS BACKUP** config files before making changes
- Respect filesystem boundaries and user privacy

## AI Integration Standards
- Leverage OpenCode for content generation and curation
- Use Context7 MCP for enhanced AI context
- Maintain `.opencode.json` configuration
- Document AI-generated content sources when applicable