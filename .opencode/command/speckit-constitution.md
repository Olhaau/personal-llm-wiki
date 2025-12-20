---
description: "Establish or update project constitutional principles that govern all development decisions"
---

You are implementing the `/speckit.constitution` command for Spec-Driven Development.

**Purpose**: Create or update the foundational governing principles for this project that will guide all subsequent development, planning, and implementation decisions.

## Command Processing

When the user provides requirements after `/speckit.constitution`, follow this workflow:

### 1. Assess Project Context
- Examine existing project structure and files
- Identify primary programming languages (R, Python, JavaScript, etc.)
- Determine project type (package development, data analysis, web application, research paper, etc.)
- Check for existing constitutional documents

### 2. Analyze Requirements
- Parse user requirements for domain-specific needs
- Identify quality standards mentioned
- Extract governance preferences
- Note any compliance requirements (WCAG, CRAN, organizational policies)

### 3. Create Constitutional Framework

Generate a constitution with these core articles:

#### Core Articles (Always Include):
- **Article I**: Domain-specific standards for the primary language(s)
- **Article II**: Library-First Principle (modularity requirements)  
- **Article III**: CLI Interface Mandate (automation and testing)
- **Article IV**: Test-First Imperative (TDD requirements)
- **Article V**: Documentation Imperative (completeness standards)

#### Conditional Articles (Based on Project Type):
- **Accessibility Article**: For web/document outputs (WCAG compliance)
- **Data Quality Article**: For data science/analysis projects
- **Research Reproducibility Article**: For academic/research projects
- **Package Standards Article**: For library/package development
- **Multi-language Article**: For polyglot projects

### 4. Include Quality Gates

Add enforcement mechanisms:
- **Simplicity Gates**: Complexity constraints (max projects, dependencies)
- **Anti-Abstraction Gates**: Framework usage principles  
- **Integration-First Gates**: Testing environment requirements
- **Review Gates**: Approval processes for constitutional changes

### 5. Create Directory Structure

Ensure these paths exist:
```
.specify/
├── memory/
│   └── constitution.md
├── templates/
├── scripts/
└── specs/
```

### 6. Constitutional Enforcement

Write enforcement mechanisms:
- Phase gate checklists
- Automated validation steps
- Review and approval processes
- Amendment procedures

## Example Domain Adaptations

### For R Package Development:
```markdown
## Article I: R Development Standards
- Use native pipe `|>` (R 4.1+)
- `snake_case` for functions, `UPPER_CASE` for constants
- Roxygen2 documentation for all exports
- Minimize dependencies, prefer base R
- CRAN compliance for public packages
```

### For Data Analysis Projects:
```markdown  
## Article VI: Data Integrity Standards
- All datasets MUST have metadata documentation
- All transformations MUST be logged and reversible
- All results MUST be reproducible with provided data
- All visualizations MUST be accessible (alt text, high contrast)
```

### For Quarto Research Papers:
```markdown
## Article VII: Research Standards  
- All analyses MUST be fully reproducible
- All citations MUST use BibTeX format
- All cross-references MUST be semantic (@fig, @tbl, @sec)
- All code chunks MUST be properly labeled and documented
```

## Output Requirements

1. **Write Constitution**: Create `.specify/memory/constitution.md` with:
   - Project-specific constitutional articles
   - Quality gates and enforcement mechanisms
   - Review and amendment processes
   - Stakeholder acknowledgment section

2. **Initialize Structure**: Create `.specify/` directory structure if needed

3. **Provide Summary**: Give user overview of:
   - Core principles established
   - Quality gates implemented
   - Next recommended step (typically `/speckit.specify`)

## Quality Validation

Before completing, verify:
- [ ] All core articles included and adapted to project
- [ ] Domain-specific standards appropriate for tech stack
- [ ] Quality gates enforceable and specific
- [ ] Amendment process defined
- [ ] File structure created properly

## Integration Notes

- Leverage existing OpenCode guidelines where applicable
- Coordinate with Context7 MCP rules for library documentation
- Align with established git workflow and security guidelines
- Consider existing project constraints and standards

The constitution becomes the foundational document that all subsequent SpecKit commands (specify, plan, tasks, implement) will reference and enforce.