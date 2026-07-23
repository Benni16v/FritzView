#!/bin/bash

############################################################
# FritzView Display API
############################################################

display_clear()
{
    buffer_clear
}

display_add()
{
    buffer_add "$1"
}

display_line()
{
    buffer_add "$1"
}

display_separator()
{
    display_line "------------------------------"
}

display_center()
{
    local TEXT="$1"
    local LEN=${#TEXT}
    local PAD=$(( (DISPLAY_WIDTH - LEN) / 2 ))

    [ "$PAD" -lt 0 ] && PAD=0

    printf -v LEFT "%*s" "$PAD" ""
    printf -v RIGHT "%*s" $((DISPLAY_WIDTH - PAD - LEN)) ""

    display_line "${LEFT}${TEXT}${RIGHT}"
}

display_render()
{
    display_driver_render "$(buffer_get)"
}
