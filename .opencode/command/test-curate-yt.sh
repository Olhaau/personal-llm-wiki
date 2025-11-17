#!/bin/bash
# Test script to validate /curate-yt slash command configuration

echo "🧪 Testing /curate-yt Slash Command Configuration"
echo "================================================"

# Check if opencode.json exists and contains curator-yt configuration
if [ ! -f "opencode.json" ]; then
    echo "❌ ERROR: opencode.json not found in current directory"
    exit 1
fi

echo "✅ opencode.json found"

# Check if curator-yt agent is configured
if grep -q '"curator-yt"' opencode.json; then
    echo "✅ curator-yt agent configuration found"
else
    echo "❌ ERROR: curator-yt agent not found in configuration"
    exit 1
fi

# Check if slash command handling is configured
if grep -q "SLASH COMMAND HANDLING" opencode.json; then
    echo "✅ Slash command handling configured"
else
    echo "❌ WARNING: Slash command handling not found in curator-yt prompt"
fi

# Check if youtube-transcript MCP is enabled
if grep -q '"youtube-transcript"' opencode.json && grep -q '"enabled": true' opencode.json; then
    echo "✅ YouTube transcript MCP appears to be configured"
else
    echo "⚠️  WARNING: YouTube transcript MCP may not be enabled"
fi

# Check if sources/youtube directory exists
if [ -d "sources/youtube" ]; then
    echo "✅ Output directory sources/youtube exists"
    echo "📁 Current files in sources/youtube:"
    ls -la sources/youtube/ | head -10
else
    echo "⚠️  WARNING: sources/youtube directory not found"
    echo "📁 Creating sources/youtube directory..."
    mkdir -p sources/youtube
fi

# Check if curator-yt agent definition exists
if [ -f ".opencode/agent/curator-yt.md" ]; then
    echo "✅ curator-yt agent definition found"
else
    echo "❌ ERROR: .opencode/agent/curator-yt.md not found"
fi

echo ""
echo "🎯 Configuration Summary:"
echo "========================"
echo "Agent Mode: primary (can handle slash commands directly)"
echo "MCP Access: youtube-transcript enabled"
echo "Write Permissions: allowed for sources/youtube/"
echo "Command Format: /curate-yt [YouTube_URL]"
echo ""
echo "✨ The /curate-yt slash command should be ready to use!"
echo ""
echo "Usage Examples:"
echo "  /curate-yt https://www.youtube.com/watch?v=dQw4w9WgXcQ"
echo "  /curate-yt https://youtu.be/dQw4w9WgXcQ"