# Rails Active MCP Usage Guide

## Overview
Rails Active MCP provides a Model-Context-Protocol (MCP) server for Ruby on Rails applications, allowing Claude to interact with your Rails models and database through structured tools.

## ⚠️ Security Considerations

**CRITICAL**: This MCP can execute arbitrary Ruby code and access your database. **Never use in production without proper security configuration.**

### Security Requirements
- Always set `safe_mode = true` in production
- Restrict `allowed_models` to only necessary models
- Consider disabling ConsoleExecuteTool entirely in production
- Use in development environments only unless properly secured

## Installation in Rails Application (Development Only)

### 1. Add to Gemfile (Development Group)
```ruby
group :development do
  gem 'rails-active-mcp'
end
```

### 2. Install and Configure
```bash
bundle install
rails generate rails_active_mcp:install
```

### 3. Configure Security Settings

Edit `config/initializers/rails_active_mcp.rb`:

```ruby
RailsActiveMcp.configure do |config|
  # CRITICAL: Enable safe mode
  config.safe_mode = true
  
  # Restrict to specific models only
  config.allowed_models = %w[User Post Comment]  # Adjust for your app
  
  # Optional: Disable dangerous tools
  # config.console_execute_tool_enabled = false
end
```

### 4. Start Rails Server
```bash
rails server
```

The MCP endpoint will be available at: `http://localhost:3000/mcp`

## Available Tools

### 1. SafeQueryTool (Read-Only)
- **Purpose**: Execute safe, read-only database queries
- **Security**: Uses parameterized queries, read-only access
- **Usage**: Query data without risk of data modification

### 2. ConsoleExecuteTool (⚠️ High Risk)
- **Purpose**: Execute arbitrary Ruby code
- **Security**: Uses blocklist-based safety checker
- **Risk**: Can bypass restrictions with creative code
- **Recommendation**: Disable in production

### 3. Model Access
- Access configured models through ActiveRecord
- All queries respect `allowed_models` configuration
- Read operations are safer than write operations

## Claude Code Integration

To use with Claude Code:

1. Ensure your Rails server is running
2. Add the MCP server:
   ```bash
   claude mcp add-json rails-active-mcp http://localhost:3000/mcp
   ```

## Usage Examples

### Querying Data
```
Use SafeQueryTool to find all active users:
- Query: "SELECT * FROM users WHERE active = true"
```

### Model Inspection
```
Use ConsoleExecuteTool to inspect User model:
- Code: "User.column_names"
- Code: "User.count"
```

### Safe Operations
```
Use SafeQueryTool for read-only operations:
- Query: "SELECT COUNT(*) as total FROM posts WHERE created_at > '2024-01-01'"
```

## Configuration Options

| Option | Default | Description |
|--------|---------|-------------|
| `safe_mode` | `false` in dev | Enable stricter security checks |
| `allowed_models` | `[]` (all models) | Restrict to specific models |
| `console_execute_tool_enabled` | `true` | Enable/disable code execution |

## Best Practices

1. **Always use safe_mode = true**
2. **Restrict allowed_models to minimum required**
3. **Monitor logs for suspicious queries**
4. **Use in development environments primarily**
5. **Consider read-only database user for production**
6. **Regular security reviews of configuration**

## Troubleshooting

### Common Issues

**MCP not responding**
- Ensure Rails server is running
- Check `/mcp` endpoint accessibility
- Verify no authentication middleware blocking access

**Access denied errors**
- Check `allowed_models` configuration
- Verify model names match exactly
- Ensure safe_mode settings are appropriate

**Security warnings**
- Review configuration for production readiness
- Consider disabling ConsoleExecuteTool
- Implement proper model restrictions

## Rate Limiting

Rails Active MCP does not implement built-in rate limiting. Consider:
- Rails middleware for rate limiting
- Reverse proxy configuration
- Monitoring and alerting for unusual activity

## Support

For issues and contributions:
- Repository: https://github.com/GoodPie/rails-active-mcp
- Security issues: Report privately to maintainers