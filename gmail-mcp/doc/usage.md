# Gmail MCP Usage

## Installation & Setup

### 1. Install Gmail MCP Server
```bash
~/dotfiles/gmail-mcp/install
```

### 2. Google Cloud Console Setup
1. Visit [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing one
3. Enable the Gmail API:
   - Go to "APIs & Services" → "Library"
   - Search for "Gmail API" and enable it
4. Create OAuth 2.0 credentials:
   - Go to "APIs & Services" → "Credentials"
   - Click "Create Credentials" → "OAuth 2.0 Client IDs"
   - Choose "Desktop Application"
   - Download the credentials JSON file

### 3. Configure Authentication
```bash
cd ~/.gmail-mcp
# Place your downloaded credentials JSON file as gcp-oauth.keys.json
chmod 600 gcp-oauth.keys.json  # Secure the credentials file
npm run auth
```
- Rename your downloaded credentials to `gcp-oauth.keys.json` in `~/.gmail-mcp/`
- Secure the file with `chmod 600` (read/write for owner only)
- Run the auth command to complete OAuth flow in browser
- Credentials are stored securely in `~/.gmail-mcp/credentials.json`

### 4. Add to Claude Code
```bash
claude mcp add-json ~/.gmail-mcp/mcp-config.json
```

## Available Features

### Email Management
- **Send emails**: Compose and send emails with attachments
- **Search emails**: Use Gmail search syntax
- **Label management**: Add/remove labels, organize emails
- **Draft management**: Create, edit, and manage drafts
- **Attachment handling**: Download and save attachments

### Filter Administration
- **Create filters**: Set up automatic email filtering rules
- **Delete filters**: Remove existing filters
- **Filter criteria**: Support for sender, subject, keywords, etc.

### Advanced Features
- **HTML emails**: Send rich formatted emails
- **Batch operations**: Process multiple emails at once
- **International support**: Handle non-ASCII characters
- **OAuth2 authentication**: Secure API access

## Usage Examples

### Basic Email Operations
```bash
# Search for emails
"Search my emails from john@example.com in the last week"

# Send email with attachment
"Send an email to team@company.com with subject 'Weekly Report' and attach the file ~/reports/weekly.pdf"

# Create email filter
"Create a Gmail filter to automatically label emails from newsletter@company.com with 'Newsletters' and mark as read"
```

### Filter Management
```bash
# List existing filters
"Show me all my Gmail filters"

# Create complex filter
"Create a filter that moves emails containing 'invoice' in the subject to 'Finance' label and forwards to accounting@company.com"

# Delete filter
"Delete the Gmail filter for newsletter@company.com"
```

## Important Notes

- **Security**: OAuth credentials are stored locally in `~/.gmail-mcp/`
- **Permissions**: Gmail API requires specific OAuth scopes for filter management
- **Rate limits**: Gmail API has rate limits; excessive requests may be throttled
- **Multiple accounts**: Supports configuration for multiple Gmail accounts

### Updates and Maintenance

**⚠️ IMPORTANT**: Always use the official update methods:

```bash
# Update Gmail MCP specifically
~/dotfiles/bin/mcp update gmail

# Update all installed MCPs
~/dotfiles/bin/mcp update

# Or update manually
~/dotfiles/gmail-mcp/install
```

## Troubleshooting

### Authentication Issues
```bash
# Re-run setup if authentication fails
cd ~/.gmail-mcp
node server.js --setup --force
```

### Permission Errors
- Ensure Gmail API is enabled in Google Cloud Console
- Verify OAuth scopes include filter management permissions
- Re-authenticate if scope changes are needed

### Connection Issues
```bash
# Test MCP connection
claude mcp list
claude mcp test gmail
```