#!/bin/sh

SID="0000000000000000"

auth_init()
{
    SID="$(auth_login)"

    [ "$SID" = "0000000000000000" ] && {

        log "Authentication failed."

        return 1
    }

    log "SID: $SID"

    return 0
}
