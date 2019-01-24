#!/bin/bash

xrandr --output eDP1 --off
xrandr --output HDMI1 --off
xrandr --output eDP1 --mode 1920x1080
[ "$(cat /sys/class/drm/card0-HDMI-A-1/status)" == "connected" ] && xrandr --output HDMI1 --mode 1920x1080 --left-of eDP1
i3-msg restart
