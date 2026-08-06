## Why

`bin/onboard` is idempotent for key files but currently asks for the user's name and email
on every run. The repository already configures one Git identity for the user, which is a
better default than guessing among several secret GPG keys.

## What Changes

- Use Git's configured name and email as the default identity before prompting.
- Use one unambiguous existing secret-key user ID only for values Git does not provide.
- Preserve explicit `--name` and `--email` values and prompt only for values that remain
  unavailable.

## Impact

- Affected specs: `onboarding-key-bootstrap`
- Affected code: `bin/onboard`
