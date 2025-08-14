# Semgrep MCP Integration

## Overview
Semgrep MCP provides code security scanning and analysis capabilities through the Model Context Protocol, enabling AI-powered security reviews and code analysis.

## Installation
```bash
mcp-install install semgrep
mcp-install integrate semgrep
```

## Key Features
- **Security vulnerability scanning** with 5000+ built-in rules
- **Code analysis** and AST generation
- **Multi-language support** for most popular programming languages
- **Semgrep Platform integration** with API token

## Usage Workflows

### Security Code Review
```
Scan this Python function for security vulnerabilities using Semgrep
```

### Code Analysis
```
Analyze this JavaScript code for potential issues and generate an AST
```

### Rule Information
```
What Semgrep rules are available for detecting SQL injection vulnerabilities?
```

## Important Notes
- **Beta software**: Under active development, features may change
- **Performance**: May be slower with large codebases
- **False positives**: Review findings carefully, some may be false positives
- **Optional token**: Set `SEMGREP_APP_TOKEN` environment variable for Semgrep Platform features

## Integration Details
- Installed via `uv tool install semgrep-mcp`
- Command: `semgrep-mcp`
- Transport: Standard input/output (stdio)