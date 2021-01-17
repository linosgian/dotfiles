#!/bin/bash

# Essentials
sudo apt install sudo git xorg pulseaudio vim curl make gcc vim-gtk htop # vim-gtk is the +clipboard version
sudo apt install transmission evince vlc
sudo apt install imagemagick scrot sxiv pkg-config libncursesw5-dev feh

# NOTE TO SELF: dont mess with fontconfig, it messes up qt5 applications
sudo apt install i3 libnotify-bin xorg \
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

sudo apt install rofi

# Fonts
sudo apt install ttf-inconsolata fonts-inconsolata fonts-font-awesome fonts-cantarell

# Xidlehook
sudo apt install libxss-dev

# do the https://github.com/jaagr/polybar/wiki/Compiling

# Needed by battery-dunst
sudo apt install acpi

# Set qt5 theme
sudo apt install qt5ct

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
