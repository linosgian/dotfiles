#!/bin/bash

xrandr --output eDP-1 --off
xrandr --output DP-1-1 --off
xrandr --output DP-1-2 --off
sleep 1
xrandr --output eDP-1 --mode 2560x1600
# sleep 1
# [ "$(cat /sys/class/drm/card0-DP-*/status | grep -w "connected")" ] && xrandr --output DP1-2 --primary --mode 1920x1080 --left-of eDP1
i3-msg restart
