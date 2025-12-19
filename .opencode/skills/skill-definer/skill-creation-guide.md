# Skill Creation Guide

## Step-by-Step Skill Creation Process

### 1. Identify the Skill Scope

Before creating a skill, clearly define:
- **Primary purpose** - What specific capability does this skill provide?
- **Target scenarios** - When should this skill be triggered?
- **Domain expertise** - What specialized knowledge does it package?
- **User types** - Who will benefit from this skill?

### 2. Design Progressive Disclosure

Structure information in layers:

#### Level 1: YAML Frontmatter
```yaml
---
name: "Descriptive Skill Name"
description: "Concise explanation of what the skill enables (1-2 sentences max)"
---
```

**Best practices:**
- Name should be clear and searchable
- Description should trigger appropriately without false positives
- Keep description under 200 characters for system prompt efficiency

#### Level 2: Main SKILL.md Content
- **When to Use** - Clear triggering conditions
- **Core Capabilities** - What the skill enables
- **Quick Start** - Immediate usage path
- **File Structure** - Navigation to deeper content

#### Level 3+: Referenced Files
- Detailed examples
- Advanced configurations  
- Specialized use cases
- Code implementations

### 3. Create the Skill Directory Structure

```bash
# Create skill directory
mkdir -p .opencode/skills/your-skill-name

# Create standard structure
mkdir -p .opencode/skills/your-skill-name/code
mkdir -p .opencode/skills/your-skill-name/config  
mkdir -p .opencode/skills/your-skill-name/templates
```

### 4. Write the Main SKILL.md File

Follow this template structure:

```markdown
---
name: "Your Skill Name"
description: "Clear, concise description of the skill's purpose"
---

# Your Skill Name

## When to Use This Skill

Use this skill for:
- Specific scenario 1
- Specific scenario 2  
- Specific scenario 3

## Core Capabilities

This skill enables the agent to:
- Primary capability with brief explanation
- Secondary capability with context
- Advanced feature with use case

## Quick Start

For immediate use, see [`examples.md`](examples.md).
For configuration options, see [`configuration.md`](configuration.md).

## Basic Usage Pattern

```language
# Clear, working example
basic_function(parameters)
```

## File Structure

- `SKILL.md` - This overview file
- `examples.md` - Practical usage examples
- `code/` - Executable scripts and functions
- `config/` - Configuration files and templates

## Integration

This skill integrates with:
- Related system 1
- Related system 2
- Existing workflow components
```

### 5. Create Supporting Documentation

#### examples.md Template
```markdown
# Skill Name Examples

## Basic Usage

### Simple Example
```language
# Working code example with explanation
example_function(data, "output.txt")
```

### Intermediate Example
```language
# More complex scenario
advanced_example(data, config, options)
```

## Advanced Usage

### Complex Scenario
Detailed example with multiple steps and explanations.

### Integration Example  
How to use with other tools or systems.

## Troubleshooting

### Common Issue 1
Problem description and solution.

### Common Issue 2
Problem description and solution.
```

### 6. Add Executable Code

#### code/ Directory Structure
```
code/
├── main-functions.py          # Primary skill functions
├── helpers.py                 # Utility functions  
├── examples.py                # Runnable examples
└── tests.py                   # Validation tests
```

#### Code Best Practices
- Include clear docstrings
- Provide working examples
- Handle errors gracefully
- Follow language-specific conventions

### 7. Create Configuration Templates

#### config/ Directory Examples
```
config/
├── default-config.yaml        # Standard configuration
├── advanced-config.yaml       # Complex scenarios
└── schema.json                # Configuration validation
```

#### Configuration Best Practices
- Use self-documenting formats (YAML/JSON)
- Include comments explaining options
- Provide multiple complexity levels
- Validate configuration formats

### 8. Validate the Skill

Use the validation checklist:

#### Structure Validation
- [ ] Proper YAML frontmatter
- [ ] Clear progressive disclosure
- [ ] Complete file structure
- [ ] Working code examples

#### Content Validation  
- [ ] Name is descriptive and searchable
- [ ] Description triggers appropriately
- [ ] Examples are complete and tested
- [ ] Documentation is comprehensive

#### Integration Validation
- [ ] Skill works in isolation
- [ ] Integrates with existing workflows
- [ ] Follows project conventions
- [ ] Meets user needs

## Advanced Skill Patterns

### Multi-Language Skills
For skills supporting multiple programming languages:

```
your-skill/
├── SKILL.md
├── python/
│   ├── examples.md
│   └── code/
├── r/
│   ├── examples.md  
│   └── code/
└── javascript/
    ├── examples.md
    └── code/
```

### Domain-Specific Skills
For specialized domains (finance, science, etc.):

```
domain-skill/
├── SKILL.md
├── methodology.md              # Domain-specific methods
├── standards.md                # Industry standards
├── regulations.md              # Compliance requirements
├── code/
├── config/
└── templates/
```

### Tool Integration Skills
For skills that integrate external tools:

```
integration-skill/
├── SKILL.md
├── setup.md                   # Installation/configuration
├── api-reference.md           # External API documentation
├── troubleshooting.md         # Common integration issues
├── code/
└── config/
    ├── auth-template.yaml
    └── connection-examples.yaml
```

## Quality Guidelines

### Documentation Quality
- Write for your future self
- Include working examples
- Explain the "why" not just the "how"
- Test all code examples
- Keep documentation in sync with code

### Code Quality
- Follow language best practices
- Include error handling
- Write defensive code
- Add meaningful comments
- Provide clear function signatures

### Usability
- Optimize for common use cases
- Provide multiple complexity levels
- Include troubleshooting guidance
- Design for discovery and exploration
- Test with actual users when possible

This structured approach ensures skills are discoverable, usable, and maintainable while following Anthropic's progressive disclosure principles.