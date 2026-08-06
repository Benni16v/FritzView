#!/bin/bash
############################################################
# FritzView Display Manager
#
# Verwaltet, welcher Screen ("page_<name>") gerade aktiv ist,
# und ruft die passende Funktion auf. Die eigentlichen Screens
# liegen in src/screens/*.sh (ueber register_screen angemeldet).
############################################################
CURRENT_PAGE="overview"

# Zeigt den Screen mit dem angegebenen Namen an, z.B.
# display_show "internet" -> ruft page_internet auf.
display_show()
{
    local PAGE="$1"
    local FUNC="page_${PAGE}"

    if declare -F "$FUNC" >/dev/null
    then
        CURRENT_PAGE="$PAGE"
        DISPLAY_CURRENT="$PAGE"
        display_clear
        "$FUNC"
        display_render
    else
        display_clear
        display_center "Page not found"
        display_center "$PAGE"
        display_render
    fi
}

# Zeigt den aktuell gemerkten Screen erneut an (z.B. nach
# einem Cache-Update, ohne den Screen zu wechseln).
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
