Goose LLM Configuration

Overview
- Goose reads LLM provider configuration from environment variables and optional defaults.
- The macOS setup script writes provider secrets to `~/.zsh/environment` and ensures `~/.zshrc` sources it.

Core variables
- GOOSE_PROVIDER: Default provider (e.g., `anthropic`, `openai`).
- GOOSE_MODEL: Default model identifier for the chosen provider (e.g., `claude-3-7-sonnet`, `gpt-4o-mini`).
 - GOOSE_HOST: Not supported for provider selection. Use provider-specific host vars instead (see below). Desktop apps use `GOOSE_API_HOST` internally to reach the local Goose service.

Provider API keys (commonly used)
- ANTHROPIC_API_KEY: Claude API key
- OPENAI_API_KEY: OpenAI API key
- (Optional) Other providers supported by tooling may use:
  - GEMINI_API_KEY (Google AI Studio)
  - MISTRAL_API_KEY
  - GROQ_API_KEY
  - OPENROUTER_API_KEY
  - TOGETHER_API_KEY
  - XAI_API_KEY
  - COHERE_API_KEY
  - AZURE_OPENAI_API_KEY (and AZURE_OPENAI_ENDPOINT)

Provider host configuration
- Anthropic: set `ANTHROPIC_HOST` (default `https://api.anthropic.com`). For Kimi (Moonshot) compatibility, use `https://api.moonshot.ai/anthropic` and the appropriate auth token.
- OpenAI: set `OPENAI_HOST` (default `https://api.openai.com`) and optional `OPENAI_BASE_PATH` (default `v1/chat/completions`).
- Ollama and others: see the provider’s entry in Goose’s provider registry for supported host/env names.

Notes on host variables
- `GOOSE_HOST` is not a recognized environment variable for choosing an LLM backend.
- `GOOSE_API_HOST` and `GOOSE_PORT` are used by Goose Desktop/GUI to connect to the local Goose API, not to select a cloud LLM provider.

How it’s provisioned
- The developer’s server uses gopass to fetch secrets and injects them when serving the installer.
- The client installer decodes the payload into `~/.zsh/environment` (600) and updates `~/.zshrc` to source it.

Moonshot (Kimi) via Anthropic-compatible API
- Defaults applied by the installer for Kimi (Moonshot):
  - `GOOSE_PROVIDER=anthropic`
  - `GOOSE_MODEL=kimi-k2-0905-preview`
  - `ANTHROPIC_BASE_URL=https://api.moonshot.ai/anthropic`
  - `ANTHROPIC_HOST=https://api.moonshot.ai/anthropic`
  - `ANTHROPIC_MODEL=kimi-k2-0905-preview`
  - `ANTHROPIC_SMALL_FAST_MODEL=kimi-k2-0905-preview`
- API key mapping:
  - `ANTHROPIC_API_KEY` is populated from `gopass show -o inaudito/services/moonshot.ai api_key`
  - Falls back to `inaudito/services/anthropic-claude api_key` if Moonshot key is absent.

Examples (`~/.zsh/environment`)
  export GOOSE_PROVIDER=anthropic
  export GOOSE_MODEL=claude-3-7-sonnet
  export ANTHROPIC_API_KEY=...redacted...
  export OPENAI_API_KEY=...redacted...
  # Optional: override provider hosts
  export ANTHROPIC_HOST=https://api.anthropic.com
  export OPENAI_HOST=https://api.openai.com

Notes
- To change defaults, edit `~/.zsh/environment` and restart the terminal.
- Secrets should be managed only with gopass on the server; the repo contains no plaintext keys.
