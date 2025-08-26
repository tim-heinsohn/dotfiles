# AppSignal MCP Server Usage Guide

## Overview
The AppSignal MCP Server provides integration with AppSignal's application monitoring platform, allowing Claude Code to access performance metrics, error tracking, and alerting data directly from your AppSignal account.

## Authentication
- **Required**: AppSignal API key (also called Personal MCP Token)
- **Get your key**: Visit https://appsignal.com/users/mcp_tokens (requires login)
- **Configuration**: Store your API key in environment variable `APPSIGNAL_API_KEY` or in the MCP server configuration

## Available Tools

### 1. List Applications
```bash
claude appsignal list_applications
```
Lists all applications in your AppSignal account with their IDs and basic information.

### 2. Get Application Metrics
```bash
claude appsignal get_metrics --app-id "YOUR_APP_ID" --metric "response_time" --timeframe "1h"
```
Retrieves performance metrics for a specific application.
- **Metrics**: response_time, throughput, error_rate, apdex, memory_usage
- **Timeframes**: 1h, 6h, 1d, 7d, 30d

### 3. List Errors
```bash
claude appsignal list_errors --app-id "YOUR_APP_ID" --timeframe "24h"
```
Lists recent errors and exceptions for an application.

### 4. Get Error Details
```bash
claude appsignal get_error --error-id "ERROR_ID"
```
Retrieves detailed information about a specific error including stack trace and context.

### 5. List Alerts
```bash
claude appsignal list_alerts --app-id "YOUR_APP_ID"
```
Lists active alerts and notifications for an application.

### 6. Get Performance Samples
```bash
claude appsignal get_samples --app-id "YOUR_APP_ID" --timeframe "1h"
```
Retrieves performance samples for slow requests and transactions.

## Usage Examples

### Monitor Application Health
```bash
# Get basic app health overview
claude appsignal list_applications

# Check response time trends
claude appsignal get_metrics --app-id "12345" --metric "response_time" --timeframe "24h"

# Review recent errors
claude appsignal list_errors --app-id "12345" --timeframe "6h"
```

### Error Investigation
```bash
# List errors in last hour
claude appsignal list_errors --app-id "12345" --timeframe "1h"

# Get details for a specific error
claude appsignal get_error --error-id "67890"

# Check if alerts are firing
claude appsignal list_alerts --app-id "12345"
```

### Performance Analysis
```bash
# Check throughput trends
claude appsignal get_metrics --app-id "12345" --metric "throughput" --timeframe "7d"

# Analyze slow transactions
claude appsignal get_samples --app-id "12345" --timeframe "1h"
```

## Rate Limiting
- **Limit**: 1000 requests per hour per API key
- **Best Practice**: Cache results when possible, use appropriate timeframes
- **Error Handling**: Server implements exponential backoff for 429 responses

## Security Considerations
- **API Key Storage**: Never commit API keys to version control
- **Environment Variables**: Use `APPSIGNAL_API_KEY` environment variable
- **Access Control**: Ensure API keys have minimal required permissions
- **Rotation**: Regularly rotate API keys using AppSignal dashboard

## Configuration
Add to your Claude Code MCP configuration:

```json
{
  "mcpServers": {
    "appsignal": {
      "command": "node",
      "args": ["/Users/your-username/.appsignal-mcp/dist/index.js"],
      "env": {
        "APPSIGNAL_API_KEY": "your-api-key-here"
      }
    }
  }
}
```

## Troubleshooting

### Common Issues
- **Authentication failed**: Check your API key and ensure it has proper permissions
- **App not found**: Verify the application ID exists in your AppSignal account
- **Rate limit exceeded**: Wait for reset or reduce request frequency

### Debug Mode
Enable debug logging by setting environment variable:
```bash
export APPSIGNAL_DEBUG=true
```

### Health Check
Verify MCP server is working:
```bash
claude appsignal list_applications
```

## Additional Resources
- [AppSignal Documentation](https://docs.appsignal.com/)
- [API Reference](https://docs.appsignal.com/api/)
- [Performance Monitoring Guide](https://docs.appsignal.com/guides/performance.html)