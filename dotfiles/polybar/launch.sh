#!/usr/bin/env bash

# Terminate already running bar instances
killall -9 -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

ACTIVE_MONITORS=$(xrandr | grep -E " connected (primary )?[1-9]+" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/")
NUM_ACTIVE_MONITORS=$(echo ${ACTIVE_MONITORS} | wc -w)

echo $ACTIVE_MONITORS
if [[ ${NUM_ACTIVE_MONITORS} == 3 ]]; then
   MONITOR=DP1-2 polybar --reload built &
   MONITOR=DP1-1 TRAY_POSITION_BUILT=none polybar --reload top &
elif [[ ${NUM_ACTIVE_MONITORS} == 2 ]]; then
   MONITOR=DP1-2 polybar --reload built &
   MONITOR=DP1-1 TRAY_POSITION_BUILT=none polybar --reload top &
elif [[ ${ACTIVE_MONITORS} =~ "DP1-" ]]; then
   MONITOR=${ACTIVE_MONITORS} TRAY_POSITION_BUILT=right polybar --reload built &
else
   MONITOR=eDP1 TRAY_POSITION_BUILT=right polybar --reload built &
fi

echo "Bars launched..."
