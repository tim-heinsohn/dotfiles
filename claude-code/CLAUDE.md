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

### Mail Server MCP
- See $DOTFILES_DIR/claude-code/docs/tools/mail-server-mcp.md for IMAP/SMTP email integration with project-based primary/secondary account configuration

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

### YouTube Transcript MCP
- See $DOTFILES_DIR/claude-code/docs/tools/youtube-mcp.md for YouTube transcript retrieval
- **Rate Limiting**: Add 1-2 second delays between bulk requests to avoid YouTube API rate limits

### YouTube Playlist MCP
- See $DOTFILES_DIR/claude-code/docs/tools/youtube-playlist-mcp.md for YouTube playlist management and watch later functionality
- **OAuth Required**: Requires Google Cloud Console setup and OAuth authentication

### Third-party Repository Analysis
For deep investigation of tools, libraries, and frameworks, git clone their source into `/srv/lib/[repo]` to examine features, configuration, and usage patterns.

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

### Further tools
Additional command-line tools available for common tasks:
- **pandoc** - Universal document converter for PDF creation and format conversion
- **ffmpeg** - Complete audio/video processing and conversion suite
- **imagemagick** - Image manipulation and conversion toolkit
- **yt-dlp** - Download videos and audio from YouTube and hundreds of other sites
- **jq/yq** - JSON/YAML processors for data extraction and manipulation
- **ripgrep/fd** - Fast file and content search tools
- **rclone** - Sync files to/from cloud storage (Google Drive, S3, etc.)
- **texlive** - Complete LaTeX distribution for professional document typesetting
- **docker/docker-compose** - Container management and orchestration

See `$DOTFILES_DIR/bin/packages` for the complete list of locally available packages.

## Practices
- See docs/tools/security-practices.md for secure coding
  guidelines and environment variable handling

## Style Guidelines
- See docs/style/markdown.md for Markdown formatting standards

