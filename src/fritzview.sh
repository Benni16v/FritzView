#!/bin/sh

BASE="$(cd "$(dirname "$0")/.." && pwd)"
export BASE

. "$BASE/src/init.sh"

display_init

while true
do
    cache_update
    page_overview
    sleep "$UPDATE_INTERVAL"
done
