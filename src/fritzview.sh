#!/bin/bash

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
BASE="$(cd "$SCRIPT_DIR/.." && pwd)"

export BASE

# Offline-Modus von außen übernehmen
OFFLINE_MODE="${OFFLINE_MODE:-false}"
export OFFLINE_MODE

. "$BASE/src/init.sh"

display_driver_init

boot_screen

cache_update

display_show "$(screen_current)"

while true
do
    sleep 5

    cache_update

    screen_next
done
