!#/bin/bash

FOLDER=~/Music

playMusic(){
	NAME="$(find "$FOLDER" -type f | dmenu -i -b -l 15)" || exit 0
	echo "$NAME"
	ffplay "$NAME" >/dev/null
}

playMusic
