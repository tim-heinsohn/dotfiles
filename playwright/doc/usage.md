# Playwright MCP Usage Guide

This document explains how to use Playwright MCP (Model Context Protocol) with Claude Code for browser automation.

## What is Playwright MCP?

Playwright MCP is a server that provides browser automation capabilities to AI assistants like Claude. It allows you to interact with web pages, take screenshots, fill forms, and perform other browser tasks through natural language commands.

## Installation (Already Done)

Playwright MCP is installed globally via:
```bash
npm install -g @playwright/mcp
```

## Claude CLI Setup

For Claude CLI, add the MCP server using:
```bash
claude mcp add playwright npx '@playwright/mcp@latest'
```

Then start Claude as usual:
```bash
claude
```

## Usage Examples

Once configured, you can use commands like:
- "Use playwright to open https://www.google.com"
- "Take a screenshot of the current page"
- "Fill out the form with my name and email"
- "Click on the 'Sign In' button"

## Verification

Test the MCP server:
```bash
mcp-server-playwright  # Should start and show "Server listening..."
```

## Claude Desktop Setup

For Claude Desktop, configure in `~/Library/Application Support/Claude/claude_desktop_config.json` (macOS) or equivalent:

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest"]
    }
  }
}
```

## Browser Sessions & Persistence

- **Sessions**: Browser state persists within a single Claude session
- **Passwords**: Browser profiles/cache are isolated per session  
- **Security**: Runs locally, no external dependencies
- **Profiles**: Uses temporary browser profiles that are cleaned up after use