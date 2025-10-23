Save current todo list to TODO.md file

Usage: /todo-save [filename]

Saves the current todo list to a markdown file in checklist format.
If no filename is provided, defaults to TODO.md in the current directory.

Format:
- [ ] Task name (pending)
- [x] Task name (completed)
- [~] Task name (in_progress)

Includes current date/time using: date "+%Y-%m-%d %H:%M"

Example:
- /todo-save
- /todo-save my-tasks.md