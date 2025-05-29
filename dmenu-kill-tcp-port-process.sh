#!/bin/bash

PROCESSES=$(netstat -tulnp 2>/dev/null | awk '
    NR > 2 {
        split($7, pid_program, "/")
        pid = pid_program[1]
        program = pid_program[2]

        if (program != "" && pid ~ /^[0-9]+$/) {
            split($4, ip_port, ":")
            port = ip_port[length(ip_port)]
            printf "%s | %s | %s | %s\n", pid, program, port, $6
        }
    }' | sort -n)

if [ -z "$PROCESSES" ]; then
    notify-send "No processes with open listening ports found."
    exit 0
fi

SELECTED_PROCESS=$(echo "$PROCESSES" | dmenu -i -l 20 -p "Select process to kill:") || exit 0
PID_TO_KILL=$(echo "$SELECTED_PROCESS" | awk -F ' | ' '{print $1}')

if kill "$PID_TO_KILL"; then
    notify-send "Process $PID_TO_KILL killed successfully."
else
    notify-send "Error killing process $PID_TO_KILL. It might require root privileges."
fi

