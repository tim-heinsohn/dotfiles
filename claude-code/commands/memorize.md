# /memorize

When the user types `/memorize [topic]`, scan this entire conversation thread for:

1. **User guidance** - instructions, preferences, "always/never" statements
2. **Claude discoveries** - insights, patterns, better approaches found during the session
3. **Project conventions** - standards, naming, structure decisions made
4. **Tool preferences** - specific ways to use tools, error handling patterns

## Response format

```
🔍 Found [N] items to memorize:

## 🏠 User-Level Guidance
**Location:** ~/dotfiles/claude-code/CLAUDE.md

### [Topic 1]
- [Exact guidance statement]
- [Another relevant point]

### [Topic 2]
- [Specific instruction]

## 📁 Project-Level Guidance  
**Location:** [current_project]/CLAUDE.md or .claude/doc/*.md

### [Topic 1]
- [Project-specific guidance]

### [Topic 2]
- [Another project-specific point]

## 📝 Ready to add:

### User-Level:
```markdown
## [Section]
[Formatted guidance for ~/dotfiles/claude-code/CLAUDE.md]
```

### Project-Level:
```markdown
## [Section]  
[Formatted guidance for current project]
```
```

## Level determination rules
- **User-level**: dotfiles, global tools, workflow patterns, editor configs
- **Project-level**: repo structure, project-specific commands, domain conventions
- **Ambiguous**: Default to user-level, mark as "review for project specificity"

## Examples

**User:** `/memorize`
**Claude:** Analyzes all guidance, groups by level and topic

**User:** `/memorize security`
**Claude:** Focuses on security patterns, separates user vs project security practices

**User:** `/memorize workflow`
**Claude:** Captures workflow guidance, distinguishing global vs project-specific workflows
```