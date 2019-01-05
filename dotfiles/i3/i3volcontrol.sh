#!/bin/bash

# Find currently active sink.
# NOTE: If none is currently used, then we change the wrong sink's
# values, due to pulseaudio not changing @DEFAULT_SINK@ properly.
ACTIVE=$(pactl list short sinks short | grep RUNNING | cut -f1)
[ -z "$ACTIVE" ] && ACTIVE=0

case "$1" in
    up)
        # Unmute first then play sound

        pactl set-sink-mute $ACTIVE 0
        paplay $HOME/.config/i3/audio-volume-change.oga
        pactl set-sink-volume $ACTIVE +5%
        ;;
    down)
        pactl set-sink-mute $ACTIVE 0
        paplay $HOME/.config/i3/audio-volume-change.oga
        pactl set-sink-volume $ACTIVE -5%
        ;;
    mute)
        pactl set-sink-mute $ACTIVE toggle
        ;;
    *)
        echo "Usage: $0 {up|down|mute}"
        exit 2
esac

# CURRENT_VOL=$( pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $ACTIVE + 1  )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,'  )
# dunstify -r 1500 $CURRENT_VOL
exit 0
