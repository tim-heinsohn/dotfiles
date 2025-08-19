# /commandize

When the user types `/commandize [topic]`, scan this entire conversation thread for reusable Claude slash commands and prompts that should be extracted as permanent commands.

## Analysis targets
- **User commands** - reusable prompts for tools, workflows, patterns
- **Project commands** - domain-specific queries and automations  
- **Session discoveries** - effective prompt patterns discovered
- **Tool integrations** - specific MCP/tool usage patterns

## Response format

```
🔍 Found [N] commands to extract:

## 🏠 User-Level Commands
**Location:** ~/dotfiles/claude-code/commands/

### /[command-name]
**Purpose:** [One-line description]
**Prompt:** [Full reusable prompt template]
**Usage:** /[command-name] [optional params]

### /[another-command]
**Purpose:** [One-line description]  
**Prompt:** [Full reusable prompt template]
**Usage:** /[command-name] [optional params]

## 📁 Project-Level Commands
**Location:** [current_project]/.claude/commands/

### /[project-command]
**Purpose:** [Project-specific purpose]
**Prompt:** [Project-specific prompt template]
**Usage:** /[project-command] [optional params]

## 📝 Ready to add:

### User-Level:
```markdown
# /[command-name]
[Purpose description]

## Usage
/[command-name] [parameters]

## Prompt template
[Full reusable Claude prompt]
```

### Project-Level:
```markdown
# /[project-command]
[Project-specific description]

## Usage  
/[project-command] [parameters]

## Prompt template
[Project-specific Claude prompt]
```
```

## Level determination rules
- **User-level**: Cross-project utilities, tool usage patterns, workflow automation
- **Project-level**: Domain-specific queries, project structure commands, tech stack patterns
- **Command patterns**: Look for repeated prompt structures, successful one-liners, complex multi-step queries

## Examples

**User:** `/commandize`
**Claude:** Analyzes all session prompts for reusable commands

**User:** `/commandize security`
**Claude:** Focuses on security scanning and analysis commands

**User:** `/commandize workflow`
**Claude:** Extracts workflow automation and process commands

## Command discovery patterns
- **Single-purpose queries** that worked well
- **Parameterized prompts** with placeholders
- **Multi-step automations** that could be one command
- **Tool-specific patterns** for MCP integrations
- **Project conventions** worth codifying