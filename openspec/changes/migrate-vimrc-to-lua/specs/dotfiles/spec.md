## MODIFIED Requirements

### Requirement: Neovim Configuration
**Previous text:** Neovim sources legacy ~/.vimrc for backward compatibility

**Updated text:** Neovim SHALL use pure Lua configuration without sourcing legacy vimrc

#### Scenario: Pure Lua config
- **WHEN** Neovim starts
- **THEN** it uses only Lua configuration from ~/.config/nvim/
- **AND** does not source ~/.vimrc

### Requirement: Plugin Management
**Previous text:** Vundle is used for legacy Vim plugin management

**Updated text:** Lazy.nvim SHALL be the only plugin manager used

#### Scenario: Lazy.nvim only
- **WHEN** Neovim loads plugins
- **THEN** only lazy.nvim is used
- **AND** no Vundle dependency exists
