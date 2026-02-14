# Common Workflows

How to perform common tasks with this dotfiles repository.

## Adding a New Dotfile

### Step 1: Create the Source File

Create your configuration file in the appropriate directory:

```bash
# Example: adding a new tool config
nvim ~/dotfiles/newtool/config.toml
```

### Step 2: Register in bombadil.toml

Edit `bombadil.toml` and add an entry:

```toml
[newtool]
source = "newtool/config.toml"
target = "~/.config/newtool/config.toml"
```

### Step 3: Link the File

```bash
bombadil link
```

### Step 4: Verify

```bash
ls -la ~/.config/newtool/config.toml
# Should show symlink to ~/dotfiles/newtool/config.toml
```

## Modifying an Existing Config

**Critical: Always edit the source in this repository, never the symlink target.**

```bash
# WRONG - will cause issues
nvim ~/.zshrc

# CORRECT - edit the source
nvim ~/dotfiles/zsh/zshrc

# Changes are reflected automatically (symlink)
```

## Adding a New Script

### Create the Script

```bash
nvim ~/dotfiles/bin/my-script
```

Add content:
```bash
#!/bin/bash
echo "My script"
```

### Make Executable

```bash
chmod +x ~/dotfiles/bin/my-script
```

### Add Help Support (Recommended)

```bash
#!/bin/bash
# @description My custom script

case "$1" in
  --help|-h)
    echo "Usage: my-script [OPTIONS]"
    echo "Options:"
    echo "  --help  Show this help message"
    exit 0
    ;;
esac

# Main script logic here
echo "Running my script"
```

## Testing Changes

### Shell Changes

```bash
# Test syntax
zsh -n ~/dotfiles/zsh/zshrc

# Reload without restarting
source ~/dotfiles/zsh/zshrc
```

### Neovim Changes

```bash
# Check for errors on startup
nvim --headless +qa +"echo errbuf" +qa

# Check config
:checkhealth
```

### Git Config

```bash
# Test gitconfig syntax
git config --list --show-origin

# Test specific alias
git config --get alias.ci
```

## Rolling Back Changes

### Using Git

```bash
# See recent changes
git log --oneline -10

# Revert a specific file
git checkout HEAD~1 -- path/to/file

# Or reset entire repo
git reset --hard HEAD
```

### Re-linking

If symlinks are broken:

```bash
# Remove broken symlinks
rm ~/.config/broken-file

# Re-link everything
bombadil link
```

## Syncing to Another Machine

```bash
# On new machine
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
bombadil link
```

Note: Some configs (especially those with credentials) may need manual adjustment on new machines.
