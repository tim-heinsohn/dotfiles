# Claude Code

This is the user CLAUDE.md.

## Tools

### Gmail MCP
- See docs/tools/gmail-mcp.md for Gmail integration with filter management
- **Rate Limiting**: When processing large batches of emails (>100), implement
  exponential backoff delays (1s, 2s, 4s, 8s) between requests to avoid Google
  API rate limits and potential account restrictions

### Jira MCP
- See docs/tools/jira-mcp.md for Jira and Confluence integration with Atlassian products
- **Caching**: See jira-mcp/cache/ for local ticket caching strategies and scheduled sync implementations

### Playwright MCP
- See docs/tools/playwright-mcp.md for browser automation with Playwright MCP
- Always close browser sessions when finished with browser automation tasks unless instructed otherwise

### Miro MCP
- See docs/tools/miro-mcp.md for Miro whiteboard collaboration platform integration
- **Authentication**: Requires Miro API access token from https://miro.com/app/settings/user-profile/apps
- **Rate Limiting**: 100 requests/minute, implement exponential backoff (1s, 2s, 4s, 8s) for 429 errors

### n8n MCP
- See docs/tools/n8n-mcp.md for n8n workflow automation node documentation
- **Coverage**: 535+ nodes with 99% parameter coverage and 90% official documentation
- **AI Nodes**: 263 AI-capable nodes with specialized documentation for ML workflows

### Rails Active MCP
- See docs/tools/rails-active-mcp.md for Rails application interaction and database querying

### Semgrep MCP
- See docs/tools/semgrep-mcp.md for code security scanning and analysis

### ElevenLabs MCP
- See docs/tools/elevenlabs-mcp.md for text-to-speech capabilities using ElevenLabs API
- **Authentication**: Requires ElevenLabs API key from https://elevenlabs.io/app/settings/api-keys
- **Rate Limiting**: 10,000-500,000 characters/month depending on plan, implement exponential backoff for 429 errors

### AppSignal MCP
- See docs/tools/appsignal-mcp.md for AppSignal application monitoring and performance metrics
- **Authentication**: Requires AppSignal Push API key from https://appsignal.com/accounts
- **Rate Limiting**: 1000 requests/hour per API key, implement exponential backoff for 429 responses

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
  - See docs/tools/acli.md for comprehensive Jira ticket creation and management, e.g.
  ```bash
  acli jira workitem create --summary "New feature" --project "KI" --type "Task" \
  description "Detailed description of the feature"
  ```
  - View comments and details: `acli jira workitem view KI-30 --fields "summary,comment,description" --json`
  - **Markdown Support**: Use `markdown-to-adf` to convert Markdown to Jira ADF format
  - Supports work items, projects, filters, and dashboard management

Let the user run `bin/git-cli-setup` to check authentication status when authentication fails.

### Git Commit Message Convention
- Use **Conventional Commits** format: `type: description`
- Common types: `feat:` (new feature), `fix:` (bug fix), `docs:`
  (documentation), `refactor:` (code restructuring), `chore:` (maintenance)
- Keep first line ≤100 chars, subsequent lines ≤100 chars, total message ≤700 chars
- Without Claude attribution please

## Practices
- See docs/tools/security-practices.md for secure coding
  guidelines and environment variable handling

## Style Guidelines
- See docs/style/markdown.md for Markdown formatting standards

