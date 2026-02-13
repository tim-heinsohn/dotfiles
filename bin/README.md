# Bin Scripts Overview

This directory contains utility scripts for system management and development.

## Core Scripts

| Script | Description |
|--------|-------------|
| `bl` | Alias for `bombadil link` - updates symlinks |

## Package Management

| Script | Description |
|--------|-------------|
| `packages` | List installed packages |
| `packages-describe` | Show package descriptions |
| `packages-install` | Install packages from list |

## Disk Management

| Script | Description |
|--------|-------------|
| `disk-overview` | Show disk usage overview |
| `disk-health-setup` | Setup disk health monitoring |
| `setup-swapfile` | Configure swapfile |

## Development Setup

| Script | Description |
|--------|-------------|
| `projects-setup` | Initialize project directories |
| `git-cli-setup` | Setup git CLI tools |
| `ruby` | Ruby version wrapper |
| `rvm-gems-cleanup` | Clean up old RVM gems |

## Utilities

| Script | Description |
|--------|-------------|
| `clear-cache` | Clear various caches |
| `fix-display-offset` | Fix display offset issues |
| `fix-pandoc-latex` | Fix pandoc LaTeX issues |
| `setup-system` | System setup utilities |
| `setup-wallpapers` | Setup wallpaper management |
| `toggle-keyboard-layout` | Toggle keyboard layout |

## MCP and AI Tools

| Script | Description |
|--------|-------------|
| `mcp` | MCP server management |
| `codex-mcp` | Codex MCP integration |
| `superclaude-install` | Install SuperClaude |

## Other

| Script | Description |
|--------|-------------|
| `npm-packages` | Manage npm packages |
| `uv-packages` | Manage uv packages |
| `dir2md` | Convert directory to markdown |
| `markdown-to-adf` | Convert markdown to ADF format |
| `nvim-send-files-by-list` | Send files to Neovim by list |
| `nvim-send-files-by-main-diff` | Send files to Neovim by git diff |
| `prehooks` | Pre-link hooks for bombadil |
| `posthooks` | Post-link hooks for bombadil |

## Symlinks

Some scripts in this directory are symlinks to `utils/bin/`:
- `split_a3_to_a4` -> `../utils/bin/split_a3_to_a4`
- `split-a3-to-a4-fzf` -> `../utils/bin/split-a3-to-a4-fzf`
