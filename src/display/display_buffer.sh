#!/bin/bash

############################################################
# FritzView Display Buffer
############################################################

DISPLAY_BUFFER=""
DISPLAY_WIDTH=40
DISPLAY_HEIGHT=20

buffer_clear()
{
    DISPLAY_BUFFER=""
}

buffer_add()
{
    DISPLAY_BUFFER="${DISPLAY_BUFFER}$1\n"
}

buffer_get()
{
    printf "%b" "$DISPLAY_BUFFER"
}
