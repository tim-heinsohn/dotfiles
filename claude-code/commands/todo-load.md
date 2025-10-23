Load todo list from TODO.md file

Usage: /todo-load [filename]

Loads tasks from a markdown checklist file into the internal TodoWrite todo
list (replacing all current ToDoWrite items).

If no filename is provided, defaults to TODO.md in the current directory.

Supported formats:
- [ ] Task name (pending)
- [x] Task name (completed)
- [~] Task name (in_progress)

Example:
- /todo-load
- /todo-load my-tasks.md

ALWAYS
- loads ALL tasks, including pending and completed
- preserves state and order
- uses internal TodoWrite as target
