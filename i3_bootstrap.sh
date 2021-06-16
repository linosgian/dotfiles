#!/bin/bash

# Essentials
sudo apt install sudo git xorg pulseaudio vim curl make gcc vim-gtk htop # vim-gtk is the +clipboard version
sudo apt install transmission evince vlc
sudo apt install imagemagick scrot sxiv pkg-config libncursesw5-dev feh

# kitty
sudo apt install 

# NOTE TO SELF: dont mess with fontconfig, it messes up qt5 applications
sudo apt install i3 libnotify-bin xorg \
	xserver-xorg-input-libinput xserver-xorg-input-evdev \
	xserver-xorg-input-mouse

# Compositor
sudo apt install compton

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
sudo apt install fonts-inconsolata fonts-font-awesome fonts-cantarell

# Xidlehook
sudo apt install libxss-dev polybar


# Set qt5 theme
sudo apt install qt5ct

wget http://wallpaper21.com/wp-content/uploads/2016/04/super-mountain-peak-ultra-HD-wallpapers.jpg


# Edit /etc/default/keyboard
# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

#XKBMODEL="pc105"
#XKBLAYOUT="us,gr"
#XKBVARIANT=""
#XKBOPTIONS="grp:win_space_toggle"

#BACKSPACE="guess"
