#!/bin/bash
XRANDR=$(which xrandr)

MONITORS=( $( ${XRANDR} | awk '( $2 == "connected" ){ print $1 }' ) )

NUM_MONITORS=${#MONITORS[@]}

COMMANDS=()
CHOICHES=()

EXTERN_ENABLED=$(cat /sys/class/drm/card0-HDMI-A-1/status)


declare -i index=0
CHOICES[$index]="cancel"
COMMANDS[$index]="true"
index+=1

CHOICES[$index]="laptop only"
COMMANDS[$index]="xrandr --output eDP1 --mode 1920x1080"
index+=1

if [ "$EXTERN_ENABLED" == "connected" ]; then
	CHOICES[$index]="external only"
	COMMANDS[$index]="xrandr --output HDMI1 --mode 1920x1080"
	index+=1

	CHOICES[$index]="dual screen: built-in -> external"
	COMMANDS[$index]="xrandr --output eDP1 --mode 1920x1080;sleep 1; \
		xrandr --output HDMI1 --mode 1920x1080 --right-of eDP1"
	index+=1

	CHOICES[$index]="dual screen: external -> built-in"
	COMMANDS[$index]="xrandr --output eDP1 --mode 1920x1080; sleep 1;\
		xrandr --output HDMI1 --mode 1920x1080 --left-of eDP1"
fi

#TODO: Implement cloning

##
#  Generate entries, where first is key.
##
function gen_entries()
{
    for a in $(seq 0 $(( ${#CHOICES[@]} -1 )))
    do
        echo $a ${CHOICES[a]}
    done
}

# Call menu
SEL=$( gen_entries | rofi -dmenu -p "Choose monitor setup" -a 0 -no-custom  | awk '{print $1}' )

# If canceled or pressed escape
[[ -z $SEL || $SEL == 0 ]] && exit

for monitor in $(seq 0 $((${NUM_MONITORS}-1)))
do
    xrandr --output ${MONITORS[$monitor]} --off
done
sleep 1
eval "${COMMANDS[$SEL]}"

sleep 1
# Restart i3 for feh and polybar to render properly
i3-msg restart
