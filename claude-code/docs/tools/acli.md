# ACLI - Atlassian CLI Tool

The Atlassian CLI (`acli`) provides command-line access to Bitbucket and other Atlassian products.


-----------------------------------------------------------------------------------------------------------------------
PLEASE NOTE: we currently are testing the Jira MCP. Thereby, please DO NOT USE acli FOR JIRA, but use Jira MCP instead!
-----------------------------------------------------------------------------------------------------------------------

## Installation

```bash
# macOS
brew install atlassian/tap/acli

# Linux
# Download from https://developer.atlassian.com/platform/acli/
```

## Authentication

```bash
# Initial setup
acli jira auth login

# Check authentication status
acli jira auth status
```

## Jira Work Item Management

### Creating Work Items

```bash
# Basic work item creation
acli jira workitem create --summary "Fix login bug" --project "PROJ" --type "Bug"

# Create with description
acli jira workitem create --summary "New feature" --project "KI" --type "Task" \
  --description "Detailed description of the feature"

# Create with assignee and labels
acli jira workitem create --summary "API endpoint" --project "KI" --type "Story" \
  --assignee "user@company.com" --label "api,backend"

# Create from file
acli jira workitem create --from-file "workitem.txt" --project "KI" --type "Task"

# Open editor for complex content
acli jira workitem create --editor --project "KI" --type "Epic"
```

### Work Item Types

Common work item types:
- `Task` - General work item
- `Story` - User story
- `Bug` - Bug report
- `Epic` - Large body of work
- `Sub-task` - Subtask of parent work item

### Essential Commands

```bash
# List work items
acli jira workitem list --project "KI" --limit 10

# Search work items
acli jira workitem search "summary ~ 'n8n'"

# Get work item details
acli jira workitem view KI-70

# Get work item with comments and full details
acli jira workitem view KI-30 --fields "summary,comment,description" --json

# Update work item
acli jira workitem update KI-70 --summary "Updated title"

# Add comment
acli jira workitem comment KI-70 --comment "Progress update"

# Transition work item
acli jira workitem transition KI-70 --transition "In Progress"

# Assign work item
acli jira workitem assign KI-70 --assignee "user@company.com"

# Add labels
acli jira workitem label add KI-70 --label "urgent"

# Remove labels
acli jira workitem label remove KI-70 --label "urgent"
```

### Advanced Usage

```bash
# Create with parent relationship
acli jira workitem create --summary "Sub-task" --project "KI" --type "Sub-task" \
  --parent "KI-70"

# Bulk operations with JSON
acli jira workitem create --generate-json > template.json
# Edit template.json, then:
acli jira workitem create --from-json "template.json"

# Filter work items
acli jira workitem list --project "KI" --status "In Progress" --assignee "@me"
```

### Common Patterns

```bash
# Quick task creation
alias jira-task="acli jira workitem create --project KI --type Task"
jira-task --summary "Review PR #123"

# Create bug with template
acli jira workitem create --project KI --type Bug \
  --description-file "bug_template.md" \
  --label "bug,needs-investigation"

# Daily standup preparation
acli jira workitem list --project KI --assignee "@me" --status "In Progress"
```

### Environment Variables

```bash
# Set default project
export ACLI_DEFAULT_PROJECT="KI"

# Set default work item type
export ACLI_DEFAULT_TYPE="Task"
```

## Project Management

```bash
# List projects
acli jira project list

# Get project details
acli jira project view KI

# List project components
acli jira project components KI

# List project versions
acli jira project versions KI
```

## Dashboard Commands

```bash
# View dashboard
acli jira dashboard view

# List dashboard gadgets
acli jira dashboard gadgets
```

## Filter Management

```bash
# List filters
acli jira filter list

# Create filter
acli jira filter create --name "My Open Issues" --jql "assignee = currentUser() AND status != Done"

# Run filter
acli jira filter run "My Open Issues"
```

## Editing Work Items
```bash
# Edit work item description/summary
acli jira workitem edit --key KI-72 --description "Updated description"
acli jira workitem edit --key KI-72 --summary "Updated title"
acli jira workitem edit --key KI-72 --editor  # Open in editor

# Markdown support - convert to ADF format first
echo "# Title\n**Bold** content" | markdown-to-adf > desc.json
acli jira workitem create --summary "My ticket" --description-file desc.json

# Common error fix: Use --key flag (not positional)
# ✅ Correct: acli jira workitem edit --key KI-72 --description "text"
# ❌ Wrong: acli jira workitem edit KI-72 --description "text"
```

## Essential Commands Summary

### Daily Commands
```bash
# Quick search
acli jira workitem search --jql "project = KI AND assignee = currentUser() AND status != Done"

# View recent work items
acli jira workitem search --jql "project = KI ORDER BY created DESC" --limit 10

# My open work items
acli jira workitem search --jql "assignee = currentUser() AND status IN ('To Do', 'In Progress')"

# Search by summary
acli jira workitem search --jql "project = KI AND summary ~ 'n8n'"

# Export to CSV
acli jira workitem search --jql "project = KI" --csv --fields "key,summary,status,assignee"
```

### Work Item Operations
```bash
# Clone work item
acli jira workitem clone KI-70

# Bulk transition
acli jira workitem transition --jql "project = KI AND status = 'To Do'" --status "In Progress"

# Archive completed work items
acli jira workitem archive --jql "project = KI AND status = Done AND updated < -30d"

# Add comment to work items
acli jira workitem comment --key KI-70 --body "Progress update"
acli jira workitem comment --key KI-70 --body "Multi-line comment here"
acli jira workitem comment --key "KI-70,KI-71" --body "Status update for both items"
acli jira workitem comment --jql "project = KI" --body "Team-wide update"

# Edit work items
acli jira workitem edit --key KI-72 --summary "Updated title"
acli jira workitem edit --key KI-72 --description "Updated description"
acli jira workitem edit --key KI-72 --editor
```

## Tips and Tricks

1. **Use aliases** for common operations:
   ```bash
   alias jt="acli jira workitem create --project KI --type Task"
   alias jb="acli jira workitem create --project KI --type Bug"
   alias jm="acli jira workitem search --jql 'assignee = currentUser() AND status != Done'"
   alias jv="acli jira workitem view"
   ```

2. **Template files** for consistent descriptions:
   ```bash
   # Create template
   echo "## Problem
   [Describe the issue]

   ## Solution
   [Describe the fix]

   ## Testing
   [How to test]" > bug_template.md
   
   # Use template
   acli jira workitem create --from-file bug_template.md --project KI --type Bug
   ```

3. **JSON templates** for complex work items:
   ```bash
   # Generate template
   acli jira workitem create --generate-json > feature.json
   
   # Edit and use
   acli jira workitem create --from-json feature.json
   ```

## Troubleshooting

```bash
# Check authentication
acli jira auth status

# Re-authenticate if needed
acli jira auth login

# Get help for specific command
acli jira workitem create --help

# Verbose output
acli jira workitem create --summary "Test" --project KI --type Task --json
```
