# Troubleshooting

Common issues and their solutions.

## Symlink Problems

### Symptom: File not updating after edit

**Problem**: Changes to source file not reflected in home directory.

**Solution**: Check if you're editing the source file, not the symlink:

```bash
# Check if file is a symlink
ls -la ~/.zshrc

# If it points to ~/dotfiles/, you're good
# If not, remove and re-link
rm ~/.zshrc
bombadil link
```

### Symptom: Broken symlinks

**Problem**: Symlinks point to non-existent files.

**Diagnosis**:
```bash
# Find broken symlinks
find ~ -xtype l -ls

# Check specific link
readlink ~/.config/nvim
```

**Solution**:
```bash
# Re-link all files
bombadil link
```

## Shell Problems

### Symptom: Zsh won't start

**Diagnosis**:
```bash
# Check syntax errors
zsh -n ~/dotfiles/zsh/zshrc

# Check what's failing
zsh -xv ~/dotfiles/zsh/zshrc 2>&1 | tail -50
```

**Solution**: Temporarily rename config to test:
```bash
mv ~/.zshrc ~/.zshrc.bak
# Start shell, fix issue, restore
```

### Symptom: Missing aliases

**Diagnosis**:
```bash
# Check if aliases file is sourced
grep aliases ~/.zshrc

# Check alias definitions
cat ~/dotfiles/zsh/aliases | grep alias
```

## Editor Problems

### Symptom: Neovim plugins not loading

**Diagnosis**:
```bash
# Check plugin manager status
nvim +PlugStatus  # vim-plug
nvim +Lazy        # lazy.nvim

# Check init.lua errors
nvim --headless +"lua vim.cmd('luafile ~/.config/nvim/init.lua')" +qa 2>&1
```

**Solution**:
```bash
# Reinstall plugins
nvim +PlugClean +PlugInstall +qa

# Or with lazy.nvim
nvim +Lazy restore +qa
```

### Symptom: LSP not working

**Diagnosis**:
```bash
# Check LSP status in Neovim
:LspInfo

# Check installed language servers
which eslint
which rust-analyzer
# etc.
```

## Bombadil Problems

### Symptom: bombadil link fails

**Diagnosis**:
```bash
# Check bombadil.toml syntax
bombadil check

# Verbose output
bombadil link -v
```

**Common issues**:
- Invalid TOML syntax
- Source file doesn't exist
- Target directory doesn't exist

### Symptom: Hooks failing

**Diagnosis**:
```bash
# Run hooks manually
~/dotfiles/bin/prehooks
~/dotfiles/bin/posthooks

# Check output for errors
```

## Git Problems

### Symptom: Git credential issues

**Diagnosis**:
```bash
# Check credential helper
git config --global credential.helper

# Test gopass integration
gopass git-credential fill
```

## Rollback Procedures

### Full Rollback

```bash
# Remove all symlinks managed by bombadil
# (Careful - this removes your configs!)

# Option 1: Backup and start fresh
cd ~
mkdir dotfiles-backup
mv .zshrc .config/nvim dotfiles-backup/

# Option 2: Use git
cd ~/dotfiles
git reset --hard HEAD~1
bombadil link
```

### Single File Rollback

```bash
# Restore specific file from git
cd ~/dotfiles
git checkout HEAD -- path/to/file

# Re-link
bombadil link
```

## Getting Help

1. Check this troubleshooting guide
2. Check `bombadil.toml` comments
3. Check relevant README files
4. Search git history: `git log --oneline --all -- path/to/file`
