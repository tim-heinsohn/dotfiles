**Goose Configuration**

- **Config file**: `~/.config/goose/config.yaml`
- **Sessions**: `~/.local/share/goose/sessions`
- **Logs**: `~/.local/state/goose/logs`
- **Inspect**: `goose info -v`

Use either environment variables (fast), the interactive wizard, or a small YAML to set provider and model. Keep API keys in envs (recommended) or let the wizard store them in your keyring.

**Fastest Setup (env vars)**

- **Core**: Set provider and default model
  - `export GOOSE_PROVIDER=openai`  # e.g., openai, anthropic, groq, openrouter, gemini, azure_openai, ollama, aws_bedrock, databricks
  - `export GOOSE_MODEL=gpt-4o-mini`  # pick a model supported by your provider

- **Provider keys** (set those you use)
  - OpenAI: `OPENAI_API_KEY`, optional `OPENAI_HOST` or `OPENAI_BASE_PATH`, `OPENAI_ORGANIZATION`, `OPENAI_PROJECT`, `OPENAI_TIMEOUT`, `OPENAI_CUSTOM_HEADERS`
  - Anthropic: `ANTHROPIC_API_KEY`, optional `ANTHROPIC_HOST`
  - Gemini: `GOOGLE_API_KEY`, optional `GOOGLE_HOST` (defaults to `https://generativelanguage.googleapis.com`)
  - Groq: `GROQ_API_KEY`, optional `GROQ_HOST` (defaults to `https://api.groq.com`)
  - OpenRouter: `OPENROUTER_API_KEY`, optional `OPENROUTER_HOST` (defaults to `https://openrouter.ai/api/v1`)
  - Azure OpenAI: `AZURE_OPENAI_ENDPOINT`, `AZURE_OPENAI_DEPLOYMENT_NAME`, `AZURE_OPENAI_API_VERSION`, `AZURE_OPENAI_API_KEY`
  - xAI: `XAI_API_KEY`, optional `XAI_HOST`
  - Others appear supported (e.g., `aws_bedrock`, `databricks`) via their normal vendor envs

- **Optional tuning**
  - `GOOSE_TEMPERATURE` (e.g., `0.2`)
  - `GOOSE_CONTEXT_LIMIT` (tokens)
  - Embeddings: `GOOSE_EMBEDDING_MODEL_PROVIDER`, `GOOSE_EMBEDDING_MODEL`
  - Advanced lead/worker: `GOOSE_LEAD_PROVIDER`, `GOOSE_LEAD_MODEL`, `GOOSE_LEAD_TURNS`, `GOOSE_LEAD_CONTEXT_LIMIT`, `GOOSE_WORKER_CONTEXT_LIMIT`

- **Quick example**
  - `export GOOSE_PROVIDER=openai`
  - `export GOOSE_MODEL=gpt-4o-mini`
  - `export OPENAI_API_KEY=sk-...`

**Config File (YAML)**

- Path: `~/.config/goose/config.yaml`
- Minimal (keep secrets in env; set provider/model here):

```yaml
provider: openai
model: gpt-4o-mini
```

- With embeddings and some tuning:

```yaml
provider: openai
model: gpt-4o-mini
embedding_model: text-embedding-3-small
temperature: 0.2
context_limit: 128000
```

- Notes
  - Goose reads API keys from env for each provider. If you prefer, run the wizard to save secrets to your keyring.
  - For OpenAI-compatible endpoints, either:
    - Use `provider: openai` and set `OPENAI_BASE_PATH` (or `OPENAI_HOST`) to your custom URL, with the corresponding key env var; or
    - Use a dedicated provider if supported (e.g., `openrouter` with `OPENROUTER_HOST`/`OPENROUTER_API_KEY`).

**Interactive Wizard**

- Run: `goose configure`
- Prompts for provider, fetches model list, asks for a model, and optionally stores secrets in your keyring.

**Quick Test**

- Non-interactive: `goose run -t "Hello" --no-session`
- Interactive session: `goose session -n test`

If Goose complains about “No provider/model configured,” ensure both `GOOSE_PROVIDER` and `GOOSE_MODEL` are set or present in `~/.config/goose/config.yaml`.

