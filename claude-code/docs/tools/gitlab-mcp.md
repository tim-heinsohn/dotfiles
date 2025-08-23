# GitLab MCP Server

The GitLab MCP server provides comprehensive integration with GitLab repositories, merge requests, and CI/CD pipelines through Claude Code.

## Overview
This MCP server enables Claude to interact with GitLab projects, review merge requests, and monitor CI/CD pipelines directly from Claude Code conversations.

## Available Tools

### Repository Operations
- **get_projects** - List GitLab projects (repositories)
- **get_project** - Get detailed information about a specific project
- **get_branches** - List branches in a project
- **get_branch** - Get information about a specific branch

### Merge Requests
- **get_merge_requests** - List merge requests in a project
- **get_merge_request** - Get detailed information about a specific merge request
- **create_merge_request** - Create a new merge request
- **merge_merge_request** - Merge an existing merge request

### Code Review & Discussions
- **get_merge_request_discussions** - Get discussions (comments) on a merge request
- **create_merge_request_discussion** - Start a new discussion on a merge request
- **add_merge_request_discussion_note** - Add a note to an existing discussion
- **create_merge_request_discussion_note** - Create a discussion note with line-specific comments

### Pipeline Monitoring
- **get_pipelines** - List CI/CD pipelines for a project
- **get_pipeline** - Get detailed information about a specific pipeline
- **get_pipeline_jobs** - List jobs in a pipeline

### Advanced Features
- **get_merge_request_diff** - Get the diff for a merge request
- **get_merge_request_commits** - Get commits in a merge request
- **get_project_members** - List project members and permissions
- **get_project_labels** - List project labels for merge requests

## Usage Examples

### Basic Repository Operations
```
# List your GitLab projects
Get my GitLab projects

# Get project details
Show me details about my project "my-awesome-project"

# List branches
Show me the branches in my GitLab project
```

### Merge Request Operations
```
# Create a merge request
Create a merge request from branch "feature/new-login" to "main" 
titled "Add new login system" with description "Implements new secure login system"

# List open merge requests
Show me the open merge requests in my project

# Review MR details
Show me the details of merge request #15 in my project
```

### Code Review with Line Comments
```
# Get MR diff and add line comments
Get the diff for merge request #15 and add a comment on line 42 of src/auth.js
suggesting to use bcrypt instead of plain text passwords
```

### CI/CD Pipeline Monitoring
```
# Check pipeline status
Show me the status of the latest pipeline for my GitLab project

# Get detailed pipeline info
Show me details about pipeline #123 in my project
```

## Line-Specific Comments (Diff Comments)

The GitLab API supports adding comments to specific lines in merge request diffs. This is implemented through the GitLab Discussions API.

### Creating Line Comments
When creating discussions on merge requests, you can specify:
- **line_type**: "new" (for new lines) or "old" (for removed lines)
- **line_code**: The specific line number in the diff
- **position**: The position within the diff

### Example Line Comment Workflow
```
# 1. Get the MR diff to identify line numbers
Get the diff for merge request #15

# 2. Add a line-specific comment
Create a discussion on merge request #15 with a comment on line 42 (new line)
in file src/auth.js with body "Consider using bcrypt for password hashing"

# 3. Reply to existing discussions
Add a note to discussion #abc123 in merge request #15
```

## Authentication Setup

### GitLab Personal Access Token
1. Navigate to: https://gitlab.com/-/profile/personal_access_tokens
2. Create a new token with these scopes:
   - **api**: Full API access (required for most operations)
   - **read_api**: Read-only API access (for read-only scenarios)
   - **read_repository**: Read repository content

### Environment Variables
Set these environment variables before using the MCP:

```bash
export GITLAB_PERSONAL_ACCESS_TOKEN="your_token_here"
export GITLAB_URL="https://gitlab.com"  # For self-hosted instances
```

### Self-Hosted GitLab
For GitLab instances other than gitlab.com:
```bash
export GITLAB_URL="https://your-gitlab-instance.com"
```

## Security Considerations

- **Token Security**: Never commit your GitLab token to version control
- **Token Scope**: Use minimal required scopes for your use case
- **HTTPS Required**: Always use HTTPS for GitLab URLs
- **Environment Isolation**: Use project-specific tokens when possible
- **Rate Limiting**: Respect GitLab's API rate limits (see below)

## Rate Limiting and Best Practices

### GitLab Rate Limits
- **Authenticated**: 2000 requests per hour per user
- **Unauthenticated**: 60 requests per hour per IP

### Best Practices
- **Pagination**: Use pagination for large result sets
- **Caching**: Cache project information when working repeatedly with same projects
- **Batch Operations**: Combine multiple operations when possible
- **Delays**: Add small delays between bulk operations

### Example Pagination Usage
```
# Get merge requests with pagination
Get merge requests in my project, show page 2 with 50 items per page

# Filter by state to reduce response size
Show only open merge requests in my project
```

## Error Handling

### Common Errors and Solutions

| Error | Cause | Solution |
|-------|-------|----------|
| 401 Unauthorized | Invalid token | Check your GitLab personal access token |
| 404 Not Found | Invalid project path | Verify project ID or full project path |
| 403 Forbidden | Insufficient permissions | Check token scopes and project access |
| 429 Too Many Requests | Rate limit exceeded | Add delays between requests |

### Debug Commands
```bash
# Verify MCP installation
claude mcp list

# Test basic connectivity
List my GitLab projects
```

## Integration Commands

### Installation
```bash
# Install GitLab MCP
mcp install gitlab

# Integrate with Claude
mcp integrate gitlab
```

### Configuration
```bash
# Set environment variables in your shell profile
echo 'export GITLAB_PERSONAL_ACCESS_TOKEN="your_token"' >> ~/.zshrc
echo 'export GITLAB_URL="https://gitlab.com"' >> ~/.zshrc
source ~/.zshrc

# Or use direnv for project-specific configuration
echo 'export GITLAB_PERSONAL_ACCESS_TOKEN="your_token"' > .envrc
direnv allow
```

## Advanced Workflows

### Automated Code Review
```
# 1. Get open merge requests
Show me open merge requests in my project

# 2. Review each MR
For each MR, get the diff and check for security issues

# 3. Add review comments
Add comments to lines with potential security issues
```

### Merge Request Lifecycle
```
# 1. Create MR from feature branch
Create merge request from feature branch to main

# 2. Monitor review discussions
Show me discussions on merge request #15

# 3. Check CI status
Show me pipeline status for merge request #15

# 4. Merge when ready
Merge merge request #15 with squash
```

### CI/CD Integration
```
# Monitor pipeline after pushing changes
Show me the pipeline status for the latest commit

# Check job logs if failures occur
Show me the logs for failed jobs in pipeline #123
```