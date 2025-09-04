# n8n MCP Usage

## Installation & Setup

### 1. Install n8n MCP Server
```bash
~/dotfiles/n8n-mcp/install
```

### 2. Configure for Self-Hosted n8n

For self-hosted n8n instances, you need to configure the domain and credentials:

#### Environment Variables
Set these environment variables before running the MCP:

```bash
# Required: Your n8n instance URL
export N8N_HOST="https://your-n8n-domain.com"

# Optional: API credentials (if using n8n API)
export N8N_API_KEY="your-api-key-here"
export N8N_API_SECRET="your-api-secret-here"

# Optional: Basic authentication
export N8N_BASIC_AUTH_USER="username"
export N8N_BASIC_AUTH_PASSWORD="password"
```

#### Configuration File
Create `~/.n8n-mcp/config.json`:

```json
{
  "n8n": {
    "host": "${N8N_HOST}",
    "apiKey": "${N8N_API_KEY}",
    "apiSecret": "${N8N_API_SECRET}",
    "basicAuth": {
      "username": "${N8N_BASIC_AUTH_USER}",
      "password": "${N8N_BASIC_AUTH_PASSWORD}"
    },
    "webhookUrl": "${N8N_WEBHOOK_URL}",
    "timeout": 30000
  }
}
```

#### Multiple Instance Support
For managing multiple n8n instances, use project-specific `.envrc` files with direnv:

**Project A (.envrc):**
```bash
# ~/projects/project-a/.envrc
export N8N_HOST="https://n8n-prod.company.com"
export N8N_API_KEY="prod-api-key"
export N8N_API_SECRET="prod-api-secret"
export N8N_BASIC_AUTH_USER="prod-user"
export N8N_BASIC_AUTH_PASSWORD="prod-pass"
export N8N_WEBHOOK_URL="https://n8n-prod.company.com/webhook"
```

**Project B (.envrc):**
```bash
# ~/projects/project-b/.envrc
export N8N_HOST="https://n8n-dev.company.com"
export N8N_API_KEY="dev-api-key"
export N8N_API_SECRET="dev-api-secret"
export N8N_BASIC_AUTH_USER="dev-user"
export N8N_BASIC_AUTH_PASSWORD="dev-pass"
export N8N_WEBHOOK_URL="https://n8n-dev.company.com/webhook"
```

**Instance-specific configs:**
Create separate config files for each instance:

```bash
# ~/.n8n-mcp/config.production.json
{
  "n8n": {
    "host": "${N8N_HOST:-https://n8n-prod.company.com}",
    "apiKey": "${N8N_API_KEY}",
    "apiSecret": "${N8N_API_SECRET}",
    "basicAuth": {
      "username": "${N8N_BASIC_AUTH_USER}",
      "password": "${N8N_BASIC_AUTH_PASSWORD}"
    },
    "webhookUrl": "${N8N_WEBHOOK_URL:-https://n8n-prod.company.com/webhook}",
    "timeout": 30000
  }
}

# ~/.n8n-mcp/config.development.json
{
  "n8n": {
    "host": "${N8N_HOST:-https://n8n-dev.company.com}",
    "apiKey": "${N8N_API_KEY}",
    "apiSecret": "${N8N_API_SECRET}",
    "basicAuth": {
      "username": "${N8N_BASIC_AUTH_USER}",
      "password": "${N8N_BASIC_AUTH_PASSWORD}"
    },
    "webhookUrl": "${N8N_WEBHOOK_URL:-https://n8n-dev.company.com/webhook}",
    "timeout": 30000
  }
}
```

### 3. Add to Claude Code
```bash
~/dotfiles/bin/mcp integrate n8n
```

### 4. Project-Specific Configuration with direnv

#### Verification Script
Create this script to verify your configuration:

```bash
#!/bin/bash
# ~/bin/verify-n8n-config

echo "🔍 Verifying n8n configuration..."
echo "Current directory: $(pwd)"
echo "N8N_HOST: ${N8N_HOST:-not set}"
echo "N8N_API_KEY: $([ -n "$N8N_API_KEY" ] && echo "***set***" || echo "not set")"

if [ -n "$N8N_HOST" ]; then
    echo "Testing connection to $N8N_HOST..."
    curl -s -o /dev/null -w "%{http_code}" "$N8N_HOST/healthz" | grep -q "200" && \\
        echo "✅ Connection successful" || \\
        echo "❌ Connection failed"
else
    echo "⚠️  N8N_HOST not configured"
fi

echo "Configuration file:"
ls -la ~/.n8n-mcp/config* 2>/dev/null || echo "No config files found"
```

#### Setup direnv for each project
1. **Install direnv** (if not already installed):
   ```bash
   # Arch Linux
   sudo pacman -S direnv
   
   # Hook into your shell (add to ~/.zshrc or ~/.bashrc)
   eval "$(direnv hook zsh)"
   ```

2. **Create .envrc files** in each project directory:
   ```bash
   # In ~/projects/client-project-a/
   echo 'export N8N_HOST="https://n8n-client-a.com"' > .envrc
   echo 'export N8N_API_KEY="client-a-key"' >> .envrc
   echo 'export N8N_BASIC_AUTH_USER="client-a-user"' >> .envrc
   echo 'export N8N_BASIC_AUTH_PASSWORD="client-a-pass"' >> .envrc
   direnv allow
   
   # In ~/projects/internal-dev/
   echo 'export N8N_HOST="https://n8n-dev.internal.com"' > .envrc
   echo 'export N8N_API_KEY="dev-key"' >> .envrc
   direnv allow
   ```

#### Advanced direnv patterns

**Conditional instance switching**:
```bash
# ~/projects/team-alpha/.envrc
if [ -n "$N8N_INSTANCE" ]; then
    case $N8N_INSTANCE in
        prod)
            export N8N_HOST="https://n8n-prod.company.com"
            export N8N_API_KEY="prod-key"
            ;;
        staging)
            export N8N_HOST="https://n8n-staging.company.com"
            export N8N_API_KEY="staging-key"
            ;;
        *)
            export N8N_HOST="https://n8n-dev.company.com"
            export N8N_API_KEY="dev-key"
            ;;
    esac
fi
```

**Git branch-based switching**:
```bash
# ~/projects/multi-env/.envrc
BRANCH=$(git branch --show-current 2>/dev/null)
case $BRANCH in
    main|master)
        export N8N_HOST="https://n8n-prod.company.com"
        ;;
    staging)
        export N8N_HOST="https://n8n-staging.company.com"
        ;;
    *)
        export N8N_HOST="https://n8n-dev.company.com"
        ;;
esac
```

#### Configuration templates

**Template .envrc** for quick project setup:
```bash
# ~/templates/n8n-project/.envrc.template
export N8N_HOST="https://CHANGE-ME.com"
export N8N_API_KEY="CHANGE-ME"
export N8N_API_SECRET="CHANGE-ME"
export N8N_BASIC_AUTH_USER="CHANGE-ME"
export N8N_BASIC_AUTH_PASSWORD="CHANGE-ME"
export N8N_WEBHOOK_URL="https://CHANGE-ME.com/webhook"
```

**Quick setup script**:
```bash
#!/bin/bash
# ~/bin/setup-n8n-project
PROJECT_NAME=$1
N8N_URL=$2

cd ~/projects/$PROJECT_NAME
cp ~/templates/n8n-project/.envrc.template .envrc
sed -i "s|CHANGE-ME.com|$N8N_URL|g" .envrc
direnv allow
```

## Available Features

### n8n Node Documentation
- **Comprehensive node library**: Access to 535+ n8n nodes from n8n-nodes-base and @n8n/n8n-nodes-langchain
- **Node properties**: 99% coverage with detailed parameter schemas and validation rules
- **Node operations**: 63.6% coverage of available actions and methods
- **AI-specific nodes**: 263 AI-capable nodes with specialized documentation

### Workflow Design Assistance  
- **Node selection**: Get recommendations for the right nodes for your automation tasks
- **Configuration guidance**: Detailed help with node parameters and settings
- **Best practices**: Learn optimal workflow patterns and configurations
- **Troubleshooting**: Debug common configuration issues

### Documentation Access
- **Official docs**: 90% coverage from official n8n documentation
- **Code examples**: Real-world usage patterns and configurations
- **Integration guides**: Connect with various services and APIs
- **Advanced features**: Complex workflow patterns and custom expressions

## Usage Examples

### Node Discovery and Selection
```bash
# Find nodes for specific tasks
"What n8n nodes can I use to send Slack messages?"

# Get detailed node documentation
"Show me all the parameters for the HTTP Request node in n8n"

# Find AI-related nodes
"What AI nodes are available in n8n for language processing?"
```

### Workflow Design Help
```bash
# Design workflow patterns
"Help me design an n8n workflow that monitors RSS feeds and posts new articles to Discord"

# Node configuration assistance
"How do I configure the Gmail node in n8n to send emails with attachments?"

# Complex automation guidance
"Create an n8n workflow that processes CSV files from Google Drive, validates data, and updates a database"
```

### Troubleshooting and Optimization
```bash
# Debug workflow issues
"Why might my n8n HTTP Request node be returning a 401 error?"

# Performance optimization
"How can I optimize my n8n workflow that processes large datasets?"

# Error handling patterns
"What's the best way to handle errors in n8n workflows?"
```

## Important Notes

### Coverage and Limitations
- **Node properties**: 99% coverage - nearly all node parameters documented
- **Node operations**: 63.6% coverage - most common operations available
- **Documentation**: 90% coverage from official sources
- **AI capabilities**: 263 nodes identified with AI/ML functionality

### Best Practices
- **Workflow design**: Start with simple workflows and gradually add complexity
- **Node selection**: Use the MCP to find the most appropriate nodes for your tasks
- **Configuration**: Leverage detailed parameter documentation to avoid common mistakes
- **Testing**: Use the MCP guidance to set up proper workflow testing

### Updates and Maintenance

**⚠️ IMPORTANT**: Always use the official update methods:

```bash
# Update n8n MCP specifically  
~/dotfiles/bin/mcp update n8n

# Update all installed MCPs
~/dotfiles/bin/mcp update

# Or update manually
~/dotfiles/n8n-mcp/install
```

## Advanced Usage

### Custom Node Development
- Get guidance on creating custom n8n nodes
- Understanding node structure and best practices
- API integration patterns and examples

### Complex Workflow Patterns
- Multi-step automation workflows
- Conditional logic and branching
- Data transformation and processing
- Error handling and retry strategies

## Troubleshooting

### Self-Hosted Configuration Issues

#### Connection Problems
```bash
# Test connection to your n8n instance
curl -I https://your-n8n-domain.com/healthz

# Verify API credentials
curl -H "X-N8N-API-KEY: your-api-key" https://your-n8n-domain.com/api/v1/workflows
```

#### Authentication Issues
```bash
# Test basic authentication
curl -u username:password https://your-n8n-domain.com

# Check webhook accessibility
curl -X POST https://your-n8n-domain.com/webhook/test \
  -H "Content-Type: application/json" \
  -d '{"test": "data"}'
```

#### Environment Validation
```bash
# Check if environment variables are set
echo $N8N_HOST
echo $N8N_API_KEY

# Validate configuration file
node -e "console.log(JSON.parse(require('fs').readFileSync(process.env.HOME + '/.n8n-mcp/config.json')))"
```

### MCP Server Issues
```bash
# Test MCP connection
claude mcp list
claude mcp test n8n

# Check n8n MCP logs
tail -f ~/.n8n-mcp/logs/debug.log
```

### Database Rebuild
```bash
# If node documentation seems outdated
cd ~/.n8n-mcp
npm run rebuild
```

### Installation Issues
```bash
# Clean reinstall with configuration reset
rm -rf ~/.n8n-mcp
~/dotfiles/n8n-mcp/install

# Reconfigure after reinstall
cp ~/.n8n-mcp/config.example.json ~/.n8n-mcp/config.json
# Edit config.json with your settings
```

### SSL/TLS Issues (Self-Hosted)
If using self-signed certificates:

```bash
# Add certificate to trusted store
export NODE_TLS_REJECT_UNAUTHORIZED=0
export NODE_EXTRA_CA_CERTS=/path/to/your/cert.pem
```

### Docker-Based n8n
For Docker deployments:

```bash
# Check container health
docker ps | grep n8n

# Verify network connectivity
docker exec n8n curl http://localhost:5678/healthz

# Update container environment variables
docker run -d \
  --name n8n \
  -p 5678:5678 \
  -e N8N_BASIC_AUTH_ACTIVE=true \
  -e N8N_BASIC_AUTH_USER=username \
  -e N8N_BASIC_AUTH_PASSWORD=password \
  n8nio/n8n
```