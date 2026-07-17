#!/bin/bash

############################################################
# FritzView Configuration
############################################################

if [ -z "$BASE" ]; then
    BASE="$(pwd)"
fi

############################################################
# Boot Theme
############################################################

LAYOUT_FILE="$BASE/config/layout.conf"

[ -f "$LAYOUT_FILE" ] && . "$LAYOUT_FILE"

BOOT_THEME="avm"

# avm
# terminal
# bios
# matrix

############################################################
# TR-064
############################################################

TR064_HOST="192.168.178.1"
TR064_PORT="49443"

############################################################
# Credentials
############################################################

CRED_FILE="$BASE/config/credentials.conf"

if [ -f "$CRED_FILE" ]; then
    . "$CRED_FILE"
fi

#################################################
# Pearl
#################################################

DISPLAY_NAME="Pearl"

PEARL_DEVICE="/dev/dpf0"

PEARL_WIDTH="320"
PEARL_HEIGHT="240"

UPDATE_INTERVAL=5

THEME="avm"

LOGLEVEL=1

############################################################
# Display
############################################################

DISPLAY_DRIVER="lcd4linux"

PAGE_TIMEOUT=5

PAGES="
overview
internet
wifi
hosts
system
"

############################################################
# LCD4Linux
############################################################

LCD_NAME="dpf"

LCD_DRIVER="DPF"

LCD_PORT="usb0"

LCD_FONT="8x10"

LCD_FOREGROUND="ffffff"

LCD_BACKGROUND="222222"

LCD_BASECOLOR="222222"

LCD_LAYOUT="fritzview"

# Auf "true" stellen, wenn du unterwegs ohne Router testest
: "${OFFLINE_MODE:=true}"
