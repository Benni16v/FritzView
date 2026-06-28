#!/bin/sh
#
# ==========================================================
# FRITZ!View Core
#
# Main daemon
#
# Version 0.1 Genesis
#
# ==========================================================

VERSION="0.1"

BASE="/mod/etc/fritzview"

CACHE="/var/tmp/fritzview"

CONFIG="$BASE/config/config.sh"

############################################################

log()
{
    echo "[FRITZ!View] $*"
}

############################################################

init()
{
    log "Initializing..."

    mkdir -p "$CACHE"

    mkdir -p "$CACHE/system"
    mkdir -p "$CACHE/network"
    mkdir -p "$CACHE/history"
    mkdir -p "$CACHE/phone"

    log "Done."
}

############################################################

run()
{
    while true
    do

        sleep 5

    done
}

############################################################

shutdown()
{
    log "Shutdown."
}

############################################################

init

run

shutdown
