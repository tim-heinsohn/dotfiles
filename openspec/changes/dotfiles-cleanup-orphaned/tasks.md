# Tasks: dotfiles-cleanup-orphaned

## 1. Backup Files
- [x] 1.1 Delete zsh/environment.bak.20250910133206
- [x] 1.2 Search for other .bak files and remove

## 2. Vim Configs (verify usage)
- [x] 2.1 Verify vundle-install still needed (vimrc sourced by nvim)
- [x] 2.2 Review vim/ configs - identify active vs legacy
- [x] 2.3 NOTE: See new proposal "migrate-vimrc-to-lua" for Vundle cleanup
- [x] 2.4 Review codex/mcp.toml - archive or remove (not present in worktree)
- [x] 2.5 Review mcp/memory/ - verify usage (kept - for Goose MCP)

## 3. Research/Temp Files
- [x] 3.1 Review playwright-mcp-*.md files - move to doc/research/ or delete (moved)
- [x] 3.2 Review playwright-qa-optimizer.js - move or delete (moved)
- [x] 3.3 Review test-playwright-optimization.js - move or delete (moved)

## 4. Unused Configs
- [x] 4.1 Verify Gemfile/Gemfile.lock usage - kept, used by termux/serve for webrick
- [x] 4.2 Review bin/ scripts for orphaned tools (kept - gopass is installed)
- [x] 4.3 Review .dots/goodies/ - verify usage (not present)
- [x] 4.4 Check for other orphaned configs (none found)

## 5. Verification
- [x] 5.1 Verify bombadil still works
- [ ] 5.2 Verify all expected symlinks exist
- [ ] 5.3 Document what was removed and why
