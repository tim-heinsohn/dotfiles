# Bin Directory

Utility scripts and executables for system management and automation.

## Scripts

### System Setup
- `setup-system` - Initial system configuration
- `setup-swapfile` - Swap file setup
- `setup-wallpapers` - Wallpaper configuration
- `disk-health-setup` - Disk health monitoring
- `disk-overview` - Disk usage analysis

### Package Management
- `packages` - Package listing and management
- `packages-install` - Install packages from list
- `packages-describe` - Describe package purposes

### Development
- `projects-setup` - Project directory setup
- `ruby` - Ruby version management wrapper
- `rvm-gems-cleanup` - RVM gem cleanup utility

### Configuration
- `prehooks` - Pre-link hooks (run before bombadil link)
- `posthooks` - Post-link hooks (run after bombadil link)
- `binaries-symlink` - Binary symlink management

### Security
- `backup-gnupg` - GPG backup utility
- `gnupg-backup` - GPG key backup
- `gnupg-restore` - GPG key restore

### Desktop
- `disable-capslock` - Remap caps lock
- `toggle-keyboard-layout` - Switch keyboard layouts
- `fix-display-offset` - Display offset correction

### Editor Integration
- `nvim-send-files-by-list` - Send file list to Neovim
- `nvim-send-files-by-main-diff` - Send diff to Neovim

### Other
- `mcp` - MCP server management
- `npm-packages` - NPM package management
- `uv-packages` - UV package management
- `clear-cache` - Clear various caches
- `dir2md` - Directory to Markdown converter

## Usage

Most scripts support `--help`:

```bash
./bin/setup-system --help
./bin/packages --help
```

## Adding New Scripts

1. Place executable scripts in this directory
2. Add shebang (`#!/bin/bash` or `#!/usr/bin/env bash`)
3. Make executable: `chmod +x bin/script-name`
4. Consider adding `--help` support for usability
