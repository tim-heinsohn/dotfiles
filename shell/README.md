# Shell Configuration

POSIX-compatible shell configuration (Bash, POSIX sh).

## Files

| File | Target | Description |
|------|--------|-------------|
| `profile` | `~/.profile` | Login shell profile |
| `bashrc` | `~/.bashrc` | Bash interactive config |
| `bash_profile` | `~/.bash_profile` | Bash login profile |
| `zlogin` | `~/.zlogin` | Zsh login commands |

## Usage

These files provide fallback configuration for:
- Bash shells (when not using Zsh)
- POSIX-compliant shells
- Login session setup

The Zsh configuration in `../zsh/` takes precedence when using Zsh.

## Priority

For Zsh:
1. `~/.zshenv` (always sourced)
2. `~/.zprofile` (login)
3. `~/.zshrc` (interactive)
4. `~/.zlogin` (login, after zshrc)

For Bash:
1. `~/.bash_profile` (login)
2. `~/.bashrc` (interactive)

## Note

Most interactive shell customization is in `../zsh/`. Edit files in this directory for Bash-specific or POSIX-compliant configurations.
