#!/bin/sh

BASE="$(cd "$(dirname "$0")/.." && pwd)"

. "$BASE/src/init.sh"

boot_start

display_driver_init

cache_update
page_manager


while true
do
    cache_update

    page_manager

    sleep "$UPDATE_INTERVAL"
done
