# Sequential MCP Usage

## Installation & Setup

### 1. Install Sequential MCP Server
```bash
~/dotfiles/sequential-mcp/install
```

### 2. Add to Claude Code
```bash
claude mcp add-json ~/.sequential-mcp/mcp-config.json
```

## Available Features

The Sequential MCP server provides multi-step reasoning and systematic analysis capabilities. It breaks down complex problems into sequential steps, making it easier to solve multi-faceted challenges.

### Core Features
- **Multi-step problem solving**: Break complex problems into manageable steps
- **Systematic analysis**: Structured thinking through sequential reasoning
- **Step-by-step planning**: Create detailed action plans for complex tasks
- **Reasoning transparency**: See the thought process behind solutions

### Available Tools
- **sequential**: Launch a new agent for multi-step problem solving
- **step_breakdown**: Analyze problems into sequential components
- **progress_tracking**: Monitor progress through complex tasks

## Usage Examples

### Basic Problem Solving
```bash
# Solve a complex coding problem
"Use sequential thinking to implement a user authentication system with JWT tokens"

# Plan a project rollout
"Break down the deployment of a new microservice architecture into sequential steps"

# Debug complex issues
"Use systematic analysis to diagnose why my Rails app is slow with large datasets"
```

### Advanced Analysis
```bash
# Multi-step security analysis
"Analyze the security implications of implementing OAuth2 in my application"

# Performance optimization planning
"Create a sequential plan to optimize database queries in my Rails app"

# Architecture decisions
"Walk through the steps to migrate from monolith to microservices"
```

## Workflow Integration

### With Rails Development
```bash
# Optimize Rails performance
"Use sequential thinking to analyze and fix N+1 query issues in my Rails app"

# Database optimization
"Create a step-by-step plan to optimize ActiveRecord queries for large datasets"

# Security auditing
"Systematically review authentication and authorization in my Rails application"
```

### With Code Analysis
```bash
# Complex refactoring
"Break down the refactoring of legacy code into manageable sequential steps"

# Security scanning
"Use systematic analysis to identify and fix security vulnerabilities"

# Performance tuning
"Create a sequential optimization plan for my application"
```

## Configuration Options

The Sequential MCP server supports several configuration options:

- **max_steps**: Maximum number of steps in sequential analysis (default: 10)
- **step_timeout**: Timeout per step in milliseconds (default: 30000)
- **detail_level**: Level of detail in step explanations (low, medium, high)

## Best Practices

### Effective Usage
- **Break down large problems**: Use sequential thinking for complex, multi-faceted issues
- **Document reasoning**: The step-by-step approach provides natural documentation
- **Iterate and refine**: Use sequential analysis results to refine your approach
- **Combine with other tools**: Use alongside other MCP servers for comprehensive solutions

### When to Use
- **Complex debugging**: When simple solutions aren't working
- **Architecture decisions**: For major system changes
- **Performance optimization**: When dealing with multi-layered performance issues
- **Security analysis**: For comprehensive security reviews

### Avoid When
- **Simple tasks**: Overkill for straightforward problems
- **Time-critical**: Sequential analysis takes longer than direct solutions
- **Well-defined issues**: When the problem and solution are already clear

## Integration Examples

### With Jira MCP
```bash
# Plan epic implementation
"Use sequential thinking to break down Jira epic PROJ-123 into implementation steps"

# Sprint planning
"Create sequential tasks for completing the current sprint"
```

### With Rails Active MCP
```bash
# Database optimization
"Use sequential analysis to optimize slow queries identified by Rails Active MCP"

# Performance debugging
"Systematically analyze performance metrics from Rails Active MCP"
```

## Important Notes

- **No authentication required**: The Sequential MCP server works out of the box
- **Local processing**: All analysis happens locally on your machine
- **Resource usage**: Sequential analysis may use more computational resources
- **Integration**: Works seamlessly with other MCP servers in your workflow

### Updates and Maintenance

**⚠️ IMPORTANT**: Always use the official update methods:

```bash
# Update Sequential MCP specifically
~/dotfiles/bin/mcp update sequential

# Update all installed MCPs
~/dotfiles/bin/mcp update

# Or update manually
~/dotfiles/sequential-mcp/install
```

## Troubleshooting

### Connection Issues
```bash
# Test MCP connection
claude mcp list
claude mcp test sequential
```

### Performance Issues
- Reduce max_steps configuration for faster responses
- Adjust step_timeout for your system capabilities
- Monitor resource usage during complex analyses

### Integration Problems
- Ensure Sequential MCP is properly added to Claude Code configuration
- Check that the server is running: `cd ~/.sequential-mcp && npm start`
- Verify Node.js version compatibility (requires Node.js 18+)