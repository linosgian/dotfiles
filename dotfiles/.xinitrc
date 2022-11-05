#!/bin/sh

echo XHC > /proc/acpi/wakeup 
xmodmap /home/lgian/.Xmodmap
udiskie -A -s &
. /etc/X11/Xsession
exec i3
