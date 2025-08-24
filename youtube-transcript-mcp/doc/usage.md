# YouTube Transcript MCP Server Usage

## Overview
The YouTube Transcript MCP server enables Claude to retrieve transcripts from YouTube videos using the `@sinco-lab/mcp-youtube-transcript` package. This server provides access to captions and subtitles for YouTube videos in multiple languages.

## Features
- **Multi-language support**: Extract transcripts in various languages
- **Paragraph formatting**: Returns text with proper paragraph breaks
- **Metadata extraction**: Includes video title, duration, and language info
- **Timestamp support**: Provides timestamps for each segment
- **No authentication required**: Uses public YouTube API endpoints
- **Rate limiting**: Built-in delays to prevent API abuse

## Available Tools

### get_transcript
Retrieves the transcript for a YouTube video.

**Parameters:**
- `video_id` (string): The YouTube video ID or full URL
- `language` (optional, string): Language code (e.g., "en", "es", "fr")
- `format` (optional, string): Output format - "text", "json", or "srt"

**Usage Examples:**

```
# Basic usage with URL
Get transcript for https://www.youtube.com/watch?v=dQw4w9WgXcQ

# With specific language
Get transcript for video dQw4w9WgXcQ in Spanish

# With format specification  
Get transcript for video dQw4w9WgXcQ in JSON format
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

## Examples

### Basic transcript retrieval
```
User: Get the transcript for this video: https://www.youtube.com/watch?v=BaW_jenozKc
Claude: I'll retrieve the transcript for this video...
[Retrieves and displays transcript]
```

### Multi-language support
```
User: Get the French transcript for video BaW_jenozKc
Claude: I'll get the French transcript...
[Returns French captions if available]
```

### Bulk processing
```
User: Get transcripts for these 5 videos with 2-second delays between requests
Claude: Processing videos with rate limiting...
[Processes each video with delays]
```

### Timestamp extraction
```
User: Get JSON format transcript with timestamps for video BaW_jenozKc
Claude: Retrieving transcript with timestamps...
[Returns structured data with timestamps]
```

## Troubleshooting

### Common Issues
1. **"No transcript found"**: Video may not have captions enabled
2. **"Video unavailable"**: Video might be private, deleted, or region-blocked
3. **Rate limit errors**: Implement exponential backoff (1s, 2s, 4s, 8s)
4. **Language detection fails**: Explicitly specify language code

### Debug Steps
1. Verify video has captions by checking YouTube directly
2. Test with a known working video (e.g., any video with CC button)
3. Check network connectivity to YouTube
4. Review server logs in `~/.youtube-transcript-mcp/` for detailed errors

### Testing Videos
Use these known working videos for testing:
- `dQw4w9WgXcQ` - Rick Astley (usually has captions)
- `BaW_jenozKc` - Test video from YouTube API docs

## Security Notes
- **No credentials required**: Uses public YouTube endpoints
- **No data storage**: Transcripts are fetched on-demand, not cached
- **HTTPS only**: All communications use encrypted connections
- **Rate limiting**: Built-in to prevent abuse
- **Privacy**: No user data is transmitted or stored

## Installation
1. Run: `/home/t/dotfiles/youtube-transcript-mcp/install`
2. Run: `mcp integrate youtube-transcript`
3. Restart Claude Desktop
4. Test functionality with sample videos