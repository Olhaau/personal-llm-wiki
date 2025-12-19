---
name: "Skill Definer"
description: "Meta-skill for creating new Agent Skills following Anthropic's structured pattern with YAML frontmatter, progressive disclosure, and proper documentation"
---

# Skill Definer

## When to Use This Skill

Use this skill when you need to:
- Create new Agent Skills following Anthropic's pattern
- Structure existing capabilities into reusable skills
- Design skill architectures with progressive disclosure
- Set up proper skill documentation and examples
- Organize code, configurations, and templates within skills

## Core Capability

This skill enables the agent to create well-structured, professional Agent Skills that follow Anthropic's design patterns:

### Progressive Disclosure Architecture
- **Level 1**: YAML frontmatter with name and description (loaded into system prompt)
- **Level 2**: Main SKILL.md content (loaded when skill is triggered)  
- **Level 3+**: Additional referenced files (loaded as needed)

### Proper Skill Structure
- **SKILL.md** - Main skill file with YAML frontmatter
- **Additional markdown files** - Detailed documentation by topic
- **code/** - Executable scripts and helper functions
- **config/** - Configuration files and templates
- **templates/** - Reusable patterns and examples

## Skill Creation Process

For new skill creation, see [`skill-creation-guide.md`](skill-creation-guide.md).

For best practices and design patterns, see [`skill-design-patterns.md`](skill-design-patterns.md).

For examples of well-structured skills, see [`skill-examples.md`](skill-examples.md).

## Quick Start Templates

Use these templates to rapidly create new skills:

### Basic Skill Template
```markdown
---
name: "Your Skill Name"
description: "Brief description of what this skill enables"
---

# Your Skill Name

## When to Use This Skill

Use this skill for:
- Specific use case 1
- Specific use case 2
- Specific use case 3

## Core Capabilities

This skill enables the agent to:
- Primary capability 1
- Primary capability 2
- Primary capability 3

## Quick Start

For immediate use, see [`examples.md`](examples.md).
For advanced features, see [`advanced-usage.md`](advanced-usage.md).

## Basic Usage Pattern

```language
# Code example showing basic usage
```

## File Structure

- `SKILL.md` - This overview
- `examples.md` - Usage examples and code
- `advanced-usage.md` - Complex scenarios
- `code/` - Executable scripts
- `config/` - Configuration files
```

### Advanced Skill Template  
For complex skills with multiple components - see [`advanced-skill-template.md`](advanced-skill-template.md).

## Integration with Development Workflow

This skill integrates with:
- **Code development** - Package existing code into reusable skills
- **Documentation** - Create comprehensive skill documentation
- **Team collaboration** - Standardize skill formats across projects
- **Knowledge management** - Preserve expertise in structured formats

The skill automatically generates proper folder structures, creates template files, and validates skill formats according to Anthropic's standards.

## Validation and Quality Assurance

Skills created with this tool are automatically validated for:
- Proper YAML frontmatter format
- Progressive disclosure structure
- Complete documentation coverage
- Working code examples
- Consistent file organization