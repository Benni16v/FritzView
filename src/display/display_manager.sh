#!/bin/bash

############################################################
# FritzView Display Manager
############################################################

CURRENT_PAGE=boot
CURRENT_OVERLAY=""
DISPLAY_CURRENT=""
DISPLAY_PREVIOUS=""
DISPLAY_OVERLAY=""

############################################################
# Seite anzeigen
############################################################

display_show()
{
    PAGE="$1"

    CURRENT_PAGE="$PAGE"
    DISPLAY_CURRENT="$PAGE"

    if [ "$PAGE" = "boot" ]
    then
        boot_screen
        return
    fi

    FUNC="page_$PAGE"

    if type "$FUNC" >/dev/null 2>&1
    then
        "$FUNC"
    else
        display_center "Page not found"
        display_center "$PAGE"
        display_render
    fi
}

############################################################
# Overlay anzeigen
############################################################

display_overlay()
{
    case "$1" in

        call)

            CURRENT_OVERLAY=call

            theme_overlay_call

        ;;

    esac
}

############################################################
# Overlay schließen
############################################################

display_overlay_close()
{
    CURRENT_OVERLAY=""

    display_show "$CURRENT_PAGE"
}

############################################################
# Nächste Seite
############################################################

display_next()
{
    case "$DISPLAY_CURRENT" in

        home)
            display_show internet
        ;;

        internet)
            display_show fritzbox
        ;;

        fritzbox)
            display_show system
        ;;

        system)
            display_show home
        ;;

        *)
            display_show home
        ;;

    esac
}

############################################################
# Vorherige Seite
############################################################

display_previous()
{
    case "$DISPLAY_CURRENT" in

        home)
            display_show system
        ;;

        internet)
            display_show home
        ;;

        fritzbox)
            display_show internet
        ;;

        system)
            display_show fritzbox
        ;;

        *)
            display_show home
        ;;

    esac
}
