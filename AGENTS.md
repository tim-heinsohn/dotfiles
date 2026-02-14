<!-- OPENSPEC:START -->
# OpenSpec Instructions

These instructions are for AI assistants working in this project.

Always open `@/openspec/AGENTS.md` when the request:
- Mentions planning or proposals (words like proposal, spec, change, plan)
- Introduces new capabilities, breaking changes, architecture shifts, or big performance/security work
- Sounds ambiguous and you need the authoritative spec before coding

Use `@/openspec/AGENTS.md` to learn:
- How to create and apply change proposals
- Spec format and conventions
- Project structure and guidelines

Keep this managed block so 'openspec update' can refresh the instructions.

<!-- OPENSPEC:END -->

# Dotfiles Configuration

This repository manages dotfiles and configurations using Bombadil for
symlinking.

## Dotfiles Management with Bombadil

This repository uses **Bombadil** to manage dotfiles via symlinks.

### Critical Rule: Edit Source Files, Not Symlink Targets

**NEVER edit files in `~/.config/` or `~/.*` directly.** These are symlink targets managed by Bombadil.

**ALWAYS edit the source files in this repository:**

| Config Type | Source Location (edit here) | Symlink Target (don't edit) |
|-------------|----------------------------|----------------------------|
| **Git** | `git/gitconfig` | `~/.gitconfig` |
| **Neovim** | `nvim/init.lua`, `nvim/lua/*.lua` | `~/.config/nvim/` |
| **OpenCode** | `opencode/opencode.json` | `~/.config/opencode/opencode.json` |
| **Zsh** | `zsh/zshrc`, `zsh/aliases`, `zsh/functions` | `~/.zshrc`, `~/.zsh/` |
| OpenCode smart-title | `opencode/smart-title.jsonc` | `~/.config/opencode/smart-title.jsonc` |
| Vim | `vim/vimrc` | `~/.vimrc` |
| All other configs | See `bombadil.toml` [settings.dots] | (listed in bombadil.toml) |

**After editing source files**, run `bombadil link` to update symlinks (or let posthooks handle it).

### Verification

Check if a file is managed by Bombadil:
```bash
ls -la ~/.config/opencode/opencode.json
# Should show: ~/.config/opencode/opencode.json -> /home/t/dotfiles/.dots/opencode/opencode.json
```

### See Also
- `bombadil.toml` - Complete list of managed dotfiles
- `bin/prehooks` and `bin/posthooks` - Auto-run on `bombadil link`
- `doc/dotfiles-structure.md` - Directory structure overview
- `doc/bombadil-workflow.md` - Bombadil workflow guide

## Workflow Commands
- See doc/guides/dotfiles-management.md for dotfile operations and guidelines

# Naming Conventions

## Directory Naming
- Use **kebab-case** for directories: `shell-scripts/`, `setup-scripts/` instead of snake_case or camelCase

## File Naming
- Config files: Use consistent extension (e.g., `.conf`, `.config`, `.yml`, `.yaml`, `.toml`)
- Scripts: Use consistent extension (`.sh` for bash, `.zsh` for zsh, or no extension - pick one per use case)
- Document files: Use `.md` extension for Markdown

## Script Naming
- Setup scripts: Use `setup-<service>` or `<service>-setup` pattern
- Use consistent verb prefixes: `setup-`, `install-`, `enable-`, `disable-`
- Prefer hyphenated names: `packages-install` over `packages_install`

## Shell Script Header Template

When creating new shell scripts in `bin/`, use this header template:

```bash
#!/bin/bash
#
# <script-name>: <one-line description>
#
# Usage: <script-name> [options]
#
# Description:
# <multi-line description>
#
# Dependencies:
# - <dependency1>
# - <dependency2>

set -euo pipefail
```

## Documentation Style

- Use Markdown (`.md`) for all documentation
- Use ATX-style headers (`#`, `##`, `###`)
- Maximum line length: 100 characters where practical
- Include heading hierarchy: Title -> H2 sections -> H3 subsections

## Code Style

- Shell: Use `set -euo pipefail` in scripts
- Comments: Use `#` for shell, `--` for Lua
- Prefer explicit over implicit

## Rails Development Commands
**ALWAYS use project-specific binstubs:**
- `bin/rails` instead of `rails`
- `bin/bundle` instead of `bundle`
- `bin/ruby` (wrapper) instead of `ruby`

These commands ensure proper Ruby version and gemset management via RVM.