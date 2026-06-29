#!/bin/sh

CALLCACHE="/var/tmp/fritzview/phone"

mkdir -p "$CALLCACHE"

nc -l -p 1012 | while IFS=';' read TYPE DATE ID EXT INT NUMBER NAME DURATION
do

    case "$TYPE" in

        RING)

            echo "RING" > "$CALLCACHE/status"

            echo "$NUMBER" > "$CALLCACHE/number"

            echo "$NAME" > "$CALLCACHE/name"

        ;;

        CALL)

            echo "CALL" > "$CALLCACHE/status"

        ;;

        CONNECT)

            echo "CONNECT" > "$CALLCACHE/status"

        ;;

        DISCONNECT)

            echo "IDLE" > "$CALLCACHE/status"

            echo "" > "$CALLCACHE/name"

            echo "" > "$CALLCACHE/number"

        ;;

    esac

done
