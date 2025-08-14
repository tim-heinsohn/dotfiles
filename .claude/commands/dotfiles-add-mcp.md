Add the specified MCP server to this dotfiles repository following the established pattern.

## Required Steps to Complete Integration

Based on the existing Gmail MCP implementation, you need to:

### 1. Create MCP Directory Structure
```bash
mkdir -p $DOTFILES_DIR/<mcp-name>-mcp/{doc,}
```

### 2. Create Installation Script
Create `<mcp-name>-mcp/install` executable script that:
- Clones or installs the MCP server (e.g., to `~/.mcp-name-mcp/`)
- Handles dependencies (npm install, pip install, etc.)
- Sets proper permissions for sensitive files
- Provides setup instructions

**Example based on Gmail MCP** (`gmail-mcp/install`):
- Clones from GitHub repository
- Runs `npm install` for dependencies
- Secures OAuth credentials with `chmod 600`
- Prints next steps for authentication

### 3. Create Usage Documentation
Create `<mcp-name>-mcp/doc/usage.md` with:
- Available features and capabilities
- Usage examples with specific commands
- Authentication/security requirements
- Rate limiting or important operational notes
- Best practices and warnings

### 4. Add to Integration Scripts
Update `/home/t/dotfiles/bin/mcp-install` to include:
- Add case in `integrate_mcp()` function for your MCP
- Add detection logic in `update_all_mcps()` for installed directory
- Update `list_mcps()` help text if needed

### 5. Create Claude Code Documentation
Create `claude-code/docs/tools/<mcp-name>-mcp.md` with:
- Critical workflow steps
- Available tools/functions  
- Important usage notes (like closing browsers for Playwright)
- Security considerations

### 6. Update User CLAUDE.md
Add reference to your MCP in `claude-code/CLAUDE.md` under Tools section:
```markdown
- See $DOTFILES_DIR/claude-code/docs/tools/<mcp-name>-mcp.md for <description>
```

### 7. Test Integration
- Run `mcp-install install <mcp-name>` 
- Run `mcp-install integrate <mcp-name>`
- Verify MCP appears in `claude mcp list`
- Test basic functionality

## Reference Implementation: Gmail MCP

Study the complete Gmail MCP implementation:
- **Installation**: `/home/t/dotfiles/gmail-mcp/install`
- **Documentation**: `/home/t/dotfiles/gmail-mcp/doc/usage.md`
- **Integration**: `/home/t/dotfiles/bin/mcp-install` (lines 55-65)
- **User docs**: `/home/t/dotfiles/claude-code/docs/tools/gmail-mcp.md`
- **User reference**: `/home/t/dotfiles/claude-code/CLAUDE.md` (line 7)

The Gmail MCP demonstrates the complete pattern:
1. Clone repository to `~/.gmail-mcp/`
2. Install npm dependencies 
3. Secure sensitive files (OAuth)
4. Provide authentication instructions
5. Integration via `claude mcp add-json` command
6. Comprehensive documentation with rate limiting warnings

Follow this exact pattern for consistency with the existing dotfiles structure.