#!/bin/bash

############################################################
# Display Widgets
############################################################

display_title()
{
    printf -v LINE "| %-36s |" "$1"
    display_line "$LINE"
    display_separator
}

display_value()
{
    printf -v LINE "| %-12s %22s |" "$1" "$2"
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

display_nav()
{
    local LEFT="< $1"
    local CENTER="$2"
    local RIGHT="$3 >"

    local WIDTH=37

    local L=${#LEFT}
    local C=${#CENTER}
    local R=${#RIGHT}

    local FREE=$((WIDTH-L-C-R))

    local GAP1=$((FREE/2))
    local GAP2=$((FREE-GAP1))

    printf -v TEXT "%s%*s%s%*s%s" \
        "$LEFT" \
        "$GAP1" "" \
        "$CENTER" \
        "$GAP2" "" \
        "$RIGHT"

    # Nur auffüllen, NICHT abschneiden!
    printf -v LINE "|%-37s|" "$TEXT"
echo "'$LINE'"
echo "LEN=${#LINE}"
    display_line "$LINE"
}

display_header()
{
    display_separator
    printf -v LINE "| %-36s |" "FRITZ!View"
    display_line "$LINE"
    display_separator
}

display_footer()
{
    display_separator
}
