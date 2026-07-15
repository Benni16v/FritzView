#!/bin/bash
#
# ==========================================================
# FRITZ!View Authentication
# ==========================================================

SID=""
CHALLENGE=""
BLOCKTIME="0"

auth_init()
{
    auth_login
}

auth_login()
{
    local xml

    xml=$(curl -ks "http://$TR064_HOST/login_sid.lua")

    SID=$(echo "$xml" | sed -n 's:.*<SID>\(.*\)</SID>.*:\1:p')

    if [ "$SID" != "0000000000000000" ] && [ -n "$SID" ]; then
        log "Existing SID accepted."
        return 0
    fi

    CHALLENGE=$(echo "$xml" | sed -n 's:.*<Challenge>\(.*\)</Challenge>.*:\1:p')

    BLOCKTIME=$(echo "$xml" | sed -n 's:.*<BlockTime>\(.*\)</BlockTime>.*:\1:p')

    if [ "$BLOCKTIME" != "0" ]; then
        log "Login blocked for $BLOCKTIME seconds."
        return 1
    fi

    auth_login_pbkdf2
}

auth_login_pbkdf2()
{
    log "PBKDF2 login not implemented yet."

    return 1
}
