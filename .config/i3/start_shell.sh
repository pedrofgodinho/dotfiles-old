#!/bin/bash
DIR=$(cat /tmp/whereami)
if [ -d "$DIR" ]; then
        i3-sensible-terminal --directory $DIR
else
        i3-sensible-terminal
fi
