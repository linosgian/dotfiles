#!/bin/bash

xrandr --output DVI-D-1 --off
xrandr --output HDMI-0 --off
sleep 1
xrandr --output HDMI-0 --mode 1920x1080
sleep 1
xrandr --output DVI-D-1 --primary --mode 1920x1080 --rate 144.00 --right-of HDMI-0
i3-msg restart
sudo nvidia-settings --assign CurrentMetaMode="HDMI-0: nvidia-auto-select +0+0 {ForceCompositionPipeline=On}, DVI-D-1: 1920x1080_144 +1920+0"
