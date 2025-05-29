#!/bin/bash

FOLDER=~/Music

playMusic(){
	NAME="$(find "$FOLDER" -type f | dmenu -i -l 15)" || exit 0
	ffplay -x 128 -y 128 "$NAME" >/dev/null
}

playMusic
