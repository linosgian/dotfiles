#!/bin/bash

xrandr --output eDP1 --off
xrandr --output HDMI1 --off
sleep 1
xrandr --output eDP1 --mode 1920x1080
sleep 1
[ "$(cat /sys/class/drm/card0-HDMI-A-1/status)" == "connected" ] && xrandr --output HDMI1 --primary --mode 1920x1080 --left-of eDP1
i3-msg restart
