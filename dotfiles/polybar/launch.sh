#!/usr/bin/env bash

# Terminate already running bar instances
killall -9 -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if [[ "$(cat /sys/class/drm/card0-DP-*/status | grep -w "connected" -m1)" == "connected" ]]; then
   MONITOR=DP1-1 polybar --reload built &
   MONITOR=DP1-2 TRAY_POSITION_BUILT=none polybar --reload top &
else
   MONITOR=eDP1 TRAY_POSITION_BUILT=right polybar --reload built &
fi

echo "Bars launched..."
