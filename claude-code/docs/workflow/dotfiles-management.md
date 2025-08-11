# Dotfiles Management

## Overview
- "dotfiles": config files symlinked from actual locations to their sources in this repo
- **`bl` (bombadil link)**: symlinks those files at their target locations
  - for testing changes you MUST run this after editing a dotfile or `bombadil.toml`
  - may run multiple times (idempotent)

## File Editing Guidelines
- Always check bombadil.toml to ensure source files are edited, not the (symlink) target files
- Example: edit Claude agents in ./claude-code/agents/ of this repository instead of ~/.claude/agents
- For maintaining the `packages` list:
  - Use or search the short description for a package to be added and write it into the second line
  - Packages shall be ordered alphabetically and each package be followed by a description line
  - Always end the description with a period (sentence closing)

## Tool Permissions
### Allowed Commands
- `bombadil link` (bl) - for dotfiles management
- Standard git commands
- File operations within this repository