#!/bin/bash
#
# ==========================================================
# Cache Library
# ==========================================================

CACHE="/var/tmp/fritzview"

cache_init()
{
    mkdir -p "$CACHE"

    mkdir -p "$CACHE/system"
    mkdir -p "$CACHE/network"
    mkdir -p "$CACHE/phone"
    mkdir -p "$CACHE/history"
    mkdir -p "$CACHE/display"
}

cache_write()
{
    local key="$1"
    local value="$2"

    mkdir -p "$(dirname "$CACHE/$key")"

    echo "$value" > "$CACHE/$key"
}

cache_read()
{
    local key="$1"

    [ -f "$CACHE/$key" ] || {
        echo ""
        return
    }

    cat "$CACHE/$key"
}

cache_exists()
{
    [ -f "$CACHE/$1" ]
}

cache_delete()
{
    rm -f "$CACHE/$1"
}

cache_get()
{
    cache_read "$@"
}

cache_update()
{
    if [[ "$OFFLINE_MODE" == "true" ]]; then
        # Wir schreiben einfach Dummy-Werte in den Cache,
        # damit die Seiten nicht leer  sind und wir was auf dem Display sehen!
        cache_write "system/model" "FRITZ!Box Dummy (Offline-Test)"
        cache_write "system/uptime" "42123"
        cache_write "network/wan_status" "Connected"
        cache_write "network/wan_ip" "127.0.0.1"
        cache_write "network/wifi_clients" "5"
        return  0
    fi
    
    # Prüft, wo fetch_data.sh liegt und führt es aus
    if [ -f "$BASE/fetch_data.sh" ]; then
        bash "$BASE/fetch_data.sh"
    elif [ -f "$BASE/src/fetch_data.sh" ]; then
        bash "$BASE/src/fetch_data.sh"
    else
        echo "[Cache] fetch_data.sh nicht gefunden!"
    fi
}
