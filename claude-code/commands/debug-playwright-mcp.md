---
description: Use Playwright to open a page and fetch its content.
allowed-tools: Bash
---

Follow these steps precisely to interact with the Playwright MCP:

## @playwright/mcp@latest

1.  **Start the server in the background.** It is critical that you add an `&`
    at the end of the command to prevent the agent from hanging. For example:
    `your-playwright-mcp-start-command &`
    – please also capture the PID to allow terminating the server at the end.
2.  **Wait for the server to be ready.** You might need a short `sleep` command
    here, e.g., `sleep 5`.
3.  **Send commands to the server.** For example, to open a page:
    `your-playwright-mcp-client-command open "https://example.com"`
4.  **Fetch the content.** `your-playwright-mcp-client-command fetch`
5.  **Crucially, close the server.** You must send the `kill <PID>`, where
    <PID> is the process ID of the server, to terminate the server process.

## @executeautomation/playwright-mcp-server

1.  **Start the server in the background.** It is critical that you add an `&`
    at the end of the command to prevent the agent from hanging. For example:
    `npx @executeautomation/playwright-mcp-server &`
2.  **Wait for the server to be ready.** You might need a short `sleep` command
    here, e.g., `sleep 5`.
3.  **Send commands to the server.** 
4.  **Fetch the content.**
5.  **Crucially, close the server.** You must send the `playwright_close` tool
    command to terminate the server process.

Example:

```bash
(echo '{"jsonrpc":"2.0","method":"tools/call","params":{"name":"playwright_navigate","arguments":{"url":"https://www.google.com"}},"id":1}'; echo '{"jsonrpc":"2.0","method":"tools/call","params":{"name":"playwright_close","arguments":{}},"id":2}') | npx @executeautomation/playwright-mcp-server
```

**Available Tools:**

Here is a list of all the available tools and their descriptions:

*   **`start_codegen_session`**: Start a new code generation session to record Playwright actions
*   **`end_codegen_session`**: End a code generation session and generate the test file
*   **`get_codegen_session`**: Get information about a code generation session
*   **`clear_codegen_session`**: Clear a code generation session without generating a test
*   **`playwright_navigate`**: Navigate to a URL
*   **`playwright_screenshot`**: Take a screenshot of the current page or a specific element
*   **`playwright_click`**: Click an element on the page
*   **`playwright_iframe_click`**: Click an element in an iframe on the page
*   **`playwright_iframe_fill`**: Fill an element in an iframe on the page
*   **`playwright_fill`**: fill out an input field
*   **`playwright_select`**: Select an element on the page with Select tag
*   **`playwright_hover`**: Hover an element on the page
*   **`playwright_upload_file`**: Upload a file to an input[type='file'] element on the page
*   **`playwright_evaluate`**: Execute JavaScript in the browser console
*   **`playwright_console_logs`**: Retrieve console logs from the browser with filtering options
*   **`playwright_close`**: Close the browser and release all resources
*   **`playwright_get`**: Perform an HTTP GET request
*   **`playwright_post`**: Perform an HTTP POST request
*   **`playwright_put`**: Perform an HTTP PUT request
*   **`playwright_patch`**: Perform an HTTP PATCH request
*   **`playwright_delete`**: Perform an HTTP DELETE request
*   **`playwright_expect_response`**: Ask Playwright to start waiting for a HTTP response. This tool initiates the wait operation but does not wait for its completion.
*   **`playwright_assert_response`**: Wait for and validate a previously initiated HTTP response wait operation.
*   **`playwright_custom_user_agent`**: Set a custom User Agent for the browser
*   **`playwright_get_visible_text`**: Get the visible text content of the current page
*   **`playwright_get_visible_html`**: Get the HTML content of the current page. By default, all <script> tags are removed from the output unless removeScripts is explicitly set to false.
*   **`playwright_go_back`**: Navigate back in browser history
*   **`playwright_go_forward`**: Navigate forward in browser history
*   **`playwright_drag`**: Drag an element to a target location
*   **`playwright_press_key`**: Press a keyboard key
*   **`playwright_save_as_pdf`**: Save the current page as a PDF file
*   **`playwright_click_and_switch_tab`**: Click a link and switch to the newly opened tab
