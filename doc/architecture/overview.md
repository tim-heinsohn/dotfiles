# Dotfiles Architecture

## Repository Structure

```
dotfiles/
├── .dots/              # Source configurations (managed by Bombadil)
├── bin/                # Executable scripts
├── claude-code/        # Claude Code configuration
├── doc/                # Documentation
│   ├── guides/         # How-to guides
│   ├── architecture/   # Architecture decisions
│   ├── research/       # Research documents
│   └── reviews/        # Code reviews
├── openspec/           # Change management
├── utils/              # Additional utilities
└── [config dirs]       # Individual tool configs (git, zsh, nvim, etc.)
```

## Design Principles

### 1. Source of Truth
Configuration files exist in this repository as the source of truth. Target locations in `$HOME` are symlinks managed by Bombadil.

### 2. Separation of Concerns
- `bin/` - Executable scripts for automation
- `doc/` - Human-readable documentation
- `[tool]/` - Tool-specific configuration (git, zsh, nvim, etc.)

### 3. Shell Configuration Strategy
RVM and other shell tools are initialized across multiple shell files to ensure compatibility:
- `zsh/zshrc` - Primary Zsh config
- `shell/bashrc` - Bash config
- `shell/bash_profile` - Bash login
- `shell/profile` - POSIX profile
- `shell/zlogin` - Zsh login

### 4. Change Management
OpenSpec is used to manage significant changes through proposals rather than direct modification.

## Bombadil Integration

The `bombadil.toml` file defines the mapping between source files in this repository and their target locations in the filesystem.

See `doc/guides/dotfiles-management.md` for details.
