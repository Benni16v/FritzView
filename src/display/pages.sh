#!/bin/sh

PAGES="
overview
wlan
internet
system
hosts
"

PAGE=1

page_show()
{
    NAME="$1"

    case "$NAME" in
        overview) page_overview ;;
        wlan)     page_wlan ;;
        internet) page_internet ;;
        system)   page_system ;;
        hosts)    page_hosts ;;
    esac
}

page_next()
{
    PAGE=$((PAGE+1))

    COUNT=$(echo "$PAGES" | wc -w)

    [ "$PAGE" -gt "$COUNT" ] && PAGE=1

    page_current
}

page_prev()
{
    PAGE=$((PAGE-1))

    COUNT=$(echo "$PAGES" | wc -w)

    [ "$PAGE" -lt 1 ] && PAGE="$COUNT"

    page_current
}

page_current()
{
    NAME=$(echo "$PAGES" | awk "{print \$$PAGE}")

    page_show "$NAME"
}
