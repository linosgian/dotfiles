#!/bin/bash

# Essentials
sudo apt install -y sudo git xorg pulseaudio vim curl make gcc vim-gtk htop # vim-gtk is the +clipboard version
sudo apt install -y transmission blueman evince thunderbird pidgin vlc
sudo apt install -y imagemagick scrot sxiv pkg-config libncursesw5-dev feh

# NOTE TO SELF: dont mess with fontconfig, it messes up qt5 applications
sudo apt install -y i3 libnotify libnotify-bin xorg \
	xserver-xorg-input-libinput xserver-xorg-input-evdev \
	xserver-xorg-input-mouse xbacklight arandr

# Terminal emulator
sudo apt install -y gnome-terminal

# Compositor
sudo apt install -y compton

# Network manager
sudo apt install -y network-manager-gnome gnome-keyring # keyring is needed to submit a wifi password

# GUI to change GTK2 and GTK3 appearance
sudo apt install -y lxappearance

# Pulseaudio GUI 
sudo apt install -y pavucontrol

# This handles automounting of devices
sudo apt install -y python3-udiskie

# GTK3 theme
sudo apt install -y arc-theme

# ROFI DEPS
# Are the deps needed????
sudo apt install -y libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0-dev
sudo apt install -y rofi

# Fonts
sudo apt install -y ttf-inconsolata fonts-inconsolata fonts-font-awesome fonts-cantarell
# Also install chrome

# Xidlehook
sudo apt install -y libxss-dev

# FIRMWARE for bluetooth (on Debian netinst)
sudo apt install -y firmware-atheros pulseaudio-module-bluetooth

# Polybar deps on Debian
sudo apt-get install -y cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev
# do the https://github.com/jaagr/polybar/wiki/Compiling

# Needed by battery-dunst
sudo apt install -y acpi

# Set qt5 theme
sudo apt install -y qt5ct

# keep touchpad.conf from /etc/X11/xorg.conf.d/30-touchpad.conf
mkdir Pictures
wget http://wallpaper21.com/wp-content/uploads/2016/04/super-mountain-peak-ultra-HD-wallpapers.jpg

# Avoid issue with broadcasted message when starting OpenVPN service
# sudo systemctl mask systemd-ask-password-wall.service
# sudo systemctl mask systemd-ask-password-wall.path


# This might fix xbacklight for intel
# under /etc/X11/xorg.conf.d/20-intel.conf
Section "Device"
        Identifier  "card0"
        Driver      "intel"
        Option      "Backlight"  "intel_backlight"
        BusID       "PCI:0:2:0"
EndSection

# echo deep > /sys/power/mem for deep sleep and add it to grub!
# Edit /etc/default/keyboard
# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

XKBMODEL="pc105"
XKBLAYOUT="us,gr"
XKBVARIANT=""
XKBOPTIONS="grp:win_space_toggle"

BACKSPACE="guess"
