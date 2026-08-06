#!/bin/bash
############################################################
# Screen Navigation
############################################################

AUTO_MODE=1
MENU_MODE=0

SCREEN_TIMEOUT="${SCREEN_TIMEOUT:-5}"
LAST_ACTION=$(date +%s)

menu_touch()
{
    LAST_ACTION=$(date +%s)
}

menu_left()
{
    menu_touch

    if [ "$MENU_MODE" = 1 ]
    then
        menu_prev
    else
        AUTO_MODE=0
        display_previous
    fi
}

menu_right()
{
    menu_touch

    if [ "$MENU_MODE" = 1 ]
    then
        menu_next
    else
        AUTO_MODE=0
        display_next
    fi
}

menu_toggle()
{
    menu_touch

    if [ "$MENU_MODE" = 1 ]
    then
        MENU_MODE=0
        AUTO_MODE=1

        display_current
    else
        MENU_MODE=1

        menu_show
    fi
}

menu_ok()
{
    menu_touch

    if [ "$MENU_MODE" = 1 ]
    then
        menu_enter
    fi
}

############################################################
# Auto Rotation
############################################################

navigation_tick()
{
    local NOW
    NOW=$(date +%s)

    [ "$AUTO_MODE" != "1" ] && return

    if [ $((NOW - LAST_ACTION)) -ge "$SCREEN_TIMEOUT" ]
    then
        LAST_ACTION="$NOW"
        display_next
    fi
}
