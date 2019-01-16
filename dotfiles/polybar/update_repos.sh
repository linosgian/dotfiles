#!/bin/bash
#TODO: Refactor this

function version_gt() { test "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1";  }

LATEST_RELEASE_ROFI=$(curl -s https://api.github.com/repos/DaveDavenport/rofi/releases/latest | jq -r .tag_name)
ROFI_VERSION=$(rofi -version | awk '{print $2}')
NEED_UPDATE=""

if version_gt $LATEST_RELEASE_ROFI $ROFI_VERSION; then
	NEED_UPDATE+="r"
fi

LATEST_RELEASE_POLYBAR=$(curl -s https://api.github.com/repos/jaagr/polybar/releases/latest | jq -r .tag_name)
POLYBAR_VERSION=$(polybar --version | awk 'NR==1{print $2}')
if version_gt $LATEST_RELEASE_POLYBAR $POLYBAR_VERSION; then
	NEED_UPDATE+="p"
fi

LATEST_RELEASE_I3_GAPS=$(curl -s https://api.github.com/repos/Airblader/i3/releases/latest | jq -r '.tag_name')
I3_GAPS_VERSION=$(i3 -v | awk '{print $3}' | awk -F "-" '{print $1}')
if version_gt $LATEST_RELEASE_I3_GAPS $I3_GAPS_VERSION; then
	NEED_UPDATE+="i"
fi

LATEST_RELEASE_XIDLEHOOK=$(curl -s https://api.github.com/repos/jD91mZM2/xidlehook/tags | jq -r '.[0] | .name')
XIDLEHOOK_VERSION=$(xidlehook --version | awk '{print $2}')
if version_gt $LATEST_RELEASE_XIDLEHOOK $XIDLEHOOK_VERSION; then
	NEED_UPDATE+="x"
fi

[ ! -z "$NEED_UPDATE" ] && (echo $NEED_UPDATE; exit 1)
