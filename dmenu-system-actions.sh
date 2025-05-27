#! /bin/bash

declare -a commands=(
  "Shutdown | shutdown now"
  "Restart | reboot"
  "Logoff | gnome-session-quit --logout --no-prompt"
)

systemActions(){
	SELECTED=$(printf '%s\n' "${commands[@]}" | dmenu -i -l 3 -p "Select an option:") || exit 0

	if [[ -n "$SELECTED" ]]; then
		COMMAND=$(echo $SELECTED | awk -F '|' '{print $NF}')
		$COMMAND
	fi
}

systemActions
