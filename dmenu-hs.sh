#! /bin/bash

FOLDER=~/Documents/Projects/hs.sh
runScript(){
	SELECTED=$(ls $FOLDER | dmenu -i -l 10) || exit 0
	$FOLDER/$SELECTED
}

runScript
