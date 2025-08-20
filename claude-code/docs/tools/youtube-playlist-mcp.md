# YouTube Playlist MCP Integration Guide

## Overview
The YouTube Playlist MCP server enables Claude to manage your YouTube playlists, including watch later, user playlists, and video operations. This is separate from the YouTube Transcript MCP which handles video transcript retrieval.

## Installation
```bash
# Install the YouTube Playlist MCP server
~/dotfiles/bin/mcp-install install youtube

# Integrate with Claude Code
~/dotfiles/bin/mcp-install integrate youtube
```

## Available Tools

### Playlist Management
- **list_playlists**: List all user playlists including watch later
- **create_playlist**: Create new playlists with title/description
- **delete_playlist**: Remove playlists
- **update_playlist**: Modify playlist metadata

### Watch Later Operations
- **get_watch_later**: Retrieve videos from watch later playlist
- **add_to_watch_later**: Add videos to watch later
- **remove_from_watch_later**: Remove videos from watch later

### Video Operations
- **search_videos**: Search YouTube videos by query
- **get_video_details**: Get detailed video information
- **add_to_playlist**: Add videos to specific playlists
- **remove_from_playlist**: Remove videos from playlists

### Channel Operations
- **search_channels**: Find YouTube channels
- **get_channel_videos**: Get videos from a channel
- **get_channel_playlists**: Get playlists from a channel

## Authentication Setup

### 1. Google Cloud Console
- Visit https://console.cloud.google.com/
- Create a new project or select existing
- Enable **YouTube Data API v3**
- Create **OAuth 2.0 credentials** (Desktop application type)
- Download `credentials.json`

### 2. Configuration
```bash
# Place credentials
mkdir -p ~/.config/youtube-mcp
cp /path/to/credentials.json ~/.config/youtube-mcp/

# Configure API key
# Edit ~/.config/youtube-mcp/config.json
{
  "youtubeApiKey": "YOUR_API_KEY_HERE",
  "oauthCredentialsPath": "$HOME/.config/youtube-mcp/credentials.json",
  "tokenPath": "$HOME/.config/youtube-mcp/token.json"
}
```

### 3. First-Time Authentication
The server will guide you through OAuth flow on first use.

## Usage Examples

### List Your Playlists
```
Show me all my YouTube playlists
```

### Manage Watch Later
```
Get my watch later playlist
Add this video to watch later: https://www.youtube.com/watch?v=dQw4w9WgXcQ
```

### Search and Organize
```
Search for "python tutorials" and add top 3 results to my "Learning" playlist
```

### Create New Playlists
```
Create a playlist called "Tech Talks" for technology presentations
```

### Channel Operations
```
Get latest videos from channel "Fireship"
List playlists from channel "TechLead"
```

## Rate Limiting
- **Exponential backoff**: 1s, 2s, 4s, 8s delays between requests
- **Batch limits**: Maximum 100 operations per batch
- **Daily quotas**: Respects YouTube API limits

## Security Notes
- OAuth tokens stored in `~/.config/youtube-mcp/token.json`
- Credentials secured with `chmod 600`
- Never commit sensitive files to version control

## Related Tools
- **youtube-transcript**: For retrieving video transcripts (separate MCP)
- Use both MCPs together for complete YouTube workflow management

## Complete YouTube Workflow
For full YouTube functionality, install both MCPs:
```bash
# Transcript retrieval
~/dotfiles/bin/mcp-install install youtube-transcript
~/dotfiles/bin/mcp-install integrate youtube-transcript

# Playlist management
~/dotfiles/bin/mcp-install install youtube
~/dotfiles/bin/mcp-install integrate youtube
```