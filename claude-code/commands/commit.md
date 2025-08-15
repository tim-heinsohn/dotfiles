Please use git to commit changes without (!) Claude attribution.

## Optional Argument

You can provide an optional free text argument to control commit message style:
- Examples: "concise", "detailed", "several by topic"
- This argument will guide how the commit message is written or whether to create multiple commits

## Examples

- `/commit` - Standard concise commit with the most important parts and details (default)
- `/commit concise` - Explicit concise commit (same as above)
- `/commit detailed` - More detailed commit message with additional context
- `/commit several [by topic]` - Multiple (sequential) commits grouped by logical topics/changes

## What to commit?

1. If there are staged changes, only commit those.
2. Otherwise only those changes and unversioned files that are related to the
   current Claude session, but always ask for confirmation before adding
   unversioned files.

## Commit Message

1. Content: use both the diff and the context of the chat for summarizing the change
2. Style: write conventional, concise commit messages as outlined in the user CLAUDE.md
3. Attribution: without Claude attribution
