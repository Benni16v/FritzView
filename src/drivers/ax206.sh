#!/bin/bash
############################################################
# AX206 Display Driver (Pearl / kompatible Bilderrahmen)
############################################################
AX206_BIN="$BASE/native/ax206/ax206_write"
AX206_RENDER="$BASE/native/ax206/render_screen.sh"
AX206_SCREEN_TXT="/tmp/fritzview/screen.txt"

driver_init()
{
    mkdir -p /tmp/fritzview
}

driver_render()
{
    if [ "$DEBUG_TERMINAL" = "true" ]; then
        clear
        printf "%b\n" "$1"
    fi
    printf "%b\n" "$1" > "$AX206_SCREEN_TXT"
    "$AX206_RENDER" "$AX206_SCREEN_TXT" "$DISPLAY_COLOR"
}

driver_render_image()
{
    local img="$1"
    local ppm="/tmp/fritzview/frame.ppm"
    mkdir -p /tmp/fritzview
    convert "$img" -resize 320x240! -depth 8 "$ppm"
    "$AX206_BIN" "$ppm"
}

driver_stop()   { :; }
driver_sleep()  { :; }
driver_wakeup() { :; }
driver_brightness() { :; }
driver_buttons()    { :; }
