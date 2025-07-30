# Playwright Usage Example

This file contains a simple example of how to use Playwright with Python to automate a browser task.

## Prerequisites

-   Playwright and its dependencies must be installed and configured as per the `playwright/install` script.
-   You must be in a shell session where the `direnv` virtual environment is active.

## Example: Take a Screenshot of Google

The following Python script will:
1.  Launch a headless Chromium browser.
2.  Navigate to `https://www.google.com`.
3.  Take a screenshot and save it as `google.png`.
4.  Close the browser.

### Code

```python
from playwright.sync_api import sync_playwright

with sync_playwright() as p:
    browser = p.chromium.launch()
    page = browser.new_page()
    page.goto("https://www.google.com/")
    page.screenshot(path="google.png")
    browser.close()
```

### How to Run

1.  Save the code above into a file named `test_playwright.py`.
2.  Run the script from your terminal:
    ```bash
    python test_playwright.py
    ```
3.  A new file named `google.png` should appear in your directory.
