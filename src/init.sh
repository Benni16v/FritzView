#!/bin/sh

############################################################
# FritzView Initialization
############################################################

if [ -z "$BASE" ]; then
    BASE="$(pwd)"
fi

export BASE

############################################################
# Configuration
############################################################

. "$BASE/config/config.sh"

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
    echo "Loading: $file"
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

if [ -f "$DRIVER" ]; then
    . "$DRIVER"
else
    echo "Display driver '$DISPLAY_DRIVER' not found."
    exit 1
fi

debug_loaded()
{
    echo "FritzView initialized."
}
