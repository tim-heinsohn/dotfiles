# Gmail MCP Usage

## Available Features

### Email Management
- **Send emails**: Compose and send emails with attachments, HTML formatting
- **Search emails**: Use Gmail search syntax for precise filtering
- **Label management**: Add/remove labels, organize emails into folders
- **Draft management**: Create, edit, and manage email drafts
- **Attachment handling**: Download and save email attachments

### Gmail Filter Administration
- **Create filters**: Set up automatic email filtering and labeling rules
- **Delete filters**: Remove existing Gmail filters
- **Complex criteria**: Filter by sender, subject, keywords, date ranges, attachments

### Advanced Operations
- **Batch operations**: Process multiple emails simultaneously
- **HTML emails**: Send rich formatted emails with styling
- **International support**: Handle non-ASCII characters and international text
- **Multiple accounts**: Support for multiple Gmail account configurations

## Usage Examples

### Email Operations
```
Send an email to team@company.com with subject 'Weekly Report' and attach ~/reports/weekly.pdf
```

```
Search my emails from john@example.com in the last week
```

```
Create a draft email to client@example.com about the project update
```

### Filter Management
```
Create a Gmail filter to automatically label emails from newsletter@company.com with 'Newsletters' and mark as read
```

```
Create a filter that moves emails containing 'invoice' in the subject to 'Finance' label and forwards to accounting@company.com
```

```
Show me all my current Gmail filters
```

```
Delete the Gmail filter for newsletter@company.com
```

### Label Operations
```
Add the 'Important' label to all emails from boss@company.com
```

```
Remove the 'Spam' label from emails in my inbox
```

## Authentication & Security

- Uses OAuth 2.0 for secure API access
- Credentials stored locally in `~/.gmail-mcp/`
- Supports Gmail API rate limiting and error handling
- Requires specific OAuth scopes for filter management operations

## Important Notes

- Gmail API has rate limits; excessive requests may be throttled
- Filter creation requires appropriate Gmail API permissions
- Some operations may require re-authentication if scopes change
- Always verify filter rules before applying to avoid unintended email routing

### Rate Limiting & Batch Processing

**⚠️ CRITICAL**: When processing large email batches, always implement delays to prevent API bans:

#### For Small Batches (< 50 emails):
```
Process emails in batches of 10-20 with 1-2 second delays between batches
```

#### For Large Batches (50+ emails):
```
Use exponential backoff: 1s → 2s → 4s → 8s → 16s delays
Process in smaller chunks (5-10 emails per batch)
Monitor for 429 (rate limit) responses and increase delays accordingly
```

#### Best Practices:
- **Never spawn multiple Claude instances** for concurrent Gmail operations
- **Use batch_modify_emails** tool instead of individual email operations
- **Start with conservative delays** and increase if you hit rate limits
- **Respect Google's quotas**: 250 quota units per user per 100 seconds
- **Consider time-based processing** for very large operations (spread across hours)