#!/bin/bash
set -e

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

TEXT_FILE="${1:-/tmp/fritzview/screen.txt}"
COLOR="${2:-white}"
WIDTH="${SAMSUNG_WIDTH:-800}"
HEIGHT="${SAMSUNG_HEIGHT:-480}"
JPG_FILE="/tmp/fritzview/screen_samsung.jpg"
FONT="DejaVu-Sans-Mono"

mkdir -p /tmp/fritzview

if [ -n "$FV_POINTSIZE_SAMSUNG" ]; then
    POINTSIZE="$FV_POINTSIZE_SAMSUNG"
else
    CACHE_FILE="/tmp/fritzview/pointsize_samsung_${WIDTH}x${HEIGHT}.cache"
    if [ -f "$CACHE_FILE" ]; then
        POINTSIZE="$(cat "$CACHE_FILE")"
    else
        REF="0123456789012345678901234567890123456789"
        CALIB=100
        MEASURED_WIDTH=$(convert -font "$FONT" -pointsize "$CALIB" label:"$REF" -format "%w" info:)
        POINTSIZE=$(awk -v c="$CALIB" -v w="$WIDTH" -v m="$MEASURED_WIDTH" 'BEGIN{printf "%.1f", (c*w/m)*0.97}')
        echo "$POINTSIZE" > "$CACHE_FILE"
    fi
fi

TEXT_CONTENT="$(cat "$TEXT_FILE")"
TEXT_CONTENT="${TEXT_CONTENT//%/%%}"

convert -size "${WIDTH}x${HEIGHT}" xc:black \
    -font "$FONT" \
    -pointsize "$POINTSIZE" \
    -fill "$COLOR" \
    -gravity NorthWest \
    -annotate +2+2 "$TEXT_CONTENT" \
    -quality 90 \
    "$JPG_FILE"

"$SCRIPT_DIR/samsung_write" "$JPG_FILE"

mkdir -p "$SCRIPT_DIR/../../webif"
convert "$JPG_FILE" "$SCRIPT_DIR/../../webif/screen.png"
