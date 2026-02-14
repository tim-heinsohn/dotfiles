# Project Context

## Purpose
This is a dotfiles repository managed by Bombadil for symlinking configurations.

## Implementation Order

When implementing multiple OpenSpec changes in parallel (via worktrees):

1. **Define merge order upfront** - Document dependencies in the proposal or a separate IMPLEMENTATION_ORDER.md
2. **Reuse main branch** - Keep all worktrees rebased on origin/main or the branch you're merging into
3. **Merge sequentially** - Don't parallel merge to target branch; merge worktrees one-by-one in dependency order
4. **Alternative: Single worktree** - Use one worktree and spawn sub-agents as Tasks (they serialize automatically)

Example order for this repo:
1. structure-reorganization (no deps)
2. cleanup-orphaned, documentation-consolidation, security-audit (on top of structure)
3. consistency-standards, usability-improvements (on top of above)
4. migrate-vimrc-to-lua (last - depends on structure)

## Tech Stack
- [List your primary technologies]
- [e.g., TypeScript, React, Node.js]

## Project Conventions

### Code Style
[Describe your code style preferences, formatting rules, and naming conventions]

### Architecture Patterns
[Document your architectural decisions and patterns]

### Testing Strategy
[Explain your testing approach and requirements]

### Git Workflow
[Describe your branching strategy and commit conventions]

## Domain Context
[Add domain-specific knowledge that AI assistants need to understand]

## Important Constraints
[List any technical, business, or regulatory constraints]

## External Dependencies
[Document key external services, APIs, or systems]
