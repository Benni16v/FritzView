#!/bin/bash
# src/displays/pearl.sh

############################################################
# Pearl Display Driver (Freetz-NG LCD4Linux)
############################################################

display_driver_init()
{
    # Stelle sicher, dass der Display-Cache-Ordner existiert
    mkdir -p "/var/tmp/fritzview/display"
}

display_driver_render()
{
    # Text-Render für LCD4Linux (schreibt den Buffer in eine Datei)
    echo -e "$1" > "/var/tmp/fritzview/display/text.txt"
}

display_driver_render_image()
{
    # Bild-Render (kopiert das aktuelle Frame dorthin, wo LCD4Linux es erwartet)
    local source_img="$1"
    
    if [ -f "$source_img" ]; then
        cp "$source_img" "/var/tmp/fritzview/display/current_boot.png"
    fi
}
