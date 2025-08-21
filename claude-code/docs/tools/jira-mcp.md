# Jira MCP Integration

The Jira MCP provides comprehensive integration with Atlassian Jira and Confluence, enabling Claude Code to manage issues, projects, and documentation directly.

## Overview

The Jira MCP server connects to Atlassian Cloud instances, providing access to:
- **Jira**: Issues, projects, users, workflows, and attachments
- **Confluence**: Pages, spaces, search, and content management

## Installation

```bash
# Install Jira MCP server
mcp install jira

# Configure credentials in ~/.jira-mcp/.env
# Integrate with Claude Code
mcp integrate jira
```

## Authentication Setup

1. **Generate API Token**: https://id.atlassian.com/manage-profile/security/api-tokens
2. **Configure Environment**: Edit `~/.jira-mcp/.env`
   ```
   JIRA_API_TOKEN=your_token_here
   JIRA_EMAIL=your_email@company.com
   JIRA_URL=https://your-company.atlassian.net
   ```

## Core Workflows

### Daily Issue Management

**Get active issues**:
```bash
claude mcp call jira search_issues --jql "assignee = currentUser() AND status != Done"
```

**Create and update issues**:
```bash
# Create new issue
claude mcp call jira create_issue --project KI --summary "New feature" --issuetype Task

# Update existing issue
claude mcp call jira update_issue --key KI-73 --description "Updated details"

# Add progress comment
claude mcp call jira add_comment --key KI-73 --comment "Progress update: completed implementation"
```

**Transition workflow**:
```bash
# Get available transitions
claude mcp call jira get_transitions --key KI-73

# Transition issue
claude mcp call jira transition_issue --key KI-73 --transition "In Review"
```

### Sprint Planning

**Backlog grooming**:
```bash
# Get backlog issues
claude mcp call jira search_issues --jql "project = KI AND status = Backlog ORDER BY priority DESC"

# Estimate and prioritize
claude mcp call jira update_issue --key KI-30 --fields '{"customfield_10016": 5, "priority": "High"}'
```

**Sprint creation**:
```bash
# Create sprint issues
claude mcp call jira create_issue --project KI --summary "Sprint planning task" --issuetype Story --parent KI-25
```

### Confluence Documentation

**Create meeting notes**:
```bash
# Create new page
claude mcp call jira create_page --space TEAM --title "Sprint 15 Retrospective" --content "Meeting notes..." --parent_id 12345

# Update existing page
claude mcp call jira update_page --page_id 12345 --content "Updated with latest decisions..."
```

**Search documentation**:
```bash
# Find relevant pages
claude mcp call jira search_pages --query "deployment process"
```

## Advanced Features

### Bulk Operations

**Batch issue updates**:
```bash
# Update multiple issues
claude mcp call jira search_issues --jql "project = KI AND labels = urgent" --max_results 50
# Then update each issue programmatically
```

**Attachment management**:
```bash
# Upload screenshots to issues
claude mcp call jira add_attachment --key KI-73 --filepath ./screenshot.png
```

### Custom Fields and Workflows

**Access custom fields**:
```bash
# Get field configuration
claude mcp call jira get_fields

# Use custom fields in issues
claude mcp call jira create_issue --project KI --summary "Test" --customfield_10001 "value"
```

## Security Best Practices

- **Never commit credentials** to version control
- **Use environment variables** for sensitive configuration
- **Restrict API token permissions** to minimum required
- **Monitor API usage** for unusual activity
- **Rotate tokens** regularly (quarterly recommended)

## Rate Limiting

- **Jira API**: 100 requests per 10 seconds per user
- **Confluence API**: 100 requests per 10 seconds per user
- **Exponential backoff**: Implement delays for 429 responses
- **Batch operations**: Use bulk endpoints when available

## Integration with Claude Code

The Jira MCP integrates seamlessly with Claude Code workflows:

```bash
# Check available tools
claude mcp tools jira

# Use in conversations
"Check the status of KI-73 using the Jira MCP"

# List all Jira MCP tools
claude mcp list jira
```

## Troubleshooting

### Common Issues

**Authentication failures**:
- Verify API token validity and expiration
- Check email address matches Jira account
- Ensure Jira URL format is correct (include https://)

**Permission errors**:
- Confirm API token has project access permissions
- Verify user has appropriate project roles
- Check issue-level permissions

**Rate limiting**:
- Implement exponential backoff for retries
- Use batch operations to reduce API calls
- Monitor usage via Atlassian admin console

### Debug Commands

```bash
# Test connection
claude mcp call jira get_projects

# Get user info
claude mcp call jira get_current_user

# List available issue types
claude mcp call jira get_issue_types --project KI
```

## Environment Variables

Required environment variables for Jira MCP:
- `JIRA_API_TOKEN`: Your Atlassian API token
- `JIRA_EMAIL`: Your Jira account email
- `JIRA_URL`: Your Jira instance URL

Optional for Confluence:
- `CONFLUENCE_API_TOKEN`: Confluence API token (can be same as Jira)
- `CONFLUENCE_EMAIL`: Confluence account email
- `CONFLUENCE_URL`: Confluence instance URL