#!/bin/bash

############################################################
# Screen Manager
############################################################

SCREENS=()
SCREEN_INDEX=0

register_screen()
{
    SCREENS+=("$1")
}

screen_current()
{
    echo "${SCREENS[$SCREEN_INDEX]}"
}

screen_next()
{
    SCREEN_INDEX=$(( (SCREEN_INDEX + 1) % ${#SCREENS[@]} ))
    display_show "$(screen_current)"
}

screen_previous()
{
    SCREEN_INDEX=$((SCREEN_INDEX - 1))

    if [ "$SCREEN_INDEX" -lt 0 ]
    then
        SCREEN_INDEX=$((${#SCREENS[@]}-1))
    fi

    display_show "$(screen_current)"
}
