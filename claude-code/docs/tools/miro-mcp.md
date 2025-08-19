# Miro MCP

Miro MCP server integration for Claude Code, providing access to Miro whiteboards and collaborative features.

## Quick Setup

```bash
# Install Miro MCP
mcp-install install miro

# Get your Miro access token
# Go to: https://miro.com/app/settings/user-profile/apps
# Create app → Generate access token

# Add to Claude Code (replace with your token)
claude mcp add-json '{"miro":{"command":"node","args":["$HOME/.miro-mcp/build/index.js"],"env":{"MIRO_ACCESS_TOKEN":"your-token-here"}}}'
```

## Available Tools

### Board Operations
- `miro_list_boards` - List all accessible boards
- `miro_create_board` - Create new boards
- `miro_get_board` - Get board details
- `miro_delete_board` - Remove boards

### Widget Management
- `miro_create_widget` - Add widgets (sticky notes, text, shapes)
- `miro_update_widget` - Modify existing widgets
- `miro_delete_widget` - Remove widgets
- `miro_list_widgets` - Get all widgets on a board

### Content Operations
- `miro_export_board` - Export boards to PDF/PNG
- `miro_share_board` - Manage board permissions
- `miro_search_widgets` - Find specific content

## Common Workflows

### Project Planning
```bash
# Create planning board
claude miro create-board "Q4 Planning"

# Add project structure
claude miro create-frame "Goals" --board-id BOARD_ID
claude miro create-sticky "Complete feature X" --x 100 --y 150
```

### Team Collaboration
```bash
# Share board with team
claude miro share-board BOARD_ID "team@company.com" "edit"

# Export for presentation
claude miro export-board BOARD_ID "pdf" "./presentation.pdf"
```

## Security Notes
- **Token security**: Never commit tokens to version control
- **Permissions**: Use minimal required scopes
- **Rate limits**: 100 requests/minute, implement backoff
- **Team access**: Careful with sharing permissions

## Rate Limiting
- **Personal tokens**: 100 req/min, 1000 req/hour, 10000 req/day
- **Exponential backoff**: 1s, 2s, 4s, 8s delays on 429 errors
- **Monitor headers**: Check rate limit info in responses

## Environment Variables
```bash
export MIRO_ACCESS_TOKEN="your-token"
export DEBUG="miro-mcp:*"  # Enable debug logging
```

## Integration Examples

### Daily Standup Notes
```bash
# Create daily standup board
claude miro create-board "Daily Standup $(date +%Y-%m-%d)"
# Add team member updates as sticky notes
```

### Architecture Diagrams
```bash
# Create system architecture board
claude miro create-board "System Architecture"
# Add components as shapes with connections
```