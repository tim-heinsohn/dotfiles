# n8n MCP Usage

## Critical Workflow Steps
Follow these steps to effectively use the n8n MCP server:

1. **Install and integrate** - Use `~/dotfiles/bin/mcp-install install n8n` and `~/dotfiles/bin/mcp-install integrate n8n`
2. **Query node documentation** - Ask about specific n8n nodes, their parameters, and configurations  
3. **Get workflow guidance** - Request help designing automation workflows with appropriate node combinations
4. **Leverage comprehensive coverage** - Use the 535+ documented nodes and 99% parameter coverage

## Available Features

### Node Documentation Access
- **535+ n8n nodes** - Complete coverage from n8n-nodes-base and @n8n/n8n-nodes-langchain
- **99% parameter coverage** - Detailed schemas and validation rules for node configuration
- **90% official documentation** - Direct access to n8n's official documentation
- **263 AI-capable nodes** - Specialized documentation for AI/ML workflow nodes

### Workflow Design Assistance
- Node selection recommendations based on automation requirements
- Configuration guidance with parameter details and best practices
- Integration patterns for connecting different services and APIs
- Error handling and workflow optimization strategies

### Code Examples and Patterns
- Real-world usage patterns and configurations
- Complex workflow patterns with conditional logic
- Data transformation and processing examples
- Custom expression examples for advanced workflows

## Important Usage Notes

### Coverage Statistics
- **Node properties**: 99% coverage ensures nearly all configuration options are documented
- **Node operations**: 63.6% coverage of available actions and methods
- **AI functionality**: 263 nodes identified with specialized AI/ML capabilities
- **Documentation completeness**: 90% coverage from official n8n sources

### Best Practices
- Start with simple workflows and gradually increase complexity
- Use MCP guidance to select the most appropriate nodes for specific tasks
- Leverage detailed parameter documentation to avoid common configuration errors
- Reference real-world examples for complex integration patterns

### Performance Considerations
- The MCP server maintains a local database of node documentation for fast queries
- Database is automatically rebuilt during installation to ensure up-to-date information
- Use `npm run rebuild` in `~/.n8n-mcp/` to refresh documentation if needed

## Security Considerations

### Local Installation
- MCP server runs locally with no external API dependencies
- Node documentation is cached locally for offline access
- No authentication or API keys required for basic node documentation queries

### Workflow Security
- Follow n8n security best practices for credential management
- Use environment variables for sensitive configuration values
- Implement proper error handling to avoid exposing sensitive data in logs