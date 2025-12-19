#!/usr/bin/env python3
"""
Skill Generator - Create new Agent Skills following Anthropic's pattern

This script creates well-structured Agent Skills with proper YAML frontmatter,
progressive disclosure, and organized file structure.
"""

import os
import yaml
import json
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Optional


class SkillGenerator:
    """Generate new Agent Skills with proper structure and documentation"""

    def __init__(self, skills_base_dir: str = ".opencode/skills"):
        self.skills_base_dir = Path(skills_base_dir)
        self.template_dir = Path(__file__).parent.parent / "templates"

    def create_skill(
        self,
        name: str,
        description: str,
        skill_type: str = "basic",
        language: str = "python",
        domain: Optional[str] = None,
    ) -> Path:
        """
        Create a new skill with proper structure

        Args:
            name: Human-readable skill name
            description: Brief description for YAML frontmatter
            skill_type: Type of skill (basic, advanced, integration, domain)
            language: Primary programming language
            domain: Specific domain if applicable

        Returns:
            Path to created skill directory
        """
        # Create skill directory name (kebab-case)
        skill_dir_name = name.lower().replace(" ", "-").replace("_", "-")
        skill_path = self.skills_base_dir / skill_dir_name

        # Create directory structure
        self._create_directory_structure(skill_path)

        # Generate main SKILL.md file
        self._create_skill_md(skill_path, name, description, skill_type)

        # Generate supporting documentation
        self._create_documentation_files(skill_path, name, skill_type)

        # Generate code templates
        self._create_code_templates(skill_path, language)

        # Generate configuration templates
        self._create_config_templates(skill_path, skill_type)

        print(f"✓ Skill created: {skill_path}")
        print(f"  Name: {name}")
        print(f"  Type: {skill_type}")
        print(f"  Language: {language}")

        return skill_path

    def _create_directory_structure(self, skill_path: Path):
        """Create standard skill directory structure"""
        directories = [
            skill_path,
            skill_path / "code",
            skill_path / "config",
            skill_path / "templates",
        ]

        for directory in directories:
            directory.mkdir(parents=True, exist_ok=True)

    def _create_skill_md(
        self, skill_path: Path, name: str, description: str, skill_type: str
    ):
        """Create main SKILL.md file with YAML frontmatter"""

        # Load template based on skill type
        template_file = self.template_dir / f"{skill_type}-skill.md"
        if not template_file.exists():
            template_file = self.template_dir / "basic-skill.md"

        if template_file.exists():
            template_content = template_file.read_text()
        else:
            template_content = self._get_default_skill_template()

        # Replace placeholders
        content = template_content.format(
            name=name,
            description=description,
            skill_type=skill_type,
            date=datetime.now().strftime("%Y-%m-%d"),
        )

        skill_md_path = skill_path / "SKILL.md"
        skill_md_path.write_text(content)

    def _create_documentation_files(self, skill_path: Path, name: str, skill_type: str):
        """Create supporting documentation files"""

        docs = {
            "examples.md": self._get_examples_template(name),
            "troubleshooting.md": self._get_troubleshooting_template(name),
        }

        # Add type-specific documentation
        if skill_type == "advanced":
            docs["advanced-usage.md"] = self._get_advanced_usage_template(name)
            docs["configuration.md"] = self._get_configuration_template(name)

        elif skill_type == "domain":
            docs["methodology.md"] = self._get_methodology_template(name)
            docs["standards.md"] = self._get_standards_template(name)

        elif skill_type == "integration":
            docs["setup.md"] = self._get_setup_template(name)
            docs["api-reference.md"] = self._get_api_reference_template(name)

        # Write documentation files
        for filename, content in docs.items():
            doc_path = skill_path / filename
            doc_path.write_text(content)

    def _create_code_templates(self, skill_path: Path, language: str):
        """Create code templates for the specified language"""

        code_templates = {
            "python": {
                "main.py": self._get_python_main_template(),
                "helpers.py": self._get_python_helpers_template(),
                "examples.py": self._get_python_examples_template(),
                "tests.py": self._get_python_tests_template(),
            },
            "r": {
                "main.R": self._get_r_main_template(),
                "helpers.R": self._get_r_helpers_template(),
                "examples.R": self._get_r_examples_template(),
                "tests.R": self._get_r_tests_template(),
            },
            "javascript": {
                "main.js": self._get_js_main_template(),
                "helpers.js": self._get_js_helpers_template(),
                "examples.js": self._get_js_examples_template(),
            },
        }

        templates = code_templates.get(language, code_templates["python"])

        for filename, content in templates.items():
            code_path = skill_path / "code" / filename
            code_path.write_text(content)

    def _create_config_templates(self, skill_path: Path, skill_type: str):
        """Create configuration templates"""

        configs = {
            "default-config.yaml": self._get_default_config_template(),
            "schema.json": self._get_config_schema_template(),
        }

        # Add advanced configurations for complex skills
        if skill_type in ["advanced", "integration"]:
            configs["advanced-config.yaml"] = self._get_advanced_config_template()

        for filename, content in configs.items():
            config_path = skill_path / "config" / filename
            config_path.write_text(content)

    # Template methods
    def _get_default_skill_template(self) -> str:
        return """---
name: "{name}"
description: "{description}"
---

# {name}

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
For troubleshooting, see [`troubleshooting.md`](troubleshooting.md).

## Basic Usage Pattern

```python
# Basic usage example
from code.main import main_function
result = main_function(input_data, config)
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
"""

    def _get_examples_template(self, name: str) -> str:
        return f"""# {name} Examples

## Basic Usage

### Simple Example
```python
# Basic usage example
from code.main import basic_function

result = basic_function(input_data)
print(result)
```

### Intermediate Example  
```python
# More complex scenario
from code.main import advanced_function

config = {{"option1": "value1", "option2": "value2"}}
result = advanced_function(input_data, config)
```

## Advanced Usage

### Complex Scenario
Detailed example with multiple steps:

1. Prepare the data
2. Configure options
3. Execute processing  
4. Validate results

### Integration Example
How to use this skill with other tools or systems.

## Common Patterns

### Pattern 1: Batch Processing
```python
# Process multiple items
for item in items:
    result = process_item(item)
    save_result(result)
```

### Pattern 2: Error Handling
```python
# Robust processing with error handling
try:
    result = risky_operation(data)
except SpecificError as e:
    result = fallback_operation(data)
```

## Troubleshooting

See [`troubleshooting.md`](troubleshooting.md) for common issues and solutions.
"""

    def _get_troubleshooting_template(self, name: str) -> str:
        return f"""# {name} Troubleshooting

## Common Issues

### Issue 1: Configuration Error
**Problem:** Configuration file not found or invalid format

**Solution:**
1. Check configuration file path
2. Validate YAML/JSON format
3. Use default configuration template

### Issue 2: Dependencies Missing
**Problem:** Required packages not installed

**Solution:**
```bash
# Install required dependencies
pip install package1 package2
# or
conda install package1 package2
```

### Issue 3: Data Format Error
**Problem:** Input data in unexpected format

**Solution:**
- Validate input data format
- Use data validation functions
- Check examples for correct format

## Performance Issues

### Slow Processing
If processing is slower than expected:
- Check data size and complexity
- Consider batch processing for large datasets
- Review configuration for optimization options

### Memory Usage
For high memory usage:
- Process data in chunks
- Use streaming processing when possible
- Monitor resource usage

## Getting Help

1. Check the examples in [`examples.md`](examples.md)
2. Review configuration options
3. Validate input data format
4. Check system requirements

## Error Messages

### "Configuration not found"
Ensure config file exists in expected location:
```
config/default-config.yaml
```

### "Invalid data format"  
Check that input data matches expected schema.

### "Processing failed"
Review error logs and check data quality.
"""

    def _get_python_main_template(self) -> str:
        return '''"""
Main functionality for this skill

This module contains the core functions that implement the skill's capabilities.
"""

import logging
from typing import Any, Dict, Optional
from pathlib import Path

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def main_function(data: Any, config: Optional[Dict] = None) -> Dict[str, Any]:
    """
    Main entry point for the skill
    
    Args:
        data: Input data to process
        config: Optional configuration dictionary
        
    Returns:
        Dictionary containing results and metadata
    """
    try:
        # Apply default configuration
        if config is None:
            config = load_default_config()
        
        # Validate inputs
        validate_input(data)
        
        # Process data
        result = process_data(data, config)
        
        return {
            "success": True,
            "result": result,
            "metadata": extract_metadata(result)
        }
        
    except Exception as e:
        logger.error(f"Processing failed: {e}")
        return {
            "success": False,
            "error": str(e),
            "result": None
        }

def process_data(data: Any, config: Dict) -> Any:
    """
    Core data processing function
    
    Args:
        data: Input data
        config: Processing configuration
        
    Returns:
        Processed data
    """
    # Implement core processing logic here
    logger.info("Processing data...")
    
    # Placeholder implementation
    processed_data = data
    
    logger.info("Processing complete")
    return processed_data

def validate_input(data: Any) -> None:
    """
    Validate input data
    
    Args:
        data: Data to validate
        
    Raises:
        ValueError: If data is invalid
    """
    if data is None:
        raise ValueError("Input data cannot be None")
    
    # Add specific validation logic here

def extract_metadata(result: Any) -> Dict[str, Any]:
    """
    Extract metadata from processing results
    
    Args:
        result: Processing result
        
    Returns:
        Dictionary containing metadata
    """
    return {
        "type": type(result).__name__,
        "size": len(result) if hasattr(result, '__len__') else 1,
        "timestamp": str(Path(__file__).stat().st_mtime)
    }

def load_default_config() -> Dict[str, Any]:
    """
    Load default configuration
    
    Returns:
        Default configuration dictionary
    """
    return {
        "option1": "default_value1",
        "option2": "default_value2",
        "debug": False
    }

if __name__ == "__main__":
    # Example usage
    sample_data = "sample input"
    result = main_function(sample_data)
    print(f"Result: {result}")
'''

    def _get_python_helpers_template(self) -> str:
        return '''"""
Helper functions for the skill

This module contains utility functions that support the main skill functionality.
"""

import json
import yaml
from pathlib import Path
from typing import Any, Dict, Union

def load_config(config_path: Union[str, Path]) -> Dict[str, Any]:
    """
    Load configuration from file
    
    Args:
        config_path: Path to configuration file
        
    Returns:
        Configuration dictionary
    """
    config_path = Path(config_path)
    
    if not config_path.exists():
        raise FileNotFoundError(f"Configuration file not found: {config_path}")
    
    if config_path.suffix.lower() == '.yaml':
        with open(config_path, 'r') as f:
            return yaml.safe_load(f)
    elif config_path.suffix.lower() == '.json':
        with open(config_path, 'r') as f:
            return json.load(f)
    else:
        raise ValueError(f"Unsupported configuration format: {config_path.suffix}")

def save_result(result: Any, output_path: Union[str, Path]) -> None:
    """
    Save processing result to file
    
    Args:
        result: Result to save
        output_path: Output file path
    """
    output_path = Path(output_path)
    output_path.parent.mkdir(parents=True, exist_ok=True)
    
    if output_path.suffix.lower() == '.json':
        with open(output_path, 'w') as f:
            json.dump(result, f, indent=2)
    elif output_path.suffix.lower() == '.yaml':
        with open(output_path, 'w') as f:
            yaml.safe_dump(result, f, default_flow_style=False)
    else:
        # Default to string representation
        with open(output_path, 'w') as f:
            f.write(str(result))

def format_error(error: Exception) -> Dict[str, Any]:
    """
    Format error information for consistent error handling
    
    Args:
        error: Exception to format
        
    Returns:
        Formatted error dictionary
    """
    return {
        "error_type": type(error).__name__,
        "error_message": str(error),
        "error_class": error.__class__.__module__
    }

def validate_schema(data: Dict[str, Any], schema: Dict[str, Any]) -> bool:
    """
    Simple schema validation
    
    Args:
        data: Data to validate
        schema: Schema definition
        
    Returns:
        True if valid, False otherwise
    """
    try:
        # Basic validation - can be extended with jsonschema library
        for key, expected_type in schema.items():
            if key in data:
                if not isinstance(data[key], expected_type):
                    return False
        return True
    except Exception:
        return False

def safe_get(data: Dict[str, Any], key: str, default: Any = None) -> Any:
    """
    Safely get value from dictionary with default
    
    Args:
        data: Dictionary to search
        key: Key to retrieve
        default: Default value if key not found
        
    Returns:
        Value or default
    """
    return data.get(key, default)
'''

    def _get_python_examples_template(self) -> str:
        return '''"""
Runnable examples for the skill

This module contains complete working examples that demonstrate how to use the skill.
"""

from code.main import main_function
from code.helpers import load_config, save_result

def basic_example():
    """Basic usage example"""
    print("=== Basic Example ===")
    
    # Sample data
    data = "Hello, World!"
    
    # Process with default configuration
    result = main_function(data)
    
    print(f"Input: {data}")
    print(f"Success: {result['success']}")
    print(f"Result: {result['result']}")
    
    return result

def config_example():
    """Example using custom configuration"""
    print("\\n=== Configuration Example ===")
    
    # Sample data
    data = ["item1", "item2", "item3"]
    
    # Custom configuration
    config = {
        "option1": "custom_value",
        "option2": True,
        "debug": True
    }
    
    # Process with custom configuration
    result = main_function(data, config)
    
    print(f"Input: {data}")
    print(f"Config: {config}")
    print(f"Success: {result['success']}")
    
    return result

def file_processing_example():
    """Example processing data from files"""
    print("\\n=== File Processing Example ===")
    
    try:
        # Load configuration from file
        config = load_config("config/default-config.yaml")
        
        # Sample data (in real usage, this would be loaded from file)
        data = {"key1": "value1", "key2": "value2"}
        
        # Process data
        result = main_function(data, config)
        
        # Save result
        save_result(result, "output/example_result.json")
        
        print("Processing complete. Result saved to output/example_result.json")
        
        return result
        
    except FileNotFoundError as e:
        print(f"Configuration file not found: {e}")
        return None

def error_handling_example():
    """Example demonstrating error handling"""
    print("\\n=== Error Handling Example ===")
    
    # Try processing invalid data
    invalid_data = None
    
    result = main_function(invalid_data)
    
    print(f"Input: {invalid_data}")
    print(f"Success: {result['success']}")
    if not result['success']:
        print(f"Error: {result['error']}")
    
    return result

if __name__ == "__main__":
    """Run all examples"""
    print("Running skill examples...")
    
    # Run examples
    basic_example()
    config_example() 
    file_processing_example()
    error_handling_example()
    
    print("\\nAll examples complete!")
'''

    def _get_default_config_template(self) -> str:
        return """# Default Configuration for Skill
# This file contains the default settings for the skill

# Basic configuration options
option1: "default_value1"
option2: "default_value2"
option3: false

# Processing options
processing:
  batch_size: 100
  parallel: false
  timeout: 30

# Output options  
output:
  format: "json"
  pretty_print: true
  include_metadata: true

# Logging options
logging:
  level: "INFO"
  file: null  # Set to file path for file logging
  console: true

# Advanced options
advanced:
  cache_enabled: true
  validation_strict: false
  error_recovery: true
"""

    def _get_config_schema_template(self) -> str:
        schema = {
            "$schema": "http://json-schema.org/draft-07/schema#",
            "title": "Skill Configuration Schema",
            "type": "object",
            "properties": {
                "option1": {"type": "string"},
                "option2": {"type": "string"},
                "option3": {"type": "boolean"},
                "processing": {
                    "type": "object",
                    "properties": {
                        "batch_size": {"type": "integer", "minimum": 1},
                        "parallel": {"type": "boolean"},
                        "timeout": {"type": "integer", "minimum": 1},
                    },
                },
                "output": {
                    "type": "object",
                    "properties": {
                        "format": {"type": "string", "enum": ["json", "yaml", "text"]},
                        "pretty_print": {"type": "boolean"},
                        "include_metadata": {"type": "boolean"},
                    },
                },
                "logging": {
                    "type": "object",
                    "properties": {
                        "level": {
                            "type": "string",
                            "enum": ["DEBUG", "INFO", "WARNING", "ERROR"],
                        },
                        "file": {"type": ["string", "null"]},
                        "console": {"type": "boolean"},
                    },
                },
            },
            "required": ["option1", "option2"],
        }

        return json.dumps(schema, indent=2)

    # Add R templates
    def _get_advanced_usage_template(self, name: str) -> str:
        return f"""# {name} Advanced Usage

## Complex Scenarios

### Scenario 1: Large-Scale Processing
For processing large datasets or complex workflows:

```python
# Configure for large-scale processing
config = {{
    "processing": {{
        "batch_size": 1000,
        "parallel": True,
        "workers": 4
    }},
    "output": {{
        "format": "parquet",
        "compression": "snappy"
    }}
}}

result = advanced_processing(large_dataset, config)
```

### Scenario 2: Custom Pipeline Integration
Integration with data processing pipelines:

```python
# Pipeline integration
def pipeline_processor(data_stream):
    for batch in data_stream:
        processed = main_function(batch, config)
        yield processed
```

## Performance Optimization

### Memory Management
For memory-intensive operations:
- Use streaming processing
- Configure batch sizes appropriately
- Monitor memory usage

### Parallel Processing
Enable parallel processing for better performance:
```python
config["processing"]["parallel"] = True
config["processing"]["workers"] = os.cpu_count()
```

## Advanced Configuration

See [`configuration.md`](configuration.md) for detailed configuration options.
"""

    def _get_configuration_template(self, name: str) -> str:
        return f"""# {name} Configuration Guide

## Configuration Structure

The skill supports multiple configuration formats:
- YAML (recommended)
- JSON  
- Python dictionaries

## Configuration Options

### Basic Options
```yaml
# Basic settings
option1: "value1"
option2: "value2"
debug: false
```

### Processing Options
```yaml
processing:
  batch_size: 100        # Items per batch
  parallel: false        # Enable parallel processing
  workers: 1             # Number of worker processes
  timeout: 30            # Timeout in seconds
```

### Output Options
```yaml
output:
  format: "json"         # Output format: json, yaml, csv
  destination: "output/" # Output directory
  pretty_print: true     # Format output for readability
  include_metadata: true # Include processing metadata
```

### Advanced Options
```yaml
advanced:
  cache_enabled: true    # Enable result caching
  validation_strict: false # Strict input validation
  error_recovery: true   # Enable error recovery
  custom_processors: []  # Custom processing functions
```

## Environment-Specific Configurations

### Development Configuration
```yaml
debug: true
logging:
  level: "DEBUG"
  console: true
processing:
  parallel: false
```

### Production Configuration
```yaml
debug: false
logging:
  level: "INFO"
  file: "/var/log/skill.log"
processing:
  parallel: true
  workers: 8
```

## Configuration Validation

The skill validates configurations against a JSON schema. Invalid configurations will raise detailed error messages.
"""

    def _get_methodology_template(self, name: str) -> str:
        return f"""# {name} Methodology

## Domain Background

This skill implements methods and standards specific to the domain.

## Theoretical Foundation

### Core Concepts
- Concept 1: Definition and application
- Concept 2: Mathematical foundation  
- Concept 3: Practical implementation

### Mathematical Framework
Key formulas and algorithms used:

```
Algorithm 1: Primary processing method
Input: Raw data
Output: Processed results
Steps:
1. Preprocessing
2. Core transformation
3. Validation
4. Output formatting
```

## Implementation Approach

### Data Processing Pipeline
1. **Input Validation**: Ensure data meets domain requirements
2. **Preprocessing**: Clean and normalize data
3. **Core Processing**: Apply domain-specific algorithms
4. **Quality Assurance**: Validate results against standards
5. **Output Generation**: Format results appropriately

### Quality Measures
- Accuracy metrics
- Validation procedures
- Error detection methods

## Best Practices

### Data Quality
- Input validation requirements
- Data cleaning procedures
- Quality assessment criteria

### Processing Guidelines
- Recommended parameters
- Common pitfalls to avoid
- Performance considerations

## References

- Domain-specific standards
- Academic literature
- Industry best practices
"""

    def _get_standards_template(self, name: str) -> str:
        return f"""# {name} Standards and Compliance

## Industry Standards

### Standard 1: [Standard Name]
- **Description**: What this standard covers
- **Compliance Level**: Full/Partial/Planned
- **Implementation**: How it's implemented in the skill

### Standard 2: [Standard Name]
- **Description**: Coverage and scope
- **Compliance Level**: Current status
- **Implementation**: Technical details

## Compliance Requirements

### Data Protection
- Privacy requirements
- Data anonymization procedures
- Retention policies

### Quality Standards
- Accuracy requirements
- Validation procedures
- Documentation standards

### Regulatory Compliance
- Relevant regulations
- Compliance procedures
- Audit trail requirements

## Validation Procedures

### Input Validation
- Format requirements
- Content validation
- Schema compliance

### Output Validation
- Quality checks
- Standard conformance
- Completeness verification

## Certification

### Testing Procedures
- Validation test suites
- Performance benchmarks
- Compliance verification

### Documentation Requirements
- Processing documentation
- Audit trails
- Quality reports

## Updates and Maintenance

### Standard Updates
- Monitoring for standard changes
- Update procedures
- Version control

### Compliance Monitoring
- Regular audits
- Performance monitoring
- Issue tracking
"""

    def _get_setup_template(self, name: str) -> str:
        return f"""# {name} Setup and Installation

## Prerequisites

### System Requirements
- Operating System: Linux/macOS/Windows
- Python: 3.8 or higher
- Memory: 4GB RAM minimum
- Disk Space: 1GB free space

### Dependencies
```bash
# Install required packages
pip install requests pyyaml jsonschema
# or using conda
conda install requests pyyaml jsonschema
```

## Installation

### Quick Installation
```bash
# Clone or download the skill
# No additional installation required
```

### Development Installation
```bash
# For development, install additional tools
pip install pytest black flake8
```

## Configuration

### Basic Configuration
1. Copy default configuration:
```bash
cp config/default-config.yaml config/my-config.yaml
```

2. Edit configuration file:
```yaml
# Customize settings
api_endpoint: "https://api.example.com"
credentials:
  username: "your_username"
  password: "your_password"
```

### Advanced Configuration
See [`configuration.md`](configuration.md) for detailed options.

## Authentication

### API Keys
Set up API authentication:
```bash
export API_KEY="your_api_key"
# or set in configuration file
```

### OAuth Setup
For OAuth authentication:
1. Register application
2. Configure credentials
3. Test authentication

## Verification

### Test Installation
```python
from code.main import main_function
result = main_function("test_data")
assert result["success"] == True
```

### Run Examples
```bash
python code/examples.py
```

## Troubleshooting

### Common Issues
- **Import errors**: Check Python path and dependencies
- **Authentication failures**: Verify credentials and permissions
- **Network issues**: Check connectivity and firewall settings

### Getting Help
- Review examples and documentation
- Check system requirements
- Verify configuration settings
"""

    def _get_api_reference_template(self, name: str) -> str:
        return f"""# {name} API Reference

## Main Functions

### main_function(data, config=None)
Primary entry point for the skill.

**Parameters:**
- `data` (Any): Input data to process
- `config` (Dict, optional): Configuration dictionary

**Returns:**
- `Dict`: Result dictionary with success status and data

**Example:**
```python
result = main_function(input_data, {{"option": "value"}})
```

### process_data(data, config)
Core processing function.

**Parameters:**
- `data` (Any): Input data
- `config` (Dict): Processing configuration

**Returns:**
- `Any`: Processed data

## Helper Functions

### validate_input(data)
Validates input data format and content.

**Parameters:**
- `data` (Any): Data to validate

**Raises:**
- `ValueError`: If data is invalid

### load_config(config_path)
Loads configuration from file.

**Parameters:**
- `config_path` (str): Path to configuration file

**Returns:**
- `Dict`: Configuration dictionary

## Configuration Schema

### Basic Configuration
```json
{{
  "option1": "string",
  "option2": "string", 
  "debug": "boolean"
}}
```

### Advanced Configuration
```json
{{
  "processing": {{
    "batch_size": "integer",
    "parallel": "boolean"
  }},
  "output": {{
    "format": "string",
    "destination": "string"
  }}
}}
```

## Error Handling

### Exception Types
- `ValueError`: Invalid input data
- `FileNotFoundError`: Missing configuration file
- `ProcessingError`: Processing failure

### Error Response Format
```python
{{
  "success": False,
  "error": "Error message",
  "error_type": "ExceptionType"
}}
```

## Examples

See [`examples.md`](examples.md) for complete usage examples.
"""

    def _get_python_tests_template(self) -> str:
        return '''"""
Test suite for the skill

This module contains unit tests for the skill functionality.
"""

import unittest
from unittest.mock import patch, MagicMock
from code.main import main_function, process_data, validate_input
from code.helpers import load_config, save_result

class TestMainFunctionality(unittest.TestCase):
    """Test main skill functions"""
    
    def test_main_function_success(self):
        """Test successful processing"""
        data = "test_data"
        result = main_function(data)
        
        self.assertTrue(result["success"])
        self.assertIsNotNone(result["result"])
        self.assertIn("metadata", result)
    
    def test_main_function_with_config(self):
        """Test processing with custom configuration"""
        data = "test_data"
        config = {"option1": "test_value"}
        
        result = main_function(data, config)
        
        self.assertTrue(result["success"])
    
    def test_validate_input_success(self):
        """Test input validation with valid data"""
        valid_data = "valid_input"
        
        # Should not raise exception
        validate_input(valid_data)
    
    def test_validate_input_failure(self):
        """Test input validation with invalid data"""
        invalid_data = None
        
        with self.assertRaises(ValueError):
            validate_input(invalid_data)

class TestHelperFunctions(unittest.TestCase):
    """Test helper functions"""
    
    @patch('builtins.open')
    @patch('yaml.safe_load')
    def test_load_config_yaml(self, mock_yaml_load, mock_open):
        """Test loading YAML configuration"""
        mock_yaml_load.return_value = {"key": "value"}
        
        result = load_config("test.yaml")
        
        self.assertEqual(result, {"key": "value"})
    
    @patch('pathlib.Path.exists')
    def test_load_config_file_not_found(self, mock_exists):
        """Test handling of missing configuration file"""
        mock_exists.return_value = False
        
        with self.assertRaises(FileNotFoundError):
            load_config("nonexistent.yaml")

class TestIntegration(unittest.TestCase):
    """Integration tests"""
    
    def test_full_workflow(self):
        """Test complete processing workflow"""
        # Test data
        data = {"input": "test"}
        config = {"debug": True}
        
        # Process
        result = main_function(data, config)
        
        # Verify
        self.assertTrue(result["success"])
        self.assertIsNotNone(result["result"])

if __name__ == "__main__":
    unittest.main()
'''

    def _get_r_examples_template(self) -> str:
        return """# Runnable examples for the R skill
# 
# This file contains complete working examples that demonstrate how to use the skill.

source("code/main.R")
source("code/helpers.R")

#' Basic usage example
basic_example <- function() {
  cat("=== Basic Example ===\\n")
  
  # Sample data
  data <- "Hello, World!"
  
  # Process with default configuration
  result <- main_function(data)
  
  cat("Input:", data, "\\n")
  cat("Success:", result$success, "\\n")
  cat("Result:", result$result, "\\n")
  
  return(result)
}

#' Example using custom configuration
config_example <- function() {
  cat("\\n=== Configuration Example ===\\n")
  
  # Sample data
  data <- c("item1", "item2", "item3")
  
  # Custom configuration
  config <- list(
    option1 = "custom_value",
    option2 = TRUE,
    debug = TRUE
  )
  
  # Process with custom configuration
  result <- main_function(data, config)
  
  cat("Input:", paste(data, collapse = ", "), "\\n")
  cat("Config options:", length(config), "\\n")
  cat("Success:", result$success, "\\n")
  
  return(result)
}

#' Example processing data from files
file_processing_example <- function() {
  cat("\\n=== File Processing Example ===\\n")
  
  tryCatch({
    # Load configuration from file
    config <- load_config("config/default-config.yaml")
    
    # Sample data (in real usage, this would be loaded from file)
    data <- list(key1 = "value1", key2 = "value2")
    
    # Process data
    result <- main_function(data, config)
    
    # Save result
    save_result(result, "output/example_result.json")
    
    cat("Processing complete. Result saved to output/example_result.json\\n")
    
    return(result)
    
  }, error = function(e) {
    cat("Error:", e$message, "\\n")
    return(NULL)
  })
}

#' Example demonstrating error handling
error_handling_example <- function() {
  cat("\\n=== Error Handling Example ===\\n")
  
  # Try processing invalid data
  invalid_data <- NULL
  
  result <- main_function(invalid_data)
  
  cat("Input: NULL\\n")
  cat("Success:", result$success, "\\n")
  if (!result$success) {
    cat("Error:", result$error, "\\n")
  }
  
  return(result)
}

# Run all examples if script is executed directly
if (!interactive()) {
  cat("Running R skill examples...\\n")
  
  # Run examples
  basic_example()
  config_example()
  file_processing_example()
  error_handling_example()
  
  cat("\\nAll examples complete!\\n")
}
"""

    def _get_r_tests_template(self) -> str:
        return """# Test suite for the R skill
#
# This file contains unit tests for the skill functionality.

library(testthat)

# Source the main files
source("code/main.R")
source("code/helpers.R")

# Test main functionality
test_that("main_function works with valid input", {
  data <- "test_data"
  result <- main_function(data)
  
  expect_true(result$success)
  expect_equal(result$result, data)
  expect_true("metadata" %in% names(result))
})

test_that("main_function works with custom config", {
  data <- "test_data"
  config <- list(option1 = "test_value")
  
  result <- main_function(data, config)
  
  expect_true(result$success)
})

test_that("validate_input catches NULL input", {
  expect_error(validate_input(NULL), "Input data cannot be NULL")
})

test_that("safe_get returns default for missing key", {
  data <- list(existing_key = "value")
  
  result <- safe_get(data, "missing_key", "default")
  
  expect_equal(result, "default")
})

test_that("safe_get returns value for existing key", {
  data <- list(existing_key = "value")
  
  result <- safe_get(data, "existing_key", "default")
  
  expect_equal(result, "value")
})

# Run tests if script is executed directly
if (!interactive()) {
  test_file("code/tests.R")
}
"""

    def _get_js_main_template(self) -> str:
        return """/**
 * Main functionality for this JavaScript skill
 * 
 * This module contains the core functions that implement the skill's capabilities.
 */

/**
 * Main entry point for the skill
 * @param {*} data - Input data to process
 * @param {Object} config - Optional configuration object
 * @returns {Object} Result object with success status and data
 */
function mainFunction(data, config = null) {
    try {
        // Apply default configuration
        if (config === null) {
            config = loadDefaultConfig();
        }
        
        // Validate inputs
        validateInput(data);
        
        // Process data
        const result = processData(data, config);
        
        return {
            success: true,
            result: result,
            metadata: extractMetadata(result)
        };
        
    } catch (error) {
        console.error(`Processing failed: ${error.message}`);
        return {
            success: false,
            error: error.message,
            result: null
        };
    }
}

/**
 * Core data processing function
 * @param {*} data - Input data
 * @param {Object} config - Processing configuration
 * @returns {*} Processed data
 */
function processData(data, config) {
    console.log("Processing data...");
    
    // Implement core processing logic here
    const processedData = data;
    
    console.log("Processing complete");
    return processedData;
}

/**
 * Validate input data
 * @param {*} data - Data to validate
 * @throws {Error} If data is invalid
 */
function validateInput(data) {
    if (data === null || data === undefined) {
        throw new Error("Input data cannot be null or undefined");
    }
    // Add specific validation logic here
}

/**
 * Extract metadata from processing results
 * @param {*} result - Processing result
 * @returns {Object} Metadata object
 */
function extractMetadata(result) {
    return {
        type: typeof result,
        length: Array.isArray(result) ? result.length : 1,
        timestamp: new Date().toISOString()
    };
}

/**
 * Load default configuration
 * @returns {Object} Default configuration object
 */
function loadDefaultConfig() {
    return {
        option1: "default_value1",
        option2: "default_value2",
        debug: false
    };
}

// Export for Node.js
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        mainFunction,
        processData,
        validateInput,
        extractMetadata,
        loadDefaultConfig
    };
}

// Example usage
if (typeof require !== 'undefined' && require.main === module) {
    const sampleData = "sample input";
    const result = mainFunction(sampleData);
    console.log(`Result: ${JSON.stringify(result)}`);
}
"""

    def _get_js_helpers_template(self) -> str:
        return """/**
 * Helper functions for the JavaScript skill
 * 
 * This module contains utility functions that support the main skill functionality.
 */

const fs = require('fs');
const path = require('path');

/**
 * Load configuration from file
 * @param {string} configPath - Path to configuration file
 * @returns {Object} Configuration object
 */
function loadConfig(configPath) {
    if (!fs.existsSync(configPath)) {
        throw new Error(`Configuration file not found: ${configPath}`);
    }
    
    const ext = path.extname(configPath).toLowerCase();
    const content = fs.readFileSync(configPath, 'utf8');
    
    if (ext === '.json') {
        return JSON.parse(content);
    } else if (ext === '.yaml' || ext === '.yml') {
        // Note: Requires yaml library
        const yaml = require('yaml');
        return yaml.parse(content);
    } else {
        throw new Error(`Unsupported configuration format: ${ext}`);
    }
}

/**
 * Save processing result to file
 * @param {*} result - Result to save
 * @param {string} outputPath - Output file path
 */
function saveResult(result, outputPath) {
    // Ensure directory exists
    const dir = path.dirname(outputPath);
    if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir, { recursive: true });
    }
    
    const ext = path.extname(outputPath).toLowerCase();
    let content;
    
    if (ext === '.json') {
        content = JSON.stringify(result, null, 2);
    } else if (ext === '.yaml' || ext === '.yml') {
        const yaml = require('yaml');
        content = yaml.stringify(result);
    } else {
        // Default to string representation
        content = String(result);
    }
    
    fs.writeFileSync(outputPath, content);
}

/**
 * Format error information for consistent error handling
 * @param {Error} error - Error to format
 * @returns {Object} Formatted error object
 */
function formatError(error) {
    return {
        error_type: error.constructor.name,
        error_message: error.message,
        error_stack: error.stack
    };
}

/**
 * Safely get value from object with default
 * @param {Object} data - Object to search
 * @param {string} key - Key to retrieve
 * @param {*} defaultValue - Default value if key not found
 * @returns {*} Value or default
 */
function safeGet(data, key, defaultValue = null) {
    return data.hasOwnProperty(key) ? data[key] : defaultValue;
}

// Export for Node.js
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        loadConfig,
        saveResult,
        formatError,
        safeGet
    };
}
"""

    def _get_js_examples_template(self) -> str:
        return """/**
 * Runnable examples for the JavaScript skill
 * 
 * This module contains complete working examples that demonstrate how to use the skill.
 */

const { mainFunction } = require('./main');
const { loadConfig, saveResult } = require('./helpers');

/**
 * Basic usage example
 */
function basicExample() {
    console.log("=== Basic Example ===");
    
    // Sample data
    const data = "Hello, World!";
    
    // Process with default configuration
    const result = mainFunction(data);
    
    console.log(`Input: ${data}`);
    console.log(`Success: ${result.success}`);
    console.log(`Result: ${result.result}`);
    
    return result;
}

/**
 * Example using custom configuration
 */
function configExample() {
    console.log("\\n=== Configuration Example ===");
    
    // Sample data
    const data = ["item1", "item2", "item3"];
    
    // Custom configuration
    const config = {
        option1: "custom_value",
        option2: true,
        debug: true
    };
    
    // Process with custom configuration
    const result = mainFunction(data, config);
    
    console.log(`Input: ${data.join(", ")}`);
    console.log(`Config: ${JSON.stringify(config)}`);
    console.log(`Success: ${result.success}`);
    
    return result;
}

/**
 * Example processing data from files
 */
function fileProcessingExample() {
    console.log("\\n=== File Processing Example ===");
    
    try {
        // Load configuration from file
        const config = loadConfig("config/default-config.json");
        
        // Sample data (in real usage, this would be loaded from file)
        const data = { key1: "value1", key2: "value2" };
        
        // Process data
        const result = mainFunction(data, config);
        
        // Save result
        saveResult(result, "output/example_result.json");
        
        console.log("Processing complete. Result saved to output/example_result.json");
        
        return result;
        
    } catch (error) {
        console.log(`Configuration file not found: ${error.message}`);
        return null;
    }
}

/**
 * Example demonstrating error handling
 */
function errorHandlingExample() {
    console.log("\\n=== Error Handling Example ===");
    
    // Try processing invalid data
    const invalidData = null;
    
    const result = mainFunction(invalidData);
    
    console.log(`Input: ${invalidData}`);
    console.log(`Success: ${result.success}`);
    if (!result.success) {
        console.log(`Error: ${result.error}`);
    }
    
    return result;
}

/**
 * Run all examples
 */
function runAllExamples() {
    console.log("Running JavaScript skill examples...");
    
    // Run examples
    basicExample();
    configExample();
    fileProcessingExample();
    errorHandlingExample();
    
    console.log("\\nAll examples complete!");
}

// Export for Node.js
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        basicExample,
        configExample,
        fileProcessingExample,
        errorHandlingExample,
        runAllExamples
    };
}

// Run examples if script is executed directly
if (typeof require !== 'undefined' && require.main === module) {
    runAllExamples();
}
"""

    def _get_advanced_config_template(self) -> str:
        return """# Advanced Configuration Template
# This file contains advanced settings and options for complex scenarios

# Basic options (override defaults)
option1: "advanced_value1"
option2: "advanced_value2"
debug: true

# Advanced processing options
processing:
  batch_size: 1000
  parallel: true
  workers: 8
  memory_limit: "4GB"
  timeout: 120
  retry_attempts: 3
  
  # Advanced algorithms
  algorithms:
    primary: "optimized"
    fallback: "robust"
    validation: "strict"

# Performance tuning
performance:
  cache:
    enabled: true
    size_limit: "1GB"
    ttl: 3600  # seconds
  
  optimization:
    enable_jit: true
    vectorization: true
    memory_pool: true
    
  monitoring:
    enable_profiling: true
    metrics_collection: true
    performance_logging: true

# Output configuration
output:
  format: "parquet"  # High-performance format
  compression: "snappy"
  partition_by: ["date", "category"]
  
  validation:
    enable_schema_check: true
    quality_threshold: 0.95
    
  metadata:
    include_lineage: true
    include_statistics: true
    include_schema: true

# Advanced error handling
error_handling:
  strategy: "graceful_degradation"
  recovery_attempts: 5
  fallback_processing: true
  
  notifications:
    email: "admin@example.com"
    webhook: "https://hooks.example.com/alerts"
    
  logging:
    detailed_errors: true
    stack_traces: true
    context_capture: true

# Security settings
security:
  encryption:
    enabled: true
    algorithm: "AES-256"
    key_rotation: true
    
  access_control:
    require_authentication: true
    allowed_users: ["admin", "processor"]
    audit_logging: true

# Integration settings
integrations:
  databases:
    primary:
      type: "postgresql"
      connection_pool: 20
      timeout: 30
      
  apis:
    rate_limiting:
      requests_per_minute: 1000
      burst_allowance: 100
      
  monitoring:
    prometheus:
      enabled: true
      port: 9090
      
  alerting:
    slack:
      webhook_url: "https://hooks.slack.com/..."
      channel: "#alerts"
"""

    def _get_r_main_template(self) -> str:
        return """# Main functionality for this R skill
# 
# This file contains the core functions that implement the skill's capabilities.

#' Main entry point for the skill
#' 
#' @param data Input data to process
#' @param config Optional configuration list
#' @return List containing results and metadata
#' @export
main_function <- function(data, config = NULL) {
  tryCatch({
    # Apply default configuration
    if (is.null(config)) {
      config <- load_default_config()
    }
    
    # Validate inputs
    validate_input(data)
    
    # Process data
    result <- process_data(data, config)
    
    list(
      success = TRUE,
      result = result,
      metadata = extract_metadata(result)
    )
    
  }, error = function(e) {
    message(paste("Processing failed:", e$message))
    list(
      success = FALSE,
      error = e$message,
      result = NULL
    )
  })
}

#' Core data processing function
#' 
#' @param data Input data
#' @param config Processing configuration
#' @return Processed data
process_data <- function(data, config) {
  message("Processing data...")
  
  # Implement core processing logic here
  processed_data <- data
  
  message("Processing complete")
  return(processed_data)
}

#' Validate input data
#' 
#' @param data Data to validate
validate_input <- function(data) {
  if (is.null(data)) {
    stop("Input data cannot be NULL")
  }
  # Add specific validation logic here
}

#' Extract metadata from processing results
#' 
#' @param result Processing result
#' @return List containing metadata
extract_metadata <- function(result) {
  list(
    type = class(result)[1],
    length = length(result),
    timestamp = Sys.time()
  )
}

#' Load default configuration
#' 
#' @return Default configuration list
load_default_config <- function() {
  list(
    option1 = "default_value1",
    option2 = "default_value2", 
    debug = FALSE
  )
}

# Example usage
if (!interactive()) {
  sample_data <- "sample input"
  result <- main_function(sample_data)
  print(paste("Result:", result$result))
}
"""

    def _get_r_helpers_template(self) -> str:
        return """# Helper functions for the R skill
#
# This file contains utility functions that support the main skill functionality.

library(yaml)
library(jsonlite)

#' Load configuration from file
#' 
#' @param config_path Path to configuration file
#' @return Configuration list
load_config <- function(config_path) {
  if (!file.exists(config_path)) {
    stop(paste("Configuration file not found:", config_path))
  }
  
  if (grepl("\\\\.yaml$|\\\\.yml$", config_path, ignore.case = TRUE)) {
    return(yaml::read_yaml(config_path))
  } else if (grepl("\\\\.json$", config_path, ignore.case = TRUE)) {
    return(jsonlite::fromJSON(config_path))
  } else {
    stop(paste("Unsupported configuration format:", config_path))
  }
}

#' Save processing result to file
#' 
#' @param result Result to save
#' @param output_path Output file path
save_result <- function(result, output_path) {
  dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)
  
  if (grepl("\\\\.json$", output_path, ignore.case = TRUE)) {
    jsonlite::write_json(result, output_path, pretty = TRUE)
  } else if (grepl("\\\\.yaml$|\\\\.yml$", output_path, ignore.case = TRUE)) {
    yaml::write_yaml(result, output_path)
  } else {
    # Default to string representation
    writeLines(as.character(result), output_path)
  }
}

#' Format error information for consistent error handling
#' 
#' @param error Error object
#' @return Formatted error list
format_error <- function(error) {
  list(
    error_type = class(error)[1],
    error_message = as.character(error),
    error_call = as.character(error$call)
  )
}

#' Safely get value from list with default
#' 
#' @param data List to search
#' @param key Key to retrieve
#' @param default Default value if key not found
#' @return Value or default
safe_get <- function(data, key, default = NULL) {
  if (key %in% names(data)) {
    return(data[[key]])
  } else {
    return(default)
  }
}
"""


def main():
    """Command-line interface for skill generator"""
    import argparse

    parser = argparse.ArgumentParser(description="Generate new Agent Skills")
    parser.add_argument("name", help="Skill name")
    parser.add_argument("description", help="Skill description")
    parser.add_argument(
        "--type",
        default="basic",
        choices=["basic", "advanced", "integration", "domain"],
        help="Skill type",
    )
    parser.add_argument(
        "--language",
        default="python",
        choices=["python", "r", "javascript"],
        help="Primary programming language",
    )
    parser.add_argument("--domain", help="Specific domain (for domain skills)")

    args = parser.parse_args()

    generator = SkillGenerator()
    skill_path = generator.create_skill(
        name=args.name,
        description=args.description,
        skill_type=args.type,
        language=args.language,
        domain=args.domain,
    )

    print(f"\nSkill created successfully at: {skill_path}")
    print("Next steps:")
    print("1. Review and customize the generated files")
    print("2. Implement the core functionality in code/")
    print("3. Test the skill with the provided examples")
    print("4. Update documentation as needed")


if __name__ == "__main__":
    main()
