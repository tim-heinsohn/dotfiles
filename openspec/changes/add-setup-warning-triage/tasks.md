# Tasks

## 1. Diagnostic Collection

- [ ] 1.1 Create a shared Bash diagnostic helper that streams output, retains command exit status, and verifies successful and failing command behavior with a shell test harness.
- [ ] 1.2 Add explicit classifier and normalization rules for npm deprecation, `ERESOLVE`, `EBADENGINE`, command failures, and German/English already-current package messages; verify fixture output produces the expected issue groups.
- [ ] 1.3 Document supported diagnostic rules and how to add a new rule in the helper documentation; verify examples match the test fixtures.

## 2. Setup Integration

- [ ] 2.1 Wrap the package and npm installation steps invoked by `setup-system` with diagnostic collection while preserving terminal prompts and their exit statuses; verify with mocked package and npm commands.
- [ ] 2.2 Add phase-end issue summaries that group repeated diagnostics by stable fingerprint and preserve occurrence counts and producing commands; verify group order and repeated-warning handling with fixtures.
- [ ] 2.3 Add noninteractive behavior that prints diagnostic summaries without agent launches; verify no mock agent executable is called when stdin is not a TTY.

## 3. Interactive Investigation

- [ ] 3.1 Add sequential TTY prompts that allow users to skip individual or remaining issue groups and choose only available `opencode`, `claude`, or `codex` executables; verify selection and skip paths with mocked agents.
- [ ] 3.2 Create bounded, untrusted-data agent context with explicit no-autonomous-change instructions and cleanup on exit; verify instruction-like fixture text is passed as data and no suggested command is executed by the wrapper.
- [ ] 3.3 Run the shell test harness, `bash -n`, and `shellcheck` for all touched scripts; verify a sample interactive session continues after each agent exits.
