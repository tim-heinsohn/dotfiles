# Claude Code Configuration

This is the project CLAUDE.md for the dotfiles repository.
This repository manages dotfiles and configurations using Bombadil for
symlinking.

There is also `claude-code/CLAUDE.md` which (via symlink) serves as the user
CLAUDE.md.

## Workflow Commands
- See @claude-code/docs/workflow/dotfiles-management.md for dotfile operations
  and guidelines

- Please use claude-code/CLAUDE.md for user level claude instructions within this repository.

## Rails Development Commands
**ALWAYS use project-specific binstubs:**
- `bin/rails` instead of `rails`
- `bin/bundle` instead of `bundle`
- `bin/ruby` (wrapper) instead of `ruby`

These commands ensure proper Ruby version and gemset management via RVM.