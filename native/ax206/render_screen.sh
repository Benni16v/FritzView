#!/bin/bash
set -e

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

TEXT_FILE="${1:-/tmp/fritzview/screen.txt}"
COLOR="${2:-white}"
PPM_FILE="/tmp/fritzview/screen.ppm"
WIDTH=320
HEIGHT=240
FONT="DejaVu-Sans-Mono"

mkdir -p /tmp/fritzview

if [ -n "$FV_POINTSIZE" ]; then
    POINTSIZE="$FV_POINTSIZE"
else
    SAFETY_MARGIN="${FV_SAFETY_MARGIN:-0.97}"
    CACHE_FILE="/tmp/fritzview/pointsize_${WIDTH}x${HEIGHT}_${SAFETY_MARGIN}.cache"
    if [ -f "$CACHE_FILE" ]; then
        POINTSIZE="$(cat "$CACHE_FILE")"
    else
        REF="0123456789012345678901234567890123456789"
        CALIB=100
        MEASURED_WIDTH=$(convert -font "$FONT" -pointsize "$CALIB" label:"$REF" -format "%w" info:)
        POINTSIZE=$(awk -v c="$CALIB" -v w="$WIDTH" -v m="$MEASURED_WIDTH" -v s="$SAFETY_MARGIN" 'BEGIN{printf "%.2f", (c*w/m)*s}')
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
    -depth 8 \
    "$PPM_FILE"

"$SCRIPT_DIR/ax206_write" "$PPM_FILE"

mkdir -p "$SCRIPT_DIR/../../webif"
convert "$PPM_FILE" "$SCRIPT_DIR/../../webif/screen.png"
