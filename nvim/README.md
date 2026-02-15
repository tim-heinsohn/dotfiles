# Neovim Configuration

Lua-based Neovim configuration.

## Files

| File | Target | Description |
|------|--------|-------------|
| `init.lua` | `~/.config/nvim/init.lua` | Main entry point |
| `lua/plugins.lua` | `~/.config/nvim/lua/plugins.lua` | Plugin management |
| `lua/keymaps.lua` | `~/.config/nvim/lua/keymaps.lua` | Key mappings |
| `lua/functions.lua` | `~/.config/nvim/lua/functions.lua` | Custom functions |
| `lua/lsp_setup.lua` | `~/.config/nvim/lua/lsp_setup.lua` | LSP configuration |

## Structure

- Modular Lua configuration
- Plugin management via plugin manager (typically packer or lazy)
- LSP client configuration
- Custom key mappings
- Utility functions

## Dependencies

- Neovim (latest stable recommended)
- Git (for plugin updates)
- Optional: LSP servers, language tools

## Usage

Edit files in this directory directly - never edit `~/.config/nvim/` directly as it's managed by Bombadil.

## Troubleshooting

- Check `~/.config/nvim/` is a symlink: `ls -la ~/.config/nvim`
- Run Neovim with debug: `nvim --log-level=debug`
- Check plugin errors: `:Lazy` (if using lazy.nvim)
