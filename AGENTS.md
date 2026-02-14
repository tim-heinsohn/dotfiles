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

## Rails Development Commands
**ALWAYS use project-specific binstubs:**
- `bin/rails` instead of `rails`
- `bin/bundle` instead of `bundle`
- `bin/ruby` (wrapper) instead of `ruby`

These commands ensure proper Ruby version and gemset management via RVM.