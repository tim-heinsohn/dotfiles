# Proposal: dotfiles-cleanup-orphaned

## Why

The repository contains files and scripts that are no longer actively used:
- Backup files from previous edits
- Deprecated tool configurations (Vim plugin manager, old MCP configs)
- Research/temporary files left behind from investigations
- Scripts for tools that may no longer be installed

This bloats the repository and creates confusion about what's actually in use.

## What Changes

### Remove Backup Files

1. **Remove backup file**
   - Delete `zsh/environment.bak.20250910133206`

2. **Review and remove any other .bak files**
   - Search for `*.bak`, `*.backup`, `*.old` files

### Remove Deprecated Tool Configs

3. **Vim-related cleanup**
   - `vundle-install` - STILL IN USE (vimrc is sourced by neovim via `vim.cmd('source ~/.vimrc')`)
   - Review `vim/vimrc`, `vim/vimrc.minimal`, `vim/vimrc.template` - verify which are active

4. **Deprecated MCP configs**
   - `codex/mcp.toml` - noted as "reference template only" in bombadil.toml
   - `mcp/memory/` - verify if Memory MCP is still in use

### Remove Research/Temp Files

5. **Move or remove research files**
   - `playwright-mcp-optimization-research.md` - appears to be temp research
   - `PLAYWRIGHT_MCP_OPTIMIZATION_SUMMARY.md` - same
   - `playwright-qa-optimizer.js` - same
   - `test-playwright-optimization.js` - same
   - Move to `doc/research/` if keeping, or delete if truly temp

6. **Review Gemfile/Gemfile.lock**
   - `Gemfile` and `Gemfile.lock` appear unused - verify and remove if not needed

### Remove Potentially Unused Scripts

7. **Audit bin/ scripts for usage**
   - `gopass-config-include`, `gnupg-backup`, `gnupg-restore` - verify if gopass/gpg still in use
   - Check for orphaned scripts that reference deprecated tools

8. **Review .dots/goodies**
   - `goodies/` directory exists in `.dots/` but not in root - verify if used

### Orphaned Configs

9. **Identify orphaned configs**
   - Files in root that aren't in bombadil.toml
   - Configs that don't have symlinks in ~/.config/ or ~/

## Impact

- Affected files: Multiple backup files, deprecated tool configs, temp research files
- Risk: Low - primarily deletion of unused files
- Need to verify before deletion to avoid removing something in use

## Open Questions

1. Should research files be kept (moved to `doc/research/`) or deleted?
2. Are the gopass/gnupg scripts still needed?
3. Should the Gemfile/Gemfile.lock be removed?
4. Should deprecated MCP configs be archived or deleted?
