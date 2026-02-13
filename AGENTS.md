<!-- OPENSPEC:START -->


# Claude Code Configuration

This is the project CLAUDE.md for the dotfiles repository.
This repository manages dotfiles and configurations using Bombadil for
symlinking.

There is also `claude-code/CLAUDE.md` which (via symlink) serves as the user
CLAUDE.md.

## Which AGENTS.md is Authoritative

| Context | File to Read |
|---------|--------------|
| General dotfiles management | Root `AGENTS.md` (this file) |
| OpenSpec change proposals | `openspec/AGENTS.md` |
| User-level Claude instructions | `claude-code/CLAUDE.md` |

The root `AGENTS.md` includes a managed block for OpenSpec. The complete
OpenSpec instructions are in `openspec/AGENTS.md`.

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
- @claude-code/docs/workflow/dotfiles-management.md - Detailed workflow guide

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