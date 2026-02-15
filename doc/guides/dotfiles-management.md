# Bombadil Workflow Guide

## Overview

Bombadil manages dotfiles by creating symlinks from target locations in your home directory to source files in this repository.

## Adding New Dotfiles

1. **Create the source file** in the appropriate location in this repository
2. **Edit `bombadil.toml`** to add the new file mapping:
   ```toml
   [settings.dots]
   files = [
     # existing files...
     "path/to/new/file = ~/.target-location",
   ]
   ```
3. **Run `bombadil link`** to create the symlink

## Editing Existing Dotfiles

1. **Never edit the symlink target** (e.g., `~/.gitconfig`)
2. **Always edit the source file** in this repository
3. **Run `bombadil link`** to update symlinks

## Prehooks and Posthooks

- **prehooks** (`bin/prehooks`): Runs before `bombadil link`
- **posthooks** (`bin/posthooks`): Runs after `bombadil link`

These can be used for:
- Backing up existing files
- Running validation
- Reloading configurations

## Verification

Check if a file is managed by Bombadil:
```bash
ls -la ~/.gitconfig
# Should show: ~/.gitconfig -> /home/t/dotfiles/git/gitconfig
```

## Common Issues

### Duplicate entries after RVM update
When RVM updates, it may add duplicate initialization lines. See `doc/rvm-management.md`.
