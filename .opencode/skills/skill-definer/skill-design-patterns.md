# Skill Design Patterns

## Progressive Disclosure Patterns

### Pattern 1: Simple → Advanced
Structure content from basic to complex:

```
SKILL.md (overview + basic usage)
├── examples.md (working code examples)  
├── advanced-usage.md (complex scenarios)
└── expert-guide.md (optimization & edge cases)
```

**When to use:** Skills with wide audience from beginners to experts

### Pattern 2: Topic-Based Disclosure
Organize by functional areas:

```
SKILL.md (overview + navigation)
├── data-processing.md
├── visualization.md  
├── export-formats.md
└── troubleshooting.md
```

**When to use:** Skills with distinct functional components

### Pattern 3: Workflow-Based Disclosure
Structure around common workflows:

```
SKILL.md (overview)
├── quick-start.md (immediate results)
├── standard-workflow.md (typical process)
├── advanced-workflows.md (complex processes)
└── customization.md (adaptation guide)
```

**When to use:** Process-oriented skills with defined workflows

## Context Window Optimization

### Minimize Initial Load
Keep SKILL.md concise and focused:

```markdown
---
name: "Data Processor"
description: "Process and transform datasets with validation and error handling"
---

# Data Processor

## When to Use This Skill
- Data cleaning and transformation tasks
- Format conversion between data types
- Validation and quality assessment

## Core Capabilities
Data validation, transformation, and export with error handling.

For examples, see [`examples.md`](examples.md).
For configuration, see [`config-guide.md`](config-guide.md).

## Quick Start
```python
process_data(input_file, output_file, validation_rules)
```

## File Structure
[Clear navigation to detailed content]
```

### Reference Large Context
Use file references for detailed information:

```markdown
## Advanced Configuration

For complete configuration options, see [`configuration-reference.md`](configuration-reference.md).

For performance tuning, see [`performance-guide.md`](performance-guide.md).
```

### Code Execution vs. Context
Balance between reading code into context vs. executing directly:

**Read into context:** Documentation, configuration, small examples
**Execute directly:** Data processing, file operations, complex algorithms

## Code Organization Patterns

### Pattern 1: Functional Organization
```
code/
├── core-functions.py          # Primary skill functions
├── utilities.py               # Helper functions
├── validators.py              # Input/output validation
└── examples.py               # Runnable examples
```

### Pattern 2: Workflow Organization  
```
code/
├── input-processing.py        # Data ingestion
├── transformation.py          # Core transformations
├── output-formatting.py       # Result formatting
└── workflow-orchestration.py  # Complete workflows
```

### Pattern 3: Component Organization
```
code/
├── parser/                    # Parsing components
├── processor/                 # Processing components  
├── exporter/                  # Export components
└── main.py                   # Orchestration
```

## Configuration Patterns

### Pattern 1: Layered Configuration
```
config/
├── defaults.yaml              # Base configuration
├── profiles/
│   ├── development.yaml       # Dev overrides
│   ├── production.yaml        # Prod overrides
│   └── custom-template.yaml   # User customization
└── schema.json               # Validation schema
```

### Pattern 2: Feature-Based Configuration
```
config/
├── data-sources.yaml          # Input configuration
├── processing-rules.yaml      # Transformation rules
├── output-formats.yaml        # Export options
└── validation-rules.yaml      # Quality checks
```

### Pattern 3: Template-Driven Configuration
```
config/
├── project-templates/         # Complete project configs
├── component-templates/       # Reusable components
└── examples/                 # Working configurations
```

## Documentation Patterns

### Pattern 1: Reference + Tutorial
```
SKILL.md (overview)
├── tutorial.md               # Step-by-step learning
├── reference.md              # Complete API reference
├── cookbook.md               # Common recipes
└── troubleshooting.md        # Problem solving
```

### Pattern 2: Audience-Based Documentation
```
SKILL.md (overview)
├── user-guide.md             # End-user documentation
├── developer-guide.md        # Technical implementation
├── administrator-guide.md     # Setup and maintenance
└── api-reference.md          # Technical reference
```

### Pattern 3: Scenario-Based Documentation
```
SKILL.md (overview)  
├── getting-started.md        # First-time usage
├── common-scenarios.md       # Typical use cases
├── advanced-scenarios.md     # Complex applications
└── integration-guide.md      # Working with other tools
```

## Error Handling Patterns

### Pattern 1: Graceful Degradation
```python
def robust_skill_function(data, config):
    try:
        return advanced_processing(data, config)
    except AdvancedError:
        logger.warning("Advanced processing failed, using basic method")
        return basic_processing(data)
    except Exception as e:
        logger.error(f"Processing failed: {e}")
        return {"error": str(e), "fallback_data": safe_fallback(data)}
```

### Pattern 2: Validation Chains
```python
def validate_and_process(data):
    validators = [check_format, check_completeness, check_quality]
    
    for validator in validators:
        result = validator(data)
        if not result.valid:
            return {"error": result.message, "data": None}
    
    return process_validated_data(data)
```

### Pattern 3: Progressive Error Recovery
```python
def process_with_recovery(data, config):
    try:
        return full_processing(data, config)
    except ConfigError:
        return process_with_defaults(data)
    except DataError:
        return process_cleaned_data(clean_data(data), config)
    except Exception:
        return minimal_processing(data)
```

## Integration Patterns

### Pattern 1: Plugin Architecture
```
skill-name/
├── SKILL.md
├── core/                     # Core functionality
├── plugins/                  # Optional extensions
│   ├── database-plugin/
│   ├── visualization-plugin/
│   └── export-plugin/
└── examples/                 # Integration examples
```

### Pattern 2: Pipeline Integration
```python
# Skill designed to work in data pipelines
def pipeline_compatible_function(data, **kwargs):
    """Function signature compatible with common pipeline tools"""
    processed_data = core_processing(data)
    return {
        "data": processed_data,
        "metadata": extract_metadata(processed_data),
        "status": "success"
    }
```

### Pattern 3: Service Integration
```
skill-name/
├── SKILL.md
├── integrations/
│   ├── api-clients/          # External service clients
│   ├── webhooks/            # Webhook handlers
│   └── connectors/          # Data source connectors
└── config/
    └── service-configs/      # Service-specific configurations
```

## Testing and Validation Patterns

### Pattern 1: Example-Driven Testing
```python
def test_examples():
    """Test all examples from documentation"""
    examples = load_examples_from_docs()
    for example in examples:
        result = execute_example(example)
        assert result.success, f"Example failed: {example.name}"
```

### Pattern 2: Configuration Validation
```python
def validate_skill_config(config_file):
    """Validate skill configuration against schema"""
    config = load_config(config_file)
    schema = load_schema("config/schema.json")
    return validate_against_schema(config, schema)
```

### Pattern 3: Integration Testing
```python
def test_skill_integration():
    """Test skill works with common tools and workflows"""
    test_cases = [
        test_with_pandas_pipeline,
        test_with_jupyter_notebook,
        test_with_command_line_interface
    ]
    return run_integration_tests(test_cases)
```

## Performance Patterns

### Pattern 1: Lazy Loading
```python
class SkillClass:
    def __init__(self):
        self._heavy_resource = None
    
    @property
    def heavy_resource(self):
        if self._heavy_resource is None:
            self._heavy_resource = load_heavy_resource()
        return self._heavy_resource
```

### Pattern 2: Caching
```python
from functools import lru_cache

@lru_cache(maxsize=128)
def expensive_operation(data_hash, config_hash):
    return complex_processing(data, config)
```

### Pattern 3: Streaming Processing
```python
def process_large_dataset(data_source):
    """Process data in chunks to manage memory"""
    for chunk in stream_data(data_source):
        yield process_chunk(chunk)
```

These patterns help create skills that are maintainable, performant, and follow Anthropic's progressive disclosure principles while integrating well with existing development workflows.