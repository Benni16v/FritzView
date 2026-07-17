#!/bin/bash

DEVICE_DB="cache/device.db"

device_db_init()
{
    mkdir -p cache
    touch "$DEVICE_DB"
}

device_db_set()
{
    KEY="$1"
    VALUE="$2"

    grep -v "^$KEY=" "$DEVICE_DB" > "$DEVICE_DB.tmp"

    echo "$KEY=$VALUE" >> "$DEVICE_DB.tmp"

    mv "$DEVICE_DB.tmp" "$DEVICE_DB"
}

device_db_get()
{
    KEY="$1"

    grep "^$KEY=" "$DEVICE_DB" | head -1 | cut -d= -f2-
}
