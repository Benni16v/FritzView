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
case "$OFFLINE_MODE" in
    true|1|yes)

        cache_write "system/model" "FRITZ!Box Dummy (Offline-Test)"
        cache_write "system/uptime" "42123"
        cache_write "network/wan_status" "Connected"
        cache_write "network/wan_ip" "127.0.0.1"
        cache_write "network/wifi_clients" "5"

        return 0
        ;;
esac
    
    cache_write "system/model"        "$(system_name)"
    cache_write "system/version"      "$(system_version)"
    cache_write "system/uptime"       "$(system_uptime)"

    cache_write "network/wan_status"  "$(wan_get_status)"
    cache_write "network/wan_ip"      "$(wan_get_external_ip)"

    cache_write "network/wifi_clients" "$(wifi_get_clients)"

    cache_write "phone/status"        "$(phone_status)"
    cache_write "phone/count"         "$(phone_count)"
    cache_write "phone/tam"           "$(tam_enabled)"
} 


