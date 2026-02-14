# Zsh Configuration

Zsh shell configuration with Oh My Zsh and customizations.

## Files

| File | Target | Description |
|------|--------|-------------|
| `zshrc` | `~/.zshrc` | Main Zsh configuration |
| `aliases` | `~/.zsh/aliases` | Shell aliases |
| `functions` | `~/.zsh/functions` | Shell functions |
| `environment` | `~/.zsh/environment` | Environment variables |
| `plugins.toml` | `~/.config/sheldon/plugins.toml` | Sheldon plugin config |
| `p10k.zsh` | `~/.p10k.zsh` | Powerlevel10k theme |
| `p10k.custom.zsh` | `~/.zsh/p10k.custom.zsh` | Custom Powerlevel10k config |

## Features

- Oh My Zsh integration
- Powerlevel10k prompt theme
- Custom aliases (defined in `aliases`)
- Shell functions (defined in `functions`)
- Plugin management via Sheldon
- Fuzzy finder integration (fzf)

## Key Aliases

See `zsh/aliases` for the complete list. Common categories:
- Git aliases
- Navigation shortcuts
- File operations
- System commands

## Usage

Edit files in this directory directly - never edit `~/.zshrc` or `~/.zsh/` directly as they're managed by Bombadil.

## Powerlevel10k

The prompt is configured via `p10k.zsh`. To customize:
1. Run `p10k configure` or edit `zsh/p10k.custom.zsh`
2. Changes to `p10k.zsh` are synced manually (not via bombadil)

## Troubleshooting

- Check symlinks: `ls -la ~/.zshrc`
- Reload config: `source ~/.zshrc`
- Check for syntax errors: `zsh -n ~/.zshrc`
