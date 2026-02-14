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

# Dotfiles Repository

This is the **project CLAUDE.md** for the dotfiles repository. It manages personal
dotfiles and configurations using **Bombadil** for symlink management.

There is also `claude-code/CLAUDE.md` which (via symlink) serves as the user-level
CLAUDE.md.

---

## Quick Reference

### Critical Rules

| Rule | Description |
|------|-------------|
| **NEVER** edit symlink targets | Always edit source files in this repository |
| **ALWAYS** run `bombadil link` | After modifying config files |
| **USE** bin/ scripts with `--help` | Most scripts support `--help` |

### Common Tasks

```bash
# Add a new dotfile
# 1. Create file in appropriate directory
# 2. Add entry to bombadil.toml
# 3. Run: bombadil link

# Modify existing config
nvim ~/dotfiles/zsh/zshrc   # Edit source, not ~/.zshrc
bombadil link               # Relink after changes

# Verify health
~/dotfiles/bin/dotfiles-health

# Get help on scripts
~/dotfiles/bin/setup-system --help
~/dotfiles/bin/packages --help
```

### Directory Purpose

| Directory | Purpose |
|-----------|---------|
| `bin/` | Executable scripts (use `--help`) |
| `zsh/` | Zsh configuration |
| `git/` | Git configuration |
| `nvim/` | Neovim Lua configuration |
| `vim/` | Vim configuration |
| `opencode/` | OpenCode/Claude Code config |
| `shell/` | Bash and POSIX shell configs |
| `services/` | Service configs (Traefik, Caddy, etc.) |
| `doc/guides/` | Getting started and troubleshooting |

### Bombadil Configuration

All managed dotfiles are defined in `bombadil.toml`:

```toml
[settings.dots]
# Format: name = { source = "path", target = "~/target" }
nvim_init_lua = { source = "nvim/init.lua", target = ".config/nvim/init.lua" }
```

### Key Scripts

| Script | Purpose |
|--------|---------|
| `bin/setup-system` | Initial system setup (--help available) |
| `bin/packages-install` | Install packages from bin/packages |
| `bin/dotfiles-health` | Verify symlinks and config |
| `bin/prehooks` | Pre-link setup (runs before bombadil link) |
| `bin/posthooks` | Post-link setup (runs after bombadil link) |

---

## Dotfiles Management

### Edit Source, Not Target

**ALWAYS edit source files in this repository:**

| Config | Edit This | Not This |
|--------|-----------|----------|
| Git | `git/gitconfig` | `~/.gitconfig` |
| Zsh | `zsh/zshrc` | `~/.zshrc` |
| Neovim | `nvim/init.lua` | `~/.config/nvim/init.lua` |

### Verification

Check if a file is managed by Bombadil:
```bash
ls -la ~/.config/nvim/init.lua
# Should show: -> /home/t/dotfiles/nvim/init.lua
```

### After Editing

After modifying any config file:
```bash
bombadil link
```

---

## Documentation

- [Getting Started](doc/guides/getting-started.md)
- [Common Workflows](doc/guides/workflows.md)
- [Troubleshooting](doc/guides/troubleshooting.md)
- [Navigation Index](doc/navigation.md)

---

## Rails Development

**ALWAYS use project-specific binstubs:**
- `bin/rails` instead of `rails`
- `bin/bundle` instead of `bundle`
- `bin/ruby` (wrapper) instead of `ruby`

These commands ensure proper Ruby version and gemset management via RVM.
