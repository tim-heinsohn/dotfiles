# Smithery CLI Integration

## Overview
Smithery CLI is a registry installer and manager for Model Context Protocol
(MCP) servers. It helps discover, inspect, run, build, and develop MCP
servers in a client‑agnostic way.

- Upstream: `@smithery/cli` (Node 18+)
- Local path: `/srv/lib/smithery-cli` (source checkout)

Core commands (from README):
- `install <package>`: Install a server for a specific client
- `uninstall <package>`: Remove a server for a client
- `inspect <server-id>`: Interactive server inspection
- `run <server-id>`: Run a server with optional `--config` JSON
- `list clients` / `list servers --client <name>`: Discovery
- `dev [entryFile]`: Dev server with hot‑reload and tunnel
- `build [entryFile]`: Build for production (`shttp` or `stdio`)
- `playground`: Browser playground for testing

This document evaluates how to integrate Smithery into our MCP flows and
proposes a safe, maintainable approach that aligns with our dotfiles
management and Codex MCP configuration model.

## Goals
- Keep MCP definitions declarative and versioned in dotfiles
- Allow rapid discovery/inspection without committing to installs
- Prefer pinned, reproducible builds for production usage
- Support both Codex CLI and Claude Desktop flows

## Fit With Our Current Flows
We manage MCP servers via:
- Codex MCP config at `codex/mcp.toml` (Bombadil‑managed)
- Per‑tool `install`/`integrate` scripts under `<name>-mcp/`
- `bin/mcp` wrapper for curated installs and integration help

Smithery complements this by providing:
- Registry discovery (`list clients`, `list servers`)
- Safety rails to test servers (`inspect`, `playground`)
- Two runtime models we can plug into Codex:
  - Quick: `npx @smithery/cli run <server-id> ...`
  - Pinned: `build` to `stdio` artifact and run via `node`

## Recommended Integration Patterns

### 1) Quick Prototyping (npx run)
Use when exploring a server before committing it to our config.

Pros: Fast, zero setup. Cons: Pulls code at runtime; less reproducible.

Codex example (add to `codex/mcp.toml`):

```toml
[mcp.servers.obsidian]
command = "npx"
args = ["-y", "@smithery/cli", "run", "mcp-obsidian",
        "--config", '{"vaultPath":"$HOME/Notes/Obsidian"}']
```

Notes:
- Keep `--config` minimal and JSON‑encoded; avoid secrets inlined.
- Good for a temporary evaluation entry; convert to pinned build after.

### 2) Pinned Production (build stdio)
Use Smithery to produce a versioned stdio binary and reference it from
Codex. This is our preferred long‑term pattern.

Steps:
1) Build stdio artifact (server repo or registry source):
   ```bash
   # Example inside a server project or using smithery defaults
   npx @smithery/cli build --transport stdio \
     --out "$HOME/.smithery/mcp-obsidian/index.cjs"
   ```
2) Reference the artifact in Codex:
   ```toml
   [mcp.servers.obsidian]
   command = "node"
   args = ["$HOME/.smithery/mcp-obsidian/index.cjs"]
   # Optionally set env if needed
   # [mcp.servers.obsidian.env]
   # OBSIDIAN_VAULT = "$HOME/Notes/Obsidian"
   ```

Pinning options:
- Capture source commit/version in a comment near the artifact path
- Store a lockfile or checksum alongside the built artifact
- Optionally check the artifact into a dotfiles‑managed path if small

### 3) HTTP Dev Loop (shttp via dev)
For active development or deep inspection, run a local shttp server and
point Codex at it.

```bash
npx @smithery/cli dev --port 8181
```

Codex entry:
```toml
[mcp.servers.smithery-dev]
transport = "http"
url = "http://localhost:8181/mcp"
```

When finished, remove the temporary dev entry from `codex/mcp.toml`.

## Claude Desktop Flow
Smithery can install directly for Claude via:

```bash
npx @smithery/cli install <package> --client claude
```

Usage notes:
- Restart Claude Desktop after install/uninstall.
- We still prefer to mirror production servers into `codex/mcp.toml` so
  both Codex and Claude stay aligned under dotfiles.
- For parity, add a matching Codex entry using either the quick or
  pinned pattern above.

## Discovery and Evaluation
- List supported clients:
  ```bash
  npx @smithery/cli list clients
  ```
- Find servers for a client:
  ```bash
  npx @smithery/cli list servers --client claude
  ```
- Inspect a server before integrating:
  ```bash
  npx @smithery/cli inspect <server-id>
  ```
- Launch the playground for interactive trials:
  ```bash
  npx @smithery/cli playground
  ```

## Configuration and Secrets
- Prefer environment variables over inline `--config` JSON in Codex.
- Where `--config` is required, keep values non‑sensitive, and source
  secrets from env at runtime.
- Document required env keys in the server’s `doc/usage.md` under this
  repo, matching our existing MCP docs.

## Security and Reliability
- Avoid `npx` in long‑term production. Prefer pinned `build` artifacts.
- Review server source and provenance when possible.
- Add basic health checks before enabling in default Codex profile.
- Keep comments in `codex/mcp.toml` noting source version and date.

## Prerequisites
- NodeJS 18+
- Optional: Smithery API key via `npx @smithery/cli login`

## Suggested Next Steps
1) Trial one server via the Quick Prototyping pattern and validate value.
2) Promote it to Pinned Production with a built stdio artifact.
3) If adopted, add a curated `install`/`integrate` pair in this repo to
   automate the build location and Codex entry creation.

## Appendix: Example Codex Entries

Quick run (runtime npx):
```toml
[mcp.servers.some-server]
command = "npx"
args = ["-y", "@smithery/cli", "run", "some-server",
        "--config", '{"key":"value"}']
```

Pinned build (stdio):
```toml
[mcp.servers.some-server]
command = "node"
args = ["$HOME/.smithery/some-server/index.cjs"]
```

Dev (shttp):
```toml
[mcp.servers.some-server-dev]
transport = "http"
url = "http://localhost:8181/mcp"
```

