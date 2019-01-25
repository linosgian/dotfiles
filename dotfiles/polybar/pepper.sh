#!/bin/bash

CURRENT_TRACK_JSON=$(curl https://now-dot-playing-dot-radiojarcom.appspot.com/api/stations/pepper/now_playing/ -s)
ARTIST="$(echo $CURRENT_TRACK_JSON | jq --raw-output '.artist')"
TRACK="$(echo $CURRENT_TRACK_JSON | jq --raw-output '.title')"
echo $ARTIST - $TRACK | tr '[:upper:]' '[:lower:]' | sed -e "s/\b\(.\)/\u\1/g"
