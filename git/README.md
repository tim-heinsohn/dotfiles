# Git Configuration

Git configuration files and templates.

## Files

| File | Target | Description |
|------|--------|-------------|
| `gitconfig` | `~/.gitconfig` | Main Git configuration |
| `gitignore` | `~/.gitignore` | Global Git ignore patterns |
| `gitattributes` | `.gitattributes` | Git attributes |
| `tigrc` | `~/.tigrc` | Tig (ncurses Git viewer) configuration |

## gitconfig Features

- Custom aliases (ci, co, cof, rb, etc.)
- Delta pager integration
- Neovim as default editor
- Gopass credential helper
- RSpec diff highlighting
- Custom merge/rebase settings

## Key Aliases

```bash
git ci     # commit
git co     # checkout
git cof    # checkout branch via fzf
git rb     # switch to recent branch
git rv     # remote -v
git fa     # fetch --all
git tu     # show untracked files as tree
git main-delta  # show delta from main branch
```

## Usage

Edit `git/gitconfig` directly - never edit `~/.gitconfig` directly as it's managed by Bombadil.
