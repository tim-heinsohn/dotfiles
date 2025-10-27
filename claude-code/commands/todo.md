Interactive todo list management

Usage: /todo [action] [task]

Actions:
- add <task> <number> - Add a new task (with position)
- clear - Clear completed tasks
- done <number> - Mark task as completed
- edit <number> <instruction> - Edit task as instructed
- help - Show this help
- i|interactive - Toggle interactive (REPL) mode for this slash command
- later <number> - Move task from internal TodoWrite to markdown file LATER.md
- list - Show current todos
- load <file> - Run slash command "/todo-load" from <file> or TODO.md
- move <current_number> <new_number> - change position of a task
- save <file> - Run slash command "/todo-save" to <file> or TODO.md
- start <number> - Mark task as in_progress
- style <number> - Fix wording, spell, style, put subject at beginning like e. g. "Topic: fix X"

Examples:
- /todo add "Fix authentication bug"
- /todo list
- /todo start 2
- /todo done 1

Negative numbers are to be counted from the end, e. g. -3 resolves as "third-last".
