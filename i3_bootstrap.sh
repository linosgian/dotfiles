#!/bin/bash

sudo apt install sudo git feh i3 libnotify xorg pulseaudio vim curl \
	vim-gtk make gcc gnome-terminal xserver-xorg-input-libinput xserver-xorg-input-evdev \
	xserver-xorg-input-mouse xbacklight pavucontrol lxappearance \
	arc-theme python3-udiskie compton htop arandr network-manager-gnome gnome-keyring

# ROFI DEPS
sudo apt install libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0-dev
sudo apt install rofi 

# Essentials
sudo apt install transmission blueman evince thunderbird pidgin vlc
sudo apt install imagemagick scrot sxiv pkg-config libncursesw5-dev

# Also install chrome

# FIRMWARE for bluetooth (on Debian netinst)
sudo apt install firmware-atheros pulseaudio-module-bluetooth

# Polybar deps on Debian
sudo apt-get install cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev
# do the https://github.com/jaagr/polybar/wiki/Compiling

# keep touchpad.conf from /etc/X11/xorg.conf.d/30-touchpad.conf
# .xinitrc .Xresources .config/* .compton.conf
# Install i3-gaps
# Lock script
# Also keep the .local/share/applications/vim-usercreated-2.desktop
# and gnome-usercreated-1.desktop for directories and vim!
