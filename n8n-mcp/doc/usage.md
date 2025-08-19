# n8n MCP Usage

## Installation & Setup

### 1. Install n8n MCP Server
```bash
~/dotfiles/n8n-mcp/install
```

### 2. Add to Claude Code
```bash
~/dotfiles/bin/mcp-install integrate n8n
```

## Available Features

### n8n Node Documentation
- **Comprehensive node library**: Access to 535+ n8n nodes from n8n-nodes-base and @n8n/n8n-nodes-langchain
- **Node properties**: 99% coverage with detailed parameter schemas and validation rules
- **Node operations**: 63.6% coverage of available actions and methods
- **AI-specific nodes**: 263 AI-capable nodes with specialized documentation

### Workflow Design Assistance  
- **Node selection**: Get recommendations for the right nodes for your automation tasks
- **Configuration guidance**: Detailed help with node parameters and settings
- **Best practices**: Learn optimal workflow patterns and configurations
- **Troubleshooting**: Debug common configuration issues

### Documentation Access
- **Official docs**: 90% coverage from official n8n documentation
- **Code examples**: Real-world usage patterns and configurations
- **Integration guides**: Connect with various services and APIs
- **Advanced features**: Complex workflow patterns and custom expressions

## Usage Examples

### Node Discovery and Selection
```bash
# Find nodes for specific tasks
"What n8n nodes can I use to send Slack messages?"

# Get detailed node documentation
"Show me all the parameters for the HTTP Request node in n8n"

# Find AI-related nodes
"What AI nodes are available in n8n for language processing?"
```

### Workflow Design Help
```bash
# Design workflow patterns
"Help me design an n8n workflow that monitors RSS feeds and posts new articles to Discord"

# Node configuration assistance
"How do I configure the Gmail node in n8n to send emails with attachments?"

# Complex automation guidance
"Create an n8n workflow that processes CSV files from Google Drive, validates data, and updates a database"
```

### Troubleshooting and Optimization
```bash
# Debug workflow issues
"Why might my n8n HTTP Request node be returning a 401 error?"

# Performance optimization
"How can I optimize my n8n workflow that processes large datasets?"

# Error handling patterns
"What's the best way to handle errors in n8n workflows?"
```

## Important Notes

### Coverage and Limitations
- **Node properties**: 99% coverage - nearly all node parameters documented
- **Node operations**: 63.6% coverage - most common operations available
- **Documentation**: 90% coverage from official sources
- **AI capabilities**: 263 nodes identified with AI/ML functionality

### Best Practices
- **Workflow design**: Start with simple workflows and gradually add complexity
- **Node selection**: Use the MCP to find the most appropriate nodes for your tasks
- **Configuration**: Leverage detailed parameter documentation to avoid common mistakes
- **Testing**: Use the MCP guidance to set up proper workflow testing

### Updates and Maintenance

**⚠️ IMPORTANT**: Always use the official update methods:

```bash
# Update n8n MCP specifically  
~/dotfiles/bin/mcp-install update n8n

# Update all installed MCPs
~/dotfiles/bin/mcp-install update

# Or update manually
~/dotfiles/n8n-mcp/install
```

## Advanced Usage

### Custom Node Development
- Get guidance on creating custom n8n nodes
- Understanding node structure and best practices
- API integration patterns and examples

### Complex Workflow Patterns
- Multi-step automation workflows
- Conditional logic and branching
- Data transformation and processing
- Error handling and retry strategies

## Troubleshooting

### MCP Server Issues
```bash
# Test MCP connection
claude mcp list
claude mcp test n8n
```

### Database Rebuild
```bash
# If node documentation seems outdated
cd ~/.n8n-mcp
npm run rebuild
```

### Installation Issues
```bash
# Clean reinstall
rm -rf ~/.n8n-mcp
~/dotfiles/n8n-mcp/install
```