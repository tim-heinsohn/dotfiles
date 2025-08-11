# Playwright MCP Usage

## Critical Workflow Steps
Follow these steps precisely to interact with the Playwright MCP:

1. **Use MCP tools directly** - The mcp__playwright__ tools are available and ready to use
2. **Navigate to pages** - Use `mcp__playwright__playwright_navigate` with URL parameter  
3. **Interact with elements** - Use tools like `mcp__playwright__playwright_click`, `mcp__playwright__playwright_fill`, etc.
4. **Take screenshots** - Use `mcp__playwright__playwright_screenshot` to capture page content
5. **CRUCIALLY close the browser** - Always use `mcp__playwright__playwright_close` to terminate the browser process properly

**Important:** The `playwright_close` step is essential for proper operation on this machine. Failure to close will leave browser processes running.

## Available Tools
- `playwright_navigate` - Navigate to URLs
- `playwright_screenshot` - Capture page screenshots  
- `playwright_click` - Click elements
- `playwright_fill` - Fill input fields
- `playwright_select` - Select dropdown options
- `playwright_hover` - Hover over elements
- `playwright_evaluate` - Execute JavaScript
- `playwright_get_visible_text` - Get page text content
- `playwright_get_visible_html` - Get page HTML content
- `playwright_close` - **REQUIRED** - Close browser and release resources