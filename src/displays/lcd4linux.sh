#!/bin/sh

############################################################
# LCD4Linux Driver
############################################################

display_render()
{
    printf "%b" "$1" >/tmp/fritzview.txt

    # später:
    # convert ...
    # lcd4linux reload
}
