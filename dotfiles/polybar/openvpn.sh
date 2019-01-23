#!/bin/bash
# Hacky way to check that I'm connected to GRNET NOC VPN
curl -s 62.217.124.86 --connect-timeout 5 > /dev/null && echo  || echo %{u#f00}%{+u}%{-u}
