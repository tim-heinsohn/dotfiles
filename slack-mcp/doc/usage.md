# Slack MCP Server Usage

The Slack MCP server provides Claude with comprehensive access to your Slack workspace, enabling reading messages, sending messages, managing channels, and retrieving user information.

## Features

- **Channel Management**: List channels, get channel information
- **Message Operations**: Read messages from channels, send messages to channels
- **User Information**: Get user details and workspace membership
- **Real-time Updates**: Access to recent messages and conversations

## Authentication

### Required OAuth Scopes

Create a Slack App at https://api.slack.com/apps with these Bot Token Scopes:

- `channels:read` - View basic information about public channels
- `channels:history` - View messages and other content in public channels
- `chat:write` - Send messages as @your-bot
- `users:read` - View people in the workspace
- `groups:read` - View basic information about private channels
- `im:read` - View basic information about direct messages
- `mpim:read` - View basic information about group direct messages

### Environment Configuration

Create a `.env` file in your MCP server directory:

```bash
SLACK_BOT_TOKEN=xoxb-your-bot-token-here
SLACK_SIGNING_SECRET=your-signing-secret-here
```

## Usage Examples

### List Available Channels
```bash
claude slack list_channels
```

### Read Recent Messages from a Channel
```bash
claude slack get_messages --channel "#general" --limit 10
```

### Send a Message to a Channel
```bash
claude slack send_message --channel "#general" --text "Hello from Claude!"
```

### Get User Information
```bash
claude slack get_users
```

### Search Messages in a Channel
```bash
claude slack search_messages --channel "#random" --query "meeting notes"
```

## Rate Limiting

Slack has the following rate limits:

- **Web API**: 1 request per second for most methods
- **RTM API**: 1 message per second sustained, short bursts allowed
- **Event subscriptions**: Rate limits vary by workspace

The MCP server implements exponential backoff for 429 responses with delays of 1s, 2s, 4s, 8s.

## Security Considerations

- Bot tokens should have minimal required scopes
- Store tokens in environment variables, never commit to version control
- Review app permissions regularly
- Use channel restrictions if your bot doesn't need access to all channels

## Best Practices

1. **Start with read-only operations** to test connectivity
2. **Use specific channel names** rather than IDs when possible for readability
3. **Implement message threading** for better conversation organization
4. **Monitor rate limit headers** to avoid hitting limits
5. **Use user mentions sparingly** to avoid notification fatigue

## Troubleshooting

### Common Issues

**"invalid_auth" error**: Check your bot token is correct and has the required scopes.

**"channel_not_found"**: Ensure the bot is added to the channel or the channel exists.

**"missing_scope"**: Add the required OAuth scope to your Slack app.

**Rate limit errors**: Reduce request frequency or implement backoff delays.

### Debug Mode

Enable debug logging by setting:
```bash
DEBUG=slack-mcp:*
```

## Advanced Usage

### Working with Threads
```bash
claude slack send_message --channel "#dev" --text "Update on the project" --thread_ts "1234567890.123456"
```

### Formatting Messages
```bash
claude slack send_message --channel "#design" --text "*Bold text* and _italic text_ with `code blocks`"
```

### Uploading Files
```bash
claude slack upload_file --channel "#resources" --file "/path/to/document.pdf" --title "Project Documentation"
```