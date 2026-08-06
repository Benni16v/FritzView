#!/bin/bash
############################################################
# FritzView Display Buffer
#
# Haelt den aktuellen Bildschirminhalt als einfachen Text-
# Puffer (Zeile fuer Zeile) sowie die aktuell aktive Farbe.
# Wird von jedem Screen ueber display_clear/display_line neu
# befuellt und am Ende per display_render an den aktiven
# Treiber (src/drivers/*.sh) uebergeben.
############################################################
DISPLAY_BUFFER=""
DISPLAY_WIDTH=40
DISPLAY_HEIGHT=20
DISPLAY_COLOR="white"

# Leert den Puffer und setzt die Farbe auf den Standard zurueck.
# Muss von JEDEM Screen als erstes aufgerufen werden, sonst
# haengen Zeilen/Farben vom vorherigen Screen noch dran.
buffer_clear()
{
    DISPLAY_BUFFER=""
    DISPLAY_COLOR="${DISPLAY_COLOR_DEFAULT:-white}"
}

# Haengt eine Zeile Text an den Puffer an (inkl. Zeilenumbruch).
buffer_add()
{
    DISPLAY_BUFFER+="$1"$'\n'
}

# Gibt den kompletten Puffer als einen String zurueck.
buffer_get()
{
    printf "%b" "$DISPLAY_BUFFER"
}webif/cgi-bin/save.sh
