# RVM Management in Dotfiles

This repository manages Ruby Version Manager (RVM) initialization across all shell types through Bombadil.

## Overview

RVM initialization is split across multiple shell configuration files:
- **zshrc** - Primary development shell (managed in `.dots/zsh/zshrc`)
- **bashrc** - Bash shell (managed in `shell/bashrc`)
- **bash_profile** - Bash login shell (managed in `shell/bash_profile`)
- **profile** - POSIX shell profile (managed in `shell/profile`)
- **zlogin** - Zsh login shell (managed in `shell/zlogin`)

All files are symlinked by Bombadil to ensure consistency across the system.

## When Updating RVM

RVM periodically releases updates. When you run `rvm get stable --auto-dotfiles`, RVM will automatically modify shell initialization files in your home directory.

### Update Process

1. **Run RVM update:**
   ```bash
   rvm get stable --auto-dotfiles
   ```

2. **Check for duplicates:**
   After the update, RVM may add duplicate initialization lines if it runs multiple times.
   Check your shell files:
   ```bash
   grep -n "rvm" ~/.bashrc ~/.bash_profile ~/.profile ~/.zshrc ~/.zlogin
   ```
   Remove any duplicate lines manually.

3. **Review changes:**
   Check what RVM modified in each shell file. Look for:
   - New RVM PATH entries
   - Updated sourcing commands
   - Changes to RVM function loading

4. **Update repo files:**
   Copy the cleaned initialization snippets to the repo:
   - `.dots/zsh/zshrc` - Update RVM section (lines 60-62)
   - `shell/bashrc` - Update RVM PATH line
   - `shell/bash_profile` - Update RVM sourcing line
   - `shell/profile` - Update RVM initialization
   - `shell/zlogin` - Update RVM sourcing line

5. **Sync with Bombadil:**
   ```bash
   bombadil link
   ```

6. **Verify the changes:**
   ```bash
   source ~/.zshrc
   rvm -v
   ```

## Important Notes

- **Don't commit duplicates:** Always remove duplicate RVM lines before committing changes
- **All shells must match:** Keep RVM initialization consistent across all shell files
- **Test after update:** Verify that `rvm`, `ruby`, and `gem` commands work correctly
- **PATH order matters:** Ensure RVM bin directory comes early in PATH so gem binaries take precedence

## File Locations

- Repository: `/home/t/dotfiles/`
  - Zsh: `.dots/zsh/zshrc`
  - Bash: `shell/bashrc`, `shell/bash_profile`
  - POSIX: `shell/profile`
  - Zsh login: `shell/zlogin`

- Home directory (symlinked by Bombadil):
  - `~/.zshrc`
  - `~/.bashrc`
  - `~/.bash_profile`
  - `~/.profile`
  - `~/.zlogin`

## Related Files

- `bombadil.toml` - Defines which shell files are managed
- `.dots/zsh/zshrc` - Contains detailed RVM update instructions in comments
