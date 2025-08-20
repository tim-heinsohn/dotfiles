# MCP Mail Server Usage

## Overview

This MCP mail server uses a **single installation** with **project-based configuration**. Each project can define its own primary and secondary email accounts using environment variables.

## Architecture

```
~/.mail-server-mcp/           # Single git clone
├── dist/index.js            # Built MCP server
├── wrapper-primary          # Maps PRIMARY_MAIL_* → EMAIL_*
├── wrapper-secondary        # Maps SECONDARY_MAIL_* → EMAIL_*
└── example-project.envrc    # Template for projects

~/projects/acme/.envrc       # ACME project emails
~/projects/johndoe/.envrc    # John Doe project emails
```

## Installation & Setup

### 1. Install MCP Mail Server
```bash
~/dotfiles/mail-server-mcp/install
```

### 2. Configure Project Email Settings

Copy the example configuration to your project directories:
```bash
# For each project
cp ~/.mail-server-mcp/example-project.envrc ~/projects/acme/.envrc
cp ~/.mail-server-mcp/example-project.envrc ~/projects/johndoe/.envrc
```

### 3. Edit Project Configuration

**Example: ACME Project (~~/projects/acme/.envrc):**
```bash
#!/bin/bash
# ACME Project Email Configuration

# === PRIMARY MAIL (ACME Corporate) ===
export PRIMARY_MAIL_USER="admin@acme.com"
export PRIMARY_MAIL_PASS="acme-app-password"
export PRIMARY_MAIL_IMAP_HOST="imap.acme.com"
export PRIMARY_MAIL_IMAP_PORT="993"
export PRIMARY_MAIL_IMAP_SECURE="true"
export PRIMARY_MAIL_SMTP_HOST="smtp.acme.com"
export PRIMARY_MAIL_SMTP_PORT="465"
export PRIMARY_MAIL_SMTP_SECURE="true"

# === SECONDARY MAIL (Personal Gmail for ACME work) ===
export SECONDARY_MAIL_USER="acme.personal@gmail.com"
export SECONDARY_MAIL_PASS="gmail-app-password"
export SECONDARY_MAIL_IMAP_HOST="imap.gmail.com"
export SECONDARY_MAIL_IMAP_PORT="993"
export SECONDARY_MAIL_IMAP_SECURE="true"
export SECONDARY_MAIL_SMTP_HOST="smtp.gmail.com"
export SECONDARY_MAIL_SMTP_PORT="465"
export SECONDARY_MAIL_SMTP_SECURE="true"
```

**Example: John Doe Project (~~/projects/johndoe/.envrc):**
```bash
#!/bin/bash
# John Doe Project Email Configuration

# === PRIMARY MAIL (John's Personal) ===
export PRIMARY_MAIL_USER="john@johndoe.com"
export PRIMARY_MAIL_PASS="johndoe-app-password"
export PRIMARY_MAIL_IMAP_HOST="imap.johndoe.com"
export PRIMARY_MAIL_IMAP_PORT="993"
export PRIMARY_MAIL_IMAP_SECURE="true"
export PRIMARY_MAIL_SMTP_HOST="smtp.johndoe.com"
export PRIMARY_MAIL_SMTP_PORT="465"
export PRIMARY_MAIL_SMTP_SECURE="true"

# No secondary mail needed for this project
```

### 4. Activate Project Environments
```bash
cd ~/projects/acme && direnv allow
cd ~/projects/johndoe && direnv allow
```

### 5. Add MCP Servers to Claude Code

The MCP servers will be integrated through the mcp-install script, creating two available servers:
- **mail-primary**: Uses PRIMARY_MAIL_* variables
- **mail-secondary**: Uses SECONDARY_MAIL_* variables (if defined)

## Email Provider Configuration

### Gmail Setup
1. Enable 2-Factor Authentication
2. Create App Password: Google Account → Security → App passwords
3. Use the app password (not regular password) in `*_MAIL_PASS`

```bash
export PRIMARY_MAIL_USER="your-email@gmail.com"
export PRIMARY_MAIL_PASS="app-password-here"
export PRIMARY_MAIL_IMAP_HOST="imap.gmail.com"
export PRIMARY_MAIL_SMTP_HOST="smtp.gmail.com"
```

### Outlook/Office365
```bash
export PRIMARY_MAIL_IMAP_HOST="outlook.office365.com"
export PRIMARY_MAIL_SMTP_HOST="smtp-mail.outlook.com"
export PRIMARY_MAIL_SMTP_PORT="587"
export PRIMARY_MAIL_SMTP_SECURE="false"
```

### Yahoo Mail
```bash
export PRIMARY_MAIL_IMAP_HOST="imap.mail.yahoo.com"
export PRIMARY_MAIL_SMTP_HOST="smtp.mail.yahoo.com"
# Requires App Password for Yahoo
```

### Custom/Corporate Email
```bash
export PRIMARY_MAIL_IMAP_HOST="mail.company.com"
export PRIMARY_MAIL_SMTP_HOST="mail.company.com"
# Check with IT for specific settings
```

## Available Features

### Email Operations
- **Read emails**: Access INBOX, Sent, and custom folders  
- **Send emails**: Compose and send HTML/text emails with attachments
- **Search emails**: Natural language email search across mailboxes
- **Folder management**: Navigate and manage different email folders
- **Attachment handling**: Send emails with file attachments

### Project-based Email Management
- **Context-aware**: Automatically uses correct email account based on current project
- **Multi-account support**: Primary and secondary email per project
- **Flexible configuration**: Each project defines its own email accounts

## Usage Examples

### Working from Project Directory

When working in a project directory, Claude automatically uses that project's email configuration:

```bash
cd ~/projects/acme

# Uses ACME's primary email (admin@acme.com)
"Send an email to client@example.com about project completion"

# Uses ACME's secondary email (acme.personal@gmail.com)  
"Send a personal follow-up email to client@example.com from my secondary account"
```

```bash
cd ~/projects/johndoe

# Uses John Doe's primary email (john@johndoe.com)
"Check my emails for messages from the design team"

# Secondary not configured - will show error
"Send from my secondary email account"
```

### Specific Account Operations

```bash
# Explicitly specify which account to use
"Send email from my primary account to team@company.com"
"Check my secondary email for personal messages" 
"Forward this email from primary to secondary account"
```

### Cross-Project Email Management

```bash
# Switch between projects as needed
cd ~/projects/acme
"Send ACME project update to stakeholders@acme.com"

cd ~/projects/johndoe  
"Send John Doe portfolio updates to clients@johndoe.com"
```

## Testing Configuration

### Test Individual Wrappers
```bash
cd ~/projects/acme

# Test primary mail configuration
~/.mail-server-mcp/wrapper-primary
# Should start without errors

# Test secondary mail configuration  
~/.mail-server-mcp/wrapper-secondary
# Should start without errors
```

### Verify Environment Variables
```bash
cd ~/projects/acme
env | grep MAIL
# Should show PRIMARY_MAIL_* and SECONDARY_MAIL_* variables

cd ~/projects/johndoe
env | grep MAIL  
# Should show only PRIMARY_MAIL_* variables
```

## Important Notes

### Security
- **App Passwords**: Always use app-specific passwords for Gmail/Yahoo
- **Environment Variables**: Email credentials stored securely in project `.envrc` files
- **File Permissions**: All `.envrc` files have restricted permissions (600)
- **Direnv**: Automatically loads environment per project directory

### Project Organization  
- **Consistency**: Use PRIMARY_MAIL_* for main project email account
- **Secondary Use**: Use SECONDARY_MAIL_* for auxiliary accounts (personal, backup, etc.)
- **Per-Project**: Each project can define different primary/secondary accounts
- **Flexibility**: Projects without secondary accounts can omit SECONDARY_MAIL_* variables

### Rate Limiting
- **Provider Limits**: Each email provider has its own rate limits
- **Per-Account**: Primary and secondary accounts have separate rate limits
- **Best Practice**: Avoid rapid successive operations to prevent throttling

## Updates and Maintenance

### Update MCP Server
```bash
# Update the shared MCP installation
~/dotfiles/mail-server-mcp/install
```

### Update Project Configurations
```bash
# Edit project-specific email settings
cd ~/projects/acme
nano .envrc
direnv reload
```

## Troubleshooting

### Environment Issues
```bash
# Check if direnv is loading correctly
cd ~/projects/acme
env | grep PRIMARY_MAIL
env | grep SECONDARY_MAIL

# Reload environment if needed
direnv reload
```

### Wrapper Script Errors
```bash
# Test wrapper directly
cd ~/projects/acme
~/.mail-server-mcp/wrapper-primary

# Common error: Missing PRIMARY_MAIL_USER
# Solution: Check .envrc has all required PRIMARY_MAIL_* variables
```

### Authentication Problems
```bash
# Verify credentials in project .envrc
cd ~/projects/acme
cat .envrc  # Check email settings

# For Gmail: Ensure using App Password, not regular password
# For Corporate: Check with IT for IMAP/SMTP settings
```

### MCP Integration Issues
```bash
# Test MCP servers are available
claude mcp list
# Should show: mail-primary, mail-secondary

# Test from specific project
cd ~/projects/acme
claude mcp test mail-primary
claude mcp test mail-secondary
```

### Debug Mode
Enable debug logging by adding to your `.envrc`:
```bash
export PRIMARY_MAIL_DEBUG="true"
export SECONDARY_MAIL_DEBUG="true"
```

## Advanced Configuration

### Multiple Email Providers per Project
```bash
# Primary: Corporate Exchange
export PRIMARY_MAIL_IMAP_HOST="mail.company.com"
export PRIMARY_MAIL_SMTP_HOST="mail.company.com"

# Secondary: Personal Gmail
export SECONDARY_MAIL_IMAP_HOST="imap.gmail.com"  
export SECONDARY_MAIL_SMTP_HOST="smtp.gmail.com"
```

### Project-Specific Settings
```bash
# Enable debug for specific project
export PRIMARY_MAIL_DEBUG="true"

# Custom ports for corporate firewall
export PRIMARY_MAIL_IMAP_PORT="1993"
export PRIMARY_MAIL_SMTP_PORT="1465"
```

This approach provides maximum flexibility while maintaining security and organization across different projects and email accounts.