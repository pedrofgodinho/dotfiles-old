#!/bin/bash
DIR=$(cat /tmp/whereami)
if [ -d "$DIR" ]; then
        kitty --directory $DIR
else
        kitty
fi
