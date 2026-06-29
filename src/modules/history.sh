#!/bin/sh

ONLINEFILE="$CACHE/history/online"

history_update()
{

STATUS="$(cache_read wan_status)"

mkdir -p "$CACHE/history"

if [ "$STATUS" = "Connected" ]
then
    echo 1 >> "$ONLINEFILE"
else
    echo 0 >> "$ONLINEFILE"
fi

tail -288 "$ONLINEFILE" > "$ONLINEFILE.tmp"

mv "$ONLINEFILE.tmp" "$ONLINEFILE"

cache_write online_history "$(cat "$ONLINEFILE")"

}
