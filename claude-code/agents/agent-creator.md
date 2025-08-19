---
name: agent-creator
description: Guide for creating specialized Claude Code agents for specific topics
color: purple
---

# Agent Creator Guide

This agent provides comprehensive instructions for creating specialized Claude Code agents focused on specific topics or domains.

## Agent Structure Overview

Every agent should follow this structure:

```yaml
---
name: [agent-name]
description: [brief description of agent's purpose]
color: [color for visual identification]
---

# [Agent Name]

## Purpose
[Clear statement of what this agent does and when to use it]

## Prerequisites
[List any required tools, APIs, or setup needed]

## Agent Workflow

### 1. Research Phase
[Steps for researching the topic/domain]

### 2. Design Phase
[How to structure the agent's approach]

### 3. Implementation Phase
[Specific instructions for implementing the solution]

### 4. Validation Phase
[How to test and verify the agent's output]

## Common Patterns
[Reusable patterns specific to this topic]

## Best Practices
[Topic-specific best practices and gotchas]

## Examples
[Concrete examples of agent usage]

## Troubleshooting
[Common issues and solutions]
```

## Creating a Topic-Specific Agent

### Step 1: Define the Agent Scope

Before creating an agent, clearly define:
- **Topic Domain**: What specific area does this agent cover?
- **Use Cases**: When should users invoke this agent?
- **Boundaries**: What is explicitly out of scope?

### Step 2: Research the Domain

Use the research phase to:
- Identify key concepts and terminology
- Find relevant tools and APIs
- Understand common workflows
- Discover edge cases and pitfalls

### Step 3: Structure the Agent

Organize instructions into logical sections:
- **Setup**: Required tools and configuration
- **Core Workflow**: Step-by-step process
- **Advanced Features**: Optional enhancements
- **Error Handling**: How to handle failures

### Step 4: Include Practical Examples

Every agent should include:
- **Minimal Example**: Basic usage pattern
- **Real-world Example**: Complex, practical scenario
- **Error Example**: How to handle common failures

## Agent Design Patterns

### Pattern 1: Tool Integration Agents
For agents that integrate with external tools:

```yaml
## Tool Setup
1. Verify tool installation: [specific command]
2. Check authentication: [how to verify]
3. Configure environment: [required variables]

## Core Workflow
1. Initialize tool connection
2. Validate inputs
3. Execute primary operation
4. Handle responses
5. Clean up resources
```

### Pattern 2: Analysis Agents
For agents that analyze code or data:

```yaml
## Analysis Process
1. Identify analysis target
2. Gather relevant context
3. Apply analysis techniques
4. Generate findings report
5. Provide actionable recommendations

## Output Format
- Summary: [brief overview]
- Details: [specific findings]
- Recommendations: [actionable next steps]
```

### Pattern 3: Code Generation Agents
For agents that generate code:

```yaml
## Generation Guidelines
- Follow existing code style
- Use appropriate libraries
- Include error handling
- Add inline documentation
- Provide usage examples

## Validation Steps
1. Check syntax validity
2. Verify imports/references
3. Run basic tests
4. Ensure security best practices
```

## Quality Checklist

Before finalizing an agent, verify:

- [ ] Clear purpose statement
- [ ] Prerequisites are documented
- [ ] Step-by-step instructions are actionable
- [ ] Examples are practical and complete
- [ ] Error scenarios are covered
- [ ] Security considerations are included
- [ ] Performance implications are noted
- [ ] External dependencies are listed

## Agent Testing

Test your agent by:
1. Following your own instructions exactly
2. Testing edge cases mentioned
3. Verifying examples work as described
4. Checking error handling paths
5. Ensuring cleanup steps are complete

## Publishing Guidelines

When adding a new agent:
1. Place in appropriate directory (`claude-code/agents/`)
2. Use descriptive filename (`topic-agent.md`)
3. Follow naming conventions
4. Include cross-references to related agents
5. Update index if applicable

## Example Agent Topics

Common agent categories:
- **Language/Framework**: `python-agent.md`, `react-agent.md`
- **Tool Integration**: `docker-agent.md`, `aws-agent.md`
- **Analysis**: `security-agent.md`, `performance-agent.md`
- **Development**: `testing-agent.md`, `deployment-agent.md`

## Template Generator

To create a new agent from this template:

```bash
# Copy template
cp claude-code/agents/agent-creator.md claude-code/agents/[your-topic]-agent.md

# Edit metadata and content
# Follow the patterns and guidelines above
```

Remember: The best agents are those that save users time by providing clear, actionable guidance for complex tasks.