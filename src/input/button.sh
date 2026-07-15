#!/bin/bash

button_left()
{
    PAGE=$((PAGE-1))

    [ "$PAGE" -lt 1 ] && PAGE=$(echo "$PAGES" | wc -w)
}

button_right()
{
    PAGE=$((PAGE+1))

    COUNT=$(echo "$PAGES" | wc -w)

    [ "$PAGE" -gt "$COUNT" ] && PAGE=1
}

button_menu()
{
    MENU=1
}
