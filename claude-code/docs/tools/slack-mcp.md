# Slack MCP Server

The Slack MCP server provides comprehensive access to your Slack workspace through Claude Code, enabling workspace management, message operations, and user interactions.

## Overview

The Slack MCP server connects Claude with your Slack workspace through the official Slack API, providing:
- Channel management and information retrieval
- Message reading and posting capabilities
- User information and workspace membership
- Real-time conversation access
- File sharing and thread management

## Authentication Setup

### 1. Create Slack App

1. Visit https://api.slack.com/apps
2. Click "Create New App" → "From scratch"
3. Name your app (e.g., "Claude MCP")
4. Select your workspace

### 2. Configure OAuth Scopes

Navigate to **OAuth & Permissions** → **Scopes** → **Bot Token Scopes** and add:

**Required scopes:**
- `channels:read` - View public channels
- `channels:history` - Read messages in public channels  
- `chat:write` - Send messages as bot
- `users:read` - View workspace members

**Optional scopes:**
- `groups:read` - View private channels
- `im:read` - View direct messages
- `mpim:read` - View group direct messages
- `files:write` - Upload files
- `reactions:write` - Add emoji reactions

### 3. Install App to Workspace

1. Go to **OAuth & Permissions** → **Install App to Workspace**
2. Review permissions and click "Allow"
3. Copy the **Bot User OAuth Token** (starts with `xoxb-`)
4. Copy the **Signing Secret** from **Basic Information**

### 4. Configure Environment

Set environment variables:

```bash
export SLACK_BOT_TOKEN="xoxb-your-bot-token-here"
export SLACK_SIGNING_SECRET="your-signing-secret-here"
```

## Usage

### Basic Operations

**List channels:**
```bash
claude slack list_channels
```

**Get channel messages:**
```bash
claude slack get_messages --channel "#general" --limit 10
```

**Send a message:**
```bash
claude slack send_message --channel "#general" --text "Hello team!"
```

**Get user information:**
```bash
claude slack get_users
```

### Advanced Operations

**Thread management:**
```bash
# Send message in thread
claude slack send_message --channel "#general" --text "Update" --thread_ts "1234567890.123456"

# Reply to specific message
claude slack send_message --channel "#general" --text "Thanks for the info" --thread_ts "parent_ts"
```

**File operations:**
```bash
# Upload file to channel
claude slack upload_file --channel "#resources" --file "/path/to/file.pdf" --title "Project docs"

# Get file info
claude slack get_file_info --file_id "F1234567890"
```

**Search operations:**
```bash
# Search messages
claude slack search_messages --query "meeting notes" --channel "#dev"

# Search users
claude slack search_users --query "john.doe@company.com"
```

## Rate Limiting

Slack implements rate limits that the MCP server handles automatically:

- **Web API**: 1 request/second for most methods
- **RTM API**: 1 message/second sustained
- **File uploads**: 1 file/second

The server uses exponential backoff (1s, 2s, 4s, 8s) for 429 responses.

## Security Considerations

### Token Management
- Store tokens in environment variables only
- Never commit tokens to version control
- Use minimal required scopes
- Rotate tokens periodically

### Channel Access
- Restrict bot to specific channels when possible
- Use channel IDs instead of names in production
- Implement user mention restrictions
- Monitor bot activity logs

### Environment Security
```bash
# Secure .env file
chmod 600 ~/.slack-env
source ~/.slack-env
```

## Best Practices

### Message Formatting
```bash
# Use Slack markdown
claude slack send_message --channel "#updates" --text "*Important*: Please review the _attached document_ for `code examples`"

# Include links
claude slack send_message --channel "#general" --text "Check out <https://example.com|this resource>"
```

### Channel Selection
```bash
# Use channel names for readability
claude slack get_messages --channel "#general"

# Use channel IDs for reliability
claude slack get_messages --channel "C1234567890"
```

### Error Handling
The MCP provides detailed error messages:

- `channel_not_found`: Check channel name/ID and bot permissions
- `missing_scope`: Add required OAuth scope to app
- `invalid_auth`: Verify bot token is correct
- `rate_limited`: Reduce request frequency

## Troubleshooting

### Common Issues

**"channel_not_found"**
- Ensure bot is added to the channel
- Verify channel exists and is accessible
- Check bot has required scopes

**"missing_scope"**
- Review OAuth scopes in Slack app settings
- Reinstall app to workspace after scope changes
- Ensure scopes match operations being performed

**"invalid_auth"**
- Verify bot token format: `xoxb-`
- Check token hasn't been revoked
- Ensure using correct workspace token

### Debug Mode

Enable detailed logging:
```bash
export DEBUG=slack-mcp:*
claude mcp restart
```

### Test Connection

Verify setup:
```bash
# Test basic connectivity
claude slack list_channels

# Check bot permissions
claude slack get_bot_info
```

## Integration with Claude Code

### Add to Claude
```bash
# Install Slack MCP
~/dotfiles/bin/mcp install slack

# Integrate with Claude
~/dotfiles/bin/mcp integrate slack
```

### Environment Variables
Ensure these are set in your shell:
- `SLACK_BOT_TOKEN`: Your bot user OAuth token
- `SLACK_SIGNING_SECRET`: App signing secret for verification

### Verification
```bash
# List configured MCPs
claude mcp list

# Test Slack integration
claude slack list_channels
```

## Advanced Configuration

### Multi-workspace Setup
For multiple workspaces, use separate environment variables:

```bash
# Workspace 1
export SLACK_BOT_TOKEN_WORK1="xoxb-token1"
export SLACK_SIGNING_SECRET_WORK1="secret1"

# Workspace 2  
export SLACK_BOT_TOKEN_WORK2="xoxb-token2"
export SLACK_SIGNING_SECRET_WORK2="secret2"
```

### Proxy Configuration
If behind corporate firewall:
```bash
export HTTPS_PROXY=http://proxy.company.com:8080
export HTTP_PROXY=http://proxy.company.com:8080
```

### Custom Rate Limits
Override default rate limiting:
```bash
export SLACK_RATE_LIMIT_DELAY=2000  # 2 second delay between requests
```