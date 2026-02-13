# Proposal: dotfiles-consistency-standards

## Why

The repository has grown inconsistently over time:
- Mixed naming conventions (snake_case, kebab-case, camelCase)
- Inconsistent file extensions for similar content
- Different patterns for similar setup scripts
- Varying documentation styles

This reduces readability and makes the codebase harder to maintain.

## What Changes

### Naming Conventions

1. **Standardize directory naming**
   - Use kebab-case for directories: `shell-scripts/`, `setup-scripts/` instead of mixed
   - Document naming convention in AGENTS.md

2. **Standardize file naming**
   - Config files: Use consistent extension (e.g., `.conf`, `.config`)
   - Scripts: Use consistent extension (`.sh` for bash, `.zsh` for zsh, or no extension)
   - Document file naming convention

3. **Standardize script names**
   - Setup scripts: `setup-<service>` or `<service>-setup` - pick one
   - Use consistent verb prefixes: `setup-`, `install-`, `enable-`, `disable-`

### Code Style

4. **Standardize shell script headers**
   - Create template for script headers (shebang, description, usage)
   - Apply to all bin/ scripts

5. **Standardize shell configuration**
   - Pick one shell as primary (zsh is current primary)
   - Document which files are for which shell
   - Reduce duplication between bash/zsh configs if possible

6. **Standardize Neovim config structure**
   - Current: `nvim/init.lua`, `nvim/lua/*.lua`
   - Consider if this matches Neovim best practices
   - Document config organization

### Configuration Patterns

7. **Standardize bombadil.toml**
   - Group related entries with comments
   - Use consistent formatting
   - Document the template rendering behavior

8. **Standardize .dots/ structure**
   - Ensure consistent organization in `.dots/`
   - Document relationship between `.dots/` and root directories

### Documentation Style

9. **Standardize documentation**
   - Pick one format for READMEs (Markdown)
   - Standardize heading levels
   - Add file headers where appropriate

10. **Standardize comments**
    - Use consistent comment style (# for shell, -- for lua, etc.)
    - Document when comments are required vs optional

## Impact

- Affected: All files in repository
- Risk: Low - consistency improvements don't break functionality
- Improves: Readability, maintainability, onboarding

## Open Questions

1. Should we adopt a specific shell style guide (e.g., Google Shell Style Guide)?
2. Should we use file extensions for scripts (.sh, .zsh) or not?
3. Should we enforce consistency via linting (e.g., shellcheck, luacheck)?
4. How should we handle existing inconsistencies - fix all at once or gradually?
