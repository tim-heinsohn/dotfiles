# Tasks: migrate-vimrc-to-lua

## 1. Analysis
- [ ] 1.1 Review vim/vimrc.minimal and identify Vundle plugins used
- [ ] 1.2 Review vim/vimrc and identify custom settings/functions
- [ ] 1.3 Review vim/vimrc.template - is it used?
- [ ] 1.4 Document all vimrc features that need Lua equivalents

## 2. Migration
- [ ] 2.1 Create Lua equivalents for vimrc settings
- [ ] 2.2 Create Lua equivalents for vimrc functions
- [ ] 2.3 Add missing plugins to nvim/lua/plugins.lua
- [ ] 2.4 Update nvim/lua/keymaps.lua with any vimrc mappings
- [ ] 2.5 Remove `vim.cmd('source ~/.vimrc')` from init.lua

## 3. Cleanup
- [ ] 3.1 Update bin/setup-system to remove Vundle installation
- [ ] 3.2 Remove vundle-install script (or mark as deprecated)
- [ ] 3.3 Decide on vim/vimrc retention (keep as reference or remove)

## 4. Testing
- [ ] 4.1 Test Neovim starts without errors
- [ ] 4.2 Verify all plugins load correctly
- [ ] 4.3 Test custom functions work
- [ ] 4.4 Test key mappings work
- [ ] 4.5 Run :Lazy sync and verify plugins install

## 5. Documentation
- [ ] 5.1 Document migration in doc/ or as comments
- [ ] 5.2 Update AGENTS.md if needed
