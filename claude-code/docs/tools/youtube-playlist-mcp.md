# YouTube Playlist MCP

## Overview
The official YouTube Playlist MCP server enables Claude to access and manage your YouTube playlists, including Watch Later, personal playlists, liked videos, and subscriptions. This provides comprehensive YouTube integration for playlist management and content organization.

## Installation
```bash
# Install the MCP server
mcp install youtube-playlist

# Integrate with Claude Code
mcp integrate youtube-playlist

# Set up OAuth credentials (required)
# 1. Go to https://console.cloud.google.com/
# 2. Create project & enable YouTube Data API v3
# 3. Create OAuth 2.0 credentials (Desktop app)
# 4. Save credentials.json to ~/.youtube-playlist-mcp/
# 5. Run: cd ~/.youtube-playlist-mcp && npm start (for initial auth)

# Restart Claude Desktop after integration
```

## Authentication Setup

### Google Cloud Console Setup
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing one
3. Enable YouTube Data API v3:
   - Go to "APIs & Services" > "Library"
   - Search for "YouTube Data API v3"
   - Click "Enable"
4. Create OAuth 2.0 credentials:
   - Go to "APIs & Services" > "Credentials"
   - Click "Create Credentials" > "OAuth 2.0 Client ID"
   - Application type: "Desktop app"
   - Download the credentials JSON file
5. Save as `~/.youtube-playlist-mcp/credentials.json`

### Required OAuth Scopes
- https://www.googleapis.com/auth/youtube.readonly
- https://www.googleapis.com/auth/youtube

## Available Tools

### get_playlists
List your YouTube playlists

**Parameters:**
- `mine` (boolean, optional): Only show your playlists (default: true)
- `max_results` (integer, optional): Maximum number of playlists (default: 50)

### get_playlist_items
List videos in a specific playlist

**Parameters:**
- `playlist_id` (string): The playlist ID (e.g., "WL" for Watch Later)
- `max_results` (integer, optional): Maximum number of items (default: 50)

### search_videos
Search for videos on YouTube

**Parameters:**
- `query` (string): Search query
- `max_results` (integer, optional): Maximum results (default: 10)
- `order` (string, optional): Sort order - "relevance", "date", "rating", "title" (default: "relevance")

### add_video_to_playlist
Add a video to a playlist

**Parameters:**
- `video_id` (string): The YouTube video ID
- `playlist_id` (string): Target playlist ID
- `position` (integer, optional): Position in playlist (0 = first)

### remove_video_from_playlist
Remove a video from a playlist

**Parameters:**
- `playlist_item_id` (string): The playlist item ID (not video ID)

### create_playlist
Create a new playlist

**Parameters:**
- `title` (string): Playlist title
- `description` (string, optional): Playlist description
- `privacy_status` (string, optional): "public", "unlisted", or "private" (default: "private")

### update_playlist
Update playlist details

**Parameters:**
- `playlist_id` (string): Playlist ID to update
- `title` (string, optional): New title
- `description` (string, optional): New description
- `privacy_status` (string, optional): New privacy status

### delete_playlist
Delete a playlist

**Parameters:**
- `playlist_id` (string): Playlist ID to delete

### get_subscriptions
List your subscribed channels

**Parameters:**
- `max_results` (integer, optional): Maximum channels (default: 50)
- `order` (string, optional): "alphabetical", "relevance", "unread" (default: "alphabetical")

### get_liked_videos
List your liked videos

**Parameters:**
- `max_results` (integer, optional): Maximum videos (default: 50)

## Usage Examples

### List all your playlists
```
List my YouTube playlists
```

### Work with Watch Later
```
Show my Watch Later playlist contents
Add video dQw4w9WgXcQ to my Watch Later
Remove the first video from my Watch Later
```

### Create and manage playlists
```
Create a new playlist called "Coding Tutorials" with description "Great programming videos"
Add video BaW_jenozKc to my "Coding Tutorials" playlist
List videos in my "Coding Tutorials" playlist
```

### Search and organize
```
Search for "JavaScript tutorial" and add top result to my Watch Later
Find Python tutorials and create a playlist from the results
```

### Subscription management
```
List my subscribed channels
Get recent uploads from my subscriptions
```

### Liked videos
```
Show my liked videos
Add all liked videos from this week to a new playlist
```

## Common Playlist IDs
- `WL` - Watch Later
- `LL` - Liked videos
- `LM` - Mix playlists (auto-generated)
- Custom playlists - Use the ID from playlist URL

## Rate Limiting
- **YouTube API quotas**: 10,000 units per day for authenticated requests
- **Recommended delays**: Add 1-2 second delays between bulk operations
- **Error handling**: Implement exponential backoff for 429 errors
- **Daily limits**: Monitor usage in Google Cloud Console

## Best Practices
1. **Batch operations**: Group operations when possible to reduce API calls
2. **Error handling**: Handle rate limit errors gracefully with retries
3. **Playlist limits**: Each playlist can contain up to 5,000 videos
4. **Naming conventions**: Use descriptive playlist names and descriptions
5. **Privacy settings**: Consider privacy status when creating playlists
6. **Video validation**: Verify video exists before adding to playlists

## Error Handling
- **Quota exceeded**: Implement retry logic with exponential backoff
- **Invalid video ID**: Validate YouTube video ID format
- **Playlist not found**: Check playlist ID and permissions
- **Duplicate videos**: Handle attempts to add duplicates gracefully
- **Privacy restrictions**: Respect video/playlist privacy settings

## Troubleshooting

### Common Issues
1. **"OAuth credentials not found"**: Ensure credentials.json is in the correct location
2. **"Insufficient permissions"**: Check OAuth scopes in Google Cloud Console
3. **"Playlist not accessible"**: Verify playlist ownership or permissions
4. **"Video already in playlist"**: Handle duplicate detection
5. **"Daily quota exceeded"**: Wait 24 hours or request quota increase

### Debug Steps
1. Check credentials.json file exists and is valid
2. Verify OAuth flow completed successfully
3. Test with simple operations first (list playlists)
4. Check Google Cloud Console for quota usage
5. Review server logs in `~/.youtube-playlist-mcp/` for detailed errors

## Security Notes
- **OAuth security**: Never share your OAuth credentials
- **Token storage**: Tokens are stored securely in the MCP directory
- **Scope limitations**: Only requests necessary permissions
- **HTTPS encryption**: All API calls use encrypted connections
- **User consent**: Requires explicit user authorization

## Advanced Usage

### Playlist Analytics
```
Analyze my "Coding Tutorials" playlist for most viewed videos
Create a summary of my liked videos by category
```

### Batch Operations
```
Find all videos from "Tech Channel" and add to a new playlist
Remove all videos older than 1 year from Watch Later
```

### Integration Workflows
```
Search for daily coding challenges and add to "Daily Learning" playlist
Monitor subscription uploads and add trending videos to Watch Later
```

## References
- [YouTube Data API v3 Documentation](https://developers.google.com/youtube/v3)
- [OAuth 2.0 for Desktop Apps](https://developers.google.com/youtube/v3/guides/auth/installed-apps)
- [API Quota Calculator](https://developers.google.com/youtube/v3/determine_quota_cost)