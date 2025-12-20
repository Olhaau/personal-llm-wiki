---
description: "Demonstrate SpecKit integration with OpenCode - show the five-command workflow in action"
---

You are demonstrating the SpecKit integration with OpenCode for multi-language development workflows.

**Purpose**: Show how Spec-Driven Development transforms traditional coding by making specifications executable and the primary source of truth.

## Demo Workflow

### Phase 1: Constitutional Governance

**Command**: `/speckit.constitution`

**Demo for R Package Development**:
```markdown
/speckit.constitution Create principles for R package development focused on 
accessibility compliance, CRAN standards, test-driven development with testthat, 
and comprehensive roxygen2 documentation. Include governance for statistical 
accuracy and reproducible research outputs.
```

**Expected Output**:
- Creates `.specify/memory/constitution.md` with R-specific articles
- Establishes CRAN compliance gates
- Defines accessibility standards (WCAG 2.1 AA)
- Sets up test-first methodology with testthat
- Includes documentation requirements for statistical functions

### Phase 2: Specification Creation  

**Command**: `/speckit.specify`

**Demo for Accessible Excel Tables**:
```markdown
/speckit.specify Build R functions that create Excel tables with full WCAG 2.1 AA 
accessibility compliance. Tables must include proper headers for screen readers, 
keyboard navigation support, high contrast compatibility, and automated alt-text 
generation for charts. Support both openxlsx2 and writexl backends.
```

**Expected Output**:
- Creates feature branch `001-accessible-excel-tables`
- Generates comprehensive specification with:
  - User stories for different accessibility needs
  - WCAG compliance requirements
  - Screen reader navigation specifications
  - Technical constraints for Excel format limitations
- Includes `[NEEDS CLARIFICATION]` markers for ambiguous areas

### Phase 3: Implementation Planning

**Command**: `/speckit.plan`  

**Demo with Technology Choices**:
```markdown
/speckit.plan Use openxlsx2 as primary backend with writexl fallback. Implement 
accessibility layer using custom S3 methods. Include testthat test suite with 
accessibility validation functions. Document with pkgdown site including 
accessibility examples and WCAG compliance guide.
```

**Expected Output**:
- Creates detailed implementation plan in `specs/001-accessible-excel-tables/plan.md`
- Generates data model for accessibility metadata
- Creates API contracts for S3 methods
- Includes research document on Excel accessibility limitations
- Validates against constitutional gates (library-first, CLI-enabled, test-first)

### Phase 4: Task Breakdown

**Command**: `/speckit.tasks`

**Expected Output**:
- Parses implementation plan and creates `tasks.md`
- Breaks down into dependency-ordered tasks:
  ```markdown
  ## User Story 1: Screen Reader Support
  
  ### Phase 1: Foundation
  - [ ] Create accessibility metadata S3 class (R/accessibility.R)
  - [ ] [P] Write accessibility validation tests (tests/testthat/test-accessibility.R) 
  - [ ] Implement header detection functions (R/headers.R)
  
  ### Checkpoint: Validate metadata handling works independently
  ```
- Marks parallel-safe tasks with `[P]`
- Includes file paths for each implementation task

### Phase 5: Implementation Execution

**Command**: `/speckit.implement`

**Expected Process**:
1. **Prerequisites Validation**: Checks constitution, spec, plan, tasks exist
2. **Context7 Integration**: Uses MCP to fetch current openxlsx2 documentation
3. **Test-First Execution**: Writes tests before implementation code
4. **Constitutional Compliance**: Validates against simplicity and CLI gates  
5. **Progress Tracking**: Provides updates on task completion

## Multi-Language Demo

### For Quarto Research Paper:

**Constitution**: 
```markdown
/speckit.constitution Establish principles for academic research with R analysis, 
Quarto publishing, reproducible research standards, and bilingual German/English 
support. Include citation management and cross-reference consistency requirements.
```

**Specification**:
```markdown
/speckit.specify Create automated research pipeline that generates academic paper 
from R analysis with proper citations, cross-references, and multi-format output 
(PDF, HTML, DOCX). Include automated fact-checking and reference validation.
```

### For Data Processing Pipeline:

**Constitution**:
```markdown
/speckit.constitution Define standards for multi-language data pipeline with R 
statistical analysis, Python data processing, and automated Excel reporting. 
Include data quality validation and lineage tracking requirements.
```

**Specification**:  
```markdown
/speckit.specify Build automated pipeline that processes survey data through 
Python cleaning, R statistical analysis, and generates accessible Excel reports 
with WCAG compliance. Include automated data quality checks and audit trails.
```

## Integration Benefits Demonstration

### 1. **Constitutional Consistency**
- Same quality standards across R, Python, Quarto projects
- Automated enforcement through phase gates
- Evolutionary governance with amendment processes

### 2. **Context7 Enhancement**  
- Automatically fetches current library documentation during implementation
- Ensures code uses latest API patterns and best practices
- Reduces outdated documentation issues

### 3. **OpenCode Ecosystem**
- Leverages existing agents (cplan for architecture, cbuild for automation)
- Integrates with security guidelines and permission system
- Uses Task tool for complex multi-step workflows

### 4. **Multi-Language Harmony**
- Constitutional principles adapt to each language's idioms
- Consistent testing and documentation standards
- Unified CLI interfaces across different tech stacks

## Comparison: Before vs After SpecKit

### Traditional Approach:
```markdown
User: "I need R functions for accessible Excel tables"
Agent: *Immediately starts coding*
Result: Works but inconsistent, undocumented, untested, may not meet accessibility standards
```

### SpecKit Approach:
```markdown
User: "I need R functions for accessible Excel tables"  
1. /speckit.constitution → Establishes accessibility and R standards
2. /speckit.specify → Creates comprehensive requirements with WCAG details
3. /speckit.plan → Plans implementation with library research  
4. /speckit.tasks → Breaks into testable, dependency-ordered tasks
5. /speckit.implement → Executes with test-first, constitutional compliance

Result: Production-ready, tested, documented, accessible, constitutionally governed code
```

## Success Metrics

After SpecKit integration, projects should demonstrate:
- **Consistency**: Same quality across languages and domains
- **Maintainability**: Clear specifications that drive updates
- **Accessibility**: WCAG compliance built-in, not retrofitted  
- **Testability**: Test-first approach ensures robust code
- **Documentation**: Specifications become living documentation
- **Velocity**: Structured approach reduces rework and technical debt

## Next Steps for User

1. **Try the Demo**: Use provided commands to see SpecKit in action
2. **Adapt Constitution**: Customize constitutional articles for specific needs
3. **Train Team**: Share SpecKit workflow with other developers
4. **Evolve Process**: Use amendment process to improve constitutional governance
5. **Scale Usage**: Apply to larger projects and multi-team coordination

SpecKit transforms development from ad-hoc coding to systematic, specification-driven engineering that maintains quality and consistency across your entire multi-language workspace.