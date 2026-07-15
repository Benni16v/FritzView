#!/bin/bash
#
# ==========================================================
# FRITZ!View Core
#
# Main Daemon
#
# Version 0.1 Genesis
#
# ==========================================================

VERSION="0.1"

BASE="/mod/etc/fritzview/src"

CACHE="/var/tmp/fritzview"

CONFIG="$BASE/scripts/config.sh"

############################################################
# Libraries
############################################################

. "$BASE/lib/logger.sh"
. "$BASE/lib/cache.sh"
. "$BASE/lib/utils.sh"
. "$BASE/lib/tr064.sh"

############################################################
# Core
############################################################

. "$BASE/core/auth.sh"
. "$BASE/core/display.sh"
. "$BASE/core/scheduler.sh"
. "$BASE/core/pages.sh"
. "$BASE/core/callmonitor.sh"

############################################################
# Modules
############################################################

. "$BASE/modules/wan.sh"
. "$BASE/modules/dsl.sh"
. "$BASE/modules/system.sh"
. "$BASE/modules/tam.sh"
. "$BASE/modules/update.sh"
. "$BASE/modules/history.sh"

############################################################

init()
{
    log "Initializing..."

    mkdir -p "$CACHE"

    mkdir -p "$CACHE/display"
    mkdir -p "$CACHE/system"
    mkdir -p "$CACHE/network"
    mkdir -p "$CACHE/history"
    mkdir -p "$CACHE/phone"

    cache_init

    # Anmeldung an der FRITZ!Box
    auth_init

    log "Done."
}

############################################################

run()
{
    log "Starting Scheduler..."

    scheduler_loop
}

############################################################

shutdown()
{
    log "Shutdown."
}

############################################################

init

"$BASE/core/callmonitor.sh" &

scheduler_run

shutdown
