#!/bin/sh

PAGE=0

page_next()
{
    PAGE=$((PAGE+1))

    [ "$PAGE" -gt 2 ] && PAGE=0
}

page_prev()
{
    PAGE=$((PAGE-1))

    [ "$PAGE" -lt 0 ] && PAGE=2
}

page_draw()
{
    case "$PAGE" in

        0)
            page_overview
        ;;

        1)
            page_wifi
        ;;

        2)
            page_box
        ;;

    esac
}
