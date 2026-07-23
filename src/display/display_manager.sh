#!/bin/bash

############################################################
# FritzView Display Manager
############################################################

CURRENT_PAGE="home"

display_show()
{
    local PAGE="$1"
    local FUNC="page_${PAGE}"

    echo "display_show -> $FUNC"

    if declare -F "$FUNC" >/dev/null
    then
        CURRENT_PAGE="$PAGE"
        DISPLAY_CURRENT="$PAGE"

        "$FUNC"

        echo "$FUNC fertig"
    else
        display_clear
        display_center "Page not found"
        display_center "$PAGE"
        display_render
    fi
}

display_current()
{
    display_show "$CURRENT_PAGE"
}

display_next()
{
    screen_next
}

display_previous()
{
    screen_previous
}
