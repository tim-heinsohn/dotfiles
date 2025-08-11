# Markdown Style Guide

## Line Length
- **Hard limit**: 80 characters per line
- Break long lines at natural points (spaces, punctuation)
- Use line breaks to improve readability

## Formatting Rules
- Use **bold** for emphasis and important terms
- Use `backticks` for code snippets and technical terms
- Use proper heading hierarchy (# ## ### etc.)

## Lists
- Use `-` for unordered lists (consistent with this project)
- Indent sublists with 2 spaces
- Keep list items concise and focused

## Code Blocks
- Use triple backticks with language specification
- Example:
  ```bash
  command --flag value
  ```

## Links
- Use descriptive link text, not "click here"
- Reference-style links for repeated URLs:
  ```markdown
  See the [documentation][docs] for details.
  
  [docs]: https://example.com/docs
  ```

## Line Breaking Examples
Good (under 80 chars):
```markdown
This is a properly formatted line that stays within the 80-character
limit by breaking at natural points.
```

Bad (over 80 chars):
```markdown
This is an improperly formatted line that exceeds the 80-character limit and should be broken up.
```