#!/bin/bash

# Essentials
sudo apt install sudo git xorg pulseaudio vim curl make gcc vim-gtk htop # vim-gtk is the +clipboard version
sudo apt install transmission blueman evince thunderbird pidgin vlc
sudo apt install imagemagick scrot sxiv pkg-config libncursesw5-dev feh

# NOTE TO SELF: dont mess with fontconfig, it messes up qt5 applications
sudo apt install i3 libnotify xorg \
	xserver-xorg-input-libinput xserver-xorg-input-evdev \
	xserver-xorg-input-mouse xbacklight arandr

# Terminal emulator
sudo apt install gnome-terminal

# Compositor
sudo apt install compton

# Network manager
sudo apt install network-manager-gnome gnome-keyring # keyring is needed to submit a wifi password

# GUI to change GTK2 and GTK3 appearance
sudo apt install lxappearance

# Pulseaudio GUI 
sudo apt install pavucontrol

# This handles automounting of devices
sudo apt install python3-udiskie

# GTK3 theme
sudo apt install arc-theme

# ROFI DEPS
# Are the deps needed????
sudo apt install libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0-dev
sudo apt install rofi

# Also install chrome

# FIRMWARE for bluetooth (on Debian netinst)
sudo apt install firmware-atheros pulseaudio-module-bluetooth

# Polybar deps on Debian
sudo apt-get install cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev
# do the https://github.com/jaagr/polybar/wiki/Compiling

# keep touchpad.conf from /etc/X11/xorg.conf.d/30-touchpad.conf
# Install i3-gaps
# Systemd lock!
