# Tasks: dotfiles-structure-reorganization

## 1. Analysis and Planning
- [ ] 1.1 Document current directory structure
- [ ] 1.2 Map relationships between root and .dots/ directories
- [ ] 1.3 Identify all configs managed by bombadil
- [ ] 1.4 Review existing service setup directories

## 2. Documentation
- [ ] 2.1 Add README.md to .dots/ explaining its purpose
- [ ] 2.2 Document bombadil workflow in doc/
- [ ] 2.3 Update AGENTS.md with structure info

## 3. Reorganization
- [ ] 3.1 Create services/ directory
- [ ] 3.2 Move service setup directories to services/
- [ ] 3.3 Update bombadil.toml for new paths (if needed)
- [ ] 3.4 Update any references to moved directories

## 4. Cleanup
- [ ] 4.1 Remove or consolidate duplicate directories
- [ ] 4.2 Verify all symlinks still work
- [ ] 4.3 Test bombadil link after changes
