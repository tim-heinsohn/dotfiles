# MCP Mail Server Usage

## Architecture Overview

**Project-based Configuration**: Single MCP installation with project-specific email accounts
- **Single clone**: `~/.mail-server-mcp/` contains the MCP server
- **Wrapper scripts**: `wrapper-primary` and `wrapper-secondary` map project environments  
- **Project configs**: Each project directory has `.envrc` with `PRIMARY_MAIL_*` / `SECONDARY_MAIL_*` variables

## Available MCP Servers

When integrated, two MCP servers are available:
- **mail-primary**: Uses `PRIMARY_MAIL_*` environment variables from current directory
- **mail-secondary**: Uses `SECONDARY_MAIL_*` environment variables from current directory

## Available Features

### Email Operations
- **Read emails**: Access INBOX, Sent, and custom folders across different providers
- **Send emails**: Compose and send HTML/text emails with file attachments
- **Search emails**: Natural language email search across mailboxes
- **Folder navigation**: Access different email folders and manage organization
- **Multi-provider support**: Gmail, Outlook, Yahoo, corporate email systems

### Project-based Email Management
- **Context-aware**: Automatically uses correct email account based on current project directory
- **Dual account support**: Primary and optional secondary email per project
- **Provider flexibility**: Each account can use different email providers (Gmail + Corporate)
- **Secure configuration**: Environment variables stored per-project with restricted permissions

## Usage Examples

### Project-Specific Operations
```bash
# When working in a project directory, emails automatically use that project's config

cd ~/projects/acme
"Send project update to stakeholders@acme.com"
# Uses ACME's PRIMARY_MAIL_* configuration

"Send personal follow-up from secondary account"  
# Uses ACME's SECONDARY_MAIL_* configuration

cd ~/projects/johndoe
"Check my inbox for client responses"
# Uses John Doe's PRIMARY_MAIL_* configuration
```

### Explicit Account Specification
```bash
"Send email from my primary account to client@example.com about project status"
"Check my secondary email for personal messages"
"Forward the meeting email from primary to secondary account"
```

### Cross-Project Email Management
```bash
# Switch context by changing directories
cd ~/projects/acme && "Send ACME status report to team@acme.com"
cd ~/projects/johndoe && "Send portfolio update to clients@johndoe.com"
```

### Advanced Email Operations
```bash
"Search my primary email for invoices from last month"
"Send HTML formatted email with project timeline to stakeholders"
"Download attachments from emails in my work folder"
"Forward all emails about Project Alpha from primary to secondary account"
```

## Configuration Requirements

### Project Environment Variables

Each project must define `PRIMARY_MAIL_*` variables in `.envrc`:

```bash
# Required for all projects
export PRIMARY_MAIL_USER="your-email@domain.com"
export PRIMARY_MAIL_PASS="your-app-password"
export PRIMARY_MAIL_IMAP_HOST="imap.domain.com"
export PRIMARY_MAIL_SMTP_HOST="smtp.domain.com"

# Optional (with sensible defaults)
export PRIMARY_MAIL_IMAP_PORT="993"
export PRIMARY_MAIL_IMAP_SECURE="true"
export PRIMARY_MAIL_SMTP_PORT="465"
export PRIMARY_MAIL_SMTP_SECURE="true"
```

### Secondary Account (Optional)
```bash
# Optional secondary account for projects that need dual email access
export SECONDARY_MAIL_USER="secondary@domain.com"
export SECONDARY_MAIL_PASS="secondary-app-password"
export SECONDARY_MAIL_IMAP_HOST="imap.gmail.com"
export SECONDARY_MAIL_SMTP_HOST="smtp.gmail.com"
```

## Email Provider Setup

### Gmail Configuration
- **Requirement**: Enable 2-Factor Authentication
- **App Password**: Generate at Google Account → Security → App passwords
- **Settings**:
  ```bash
  export PRIMARY_MAIL_IMAP_HOST="imap.gmail.com"
  export PRIMARY_MAIL_SMTP_HOST="smtp.gmail.com"
  export PRIMARY_MAIL_SMTP_PORT="465"
  ```

### Corporate/Exchange Email
- **Check with IT**: Verify IMAP/SMTP settings and security policies
- **Common settings**:
  ```bash
  export PRIMARY_MAIL_IMAP_HOST="mail.company.com"
  export PRIMARY_MAIL_SMTP_HOST="mail.company.com"
  ```

### Outlook/Office365
- **Settings**:
  ```bash
  export PRIMARY_MAIL_IMAP_HOST="outlook.office365.com" 
  export PRIMARY_MAIL_SMTP_HOST="smtp-mail.outlook.com"
  export PRIMARY_MAIL_SMTP_PORT="587"
  export PRIMARY_MAIL_SMTP_SECURE="false"
  ```

## Authentication & Security

- **Environment isolation**: Each project's credentials stored separately
- **App passwords**: Required for Gmail, Yahoo, and other providers with 2FA
- **File permissions**: All `.envrc` files secured with 600 permissions
- **Direnv integration**: Automatic environment loading per project directory
- **No shared credentials**: Each project can use completely different email providers

## Important Notes

### Rate Limiting & Provider Limits
- **IMAP connections**: Most providers limit concurrent connections (typically 10-15)
- **SMTP sending**: Providers have daily/hourly sending limits
- **Best practice**: Avoid rapid successive operations to prevent throttling
- **Multi-account**: Primary and secondary accounts have separate rate limits

### Project Organization Best Practices
- **PRIMARY_MAIL_***: Use for main project email account (corporate, client-facing)
- **SECONDARY_MAIL_***: Use for auxiliary needs (personal, backup, notifications)
- **Consistency**: Maintain consistent naming across projects
- **Documentation**: Document email setup in project README files

### Directory Context Awareness
- **Working directory**: MCP servers detect and use email config from current directory
- **Project switching**: Simply `cd` to different project to switch email context
- **Environment loading**: Direnv automatically loads appropriate `.envrc` when entering project
- **Fallback behavior**: Clear error messages if email variables not configured

## Troubleshooting

### Environment Variable Issues
```bash
# Check if variables are loaded
cd ~/projects/your-project
env | grep MAIL

# Reload direnv if needed  
direnv reload
```

### Authentication Failures
- **Gmail**: Verify 2FA enabled and using App Password (not regular password)
- **Corporate**: Check firewall settings and IT security policies
- **Outlook**: Verify account settings and modern authentication

### MCP Server Issues
```bash
# Test wrapper scripts directly
cd ~/projects/your-project
~/.mail-server-mcp/wrapper-primary    # Should start without errors
~/.mail-server-mcp/wrapper-secondary  # Should start if SECONDARY_MAIL_* defined
```

### Project Configuration Problems
- **Missing variables**: Ensure all required `PRIMARY_MAIL_*` variables are defined
- **File permissions**: Check `.envrc` files have correct permissions (600)
- **Direnv setup**: Verify `direnv allow` was run in project directory

## Integration Commands

```bash
# Install and integrate
~/dotfiles/bin/mcp install mail-server
~/dotfiles/bin/mcp integrate mail-server

# Verify integration
claude mcp list
# Should show: mail-primary, mail-secondary

# Test from project directory
cd ~/projects/your-project  
claude mcp test mail-primary
```