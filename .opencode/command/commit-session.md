---
description: OpenCode commit-session command - Commit and push changes with session summary
---

# OpenCode Commit Session Command

This command provides the same functionality as Claude's `/commit-session` slash command for OpenCode users.

## Usage

### Option 1: Direct Script Execution
```bash
./commands/commit-session.sh
```

### Option 2: Via OpenCode Agent
Ask any OpenCode agent to "run the commit-session command" or "commit this session".

### Option 3: As Slash Command
Use `/commit-session` with OpenCode agents that support slash commands.

## What it does

1. **Reviews the current session**: Analyzes recent changes and activities
2. **Creates a concise summary**: Generates a meaningful commit message
3. **Shows the summary**: Presents the proposed commit message
4. **Asks for permission**: Requests user approval before committing
5. **Executes if approved**: Stages, commits, and pushes changes
6. **Confirms completion**: Reports success or failure

## Commit Message Format

- **First line**: Brief overview (50 chars or less)
- **Optional second line**: Blank
- **Optional third+ lines**: More details if needed

### Examples:
- "Fix git automation script logging and SSH authentication"
- "Add user authentication feature\n\nImplemented JWT-based auth with password hashing"
- "Refactor database queries for performance"

## Requirements

- Git repository must be initialized
- Remote repository must be configured
- User must have push permissions
- Working directory must be clean or have changes to commit

## Security

- Always asks for user confirmation before committing
- Shows exact commit message before execution
- Respects OpenCode security guidelines
- No automatic commits without explicit approval

## Integration with OpenCode

This command integrates with OpenCode's agent system and follows the same security model:
- Requests permission for git operations
- Provides clear explanations of actions
- Offers manual alternatives if permissions are denied

## Implementation Details

The command consists of:
- **Documentation** (`commit-session.md`) - This file
- **Executable Script** (`commit-session.sh`) - Main implementation
- **OpenCode Integration** - Slash command support via agent configuration

## Error Handling

- Validates git repository existence
- Checks for changes before proceeding
- Handles push failures gracefully
- Provides clear error messages and recovery suggestions