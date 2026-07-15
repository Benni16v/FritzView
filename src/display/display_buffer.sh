#!/bin/bash

############################################################
# FritzView Display Buffer
############################################################

DISPLAY_BUFFER=""
DISPLAY_WIDTH=40
DISPLAY_HEIGHT=20

display_clear()
{
    DISPLAY_BUFFER=""
}

display_add()
{
    DISPLAY_BUFFER="${DISPLAY_BUFFER}$1\n"
}

display_line()
{
    DISPLAY_BUFFER="${DISPLAY_BUFFER}$1\n"
}

display_empty()
{
    display_add "|                                      |"
}

display_separator()
{
    display_add "+--------------------------------------+"
}

display_center()
{
    TEXT="$1"

    LEN=${#TEXT}

    PAD=$(( (40 - LEN) / 2 ))

    [ "$PAD" -lt 0 ] && PAD=0

    printf -v LEFT "%*s" "$PAD" ""

    printf -v RIGHT "%*s" $((40 - PAD - LEN)) ""

    display_add "${LEFT}${TEXT}${RIGHT}"
}

display_box()
{
    printf -v LINE '%*s' $((DISPLAY_WIDTH-2)) ''
    LINE=${LINE// /-}

    display_add "+${LINE}+"
}

display_render()
{
    display_driver_render "$DISPLAY_BUFFER"
}
