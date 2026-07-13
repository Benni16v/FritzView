#!/bin/sh

PAGE_COUNT=0
PAGE=1

register_page()
{
    PAGE_COUNT=$((PAGE_COUNT+1))

    eval PAGE_$PAGE_COUNT="$1"
}

page_show()
{
    eval NAME=\$PAGE_$PAGE

    page_"$NAME"
}

page_next()
{
    PAGE=$((PAGE+1))

    [ "$PAGE" -gt "$PAGE_COUNT" ] && PAGE=1
}

page_prev()
{
    PAGE=$((PAGE-1))

    [ "$PAGE" -lt 1 ] && PAGE="$PAGE_COUNT"
}

page_manager()
{
    page_show
    
    sleep "$PAGE_TIMEOUT"

    page_next

    sleep "$PAGE_TIMEOUT"
}
