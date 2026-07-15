#!/bin/bash
#
# ==========================================================
# Cache Library
# ==========================================================

CACHE="/var/tmp/fritzview"

cache_init()
{
    mkdir -p "$CACHE"

    mkdir -p "$CACHE/system"
    mkdir -p "$CACHE/network"
    mkdir -p "$CACHE/phone"
    mkdir -p "$CACHE/history"
    mkdir -p "$CACHE/display"
}

cache_write()
{
    local key="$1"
    local value="$2"

    mkdir -p "$(dirname "$CACHE/$key")"

    echo "$value" > "$CACHE/$key"
}

cache_read()
{
    local key="$1"

    [ -f "$CACHE/$key" ] || {
        echo ""
        return
    }

    cat "$CACHE/$key"
}

cache_exists()
{
    [ -f "$CACHE/$1" ]
}

cache_delete()
{
    rm -f "$CACHE/$1"
}

cache_get()
{
    cache_read "$@"
}
