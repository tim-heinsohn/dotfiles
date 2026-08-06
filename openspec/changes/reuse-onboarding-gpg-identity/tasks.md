## 1. Implementation

- [x] 1.1 Read Git's configured user name and email as default identity values.
- [x] 1.2 Discover one valid existing secret-key user ID through GnuPG's machine-readable
  output only to fill identity values missing from Git.
- [x] 1.3 Reuse configured or discovered identity values before prompting, while preserving
  explicit options and the ambiguous/no-key fallback.
- [x] 1.4 Validate shell syntax and static analysis without generating credentials.
