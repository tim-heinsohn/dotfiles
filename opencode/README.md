# OpenCode Configuration

AI coding assistant configuration for OpenCode/Claude Code.

## Files

| File | Target | Description |
|------|--------|-------------|
| `opencode.json` | `~/.config/opencode/opencode.json` | Main OpenCode config |
| `smart-title.jsonc` | `~/.config/opencode/smart-title.jsonc` | Smart title rules |

## Configuration

- Model preferences
- Tool permissions
- Custom commands
- Context management

## Smart Title Rules

The `smart-title.jsonc` file defines rules for generating intelligent window titles based on:
- Current working directory
- Git repository information
- Active files
- Project type

## Usage

Edit files in this directory directly - never edit `~/.config/opencode/` directly as it's managed by Bombadil.

## See Also

- [OpenCode Documentation](https://opencode.ai)
- `../claude-code/` - Additional Claude/AI assistant configs
