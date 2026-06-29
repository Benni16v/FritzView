#!/bin/sh
#
# ==========================================================
# FRITZ!View Cache Library
# ==========================================================

CACHE=${CACHE:-/var/tmp/fritzview}

cache_init()
{
    mkdir -p "$CACHE"
}

cache_write()
{
    local KEY="$1"
    shift

    mkdir -p "$(dirname "$CACHE/$KEY")"

    printf "%s\n" "$*" > "$CACHE/$KEY"
}

cache_read()
{
    local KEY="$1"

    [ -f "$CACHE/$KEY" ] && cat "$CACHE/$KEY"
}

cache_exists()
{
    [ -f "$CACHE/$1" ]
}

cache_delete()
{
    rm -f "$CACHE/$1"
}
