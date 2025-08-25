# YouTube Transcript MCP

## Overview
The YouTube Transcript MCP server enables Claude to retrieve transcripts from YouTube videos using the `@sinco-lab/mcp-youtube-transcript` package. This provides access to captions and subtitles for YouTube videos in multiple languages.

## Installation
```bash
# Install the MCP server
mcp install youtube-transcript

# Integrate with Claude Code
mcp integrate youtube-transcript

# Restart Claude Desktop after integration
```

## Available Tools

### get_transcript
Retrieves the transcript for a YouTube video.

**Parameters:**
- `video_id` (string): The YouTube video ID or full URL
- `language` (optional, string): Language code (e.g., "en", "es", "fr")
- `format` (optional, string): Output format - "text", "json", or "srt"

## Usage Examples

### Basic transcript retrieval
```
Get transcript for https://www.youtube.com/watch?v=dQw4w9WgXcQ
```

### Multi-language support
```
Get transcript for video BaW_jenozKc in Spanish
```

### JSON format with timestamps
```
Get transcript for video BaW_jenozKc in JSON format
```

### Bulk processing with rate limiting
```
Get transcripts for these 5 videos with 2-second delays between requests
```

## Rate Limiting
- **YouTube API limits**: Respect YouTube's rate limits to avoid IP blocking
- **Recommended delays**: Add 1-2 second delays between requests for bulk processing
- **Error handling**: The server will return 429 errors if rate limited

## Error Handling
- **Video not found**: Returns clear error if video doesn't exist
- **No captions available**: Indicates when video has no transcripts
- **Language not available**: Shows available languages when requested language is missing
- **Invalid video ID**: Validates YouTube video ID format

## Best Practices
1. **Always specify language**: When known, specify the language to avoid auto-detection issues
2. **Handle missing transcripts gracefully**: Some videos don't have captions
3. **Use video IDs directly**: More reliable than parsing URLs
4. **Check availability first**: Verify transcript exists before processing
5. **Implement delays**: Add 1-2 second delays between bulk requests

## Security Notes
- **No credentials required**: Uses public YouTube endpoints
- **No data storage**: Transcripts are fetched on-demand, not cached
- **HTTPS only**: All communications use encrypted connections
- **Rate limiting**: Built-in to prevent abuse
- **Privacy**: No user data is transmitted or stored

## Troubleshooting

### Common Issues
1. **"No transcript found"**: Video may not have captions enabled
2. **"Video unavailable"**: Video might be private, deleted, or region-blocked
3. **Rate limit errors**: Implement exponential backoff (1s, 2s, 4s, 8s)
4. **Language detection fails**: Explicitly specify language code

### Debug Steps
1. Verify video has captions by checking YouTube directly
2. Test with known working videos (e.g., any video with CC button)
3. Check network connectivity to YouTube

## Testing Videos
Use these known working videos for testing:
- `dQw4w9WgXcQ` - Rick Astley (usually has captions)
- `BaW_jenozKc` - Test video from YouTube API docs