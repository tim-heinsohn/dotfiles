# Claude Code

This is the user CLAUDE.md.

## Tools

### Gmail MCP
- See $DOTFILES_DIR/claude-code/docs/tools/gmail-mcp.md for Gmail integration with filter management
- **Rate Limiting**: When processing large batches of emails (>100), implement exponential backoff delays (1s, 2s, 4s, 8s) between requests to avoid Google API rate limits and potential account restrictions

### Playwright MCP
- See $DOTFILES_DIR/claude-code/docs/tools/playwright-mcp.md for browser automation with Playwright MCP
- Always close browser sessions when finished with browser automation tasks unless instructed otherwise

### Semgrep MCP
- See $DOTFILES_DIR/claude-code/docs/tools/semgrep-mcp.md for code security scanning and analysis

### Third-party Repository Analysis
- Third-party repository analysis: spawn gemini for help on understanding how tools actually work
  If you need to analyze a tool such as Kamal or AnythingLLM, please consider the option of ch
  their repository into /srv/lib/[repo] and request `gemini` to analyze it, place
  insights into GEMINI.md (in that repository) and try to answer the open
  question (and place that in a dedicated doc/[topic].md). The answer shall be
  given back directly or placed in a specific file that you tell `gemini`.
  Gemini is useful for large repositories (huge context window) and cost-effectiveness 
  (Google offers free tier with OAuth login).

### Git Service Integration
For interacting with Git repositories, PRs/MRs, and issues, use:
- **GitHub**: `gh` CLI for repositories, PRs, issues, releases
- **GitLab**: `glab` CLI for repositories, MRs, issues, releases  
- **Atlassian**: `acli` CLI for Bitbucket repos/PRs, Jira issues, Confluence

Let the user run `${DOTFILES_DIR}/bin/git-cli-setup` to check authentication status when authentication fails.

## Practices
- See $DOTFILES_DIR/claude-code/docs/tools/security-practices.md for secure coding
  guidelines and environment variable handling

## Style Guidelines
- See $DOTFILES_DIR/claude-code/docs/style/markdown.md for Markdown formatting standards

## Commit Message Convention
- Use **Conventional Commits** format: `type: description`
- Common types: `feat:` (new feature), `fix:` (bug fix), `docs:` (documentation), `refactor:` (code restructuring), `chore:` (maintenance)
- Keep first line ≤100 chars, subsequent lines ≤100 chars, total message ≤700 chars
