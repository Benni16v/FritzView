#!/bin/bash

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
BASE="$(cd "$SCRIPT_DIR/.." && pwd)"

export BASE

. "$BASE/src/init.sh"

display_driver_init

boot_screen

cache_update

display_show home

sleep 2


while true
do

    cache_update

    display_show home
    sleep 5

    display_show internet
    sleep 5

    display_show phone
    sleep 5
    
     display_show wifi
    sleep 5

    display_show mesh
    sleep 5

    display_show system
    sleep 5

done
