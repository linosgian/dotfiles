#!/bin/bash

XRANDR=$(which xrandr)

MONITORS=( $( ${XRANDR} | awk '( $2 == "connected" ){ print $1 }' ) )


NUM_MONITORS=${#MONITORS[@]}

TITLES=()
COMMANDS=()


function gen_xrandr_only()
{
    selected=$1

    cmd="xrandr --output ${MONITORS[$selected]} --auto "

    for entry in $(seq 0 $((${NUM_MONITORS}-1)))
    do
        if [ $selected != $entry ]
        then
            cmd="$cmd --output ${MONITORS[$entry]} --off"
        fi
    done

    echo $cmd
}



declare -i index=0
TILES[$index]="cancel"
COMMANDS[$index]="true"
index+=1


for entry in $(seq 0 $((${NUM_MONITORS}-1)))
do
    TILES[$index]="only ${MONITORS[$entry]}"
    COMMANDS[$index]=$(gen_xrandr_only $entry)
    index+=1
done

##
# Dual screen options
##
for entry_a in $(seq 0 $((${NUM_MONITORS}-1)))
do
    for entry_b in $(seq 0 $((${NUM_MONITORS}-1)))
    do
        if [ $entry_a != $entry_b ]
        then
            TILES[$index]="dual screen ${MONITORS[$entry_a]} -> ${MONITORS[$entry_b]}"
            COMMANDS[$index]="xrandr --output ${MONITORS[$entry_a]} --auto;
                              xrandr --output ${MONITORS[$entry_b]} --auto --left-of ${MONITORS[$entry_a]}"

            index+=1
        fi
    done
done


##
# Clone monitors
##
for entry_a in $(seq 0 $((${NUM_MONITORS}-1)))
do
    for entry_b in $(seq 0 $((${NUM_MONITORS}-1)))
    do
        if [ $entry_a != $entry_b ]
        then
            TILES[$index]="clone screen ${MONITORS[$entry_a]} -> ${MONITORS[$entry_b]}"
            RESOLUTION=$(xrandr | awk "/${MONITORS[$entry_a]}/{getline; print \$1}")
            echo $RESOLUTION
            COMMANDS[$index]="xrandr --output ${MONITORS[$entry_a]} --auto; \
                              xrandr --output ${MONITORS[$entry_b]} --auto --scale-from $RESOLUTION"
            index+=1
        fi
    done
done


##
#  Generate entries, where first is key.
##
function gen_entries()
{
    for a in $(seq 0 $(( ${#TILES[@]} -1 )))
    do
        echo $a ${TILES[a]}
    done
}

# Call menu
SEL=$( gen_entries | rofi -dmenu -p "Choose monitor setup" -a 0 -no-custom  | awk '{print $1}' )

[[ -z $SEL ]] && exit

for monitor in $(seq 0 $((${NUM_MONITORS}-1)))
do
    xrandr --output ${MONITORS[$monitor]} --off
done
eval "${COMMANDS[$SEL]}"

# Restart i3 for feh and polybar to render properly
# If we didn't cancel
i3-msg restart
