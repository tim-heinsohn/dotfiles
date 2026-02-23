# Dotfiles Repository

This repository manages system and development configuration files (dotfiles) using **Bombadil** for symlink management.

## What is Bombadil?

Bombadil is a dotfile manager that:
- Stores your configuration files in this repository
- Creates symlinks from their target locations (~/.config/, ~/.*) to this repo
- Allows centralized version control of all your configurations

## Quick Start

### Viewing Current Configurations

```bash
# List all managed dotfiles
cat bombadil.toml

# Check what a specific config file links to
ls -la ~/.gitconfig
```

### Making Changes

**Critical Rule: Always edit source files in this repository, never the symlink targets.**

```bash
# 1. Edit the source file in this repository
# Example: Edit git configuration
vim git/gitconfig

# 2. Apply changes to symlinks
bombadil link

# Or use the alias
bl
```

## Directory Structure

```
dotfiles/
├── .dots/              # Source files for Bombadil-managed configs
├── bin/                # Utility scripts
├── claude-code/        # Claude Code configuration and agents
├── doc/                # Documentation
│   ├── guides/         # How-to guides
│   ├── architecture/   # Architecture decisions
│   ├── research/       # Research documents
│   └── reviews/        # Code reviews
├── openspec/           # OpenSpec change management
├── utils/              # Additional utilities
├── zsh/                # Zsh configuration
├── nvim/               # Neovim configuration
├── git/                # Git configuration
├── opencode/           # OpenCode configuration
└── bombadil.toml       # Bombadil configuration
```

## Configuration Areas

| Config | Source Location | Target Location |
|--------|-----------------|-----------------|
| Git | `git/gitconfig` | `~/.gitconfig` |
| Zsh | `zsh/zshrc`, `zsh/aliases` | `~/.zshrc`, `~/.zsh/` |
| Neovim | `nvim/` | `~/.config/nvim/` |
| OpenCode | `opencode/` | `~/.config/opencode/` |
| Vim | `vim/vimrc` | `~/.vimrc` |

See `bombadil.toml` for the complete list.

## Scripts

The `bin/` directory contains utility scripts:

- **bl** (bombadil link) - Update symlinks after editing configs
- **packages** - List/manage installed packages
- **disk-overview** - Show disk usage
- **disk-health-setup** - Setup disk health monitoring
- **projects-setup** - Initialize project directories

See `bin/README.md` for details.

## Development Setup

### Rails Development

Always use project-specific binstubs:
- `bin/rails` instead of `rails`
- `bin/bundle` instead of `bundle`

These ensure proper Ruby version management via RVM.

### OpenSpec Workflow

For proposals and changes, use OpenSpec:
- See `openspec/AGENTS.md` for detailed instructions
- Use `openspec list` to see active changes
- Use `openspec validate <change> --strict` to validate proposals

## Documentation

- **doc/guides/dotfiles-management.md** - How to manage dotfiles with Bombadil
- **doc/guides/tmux-i3-workflow.md** - Tmux session profiles and i3 integration
- **doc/guides/browser-window-workspace-recovery.md** - Restore browser windows to remembered i3 workspaces
- **doc/guides/openspec-usage.md** - How to use OpenSpec for changes
- **doc/architecture/overview.md** - Architecture decisions and structure
- **doc/rvm-management.md** - Ruby Version Manager setup
- **doc/sudo.md** - Sudo authentication troubleshooting

## Related Files

- `bombadil.toml` - Defines which files are managed
- `bin/prehooks` - Runs before `bombadil link`
- `bin/posthooks` - Runs after `bombadil link`
- `TODO.md` - Future ideas and improvements backlog
- `FREIGHT.md` - Known issues and workarounds
