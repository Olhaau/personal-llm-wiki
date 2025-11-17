---
description: OpenCode curate-yt command - Transform YouTube videos into agent-optimized knowledge articles
---

# OpenCode Curate YouTube Command

This command transforms YouTube video transcripts into structured, agent-optimized knowledge articles using the curator-yt specialized agent.

## Usage

### Option 1: Direct Agent Call
Ask any OpenCode agent to "curate the YouTube video [URL]" and it will delegate to the curator-yt agent.

### Option 2: As Slash Command
Use `/curate-yt [YouTube URL]` with OpenCode agents that support slash commands.

#### Examples:
```
/curate-yt https://www.youtube.com/watch?v=dQw4w9WgXcQ
/curate-yt https://youtu.be/dQw4w9WgXcQ
```

## What it does

1. **Extracts video metadata**: Gets title, creator, duration, and description
2. **Downloads transcript**: Uses YouTube transcript MCP to get video content
3. **Analyzes content**: Identifies technical concepts, frameworks, and actionable intelligence
4. **Structures knowledge**: Creates agent-optimized markdown with decision trees and implementation guides
5. **Saves to knowledge base**: Stores in `./sources/youtube/` with standardized naming
6. **Creates knowledge graph**: Links concepts using [[Topic]] format for cross-referencing

## Output Format

### File Location
- **Directory**: `./sources/youtube/`
- **Naming**: `[Creator]-[ShortTitle].md`
- **Example**: `TechWorldwithNana-Kubernetes-Rancher-Desktop.md`

### Content Structure
The curated content includes:
- **Agent Context Summary**: Metadata and use cases for AI agents
- **Executive Summary**: Key outcomes and applicability
- **Decision Framework**: When/how to apply the knowledge
- **Implementation Pathway**: Step-by-step action sequence  
- **Technical Deep Dive**: Core concepts and methodologies
- **Knowledge Graph Connections**: Related topics and prerequisites
- **Agent Reference Guide**: Commands, configs, and troubleshooting
- **Quality Assessment**: Ratings for technical accuracy and usability

## Agent-Optimized Features

### For AI Context Usage
- **Structured Intelligence**: Clear decision trees and implementation pathways
- **Technical Accuracy**: Preserved commands, configs, and code snippets
- **Cross-References**: [[Topic]] links for knowledge graph building
- **Actionable Content**: Focus on practical implementation over entertainment

### Quality Metrics
- **Technical Accuracy** (1-5): Factual correctness and currentness
- **Implementation Completeness** (1-5): Readiness for practical application
- **Agent Usability** (1-5): Structure optimization for AI consumption
- **Knowledge Currency** (1-5): Relevance of information and practices

## Requirements

- **YouTube URL**: Valid YouTube video link with available transcript
- **MCP Access**: YouTube transcript MCP server must be enabled
- **Write Permission**: Ability to create files in `./sources/youtube/`
- **Network Access**: Connection to YouTube for transcript extraction

## Supported Video Types

- **Tutorials**: Technical how-to content
- **Demos**: Software demonstrations
- **Reviews**: Technology and tool evaluations  
- **Discussions**: Technical deep-dives and analysis
- **Conferences**: Technical presentations and talks

## Error Handling

### Common Issues
- **No Transcript**: Videos without available transcripts cannot be processed
- **Private/Restricted**: Videos with access limitations cannot be accessed
- **Very Short Content**: May result in limited knowledge extraction
- **Non-Technical Content**: Entertainment videos may have reduced agent utility

### Fallback Strategies
- Work with auto-generated transcripts when manual ones unavailable
- Provide best-effort curation with noted limitations
- Adapt template structure for different content types
- Include quality warnings for suboptimal source material

## Integration with OpenCode

### Security Compliance
- Follows OpenCode security guidelines for MCP usage
- Requests permission for YouTube transcript access
- Creates files only in designated knowledge directory
- Provides manual alternatives if permissions denied

### Agent Coordination
- Uses specialized curator-yt agent for processing
- Maintains consistency with OpenCode agent architecture
- Supports both direct calls and slash command interface
- Integrates with existing knowledge management workflow

## Knowledge Base Integration

### File Organization
```
./sources/youtube/
├── TechWorldwithNana-Kubernetes-Rancher-Desktop.md
├── Fireship-Docker-Explained-100-Seconds.md
├── NetworkChuck-Linux-Command-Line-Basics.md
└── ...
```

### Cross-Referencing
- Automatic [[Topic]] link generation for knowledge graphs
- Consistent taxonomy across curated content
- Bidirectional concept relationships
- Search-optimized metadata tags

## Command Processing

When `/curate-yt [URL]` is invoked:

1. **URL Validation**: Verify YouTube URL format and accessibility
2. **Agent Delegation**: Hand off to curator-yt specialized agent
3. **Processing Execution**: Extract, analyze, structure, and save content
4. **Result Reporting**: Confirm successful creation and file location
5. **Error Handling**: Provide clear error messages and suggested fixes

## Best Practices

### For Users
- **Verify URLs**: Ensure videos have available transcripts
- **Review Output**: Check generated articles for accuracy
- **Update Knowledge**: Curate related videos to build comprehensive topics
- **Tag Maintenance**: Use consistent topic naming for better cross-referencing

### For Agents
- **Preserve Technical Accuracy**: Maintain exact terminology and commands
- **Structure for Consumption**: Use clear hierarchies and actionable sections
- **Link Related Concepts**: Create meaningful knowledge graph connections
- **Validate Output**: Ensure all generated content meets quality standards

This command bridges the gap between YouTube's wealth of technical content and the structured knowledge requirements of AI agent systems.