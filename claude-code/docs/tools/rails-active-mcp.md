# Rails Active MCP Integration

## Overview
Rails Active MCP provides a Model-Context-Protocol (MCP) server for Ruby on Rails applications, enabling Claude to interact with your Rails models and database through structured tools.

## Installation
```bash
mcp-install install rails-active-mcp
```

## Usage Examples

### Example 1: Debugging User Model Issues
```
# Check if users table exists and has expected columns
Use ConsoleExecuteTool:
Code: "User.column_names"
Code: "User.count"
Code: "User.first.inspect"

# Check for validation issues
Use SafeQueryTool:
Query: "SELECT COUNT(*) as total_users, COUNT(CASE WHEN email IS NULL THEN 1 END) as null_emails FROM users"

# Find users created in last 24 hours
Use SafeQueryTool:
Query: "SELECT id, email, created_at FROM users WHERE created_at > datetime('now', '-1 day') ORDER BY created_at DESC"
```

### Example 2: Analyzing Post Performance
```
# Get post statistics
Use SafeQueryTool:
Query: "SELECT COUNT(*) as total_posts, AVG(LENGTH(content)) as avg_content_length, MAX(created_at) as latest_post FROM posts"

# Check for posts without authors
Use SafeQueryTool:
Query: "SELECT p.id, p.title, p.created_at FROM posts p LEFT JOIN users u ON p.user_id = u.id WHERE u.id IS NULL"

# Find top 5 most recent posts with author info
Use SafeQueryTool:
Query: "SELECT p.id, p.title, u.email as author_email, p.created_at FROM posts p JOIN users u ON p.user_id = u.id ORDER BY p.created_at DESC LIMIT 5"
```

### Example 3: Database Schema Investigation
```
# List all tables
Use ConsoleExecuteTool:
Code: "ActiveRecord::Base.connection.tables"

# Check table structure
Use ConsoleExecuteTool:
Code: "ActiveRecord::Base.connection.columns('posts').map { |c| [c.name, c.type] }"

# Find foreign key relationships
Use SafeQueryTool:
Query: "SELECT name FROM sqlite_master WHERE type='table' AND sql LIKE '%REFERENCES%'"
```

These examples work directly within your Rails application context when the MCP is properly configured.