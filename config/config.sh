#!/bin/bash
############################################################
# FritzView Configuration Loader
############################################################
if [ -z "$BASE" ]; then
    BASE="$(pwd)"
fi
# Standardwerte setzen
TR064_HOST="192.168.178.1"
TR064_PORT="49443"
TR064_USER=""
TR064_PASS=""

THEME="avm"
BOOT_THEME="avm"

DISPLAY_NAME="Pearl"
DISPLAY_DRIVER="ax206"
PEARL_DEVICE="/dev/dpf0"
PEARL_WIDTH="320"
PEARL_HEIGHT="240"

SAMSUNG_WIDTH="800"
SAMSUNG_HEIGHT="480"
UPDATE_INTERVAL=5

LOGLEVEL=1

: "${OFFLINE_MODE:=false}"
PAGE_TIMEOUT=5

DEBUG_TERMINAL="true"

PAGES="
overview
internet
wifi
hosts
system
"
# Benutzer-Einstellungen laden (überschreibt Standardwerte)
CRED_FILE="$BASE/config/credentials.conf"
if [ -f "$CRED_FILE" ]; then
    . "$CRED_FILE"
fi
# Werte formatieren
THEME=$(echo "$THEME" | tr '[:upper:]' '[:lower:]')
BOOT_THEME=$(echo "$BOOT_THEME" | tr '[:upper:]' '[:lower:]')
