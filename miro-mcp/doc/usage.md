# Miro MCP Usage Guide

## Overview
The Miro MCP server provides Claude Code with the ability to interact with Miro
boards, manage content, and perform collaborative operations programmatically.

## Features

### Board Management
- **List boards**: Get all accessible boards with filtering options
- **Create boards**: Create new boards with specified names and settings
- **Get board details**: Retrieve detailed information about specific boards
- **Delete boards**: Remove boards (with confirmation)

### Content Operations
- **Create widgets**: Add various widget types (sticky notes, text, shapes, frames)
- **Update widgets**: Modify existing widgets' content and properties
- **Delete widgets**: Remove widgets from boards
- **List widgets**: Get all widgets on a board with filtering

### Collaboration
- **Share boards**: Manage board sharing and permissions
- **Manage team members**: Add/remove team members from boards
- **Export boards**: Export boards to various formats (PDF, PNG, etc.)

## Usage Examples

### Basic Board Operations

```bash
# List all your boards
claude miro list-boards

# Create a new board
claude miro create-board "My Project Planning"

# Get details about a specific board
claude miro get-board "uXjV1234567890"

# Delete a board
claude miro delete-board "uXjV1234567890"
```

### Widget Management

```bash
# List all widgets on a board
claude miro list-widgets "uXjV1234567890"

# Add a sticky note
claude miro create-sticky "uXjV1234567890" "Hello World" --x 100 --y 200

# Add a text widget
claude miro create-text "uXjV1234567890" "Project Goals" --x 300 --y 100

# Add a frame
claude miro create-frame "uXjV1234567890" "Planning Section" --x 50 --y 50 --width 400 --height 300
```

### Advanced Operations

```bash
# Export board to PDF
claude miro export-board "uXjV1234567890" "pdf" "./my-board.pdf"

# Share board with team members
claude miro share-board "uXjV1234567890" "user@example.com" "edit"

# Search for specific widgets
claude miro search-widgets "uXjV1234567890" "meeting notes"
```

## Authentication

### Getting Access Token
1. Go to [Miro Developer Settings](https://miro.com/app/settings/user-profile/apps)
2. Create a new app or select existing one
3. Generate a personal access token
4. Set the token in your environment: `export MIRO_ACCESS_TOKEN="your-token-here"`

### Required Permissions
- **boards:read** - Read access to boards
- **boards:write** - Write access to boards
- **boards:share** - Share boards with others
- **teams:read** - Read team information

## Rate Limiting

The Miro API has the following rate limits:
- **100 requests per minute** for personal access tokens
- **1000 requests per hour** for OAuth tokens
- **10000 requests per day** for all tokens

Best practices:
- Implement exponential backoff for retries
- Batch operations when possible
- Cache frequently accessed data
- Monitor response headers for rate limit information

## Error Handling

Common error scenarios:
- **401 Unauthorized**: Invalid or expired token
- **403 Forbidden**: Insufficient permissions
- **404 Not Found**: Board or widget not found
- **429 Too Many Requests**: Rate limit exceeded
- **500 Internal Server Error**: Server-side issues

## Security Considerations

- Never commit access tokens to version control
- Use environment variables for sensitive data
- Regularly rotate access tokens
- Limit app permissions to only what's needed
- Monitor API usage for suspicious activity

## Troubleshooting

### Common Issues

**"Invalid access token"**
- Verify token is correctly set in environment
- Check if token has required permissions
- Regenerate token if necessary

**"Board not found"**
- Confirm board ID is correct
- Ensure you have access to the board
- Check if board was deleted or moved

**"Rate limit exceeded"**
- Wait for rate limit reset
- Implement retry logic with exponential backoff
- Consider reducing request frequency

### Debug Mode
Enable debug logging by setting:
```bash
export DEBUG="miro-mcp:*"
```

## Best Practices

1. **Organize boards** with clear naming conventions
2. **Use frames** to group related content
3. **Implement error handling** for production use
4. **Monitor API usage** to avoid rate limits
5. **Regular token rotation** for security
6. **Document important board IDs** for team reference
