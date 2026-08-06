#!/bin/bash
############################################################
# FritzView Menu System
############################################################

MENU_ENTRY=1

MENU_ITEMS="
Overview
Netzwerk
WLAN
Telefonie
System
Speicher
Mesh
Einstellungen
"

menu_show()
{
    display_clear
    display_header
    
    local NR=1

    echo "$MENU_ITEMS" |
    while read -r ITEM
    do
        [ -z "$ITEM" ] && continue

        if [ "$MENU_ENTRY" = "$NR" ]
        then
            display_line "> $ITEM"
        else
            display_line "  $ITEM"
        fi

        NR=$((NR+1))
    done

    display_footer
    display_end
}

############################################################
# Menu Navigation
############################################################

menu_prev()
{
    MENU_ENTRY=$((MENU_ENTRY-1))
    [ "$MENU_ENTRY" -lt 1 ] && MENU_ENTRY=8
    menu_show
}

menu_next()
{
    MENU_ENTRY=$((MENU_ENTRY+1))
    [ "$MENU_ENTRY" -gt 8 ] && MENU_ENTRY=1
    menu_show
}

menu_enter()
{
    echo "Menu ausgewählt: $MENU_ENTRY"
}
