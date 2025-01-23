#!/bin/sh

connection_status() {
    connection=$(sudo wg show "$config_name" 2>/dev/null | head -n 1 | awk '{print $NF }')

    if [ "$connection" = "$config_name" ]; then
        echo "1"
    else
        echo "2"
    fi
}

config_name=wg1
green=#55aa55
red=#ec5f67

case "$1" in
--toggle)
    if [ "$(connection_status)" = "1" ]; then
        sudo systemctl stop wg-quick@${config_name}.service 2>/dev/null
    else
        sudo systemctl start wg-quick@${config_name}.service 2>/dev/null
    fi
    ;;
*)
    if [ "$(connection_status)" = "1" ]; then
        echo "%{T4}%{F"$green"}%{T-}%{F-} "$config_name""
    elif [ "$(connection_status)" = "2" ]; then
        echo "%{T4}%{F"$red"} %{T-}%{F-} "$config_name""
    else
        echo "dafauq"
    fi
    ;;
esac
