# Dotfiles Repository

Personal dotfiles and configuration management repository using [Bombadil](https://oknozor.github.io/toml-bombadil/) for symlink management.

## Overview

This repository contains configuration files for:
- **Shell**: Zsh, Bash
- **Editor**: Neovim, Vim
- **Tools**: Git, GPG, GoPass, various CLI utilities
- **Desktop**: i3, Rofi, Alacritty/Wezterm
- **Development**: Ruby/Rails, Node.js, various MCPs

## Quick Start

### Prerequisites

- [Bombadil](https://oknozor.github.io/toml-bombadil/) installed
- Zsh (primary shell)
- Neovim or Vim
- Git

### Setup

```bash
# Clone the repository
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Link all dotfiles
bombadil link

# Verify symlinks
ls -la ~/
```

## Directory Structure

| Directory | Purpose |
|-----------|---------|
| `bin/` | Executable scripts and utilities |
| `git/` | Git configuration (gitconfig, gitignore, etc.) |
| `nvim/` | Neovim configuration (Lua-based) |
| `zsh/` | Zsh configuration (zshrc, aliases, functions) |
| `shell/` | Bash and POSIX shell configs |
| `opencode/` | OpenCode/Cline AI assistant config |
| `vim/` | Vim configuration |
| `docker/` | Docker and container configs |
| `services/` | Service configurations (Traefik, Caddy, etc.) |
| `doc/` | Documentation and guides |
| `utils/` | Utility scripts and tools |

## Common Tasks

### Adding a New Dotfile

1. Add the file to this repository in the appropriate directory
2. Edit `bombadil.toml` to add a new `[settings.dots]` entry:
   ```toml
   myconfig = { source = "path/to/config", target = "~/.config/myconfig" }
   ```
3. Run `bombadil link` to create the symlink

### Modifying an Existing Config

**Always edit the source file in this repository, never the symlink target:**

```bash
# Correct: Edit the source
nvim ~/dotfiles/zsh/zshrc

# Wrong: Edit the symlink target
nvim ~/.zshrc  # This will cause issues!
```

### Running Scripts

Many utility scripts are in `bin/`. Most support `--help`:

```bash
~/dotfiles/bin/setup-system --help
~/dotfiles/bin/packages --help
```

## Configuration Files

All managed configurations are defined in `bombadil.toml`. Each entry maps a source file in this repository to its target location in the home directory.

## Documentation

- [Getting Started Guide](doc/guides/getting-started.md)
- [Common Workflows](doc/guides/workflows.md)
- [Troubleshooting](doc/guides/troubleshooting.md)
- [AGENTS.md](AGENTS.md) - AI assistant instructions

## Scripts

Key scripts in `bin/`:

| Script | Purpose |
|--------|---------|
| `setup-system` | Initial system setup |
| `packages` | Package management |
| `prehooks` | Pre-link setup (runs before bombadil link) |
| `posthooks` | Post-link setup (runs after bombadil link) |
| `projects-setup` | Project directory setup |
| `disk-health-setup` | Disk health monitoring setup |

## Troubleshooting

See [Troubleshooting Guide](doc/guides/troubleshooting.md) for common issues:

- Symlink problems
- Permission issues
- Missing dependencies
- Rollback procedures

## License

Personal configuration files. Use at your own risk.
