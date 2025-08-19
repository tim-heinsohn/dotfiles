# Jira MCP Usage Guide

The Jira MCP server provides comprehensive integration with Atlassian Jira and Confluence, allowing Claude Code to interact with issues, projects, and documentation.

## Features

### Jira Integration
- **Issues**: Create, read, update, delete, search, and transition issues
- **Projects**: List and get project details
- **Users**: Get user information and search users
- **Fields**: Get available fields and field configurations
- **Transitions**: Get available issue transitions
- **Comments**: Add and manage issue comments
- **Attachments**: Upload and manage issue attachments

### Confluence Integration  
- **Pages**: Create, read, update, and delete pages
- **Spaces**: List and get space details
- **Search**: Search for pages and content
- **Attachments**: Upload and manage page attachments

## Setup

1. **Install Jira MCP**: `mcp-install install jira`
2. **Configure credentials**: Edit `~/.jira-mcp/.env`
3. **Integrate**: `mcp-install integrate jira`
4. **Test**: `claude mcp call jira get_projects`

## Authentication

### Jira API Token
1. Go to https://id.atlassian.com/manage-profile/security/api-tokens
2. Click "Create API token"
3. Copy the token to `~/.jira-mcp/.env`:
   ```
   JIRA_API_TOKEN=your_token_here
   JIRA_EMAIL=your_email@company.com
   JIRA_URL=https://your-company.atlassian.net
   ```

### Confluence (Optional)
Same API token can be used for Confluence:
```
CONFLUENCE_API_TOKEN=your_token_here
CONFLUENCE_EMAIL=your_email@company.com  
CONFLUENCE_URL=https://your-company.atlassian.net/wiki
```

## Usage Examples

### Jira Operations

**List all projects**:
```bash
claude mcp call jira get_projects
```

**Search for issues**:
```bash
claude mcp call jira search_issues --jql "project = KI AND status = 'In Progress'"
```

**Get issue details**:
```bash
claude mcp call jira get_issue --key KI-73
```

**Create issue**:
```bash
claude mcp call jira create_issue --project KI --summary "New feature" --description "Feature details" --issuetype Task
```

**Update issue**:
```bash
claude mcp call jira update_issue --key KI-73 --description "Updated description"
```

**Transition issue**:
```bash
claude mcp call jira transition_issue --key KI-73 --transition "In Progress"
```

**Add comment**:
```bash
claude mcp call jira add_comment --key KI-73 --comment "Progress update"
```

**Upload attachment**:
```bash
claude mcp call jira add_attachment --key KI-73 --filepath /path/to/file.txt
```

### Confluence Operations

**List spaces**:
```bash
claude mcp call jira get_spaces
```

**Get page content**:
```bash
claude mcp call jira get_page --page_id 12345
```

**Create page**:
```bash
claude mcp call jira create_page --space KEY --title "New Page" --content "Page content" --parent_id 12345
```

**Update page**:
```bash
claude mcp call jira update_page --page_id 12345 --content "Updated content"
```

**Search pages**:
```bash
claude mcp call jira search_pages --query "project documentation"
```

## Rate Limiting

- **Jira API**: 100 requests per 10 seconds per user
- **Confluence API**: 100 requests per 10 seconds per user
- Implement exponential backoff for 429 responses
- Consider batch operations for large data sets

## Security Notes

- Never commit API tokens to version control
- Use environment variables for sensitive configuration
- Restrict API token permissions to minimum required
- Monitor API usage for unusual activity
- Rotate tokens regularly

## Common Workflows

### Daily Standup Notes
```bash
# Get team issues
claude mcp call jira search_issues --jql "project = KI AND assignee = currentUser() AND status != Done"

# Add progress comments
claude mcp call jira add_comment --key KI-73 --comment "Completed implementation, ready for review"
```

### Sprint Planning
```bash
# Get backlog issues
claude mcp call jira search_issues --jql "project = KI AND status = Backlog ORDER BY priority DESC"

# Create sprint issues
claude mcp call jira create_issue --project KI --summary "Sprint planning" --issuetype Story
```

### Documentation Updates
```bash
# Update Confluence page with meeting notes
claude mcp call jira update_page --page_id 12345 --content "Updated with latest decisions..."
```

## Troubleshooting

### Common Issues

**Authentication errors**:
- Verify API token is valid and not expired
- Check email address matches Jira account
- Ensure URL format is correct (include https://)

**Rate limiting**:
- Add delays between requests
- Use batch operations where possible
- Monitor API usage dashboard

**Permission errors**:
- Check API token has required project permissions
- Verify user has access to requested resources
- Review project permissions and roles