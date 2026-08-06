#!/bin/bash
SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
BASE="$(cd "$SCRIPT_DIR/.." && pwd)"
export BASE
export LC_ALL=C.UTF-8

. "$BASE/src/init.sh"
driver_init
boot_screen
# Initiales Cache-Update beim Start
cache_update &
COUNTER=0
while true
do
    # 1. Alle 4 Sekunden automatisch den naechsten Screen ansteuern
    if [ $((COUNTER % 4)) -eq 0 ]; then
        screen_next
    fi
    # 2. Nur alle 30 Sekunden ein Cache-Update im Hintergrund erlauben
    if [ $COUNTER -gt 0 ] && [ $((COUNTER % 30)) -eq 0 ]; then
        cache_update &
    fi
    PAGE="$(screen_current)"
    [ -z "$PAGE" ] && PAGE="overview"
    display_clear
    if declare -f "page_${PAGE}" >/dev/null; then
        "page_${PAGE}"
    else
        page_overview
    fi
    display_render
    COUNTER=$((COUNTER + 1))
    sleep 1
done
