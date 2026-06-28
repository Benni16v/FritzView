#!/bin/sh
#
# Cache helper
#

cache_write()
{
    mkdir -p "$CACHE"
    printf "%s\n" "$2" > "$CACHE/$1"
}

cache_read()
{
    [ -f "$CACHE/$1" ] && cat "$CACHE/$1"
}

cache_exists()
{
    [ -f "$CACHE/$1" ]
}
