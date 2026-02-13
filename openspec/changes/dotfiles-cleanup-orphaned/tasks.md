# Tasks: dotfiles-cleanup-orphaned

## 1. Backup Files
- [ ] 1.1 Delete zsh/environment.bak.20250910133206
- [ ] 1.2 Search for other .bak files and remove

## 2. Vim Configs (verify usage)
- [ ] 2.1 Verify vundle-install still needed (vimrc sourced by nvim)
- [ ] 2.2 Review vim/ configs - identify active vs legacy
- [ ] 2.3 NOTE: See new proposal "migrate-vimrc-to-lua" for Vundle cleanup
- [ ] 2.4 Review codex/mcp.toml - archive or remove
- [ ] 2.5 Review mcp/memory/ - verify usage

## 3. Research/Temp Files
- [ ] 3.1 Review playwright-mcp-*.md files - move to doc/research/ or delete
- [ ] 3.2 Review playwright-qa-optimizer.js - move or delete
- [ ] 3.3 Review test-playwright-optimization.js - move or delete

## 4. Unused Configs
- [ ] 4.1 Verify Gemfile/Gemfile.lock usage - remove if unused
- [ ] 4.2 Review bin/ scripts for orphaned tools
- [ ] 4.3 Review .dots/goodies/ - verify usage
- [ ] 4.4 Check for other orphaned configs

## 5. Verification
- [ ] 5.1 Verify bombadil still works
- [ ] 5.2 Verify all expected symlinks exist
- [ ] 5.3 Document what was removed and why
