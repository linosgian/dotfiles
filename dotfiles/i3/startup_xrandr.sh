#!/bin/bash

xrandr --output eDP1 --off
xrandr --output DP1-2 --off
sleep 1
xrandr --output eDP1 --mode 1920x1080
sleep 1
[ "$(cat /sys/class/drm/card0-DP-*/status | grep -w "connected")" ] && xrandr --output DP1-2 --primary --mode 1920x1080 --left-of eDP1
i3-msg restart
