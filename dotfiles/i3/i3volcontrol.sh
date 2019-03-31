#!/bin/bash

# Find currently active sink.
# NOTE: If none is currently used, then we change the wrong sink's
# values, due to pulseaudio not changing @DEFAULT_SINK@ properly.
# ACTIVE=$(pactl list short sinks short | grep RUNNING | cut -f1)

# NOTE: Change this to whichever device should be your default
# [ -z "$ACTIVE" ] && ACTIVE=alsa_output.pci-0000_00_1f.3.analog-stereo

case "$1" in
    up)
        # Unmute first then play sound

        pactl set-sink-mute @DEFAULT_SINK@ 0
        paplay $HOME/.config/i3/audio-volume-change.oga
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        ;;
    down)
        pactl set-sink-mute @DEFAULT_SINK@ 0
        paplay $HOME/.config/i3/audio-volume-change.oga
        pactl set-sink-volume @DEFAULT_SINK@ -5%
        ;;
    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        ;;
    *)
        echo "Usage: $0 {up|down|mute}"
        exit 2
esac

exit 0
