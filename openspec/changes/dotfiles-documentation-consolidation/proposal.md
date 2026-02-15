# Proposal: dotfiles-documentation-consolidation

## Why

Documentation is fragmented across multiple locations:
- Multiple `AGENTS.md` files (root, `openspec/AGENTS.md`, `.claude/`)
- Unclear which is the authoritative source
- Missing overview documentation about the repository structure
- Scattered markdown files at root level without clear organization

This makes it difficult for developers (including AI assistants) to understand the repository.

## What Changes

### Consolidate AGENTS.md

1. **Single source of truth for AGENTS.md**
   - Determine which AGENTS.md is authoritative
   - Current candidates: root `AGENTS.md`, `openspec/AGENTS.md`
   - Keep one, create symlinks or include from other locations
   - Document which file AI assistants should read

2. **CLAUDE.md symlink cleanup**
   - `CLAUDE.md` → `AGENTS.md` symlink exists - verify it's still needed

### Improve Repository Documentation

3. **Create comprehensive README.md**
   - Explain what this repository is (dotfiles managed by Bombadil)
   - Document the directory structure
   - List main configuration areas
   - Explain the bombadil workflow
   - Include quick start for new users

4. **Document bombadil workflow**
   - Add `doc/dotfiles-management.md` or enhance existing
   - Explain `.dots/` vs root directory relationship
   - Document prehooks/posthooks
   - Explain how to add new dotfiles

### Organize Documentation

5. **Consolidate root-level markdown files**
   - Move `FREIGHT.md`, `TODO.md` to `doc/` if relevant
   - Review if they should be in version control

6. **Improve doc/ structure**
   - `doc/research/` - for research files (already exists)
   - `doc/reviews/` - for code reviews (already exists)
   - Add `doc/guides/` for how-to documents
   - Add `doc/architecture/` for architecture decisions

7. **Review and update existing docs**
   - `doc/rvm-management.md` - verify still accurate
   - `doc/sudo.md` - verify still accurate
   - `utils/README.md` - verify still accurate

### Add Missing Documentation

8. **Document bin/ scripts**
   - Each significant script should have header comments
   - Consider adding `bin/README.md` for overview

9. **Document OpenSpec usage**
   - The `openspec/` directory exists but may need better documentation
   - Clarify when to use OpenSpec vs direct changes

## Impact

- Affected files: AGENTS.md, CLAUDE.md, potential new README.md, doc/ structure
- Low risk - primarily documentation changes
- High value - improves maintainability and onboarding

## Open Questions

1. Which AGENTS.md should be the authoritative source?
2. Should there be a top-level README.md (currently only AGENTS.md exists)?
3. How should we handle TODO.md - keep at root or move to doc/?
4. Should FREIGHT.md be kept in version control?
