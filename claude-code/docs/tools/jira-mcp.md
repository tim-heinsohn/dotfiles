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
Use Claude Code with natural language:
- "Show me all my active Jira issues"
- "List issues assigned to me that aren't done yet"
- "What tickets are currently in progress?"

**Create and update issues**:
Use Claude Code with natural language:
- "Create a new task in project KI titled 'New feature'"
- "Update issue KI-73 description with latest requirements"
- "Add a comment to KI-73: Progress update - completed implementation"

**Transition workflow**:
Use Claude Code with natural language:
- "Show me the available transitions for issue KI-73"
- "Move issue KI-73 to In Review status"

### Sprint Planning

**Backlog grooming**:
Use Claude Code with natural language:
- "Show me the backlog for project KI ordered by priority"
- "What issues are in the backlog for our team?"
- "Update issue KI-30 story points to 5 and priority to High"

**Sprint creation**:
Use Claude Code with natural language:
- "Create a new story in project KI titled 'Sprint planning task' with parent KI-25"

### Confluence Documentation

**Create meeting notes**:
Use Claude Code with natural language:
- "Create a new Confluence page in space TEAM titled 'Sprint 15 Retrospective' with these notes..."
- "Update Confluence page 12345 with the latest meeting decisions"

**Search documentation**:
Use Claude Code with natural language:
- "Search for pages about deployment process"
- "Find all documentation related to our project"

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

- **Check integration**: `claude mcp get jira`
- **List configured servers**: `claude mcp list`
- **Use in conversations**: Start Claude Code and use natural language like "Check the status of KI-73"
- **Interactive testing**: Run `/mcp` within Claude Code to check server status

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

Use Claude Code commands to test integration:

```bash
# Check server status
claude mcp get jira

# List all configured MCP servers
claude mcp list

# Test within Claude Code
claude
# Then type: /mcp
# Or use: "Show me my Jira projects to test connection"
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