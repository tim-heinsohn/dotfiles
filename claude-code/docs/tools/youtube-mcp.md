# YouTube Transcript MCP Integration

## Overview
The YouTube Transcript MCP server enables Claude to retrieve transcripts from YouTube videos using the `@sinco-lab/mcp-youtube-transcript` package. This provides direct access to YouTube captions and subtitles for content analysis, summarization, and research.

## Installation via Dotfiles

### 1. Install the MCP Server
```bash
# From dotfiles directory
mcp install youtube
```

### 2. Integrate with Claude Code
```bash
# Add to Claude Desktop configuration
mcp integrate youtube
```

### 3. Restart Claude Desktop
After integration, restart Claude Desktop to load the new MCP server.

## Available Tools

### get_transcript
Retrieves transcript data from YouTube videos.

**Parameters:**
- `video_id` (string): YouTube video ID or full URL
- `language` (optional): Language code ("en", "es", "fr", etc.)
- `format` (optional): Output format ("text", "json", "srt")

**Usage Examples:**
```
# Basic transcript retrieval
Get transcript for https://youtu.be/dQw4w9WgXcQ

# Specific language
Get transcript for video dQw4w9WgXcQ in Spanish

# JSON format with timestamps
Get transcript for video BaW_jenozKc in JSON format
```

## Rate Limiting & Best Practices

### YouTube API Limits
- **Respect rate limits**: YouTube enforces request limits
- **Recommended delays**: 1-2 seconds between bulk requests
- **Error handling**: Server returns 429 for rate limit violations

### Best Practices
1. **Specify language when known**: Improves accuracy and reduces processing time
2. **Use video IDs directly**: More reliable than URL parsing
3. **Handle missing transcripts gracefully**: Not all videos have captions
4. **Implement exponential backoff**: 1s, 2s, 4s, 8s delays for retries

## Error Handling

| Error | Cause | Solution |
|---|---|---|
| "No transcript found" | Video has no captions | Check YouTube for CC availability |
| "Video unavailable" | Private/deleted/region-blocked | Verify video accessibility |
| "Rate limited" | Too many requests | Add delays between requests |
| "Invalid video ID" | Malformed ID | Use valid YouTube video ID |

## Security Considerations
- **No authentication required**: Uses public YouTube endpoints
- **HTTPS only**: All communications encrypted
- **No data persistence**: Transcripts fetched on-demand, not cached
- **Privacy**: No user data transmitted to external services

## Common Use Cases

### Content Analysis
```
User: Analyze this video transcript for key themes
[Retrieves transcript and performs analysis]
```

### Research & Summarization
```
User: Summarize the main points from this 30-minute tutorial
[Gets transcript and provides concise summary]
```

### Multi-language Content
```
User: Get the English transcript from this Spanish video
[Retrieves English captions if available]
```

## Troubleshooting

### Basic Checks
1. Verify video has captions (look for CC button on YouTube)
2. Test with known working video (e.g., popular educational content)
3. Check network connectivity to YouTube
4. Review server logs in `~/.youtube-mcp/` directory

### Debug Commands
```bash
# Check if MCP is installed
ls -la ~/.youtube-mcp/

# Test basic functionality
npx -y @sinco-lab/mcp-youtube-transcript --help

# Verify Claude integration
claude mcp list
```

## Integration with Workflow

### Quick Start
1. Install: `mcp install youtube`
2. Integrate: `mcp integrate youtube`
3. Restart Claude Desktop
4. Test: "Get transcript for https://youtu.be/dQw4w9WgXcQ"

### Advanced Usage
Combine with other MCP tools for powerful workflows:
- **Playwright**: Navigate to videos and extract transcripts
- **File System**: Save transcripts to local files
- **Git**: Commit transcript changes to repositories