#!/bin/bash
XRANDR=$(which xrandr)

MONITORS=( $( ${XRANDR} | awk '( $2 == "connected" ){ print $1 }' ) )

NUM_MONITORS=${#MONITORS[@]}

COMMANDS=()
CHOICHES=()

EXTERN_ENABLED=$(cat /sys/class/drm/card0-DP-*/status | grep -w "connected" -m1)
CONNECTED_MONITORS=$(xrandr | grep " connected" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/")
ACTIVE_MONITORS=$(xrandr | grep -E " connected (primary )?[1-9]+" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/")
NUM_CONNECTED_MONITORS=$(echo ${CONNECTED_MONITORS} | wc -w)

declare -i index=0
CHOICES[$index]="cancel"
COMMANDS[$index]="true"
index+=1

CHOICES[$index]="laptop only"
COMMANDS[$index]="xrandr --output eDP1 --mode 1920x1080"
index+=1

if [ "$NUM_CONNECTED_MONITORS" == 3 ]; then
	CHOICES[$index]="external only"
	COMMANDS[$index]="xrandr --output DP1-1 --mode 1920x1080;sleep 1;\
		xrandr --output DP1-2 --mode 1920x1080 --primary --right-of DP1-1"
	index+=1
fi

echo ${CONNECTED_MONITORS}
if [ ${NUM_CONNECTED_MONITORS} == 2 ]; then
	CHOICES[$index]="WFH"
	COMMANDS[$index]="xrandr --output DP1-2 --mode 1920x1080;sleep 1;\
		xrandr --output eDP1 --off"
	index+=1
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
