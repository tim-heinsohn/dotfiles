# Claude Code

This is the user CLAUDE.md.

## Tools
- See $DOTFILES_DIR/claude-code/docs/tools/playwright-mcp.md for browser automation with Playwright MCP
- Always close browser sessions when finished with browser automation tasks unless instructed otherwise
- Third-party repository analysis: spawn gemini for help on understanding how tools actually work
  If you need to analyze a tool such as Kamal or AnythingLLM, please consider the option of ch
  their repository into /srv/lib/[repo] and request `gemini` to analyze it, place
  insights into GEMINI.md (in that repository) and try to answer the open
  question (and place that in a dedicated doc/[topic].md). The answer shall be
  given back directly or placed in a specific file that you tell `gemini`.

## Practices
- See $DOTFILES_DIR/claude-code/docs/tools/security-practices.md for secure coding
  guidelines and environment variable handling

## Style Guidelines
- See $DOTFILES_DIR/claude-code/docs/style/markdown.md for Markdown formatting standards
