#!/bin/bash

ACTIVE=$(pactl list short sinks short | grep RUNNING | cut -f1)
[ -z "$ACTIVE" ] && echo 0 && exit

echo $ACTIVE
