# /curate-yt Quick Reference

## Command Syntax
```
/curate-yt [YouTube_URL]
```

## Examples
```bash
# Standard YouTube URL
/curate-yt https://www.youtube.com/watch?v=dQw4w9WgXcQ

# Short YouTube URL  
/curate-yt https://youtu.be/dQw4w9WgXcQ

# YouTube URL with playlist (video will be extracted)
/curate-yt https://www.youtube.com/watch?v=dQw4w9WgXcQ&list=PLrAXtmRdnEQy6nuLvv7gMq9-nR3WQjCH3
```

## What Happens
1. **Extracts** video metadata (title, creator, duration)
2. **Downloads** transcript using YouTube MCP
3. **Analyzes** content for technical concepts and frameworks
4. **Structures** knowledge into agent-optimized format
5. **Saves** to `./sources/youtube/[Creator]-[Title].md`

## Output Structure
- **Agent Context Summary**: Metadata and AI use cases
- **Executive Summary**: Key outcomes and scope
- **Decision Framework**: When/how to apply knowledge
- **Implementation Pathway**: Step-by-step instructions
- **Technical Deep Dive**: Concepts and code snippets
- **Knowledge Graph**: [[Topic]] links for cross-referencing
- **Reference Guide**: Commands, configs, troubleshooting

## Requirements
- ✅ Valid YouTube URL with available transcript
- ✅ YouTube transcript MCP server running (port 4004)
- ✅ Write permission to `./sources/youtube/` directory

## Troubleshooting

### "No transcript available"
- Video has disabled captions
- Try finding alternative video on same topic

### "Permission denied" 
- Check MCP server is running: `curl http://localhost:4004/mcp`
- Verify `youtube-transcript` enabled in opencode.json

### "Invalid URL"
- Ensure URL starts with `https://www.youtube.com/watch?v=` or `https://youtu.be/`
- Remove extra parameters if needed

## File Naming Convention
```
[Creator]-[ShortTitle].md

Examples:
- TechWorldwithNana-Kubernetes-Rancher-Desktop.md  
- Fireship-Docker-Explained-100-Seconds.md
- NetworkChuck-Linux-Command-Line-Basics.md
```

## Knowledge Graph Integration
- Uses `[[Topic]]` format for concept linking
- Creates bidirectional relationships
- Enables cross-referencing between curated content
- Builds searchable knowledge base for AI agents

---
*This command is specifically designed for creating AI agent-optimized knowledge from YouTube technical content.*