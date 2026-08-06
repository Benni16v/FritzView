#!/bin/bash
############################################################
# Samsung SPF Display Driver
############################################################
SAMSUNG_BIN="$BASE/native/samsung/samsung_write"
SAMSUNG_RENDER="$BASE/native/samsung/render_screen.sh"
SAMSUNG_SCREEN_TXT="/tmp/fritzview/screen.txt"

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
    printf "%b\n" "$1" > "$SAMSUNG_SCREEN_TXT"
    "$SAMSUNG_RENDER" "$SAMSUNG_SCREEN_TXT" "$DISPLAY_COLOR"
}

driver_render_image()
{
    local img="$1"
    local jpg="/tmp/fritzview/frame_samsung.jpg"
    local w="${SAMSUNG_WIDTH:-800}"
    local h="${SAMSUNG_HEIGHT:-480}"
    mkdir -p /tmp/fritzview
    convert "$img" -resize "${w}x${h}!" -quality 90 "$jpg"
    "$SAMSUNG_BIN" "$jpg"
}

driver_stop()   { :; }
driver_sleep()  { :; }
driver_wakeup() { :; }
driver_brightness() { :; }
driver_buttons()    { :; }
