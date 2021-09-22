#!/bin/sh

udiskie -A -s &
. /etc/X11/Xsession
exec i3
