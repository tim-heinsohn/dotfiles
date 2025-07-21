# Claude Code Configuration

## Workflow Commands

### Dotfiles Management
- **`bl` (bombadil link)**: Links dotfiles from this repository to their target locations
  - Run this after making changes to bombadil.toml or adding new dotfiles
  - Safe to run multiple times (idempotent)

## Tool Permissions

### Allowed Commands
- `bombadil link` (bl) - for dotfiles management
- Standard git commands
- File operations within this repository

### Security Restrictions
- Environment variables ending in `_KEY` or `_PASSWORD` should never have their content displayed
- Use `${VAR:+set}` pattern to check if sensitive vars are set without revealing content