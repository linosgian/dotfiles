#!/usr/bin/env bash

# Terminate already running bar instances
killall -9 -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if [[ "$(cat /sys/class/drm/card0-HDMI-A-1/status)" == "connected" ]]; then
   MONITOR=eDP1 TRAY_POSITION_BUILT=none polybar --reload built &
   MONITOR=HDMI1 polybar --reload top &
else
   MONITOR=eDP1 TRAY_POSITION_BUILT=right polybar --reload built &
fi

echo "Bars launched..."
