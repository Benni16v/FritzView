#!/bin/bash

############################################################
# FritzView Initialization
############################################################

if [ -z "$BASE" ] || [ ! -d "$BASE/config" ]; then
    BASE="$(pwd)"
fi

export BASE

# detect sourcing
(return 0 2>/dev/null) && SOURCED=1 || SOURCED=0

fv_exit()
{
    CODE="$1"

    if [ "$SOURCED" = "1" ]
    then
        return "$CODE"
    else
        exit "$CODE"
    fi
}

############################################################
# Configuration
############################################################

. "$BASE/config/config.sh"

THEME=$(echo "$THEME" | tr '[:upper:]' '[:lower:]')
BOOT_THEME=$(echo "$BOOT_THEME" | tr '[:upper:]' '[:lower:]')

############################################################
# Libraries
############################################################

for file in "$BASE"/src/lib/*.sh
do
    [ -f "$file" ] && . "$file"
done

############################################################
# Modules
############################################################

for file in "$BASE"/src/modules/*.sh
do
    [ "$LOGLEVEL" -ge 2 ] && echo "Loading: $file"
    . "$file" || echo "ERROR loading $file"
done

#################################################
# Cache
############################################################

for file in "$BASE"/src/cache/*.sh
do
    [ -f "$file" ] && . "$file"
done

############################################################
# Display
############################################################

for file in "$BASE"/src/display/*.sh
do
    [ -f "$file" ] && . "$file"
done

############################################################
# Display Driver
############################################################

DRIVER="$BASE/src/displays/$DISPLAY_DRIVER.sh"

if [ -f "$DRIVER" ]
then
    . "$DRIVER"
else
    echo "Display driver '$DISPLAY_DRIVER' not found."
    return 1 2>/dev/null || exit 1
fi

############################################################
# Boot Screens
############################################################

for file in "$BASE"/src/boot/*.sh
do
    [ -f "$file" ] && . "$file"
done

############################################################
# Theme
############################################################

THEME_DIR="$BASE/themes/$THEME"

[ -f "$THEME_DIR/$THEME.sh" ] && . "$THEME_DIR/$THEME.sh"

############################################################
# Pages
############################################################

for file in "$BASE"/src/pages/*.sh
do
    [ -f "$file" ] && . "$file"
done

############################################################
# Debug
############################################################

debug_loaded()
{
    echo "FritzView initialized."
}
