#!/bin/bash

PROCESS=$(ps aux | dmenu -l 20 -p "Select process to kill") || exit 0
PID=$(echo $PROCESS | awk '{print $2}')

notify-send "Killing process with PID $PID"
kill $PID

