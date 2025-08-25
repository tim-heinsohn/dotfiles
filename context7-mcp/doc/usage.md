# Context7 MCP Server Usage

## Overview
Context7 is an MCP server that provides intelligent context management for Claude Code, allowing you to retrieve and manage documentation, code examples, and technical context from various sources.

## Features
- **Documentation Retrieval**: Fetch up-to-date documentation for libraries and frameworks
- **Code Examples**: Get relevant code examples based on your current context
- **Version Awareness**: Automatically handles version-specific documentation
- **Multi-language Support**: Supports various programming languages and frameworks

## Available Tools

### get_context
Retrieves contextual information and documentation for a given topic.

**Parameters:**
- `query` (string): The topic or library to get context for
- `language` (string, optional): Programming language (e.g., "python", "javascript")
- `version` (string, optional): Specific version of the library/framework

**Example:**
```json
{
  "query": "react hooks",
  "language": "javascript",
  "version": "18.0.0"
}
```

### search_examples
Searches for relevant code examples.

**Parameters:**
- `query` (string): The topic to search examples for
- `language` (string, optional): Programming language
- `limit` (number, optional): Maximum number of examples to return (default: 5)

**Example:**
```json
{
  "query": "python async await",
  "language": "python",
  "limit": 3
}
```

### get_latest_version
Gets the latest stable version of a library or framework.

**Parameters:**
- `package_name` (string): Name of the package/library
- `registry` (string, optional): Package registry (npm, pypi, etc.)

**Example:**
```json
{
  "package_name": "react",
  "registry": "npm"
}
```

## Usage Examples

### Getting React Documentation
```bash
claude mcp call context7 get_context '{"query": "react useState hook", "language": "javascript"}'
```

### Searching Python Examples
```bash
claude mcp call context7 search_examples '{"query": "pandas dataframe merge", "language": "python", "limit": 5}'
```

### Checking Latest Package Version
```bash
claude mcp call context7 get_latest_version '{"package_name": "fastapi", "registry": "pypi"}'
```

## Configuration
The Context7 MCP server is configured via the mcp-config.json file created during installation:

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
Context7 implements intelligent caching to minimize API calls. However:
- Cache TTL: 1 hour for documentation, 30 minutes for examples
- Exponential backoff on rate limit errors (1s, 2s, 4s, 8s)
- Maximum retry attempts: 3

## Best Practices
1. **Be Specific**: Include language and version when possible for accurate results
2. **Use Keywords**: Focus on specific function names or concepts
3. **Check Versions**: Use get_latest_version to ensure you're referencing current documentation
4. **Cache Awareness**: Recent queries are cached for faster responses

## Troubleshooting

### Server Not Starting
1. Check if Node.js is installed: `node --version`
2. Verify the installation: `ls ~/.context7-mcp/`
3. Check logs: Look for error messages in the Claude Code output

### No Results Returned
1. Ensure the query is specific enough
2. Check if the library/framework is supported
3. Verify the language parameter is correct

### Authentication Issues
Context7 typically doesn't require authentication for basic usage. If authentication is needed, check the repository README for specific setup instructions.