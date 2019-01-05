#!/bin/sh
udiskie -t &
. /etc/X11/Xsession
exec i3
