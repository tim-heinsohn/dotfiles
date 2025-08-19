# AppSignal MCP Server

## Overview
The AppSignal MCP Server provides integration with AppSignal's application monitoring platform, enabling Claude Code to access performance metrics, error tracking, and alerting data directly from your AppSignal account.

## Installation
```bash
# Install the MCP server
~/dotfiles/bin/mcp-install install appsignal

# Add to Claude Code configuration
~/dotfiles/bin/mcp-install integrate appsignal
```

## Authentication
**Required**: AppSignal Push API key
- **Get your key**: https://appsignal.com/accounts → Select app → Settings → Push API key
- **Environment variable**: `APPSIGNAL_PUSH_API_KEY`

## Available Tools

### Application Management
- **List Applications**: `claude appsignal list_applications`
- **Get Application Details**: `claude appsignal get_app --app-id "APP_ID"`

### Performance Metrics
- **Get Metrics**: `claude appsignal get_metrics --app-id "APP_ID" --metric "response_time" --timeframe "1h"`
- **Available metrics**: response_time, throughput, error_rate, apdex, memory_usage
- **Timeframes**: 1h, 6h, 1d, 7d, 30d

### Error Management
- **List Errors**: `claude appsignal list_errors --app-id "APP_ID" --timeframe "24h"`
- **Get Error Details**: `claude appsignal get_error --error-id "ERROR_ID"`

### Alerting
- **List Alerts**: `claude appsignal list_alerts --app-id "APP_ID"`
- **Get Alert Details**: `claude appsignal get_alert --alert-id "ALERT_ID"`

### Performance Analysis
- **Get Samples**: `claude appsignal get_samples --app-id "APP_ID" --timeframe "1h"`
- **Analyze Transactions**: `claude appsignal analyze_transaction --app-id "APP_ID" --transaction "TRANSACTION_NAME"`

## Usage Examples

### Health Check
```bash
# Get all applications
claude appsignal list_applications

# Check app health
claude appsignal get_metrics --app-id "12345" --metric "response_time" --timeframe "24h"
```

### Error Investigation
```bash
# List recent errors
claude appsignal list_errors --app-id "12345" --timeframe "6h"

# Get detailed error information
claude appsignal get_error --error-id "67890"
```

### Performance Monitoring
```bash
# Check throughput trends
claude appsignal get_metrics --app-id "12345" --metric "throughput" --timeframe "7d"

# Analyze slow transactions
claude appsignal get_samples --app-id "12345" --timeframe "1h"
```

## Rate Limiting
- **Limit**: 1000 requests/hour per API key
- **Backoff**: Exponential backoff for 429 errors
- **Best Practice**: Cache results, use appropriate timeframes

## Security
- **API Key**: Never commit to version control
- **Environment Variables**: Use `APPSIGNAL_PUSH_API_KEY`
- **Permissions**: Ensure minimal required API key permissions
- **Rotation**: Regular key rotation via AppSignal dashboard

## Configuration
Add to Claude Code MCP configuration:
```json
{
  "mcpServers": {
    "appsignal": {
      "command": "node",
      "args": ["~/.appsignal-mcp/dist/index.js"],
      "env": {
        "APPSIGNAL_PUSH_API_KEY": "your-api-key-here"
      }
    }
  }
}
```

## Troubleshooting
- **Auth issues**: Verify API key and permissions
- **Rate limits**: Wait for reset or reduce frequency
- **App not found**: Check application ID exists
- **Debug mode**: Set `APPSIGNAL_DEBUG=true` for verbose logging

## Resources
- [AppSignal Docs](https://docs.appsignal.com/)
- [API Reference](https://docs.appsignal.com/api/)
- [Performance Guide](https://docs.appsignal.com/guides/performance.html)