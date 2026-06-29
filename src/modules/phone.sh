#!/bin/sh
#
# ==========================================================
# FRITZ!View Phone Module
# ==========================================================

phone_update()
{
    [ -f "$CACHE/phone/status" ] || echo "IDLE" > "$CACHE/phone/status"
    [ -f "$CACHE/phone/name" ]   || echo "" > "$CACHE/phone/name"
    [ -f "$CACHE/phone/number" ] || echo "" > "$CACHE/phone/number"

    cache_write phone/status "$(cat "$CACHE/phone/status")"
    cache_write phone/name   "$(cat "$CACHE/phone/name")"
    cache_write phone/number "$(cat "$CACHE/phone/number")"
}
