# Proposal: migrate-vimrc-to-lua

## Why

The current Neovim configuration has a legacy dependency on Vim's Vundle plugin manager:
- Neovim sources `~/.vimrc` (legacy Vim config) at startup
- Legacy `.vimrc` uses Vundle for plugin management
- This creates unnecessary complexity: two plugin managers (Vundle for vim, lazy for nvim)
- Plain Lua is the recommended approach for Neovim configuration

Migrating to pure Lua will simplify the configuration and remove the legacy dependency.

## What Changes

### 1. Analyze Current vimrc Usage

1. **Identify what's in vimrc that's used**
   - Review `vim/vimrc`, `vim/vimrc.minimal`, `vim/vimrc.template`
   - Determine which features/plugins are actually used
   - Document any custom functions or settings needed

2. **Identify Vundle plugins**
   - List all plugins in `vim/vimrc.minimal`
   - Find Lua equivalents or Neovim-native alternatives

### 2. Migrate Configuration to Lua

3. **Create Lua equivalents for vimrc features**
   - Convert vimscript settings to Lua
   - Convert custom functions to Lua
   - Add to existing `nvim/lua/` directory

4. **Consolidate plugin management**
   - Use only `lazy.nvim` (already configured in nvim/init.lua)
   - Add any missing plugins from vimrc to `nvim/lua/plugins.lua`

5. **Remove vimrc source**
   - Remove `vim.cmd('source ~/.vimrc')` from `nvim/init.lua`
   - Keep `vim/vimrc` as reference but don't source it

### 3. Cleanup

6. **Remove or archive legacy files**
   - Keep `vim/vimrc` for reference during migration
   - Can be removed after successful migration
   - Remove `vundle-install` script after migration
   - Update `bin/setup-system` to remove Vundle installation

### 4. Testing

7. **Verify Neovim works correctly**
   - Test all previously-used vimrc features work in Lua
   - Verify plugins load correctly
   - Test key mappings and custom functions

## Breaking Changes

- **Removed**: `vim.cmd('source ~/.vimrc')` - legacy vimrc no longer sourced
- **Removed**: Vundle plugin manager dependency
- **Migration**: Users will need to run `:Lazy sync` after update to get new plugins

## Impact

- Affected files: `nvim/init.lua`, `vim/vimrc`, `vim/vimrc.minimal`, `vim/vimrc.template`, `bin/setup-system`
- Neovim-only change - doesn't affect legacy Vim usage

## Open Questions

1. Should we keep `vim/vimrc` as documentation or remove it entirely after migration?
2. Are there any specific vimrc features that are difficult to migrate to Lua?
3. Should we also migrate the user to use Neovim exclusively (vs Vim)?
