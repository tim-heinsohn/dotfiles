# Context7 MCP Integration

## Overview
Context7 provides intelligent context management for Claude Code by retrieving up-to-date documentation, code examples, and technical context from various sources. This includes library documentation, API references, and version-specific information.

## Setup
```bash
# Install Context7 MCP
mcp install context7

# Add to Claude Code
mcp integrate context7
```

## Available Tools

### get_context
Retrieve contextual information and documentation for a given topic.

**Parameters:**
- `query` (string): The topic or library to get context for
- `language` (string, optional): Programming language (e.g., "python", "javascript")
- `version` (string, optional): Specific version of the library/framework

**Example:**
```bash
claude mcp call context7 get_context '{"query": "react useState hook", "language": "javascript"}'
```

### search_examples
Search for relevant code examples.

**Parameters:**
- `query` (string): The topic to search examples for
- `language` (string, optional): Programming language
- `limit` (number, optional): Maximum number of examples (default: 5)

**Example:**
```bash
claude mcp call context7 search_examples '{"query": "python async await", "language": "python", "limit": 3}'
```

### get_latest_version
Get the latest stable version of a library or framework.

**Parameters:**
- `package_name` (string): Name of the package/library
- `registry` (string, optional): Package registry (npm, pypi, etc.)

**Example:**
```bash
claude mcp call context7 get_latest_version '{"package_name": "fastapi", "registry": "pypi"}'
```

## Usage Patterns

### Documentation Lookup
Use for getting accurate, version-specific documentation:
```bash
# Get FastAPI documentation
claude mcp call context7 get_context '{"query": "fastapi dependency injection", "language": "python"}'

# Get React latest practices
claude mcp call context7 get_context '{"query": "react server components", "language": "javascript", "version": "18.0.0"}'
```

### Example Discovery
Find relevant code examples quickly:
```bash
# Python examples for async patterns
claude mcp call context7 search_examples '{"query": "asyncio gather", "language": "python", "limit": 5}'

# JavaScript examples for error handling
claude mcp call context7 search_examples '{"query": "javascript try catch finally", "language": "javascript"}'
```

### Version Management
Ensure you're working with current versions:
```bash
# Check latest versions
claude mcp call context7 get_latest_version '{"package_name": "nextjs", "registry": "npm"}'
claude mcp call context7 get_latest_version '{"package_name": "django", "registry": "pypi"}'
```

## Integration with Claude Code

### In Conversations
Context7 enhances Claude's ability to provide accurate technical guidance by:
- Retrieving current documentation for libraries
- Providing version-specific examples
- Ensuring recommendations align with latest best practices

### Best Practices
1. **Be Specific**: Include language and version when possible
2. **Use Keywords**: Focus on function names or specific concepts
3. **Check Versions**: Use `get_latest_version` before implementing solutions
4. **Combine Tools**: Use `get_context` + `search_examples` for comprehensive understanding

## Configuration
The MCP server is configured via `$HOME/.context7-mcp/mcp-config.json`:

```json
{
  "mcpServers": {
    "context7": {
      "command": "node",
      "args": ["~/.context7-mcp/dist/index.js"],
      "env": {}
    }
  }
}
```

## Rate Limiting
- **Cache TTL**: 1 hour for documentation, 30 minutes for examples
- **Backoff**: Exponential backoff on rate limit errors (1s, 2s, 4s, 8s)
- **Retries**: Maximum 3 retry attempts

## Troubleshooting

### Server Not Starting
1. Verify Node.js installation: `node --version`
2. Check installation: `ls ~/.context7-mcp/`
3. Review logs: Check Claude Code output for error messages

### No Results
1. Ensure query specificity
2. Check language parameter
3. Verify library/framework support

### Performance Issues
Context7 uses intelligent caching. Recent queries are served from cache for faster responses.