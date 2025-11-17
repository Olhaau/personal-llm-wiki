# Context7 MCP Integration Rules

## Automatic Context7 Usage

**Rule**: Always use Context7 MCP tools automatically when working with:
1. **Code generation** - Generating new code using libraries or frameworks
2. **Setup or configuration steps** - Installing, configuring, or setting up libraries/tools
3. **Library/API documentation** - Understanding how to use specific libraries, frameworks, or APIs

## Implementation Requirements

### When to Use Context7 Tools

The agent MUST automatically use Context7 MCP tools in these scenarios:

#### 1. Code Generation with Libraries
- Writing code that uses external libraries (npm packages, Python libraries, R packages, etc.)
- Implementing features using specific frameworks (React, Express, FastAPI, Arrow, etc.)
- Using APIs (REST, GraphQL, database drivers, etc.)

**Example**: When asked "create a REST API with Express", automatically:
1. Use Context7 to resolve the library ID for Express
2. Fetch Express documentation
3. Generate code based on current best practices

#### 2. Setup and Configuration
- Installing dependencies
- Configuring build tools (webpack, vite, rollup, etc.)
- Setting up testing frameworks
- Configuring linters, formatters, or other dev tools
- Database setup and migrations

**Example**: When asked "setup Jest for testing", automatically:
1. Use Context7 to get Jest library documentation
2. Provide setup instructions based on current version
3. Generate configuration files

#### 3. Library/API Documentation
- Explaining how to use a library
- Understanding API methods and parameters
- Checking current best practices
- Verifying syntax and usage patterns
- Finding examples and code snippets

**Example**: When asked "how do I use Arrow's write_parquet function", automatically:
1. Resolve Arrow library ID for the relevant language (R, Python, etc.)
2. Fetch current documentation
3. Provide accurate examples

## Context7 MCP Tools Available

The following Context7 tools should be used:
- `mcp__context7_resolve_library_id` - Get the canonical library identifier
- `mcp__context7_get_library_docs` - Fetch comprehensive library documentation
- Any other Context7 MCP tools that become available

## User Communication

### DO NOT explicitly mention Context7 usage unless:
1. The user specifically asks about Context7
2. There's an error with Context7 tools
3. The user wants to know why a particular approach was chosen

### DO focus on:
1. Providing accurate, up-to-date code and documentation
2. Using current best practices from the library docs
3. Delivering solutions efficiently

## Error Handling

If Context7 tools are unavailable or fail:
1. Fall back to general knowledge (with appropriate disclaimers about version currency)
2. Suggest the user check official documentation
3. Warn that the information may not reflect the latest version

## Example Workflow

```
User: "Write a function to read a CSV with pandas"

Agent (internal process):
1. Automatically use Context7 to resolve "pandas" library ID
2. Fetch pandas documentation for read_csv
3. Generate code with current best practices
4. Provide example without mentioning Context7

Agent response:
"Here's a function to read a CSV with pandas:

[code example based on current pandas docs]

This uses pandas' read_csv function with proper error handling..."
```

## Priority

Context7 usage should be **proactive and automatic**, not reactive to user requests. This ensures:
- Code uses current APIs and best practices
- Configuration matches latest library versions
- Documentation is accurate and up-to-date
- Examples work with current releases

## Scope

This rule applies to:
- All programming languages (Python, R, JavaScript, TypeScript, etc.)
- All package ecosystems (npm, PyPI, CRAN, Maven, Cargo, etc.)
- All frameworks and libraries (web, data science, ML, etc.)
- All development tools (build tools, linters, testers, etc.)

---

**Summary**: When generating code, providing setup instructions, or explaining library usage, ALWAYS use Context7 MCP tools automatically to ensure accurate, current information without explicitly mentioning this to the user.
