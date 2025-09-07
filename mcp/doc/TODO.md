MCP Ruby Spin-off — Concept and Architecture

Goals
- Provide a standalone, Ruby-based MCP manager with the same CLI surface as
  current `bin/mcp`: install, update, integrate, disintegrate, uninstall,
  list, info, prompt, search.
- Open architecture supporting:
  a) multiple curated MCPs and unlimited non‑curated MCPs,
  b) multiple MCP clients (Claude, Codex, Goose initially),
  c) profiles (e.g., primary/secondary) to switch MCP auths/config quickly.
- Lean, object‑oriented implementation with small, testable, reusable classes.

CLI Parity
- Commands:
  - install <name...>
  - update [name...]
  - integrate <name...>
  - disintegrate <name...>
  - uninstall <name...>
  - list
  - info <name>
  - prompt <name>
  - search <query>
- Behavior mirrors `bin/mcp`, including curated fallbacks and minimal noise.

Repository Layout (Ruby gem)
- gem name: `mcp_cli`
- bin/
  - mcp -> CLI entrypoint (Thor/CLI toolkit)
- lib/
  - mcp_cli.rb (boot)
  - mcp_cli/
    - cli.rb (command definitions)
    - registry/
      - sources/
        - curated.rb (curated definitions)
        - mcp_get.rb (delegates to `mcp-get` if installed)
        - smithery.rb (delegates to Smithery CLI if installed)
      - resolver.rb (resolves MCP by name across sources)
      - model.rb (Mcp descriptor: name, desc, install/integrate hints)
    - servers/
      - server.rb (base class with install/update/uninstall hooks)
      - curated_server.rb (scripted installer from repo or gem)
      - generic_server.rb (non‑curated; uses mcp-get, Smithery, npm/npx, pip/pipx, or manual command)
      - node_server.rb (install/start via npm/npx when specified)
      - python_server.rb (install/start via pip/pipx when specified)
    - clients/
      - base_client.rb (idempotent integrate/disintegrate contracts)
      - claude.rb (Claude adapter)
      - codex.rb (Codex adapter)
      - goose.rb (Goose adapter)
    - config/
      - base_config.rb (read/merge/write with backup + idempotency)
      - json_config.rb (generic JSON handler)
      - toml_config.rb (generic TOML handler)
      - yaml_config.rb (generic YAML handler)
    - profiles/
      - manager.rb (create/use/list profiles)
      - profile.rb (data model: name, env, overrides)
    - integration/
      - integrator.rb (orchestrates server<->client integration per profile)
    - util/
      - fs.rb, cmd.rb, log.rb (small utilities only where needed)

Key Concepts
- Registry:
  - Composed of multiple Sources (curated, mcp-get, user‑local files).
  - Optional Smithery source integrates with Smithery CLI to discover/install
    MCP servers published to Smithery catalogs.
  - Resolves MCP by name to a Model, which knows how to create a Server.
  - Curated source ships with the gem (YAML), but can be extended by drop‑in
  files under `~/.config/mcp/curated/*.yml`.

- Servers:
  - Base interface: install, update, uninstall, info_path, prompt_path.
  - CuratedServer: executes repo‑provided install/integrate scripts, or Ruby
  blocks defined in curated YAML (portable across platforms).
  - GenericServer: for non‑curated/unknown MCPs; attempts in order:
    1) `mcp-get` (if available), 2) Smithery CLI, 3) npm/npx for Node MCPs,
    4) pip/pipx for Python MCPs, 5) Docker or manual command guidance.

- Clients (adapters):
  - BaseClient contract: integrate(server, profile), disintegrate(server,
    profile), list, write_config, etc.
  - Implementations:
    - Claude: wraps `claude mcp add/remove/list` and/or edits settings JSON as
      needed (adapter chooses best method per platform/version).
    - Codex: edits `~/.codex/config.toml` (or `~/.codex/mcp.toml`) via TOML
      adapter. Idempotent upsert.
    - Goose: edits `~/.config/goose/config.yaml` via YAML adapter. Idempotent
      upsert. Handles nested extensions and env keys.
  - Config handlers provide reusable read/merge/write capability (backup,
    minimal diffs, sort keys for stable outputs).

- Profiles:
  - Modeled as named overlays stored in `~/.config/mcp/profiles.yml` (and per-
    profile secrets in OS keychain/Pass/gopass if desired).
  - Each profile can specify env bindings and provider‑specific tokens for MCPs
    and for clients.
  - `mcp profile use <name>` applies the overlay when integrating, so the same
    server can be integrated with different credentials without changing base
    config. Supports quick switches similar to primary/secondary.

Data & Config Model
- Global config dir: `${XDG_CONFIG_HOME:-~/.config}/mcp`
  - `config.yml`: global defaults { default_profile, clients: [enabled], … }
  - `profiles.yml`: list of profiles (name, env vars, secrets refs)
  - `curated/*.yml`: curated MCP definitions (merge with bundled ones)
  - `cache/`: registry cache, search indexes for mcp-get/Smithery (optional)

Install Strategies
- mcp-get: preferred path for non‑curated MCPs when available (install/update,
  metadata for search/list). The resolver uses it to fetch known servers.
- Smithery CLI: use as an alternative registry and installer. The Smithery
  source supports discovery, `smithery install`, and metadata lookup.
- npm/npx: Node‑based MCP servers can be installed via `npm i -g` or launched
  via `npx <pkg>`; the server model may specify the exact start command.
- Python (pip/pipx): Python‑based servers installed with pip/pipx; start via a
  console‑script entry point. The server model captures the package name and
  start command.
- Docker/native: fallback for servers that publish containers or binaries.

Curated Definition Schema (YAML)
  name: gmail
  description: Gmail integration with filters
  install:
    script: ~/.gmail-mcp/install           # or an inline shell block
  integrate:
    clients:
      claude:
        cmd: ["claude", "mcp", "add", "gmail", "--", "node", "~/.gmail-mcp/dist/index.js"]
      codex:
        upsert:
          server: gmail
          command: node ~/.gmail-mcp/dist/index.js
          env_keys: ["GOOGLE_CLIENT_ID", "GOOGLE_CLIENT_SECRET"]
      goose:
        upsert:
          extension: gmail
          command: node ~/.gmail-mcp/dist/index.js
          env_keys: ["GOOGLE_*"]
  uninstall:
    remove_paths: ["~/.gmail-mcp"]

Extensibility
- New MCPs:
  - Add a curated YAML to `~/.config/mcp/curated/NAME.yml` or publish a gem
  `mcp-<name>` that registers itself at load time.
  - Non‑curated MCPs work via `mcp-get` or Smithery automatically; the CLI
    detects and proxies (install/update) or guides manual integration.
  - Node/Python servers can declare package info (npm/pip) and start commands
    in curated YAML, enabling zero‑config installation/invocation.

- New Clients:
  - Implement `McpCli::Clients::BaseClient` and register in a small registry.
  - Provide adapter for config format (JSON/TOML/YAML). Reuse existing
    config handlers.
  - Client‑specific logic (e.g., Claude CLI vs settings file) lives entirely in
    the adapter.

Implementation Notes
- CLI framework: Thor (or Commander/GLI). Keep commands thin; delegation to
  service objects.
- Dependency minimization: prefer stdlib, small TOML/YAML/JSON libs, no heavy
  frameworks. Avoid shelling out unless necessary (Claude/Codex CLIs).
- Idempotency: reads + no‑op writes when state matches; unit tests ensure
  merging logic does not churn.
- Backups: write `*.bak` on first write per file; configurable.
- Logging: quiet by default; `--verbose` for diagnostics.

Class Sketch
- McpCli::CLI (Thor)
- McpCli::Registry::Resolver
- McpCli::Registry::Sources::{Curated, McpGet, UserCurated}
- McpCli::Servers::{Server, CuratedServer, GenericServer}
- McpCli::Clients::{BaseClient, Claude, Codex, Goose}
- McpCli::Config::{BaseConfig, JsonConfig, TomlConfig, YamlConfig}
- McpCli::Profiles::{Manager, Profile}
- McpCli::Integration::Integrator

Flows
- install gmail
  -> Resolver -> CuratedServer -> run install
- install open‑source‑server
  -> Resolver -> GenericServer -> try mcp-get -> Smithery -> npm/pip path
- integrate gmail --client=goose --profile=work
  -> load profile -> Resolver -> Server
  -> Integrator applies to Goose via Goose adapter (YAML upsert)
- update (no args)
  -> enumerate installed curated + `mcp-get` installed -> apply updates

Profiles Workflow
- `mcp profile list`
- `mcp profile create work --env GOOGLE_CLIENT_ID=...`
- `mcp profile use work`
- Subsequent install/integrate commands use the active profile automatically.

Migration Path
- Start with read‑only adapters that introspect Claude/Codex/Goose config.
- Implement idempotent upsert for Codex (TOML) and Goose (YAML).
- Add Claude CLI integration (shell out to `claude mcp add/remove`).
- Port curated definitions from dotfiles into YAML, then keep them versioned in
  the new repo; allow local overrides.

Milestones
1. Skeleton gem + CLI (Thor) + Profiles manager + Registry (curated only).
2. Config handlers (JSON/TOML/YAML) with tests.
3. Clients: Codex + Goose adapters; basic integrate/disintegrate.
4. Claude adapter (CLI + settings fallback) and aggregated `search` across
   curated, mcp-get, and Smithery.
5. Curated MCPs ported; add Node/Python install strategies; docs + migration.
6. Plugin API for MCPs and Clients; release 1.0.
