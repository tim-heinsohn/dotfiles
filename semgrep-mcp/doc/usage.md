# Semgrep MCP Usage Guide

The Semgrep MCP server provides code security scanning and analysis capabilities through the Model Context Protocol.

## Features

- **Security vulnerability scanning**: Scan code for security issues using 5000+ built-in Semgrep rules
- **Code analysis**: Generate Abstract Syntax Trees and understand code structure
- **Multi-language support**: Works with most popular programming languages
- **Semgrep Platform integration**: Connect to Semgrep AppSec Platform with API token

## Installation

```bash
mcp install semgrep
mcp integrate semgrep
```

## Configuration

### Basic Setup (Community Edition)
No additional configuration required for basic scanning functionality using 5000+ community rules and single-file analysis.

### Platform Integration (Enhanced Features)
For significantly improved analysis capabilities:

```bash
export SEMGREP_APP_TOKEN="your-semgrep-platform-token"
```

**Requirements**: Teams tier account (10 contributors free, then $40/month per contributor)
**Get token**: [Semgrep Platform Settings > Tokens](https://semgrep.dev/manage/settings/tokens)

**Platform Benefits**:
- **Cross-file taint analysis**: Track vulnerabilities across multiple files
- **Pro rules**: Access to 20,000+ proprietary security rules (vs 5,000+ community)
- **Enhanced accuracy**: 250% more true positives, 25% fewer false positives
- **AI-powered insights**: Contextual remediation guidance and noise reduction (~20%)
- **Framework-aware analysis**: Advanced semantic understanding

**Privacy**: All analysis runs locally - your code is never uploaded. The token enables advanced analysis engines and enhanced rule sets.

## Available Tools

- **Code scanning**: Security vulnerability detection
- **AST generation**: Abstract Syntax Tree creation for code analysis
- **Rule fetching**: Access to Semgrep rule information
- **Multi-format support**: Various output formats for analysis results

## Usage Examples

### Security Scanning
```
Scan this Python file for security vulnerabilities using Semgrep
```

### Advanced Cross-File Analysis (with Platform token)
```
Perform cross-file taint analysis on this codebase to find complex vulnerabilities
```

### Code Analysis
```
Generate an AST for this JavaScript function to understand its structure
```

### Rule Information
```
Get information about Semgrep rules for SQL injection detection
```

## Best Practices

- **Start without token**: Test basic functionality first with community rules
- **Review findings carefully**: Both community and pro rules may have false positives
- **Use platform token for complex analysis**: Cross-file analysis catches sophisticated vulnerabilities
- **Monitor resource usage**: Cross-file analysis requires 4-8GB RAM per core
- **Scan critical code changes**: Focus on security-sensitive modifications

## Version Compatibility

**Solution Implemented**: This installation uses version pinning to avoid FastMCP compatibility issues.

**Installed Versions**:
- `semgrep-mcp==0.1.4` (compatible stable version)  
- `mcp==1.3.0` (compatible MCP library version)

**Why Version Pinning**: Recent FastMCP updates introduced breaking changes. The pinned versions ensure stable operation.

## Limitations & Considerations

- **Version locked**: Using older but stable versions for compatibility
- **Beta software**: MCP server under active development  
- **Memory requirements**: Platform features need significant RAM for large codebases
- **Token costs**: Enhanced features require Teams tier ($40/month after 10 free contributors)
- **Local analysis only**: Works on any local project - no repository connection required
- **Privacy first**: Code never leaves your machine, even with platform token

## Support

- GitHub: https://github.com/semgrep/mcp
- Documentation: https://semgrep.dev/docs
- Community: https://semgrep.dev/community