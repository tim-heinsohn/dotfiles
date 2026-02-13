# Proposal: dotfiles-usability-improvements

## Why

The repository is difficult to navigate for new users (including AI assistants):
- No clear entry point or overview
- Unclear what each directory contains
- Difficult to find relevant configurations
- No quick reference for common tasks

This reduces developer productivity and makes the repository harder to maintain.

## What Changes

### Improve Navigation

1. **Create entry point documentation**
   - Add `README.md` at root explaining the repository
   - Make AGENTS.md more discoverable
   - Add quick reference section for common tasks

2. **Improve directory descriptions**
   - Add `README.md` or header comment in each major directory
   - Use consistent format: purpose, key files, dependencies
   - Example: `bin/README.md`, `services/README.md`

3. **Create navigation aid**
   - Consider adding a simple index or map document
   - Could be generated from directory structure + README files

### Improve Discoverability

4. **Add findability to configs**
   - Add comments at top of each config file describing its purpose
   - Example: `# Git configuration - ~/.gitconfig`

5. **Improve bombadil.toml**
   - Add comments explaining each config entry
   - Group related configs (shell, git, editor, etc.)
   - Document the source→target relationship

6. **Add search-friendly headers**
   - Add metadata or consistent headers for AI assistants
   - Example: `# @description Main shell configuration`

### Improve Onboarding

7. **Create getting started guide**
   - New user checklist: clone, run bombadil link, verify
   - Explain dependencies (bombadil, required tools)
   - Document first-time setup steps

8. **Document common workflows**
   - How to add a new dotfile
   - How to modify an existing config
   - How to add a new script
   - How to test changes

9. **Add troubleshooting section**
   - Common issues and solutions
   - How to debug symlink issues
   - How to roll back changes

### Developer Experience

10. **Improve bin/ usability**
    - Add `--help` or usage to all scripts
    - Standardize script interface (flags, arguments)
    - Add executable bits where missing

11. **Add validation scripts**
    - Script to verify symlinks are correct
    - Script to check for broken configs
    - Script to audit repository health

12. **Improve AGENTS.md**
    - Make it more actionable for AI assistants
    - Add examples of common tasks
    - Document tool preferences and conventions

## Impact

- Affected: All documentation, potentially some scripts
- Risk: Low - primarily documentation and UX improvements
- Improves: Developer experience, onboarding time, maintainability

## Open Questions

1. Should we create a single comprehensive README or multiple focused ones?
2. Should we add a CLI tool for common dotfiles operations?
3. Should we add automated health checks (CI-style validation)?
4. How much detail should go into onboarding vs. linking to external docs?
