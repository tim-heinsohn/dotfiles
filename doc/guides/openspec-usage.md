# OpenSpec Usage Guide

## What is OpenSpec?

OpenSpec is a spec-driven development workflow used in this repository to manage changes through proposals rather than direct modifications.

## When to Use OpenSpec

Create a proposal when:
- Adding new features or capabilities
- Making breaking changes
- Changing architecture or patterns
- Significant performance or security work

Skip proposals for:
- Bug fixes (restoring intended behavior)
- Typos, formatting, comments
- Dependency updates (non-breaking)
- Configuration changes

## Basic Workflow

### 1. Explore Current State
```bash
openspec list                    # List active changes
openspec list --specs            # List existing specifications
```

### 2. Create a Proposal
```bash
# Choose a unique change-id (kebab-case, verb-led)
CHANGE=add-new-feature

# Scaffold the proposal
mkdir -p openspec/changes/$CHANGE
```

Create `proposal.md`:
```
[Problemmarkdown
## Why or opportunity being addressed]

## What Changes
- [List of changes]

## Impact
- Affected files: [list]
```

Create `tasks.md`:
```markdown
## 1. Implementation
- [ ] 1.1 Task description
```

### 3. Validate
```bash
openspec validate $CHANGE --strict
```

### 4. Get Approval
Do not start implementation until the proposal is reviewed and approved.

### 5. Implement and Archive
After implementation, the change will be archived to `openspec/changes/archive/`.

## Key Files

- `openspec/project.md` - Project conventions
- `openspec/AGENTS.md` - Detailed AI instructions
- `openspec/specs/` - Current specifications (what IS built)
- `openspec/changes/` - Active proposals (what SHOULD change)

## Related Documentation

- See `openspec/AGENTS.md` for complete instructions
- See `openspec/project.md` for project conventions
