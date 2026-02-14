# Services Configuration

Reverse proxy and service configurations.

## Directories

| Directory | Purpose |
|-----------|---------|
| `traefik/` | Traefik reverse proxy config |
| `caddy/` | Caddy web server config |
| `postgresql/` | PostgreSQL config |
| `mariadb/` | MariaDB config |

## Traefik

Dynamic reverse proxy with:
- Docker provider
- Let's Encrypt integration
- Dashboard (secure)

## Caddy

Automatic HTTPS web server with:
- Simple configuration format
- Automatic SSL/TLS
- HTTP/3 support

## Database Services

PostgreSQL and MariaDB configurations for local development.

## Usage

Edit configuration files in the respective subdirectories. Symlink targets are typically in `~/.config/` or service-specific directories.

## Dependencies

- Traefik or Caddy (based on use case)
- PostgreSQL and/or MariaDB (if using local databases)

## Security Note

Some configuration files may contain sensitive data. Ensure proper permissions and never commit secrets to version control.
