# Tasks: migrate-vimrc-to-lua

## 1. Analysis
- [x] 1.1 Review vim/vimrc.minimal and identify Vundle plugins used
- [x] 1.2 Review vim/vimrc and identify custom settings/functions
- [x] 1.3 Review vim/vimrc.template - is it used?
- [x] 1.4 Document all vimrc features that need Lua equivalents

## 2. Migration
- [x] 2.1 Create Lua equivalents for vimrc settings
- [x] 2.2 Create Lua equivalents for vimrc functions
- [x] 2.3 Add missing plugins to nvim/lua/plugins.lua
- [x] 2.4 Update nvim/lua/keymaps.lua with any vimrc mappings
- [x] 2.5 Remove `vim.cmd('source ~/.vimrc')` from init.lua

## 3. Cleanup
- [x] 3.1 Update bin/setup-system to remove Vundle installation
- [x] 3.2 Remove vundle-install script (or mark as deprecated)
- [x] 3.3 Decide on vim/vimrc retention (keep as reference or remove)

## 4. Testing
- [x] 4.1 Test Neovim starts without errors
- [ ] 4.2 Verify all plugins load correctly
- [ ] 4.3 Test custom functions work
- [ ] 4.4 Test key mappings work
- [ ] 4.5 Run :Lazy sync and verify plugins install

## 5. Documentation
- [ ] 5.1 Document migration in doc/ or as comments
- [ ] 5.2 Update AGENTS.md if needed
