---
description: "Create structured functional specifications from user requirements following constitutional principles"
---

You are implementing the `/speckit.specify` command for Spec-Driven Development.

**Purpose**: Transform user requirements into comprehensive, structured specifications that serve as executable blueprints for development.

## Prerequisites

Before processing, verify:
- [ ] Constitutional document exists (`.specify/memory/constitution.md`)
- [ ] Git repository is initialized 
- [ ] User has provided clear requirements

If constitution missing, suggest running `/speckit.constitution` first.

## Command Processing

### 1. Requirements Analysis
- Parse user requirements for core functionality
- Identify user types and their goals
- Extract business value and motivations
- Note any technical constraints mentioned
- Flag ambiguous or incomplete areas

### 2. Feature Branch Management
- Determine next feature number (scan existing `.specify/specs/` directory)
- Generate semantic branch name from requirements
- Create git branch: `[number]-[feature-name]` (e.g., `001-accessible-tables`)
- Switch to new branch for specification work

### 3. Specification Generation

Create comprehensive specification using template structure:

#### Core Sections:
1. **Overview**: ID, branch, priority, complexity, summary
2. **User Stories**: Primary stories with acceptance criteria
3. **Functional Requirements**: Core functionality, data, integration needs
4. **Non-Functional Requirements**: Performance, accessibility, usability
5. **Technical Constraints**: Technology, environmental, organizational limits
6. **Dependencies**: Upstream, downstream, external requirements
7. **Success Criteria**: Definition of done, acceptance scenarios

#### Constitutional Compliance:
- Verify alignment with constitutional principles
- Include library-first architecture requirements
- Specify CLI interface needs
- Plan for test-first development
- Address documentation requirements
- Include accessibility standards where applicable

### 4. Uncertainty Management
Use `[NEEDS CLARIFICATION: specific question]` markers for:
- Ambiguous requirements
- Missing technical details
- Unclear business rules
- Undefined integration points
- Unspecified performance criteria

**Critical**: Never guess or make assumptions - mark for clarification instead.

### 5. Quality Validation

Include comprehensive review checklist:
- [ ] Requirement completeness (no unclear areas)
- [ ] Constitutional compliance verified
- [ ] User stories have testable acceptance criteria
- [ ] Non-functional requirements are measurable
- [ ] Dependencies identified and documented
- [ ] Success criteria are specific and achievable

## Specification Structure

### User Story Format:
```markdown
#### Story 1: [User Type] + [Core Action]
**As a** [specific user type]
**I want** [specific capability/goal] 
**So that** [clear business value/benefit]

**Acceptance Criteria:**
- [ ] [Testable condition 1]
- [ ] [Testable condition 2] 
- [ ] [Testable condition 3]
```

### Requirements Format:
```markdown
### Functional Requirements

1. **[Requirement Name]**: [Clear description]
   - Input: [Expected inputs with validation rules]
   - Processing: [Operations performed]
   - Output: [Produced outputs with formats]
   - Validation: [Data validation and error handling]
```

### Accessibility Integration (when applicable):
```markdown
### Accessibility Requirements
- **WCAG Compliance**: Level AA for [specific outputs]
- **Screen Reader Support**: [Specific navigation requirements]  
- **Keyboard Navigation**: [Full keyboard accessibility]
- **High Contrast**: [Visual accessibility support]
```

## Output Requirements

1. **Create Specification File**: 
   - Path: `.specify/specs/[feature-branch]/spec.md`
   - Use specification template with project-specific adaptations
   - Include all required sections with constitutional alignment

2. **Initialize Feature Directory**:
   - Create feature-specific directory structure
   - Prepare for subsequent plan and task documents
   - Set up proper file organization

3. **Provide Next Steps**:
   - Summarize specification created
   - Highlight any clarification needs
   - Recommend next action (clarification or `/speckit.plan`)

## Domain-Specific Adaptations

### For R Package Development:
- Include CRAN compliance requirements
- Specify roxygen2 documentation needs
- Address namespace and dependency management
- Include testthat testing requirements

### For Data Analysis Projects:
- Specify data input/output formats  
- Include reproducibility requirements
- Address data validation and quality checks
- Specify visualization and reporting needs

### For Quarto Documents:
- Include cross-reference requirements
- Specify multi-format output needs (PDF, HTML, DOCX)
- Address citation and bibliography management
- Include accessibility for academic outputs

### For Web Applications:
- Include responsive design requirements
- Specify browser compatibility  
- Address security and authentication
- Include SEO and performance requirements

## Quality Assurance

Before completion, verify:
- [ ] All constitutional principles addressed
- [ ] User stories are complete and testable
- [ ] Non-functional requirements are measurable  
- [ ] Dependencies are identified
- [ ] Assumptions and risks documented
- [ ] Success criteria are achievable
- [ ] Review checklist is complete

## Error Handling

If requirements are insufficient:
- Request specific clarifications
- Provide examples of missing information
- Suggest user story formats for complex scenarios
- Offer templates for technical requirements

## Integration Notes

- Reference constitutional principles throughout
- Coordinate with existing project constraints
- Consider Context7 integration for library documentation
- Align with OpenCode security and quality guidelines
- Prepare for subsequent planning and implementation phases

The specification becomes the authoritative source of truth that drives all subsequent development activities.