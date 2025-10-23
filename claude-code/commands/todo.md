Interactive todo list management

Usage: /todo [action] [task]

Actions:
- add <task> <number> - Add a new task (with position)
- edit <number> <instruction> - Edit task as instructed
- style <number> - Fix wording, spell, style, put subject at beginning like e. g. "Topic: fix X"
- list - Show current todos
- move <current_number> <new_number> - change position of a task
- start <number> - Mark task as in_progress
- done <number> - Mark task as completed
- load <file> - Run slash command "/todo-load" from <file> or TODO.md
- save <file> - Run slash command "/todo-save" to <file> or TODO.md
- clear - Clear completed tasks
- i|interactive - Toggle interactive (REPL) mode for this slash command
- help - Show this help

Examples:
- /todo add "Fix authentication bug"
- /todo list
- /todo start 2
- /todo done 1

Negative numbers are to be counted from the end, e. g. -3 resolves as "third-last".
