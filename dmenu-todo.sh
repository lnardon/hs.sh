#!/bin/bash

TODO_FILE="$HOME/.todo"
touch "$TODO_FILE"

choice=$( (echo "➕ Add New Task"; cat "$TODO_FILE") | dmenu -i -l 10 -p "TODO List:")
[ -z "$choice" ] && exit

if [ "$choice" = "➕ Add New Task" ]; then
  new_task=$(dmenu -p "New Task:")
  [ -n "$new_task" ] && echo "$new_task" >> "$TODO_FILE"
  exit 0
fi

confirm=$(echo -e "Yes\nNo" | dmenu -p "Delete task: '$choice'?")
if [ "$confirm" = "Yes" ]; then
  awk -v task="$choice" '$0 != task' "$TODO_FILE" > "$TODO_FILE.tmp" && mv "$TODO_FILE.tmp" "$TODO_FILE"
  notify-send "$choice deleted!"
fi

