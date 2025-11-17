# OpenCode Security and Permission Guidelines

## Default Restrictions

By default, OpenCode agents are restricted to **file operations** and **basic system commands** only. The following tools require explicit user permission:

### Allowed by Default
- **write**: Create and modify files in the workspace
- **edit**: Edit existing files
- **read**: Read file contents
- **list**: List directory contents
- **glob**: Find files using patterns
- **grep**: Search file contents
- **bash**: Execute basic system commands (limited scope)

### Require Explicit Permission
- **webfetch**: Fetch content from external URLs
- **mcp**: Use Model Context Protocol servers
- **task**: Launch specialized agents
- **bash** (network operations): Commands that access network resources
- **bash** (system modification): Commands that modify system configuration

## Permission Granting

### Session-Level Permissions
Users can grant permissions for the entire session using these commands:
- `!allow webfetch` - Allow web fetching for this session
- `!allow mcp` - Allow MCP server usage for this session
- `!allow network` - Allow network-related bash commands
- `!allow system` - Allow system modification commands
- `!allow all` - Allow all restricted operations

### One-Time Permissions
For single operations, users can explicitly approve when prompted:
- Agent will ask: "Permission required to fetch https://example.com - Allow? (y/n/always)"
- User responses:
  - `y` - Allow this operation once
  - `n` - Deny this operation
  - `always` - Allow this type of operation for the session

## Security Considerations

### Web Fetching
- **Risk**: External data retrieval, potential information disclosure
- **Mitigation**: Always validate URLs and content before processing
- **User Control**: Must explicitly approve each domain or grant session permission

### MCP Servers
- **Risk**: External service interaction, data transmission
- **Mitigation**: Limit to configured and trusted MCP servers
- **User Control**: Require permission for each MCP operation

### System Commands
- **Risk**: System modification, file system access beyond workspace
- **Mitigation**: Restrict to workspace directory and read-only system operations
- **User Control**: Ask before any system configuration changes

### Network Operations
- **Risk**: Outbound connections, data transmission
- **Mitigation**: Explicit approval for each network operation
- **User Control**: Session-level or per-operation permission required

## Agent Behavior Requirements

### Before Requesting Permission
1. **Explain the operation**: Clearly state what action will be performed
2. **Justify the need**: Explain why this operation is necessary
3. **Specify scope**: Detail what data/resources will be accessed
4. **Offer alternatives**: Suggest alternative approaches if permission is denied

### When Permission is Denied
1. **Graceful degradation**: Continue with available tools
2. **Alternative solutions**: Suggest manual steps or workarounds
3. **Clear explanation**: Explain what cannot be accomplished without permission

### Permission Request Format
```
🔒 Permission Required: [OPERATION_TYPE]
📋 Action: [Specific action to be performed]
🎯 Purpose: [Why this action is needed]
📄 Scope: [What will be accessed/modified]
🔄 Allow for session? (y/n/always): 
```

## Workspace Safety

### File Operations
- **Always** operate within the workspace directory (`/home/oli/work 💻`)
- **Never** modify system files outside the workspace
- **Always** backup critical files before major modifications
- **Ask** before deleting files or directories

### Data Handling
- **Never** transmit sensitive data without explicit permission
- **Always** sanitize data before external operations
- **Never** store credentials or secrets in plain text
- **Ask** before accessing configuration files containing sensitive data

### Command Execution
- **Validate** all bash commands before execution
- **Restrict** to workspace directory operations by default
- **Ask** before installing system packages or modifying global configuration
- **Never** execute commands that could compromise system security

## Compliance Requirements

### User Consent
- All restricted operations require informed user consent
- Users must understand the implications of granting permissions
- Permission grants should be logged for session transparency

### Data Protection
- Minimize data collection and transmission
- Encrypt sensitive data in transit and at rest
- Respect user privacy and data sovereignty

### Audit Trail
- Log all permission requests and grants
- Track usage of restricted operations
- Provide transparency in agent actions

## Emergency Procedures

### Permission Revocation
- `!revoke webfetch` - Revoke web fetching permission
- `!revoke mcp` - Revoke MCP server access
- `!revoke all` - Revoke all granted permissions
- `!reset` - Reset all permissions to default restrictions

### Security Incident Response
1. **Immediate**: Stop all restricted operations
2. **Assess**: Determine scope of potential security impact
3. **Report**: Inform user of security concern
4. **Remediate**: Suggest corrective actions
5. **Prevent**: Update guidelines to prevent recurrence

## Best Practices

### For Users
- **Review permissions** before granting session-wide access
- **Use specific permissions** rather than blanket approvals
- **Monitor agent activities** and revoke permissions if concerned
- **Keep workspace clean** and organized for better security

### For Agents
- **Minimize permission requests** by using available tools first
- **Batch operations** to reduce permission prompts
- **Provide clear justification** for each permission request
- **Respect user decisions** and work within granted permissions
- **Follow principle of least privilege** in all operations

## Configuration Reference

These guidelines are enforced through the `opencode.json` configuration:
- Default tool permissions are set to `false` for restricted operations
- Permission modes: `allow`, `ask`, `deny`
- Session overrides can be granted through user commands
- All agents inherit these base security settings unless explicitly overridden

---

**Remember**: Security is a shared responsibility between the agent and the user. Always err on the side of caution and transparency.