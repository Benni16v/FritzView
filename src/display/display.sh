#!/bin/bash
case "$DISPLAY_DRIVER" in

console)

    . "$BASE/src/displays/console.sh"

;;

pearl)

    . "$BASE/src/displays/pearl.sh"

;;

esac

############################################################
# Widgets
############################################################

display_title()
{
    display_line "$1"
    display_separator
}

display_value()
{
    printf -v LINE "%-10s %s" "$1" "$2"
    display_line "$LINE"
}

display_icon()
{
    display_line "$1 $2"
}

display_progress()
{
    VALUE="$1"
    MAX="$2"

    BAR=""

    I=0

    while [ "$I" -lt "$MAX" ]
    do
        if [ "$I" -lt "$VALUE" ]
        then
            BAR="${BAR}#"
        else
            BAR="${BAR}-"
        fi

        I=$((I+1))
    done

    display_line "[$BAR]"
}

display_clear()
{
    DISPLAY_BUFFER=""
}

display_line()
{
    DISPLAY_BUFFER="${DISPLAY_BUFFER}$1\n"
}

display_separator()
{
    display_line "------------------------------"
}

display_header()
{
    TIME="$(date +%H:%M)"

    display_line " FRITZ!View             $TIME"
    display_separator
}

display_footer()
{
    display_separator
}

display_end()
{
    display_driver_render "$DISPLAY_BUFFER"
}
