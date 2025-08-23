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

1. **Install Jira MCP**: `mcp install jira`
2. **Configure credentials**: Edit `~/.jira-mcp/.env`
3. **Integrate**: `mcp integrate jira`
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

### Using Claude Code with Jira MCP

Once integrated, use natural language with Claude Code to interact with Jira:

**List all projects**:
- "Show me my Jira projects"
- "List all projects I have access to"

**Search for issues**:
- "Search for issues in project KI with status In Progress"
- "Find all high priority bugs assigned to me"

**Get issue details**:
- "Show me details for issue KI-73"
- "What's the current status of ticket PROJ-123?"

**Create issue**:
- "Create a new task in project KI with title 'New feature' and description 'Feature details'"
- "Add a bug report to project PROJ"

**Update issue**:
- "Update issue KI-73 description to include latest requirements"
- "Change the priority of PROJ-456 to high"

**Transition issue**:
- "Move issue KI-73 to In Progress"
- "Transition ticket PROJ-789 to Done"

**Add comment**:
- "Add a comment to issue KI-73: Progress update - implementation complete"
- "Comment on PROJ-123 with the testing results"

**Upload attachment**:
- "Upload the file screenshot.png to issue KI-73"
- "Attach the requirements document to ticket PROJ-456"

### Confluence Operations

**List spaces**:
- "Show me all Confluence spaces"
- "List spaces I can access"

**Get page content**:
- "Get the content of Confluence page 12345"
- "Show me the documentation for our deployment process"

**Create page**:
- "Create a new page in space KEY titled 'Sprint Retrospective'"
- "Add a documentation page under the parent page 12345"

**Update page**:
- "Update Confluence page 12345 with the latest meeting notes"
- "Add the new requirements to the project documentation"

**Search pages**:
- "Search for pages about project documentation"
- "Find all pages mentioning deployment process"

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
Use Claude Code with prompts like:
- "Show me all my open issues for project KI"
- "List my Jira issues that aren't done yet"
- "Add a comment to KI-73: Completed implementation, ready for review"

### Sprint Planning
Use Claude Code with prompts like:
- "Show me the backlog for project KI ordered by priority"
- "Create a new story in project KI titled 'Sprint planning'"
- "What issues are in the backlog for our team?"

### Documentation Updates
Use Claude Code with prompts like:
- "Update Confluence page 12345 with these meeting notes: [paste notes]"
- "Create a new page in space TEAM titled 'Sprint 15 Retrospective'"
- "Find and update the deployment documentation with latest changes"

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