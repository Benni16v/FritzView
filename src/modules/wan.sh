#!/bin/sh

wan_update()
{
    cache_write wan_ip "$(tr064_get_wan_ip)"

    XML="$(tr064_get_status)"

    cache_write wan_status \
        "$(echo "$XML" | xml "<NewConnectionStatus>")"

    cache_write uptime \
        "$(echo "$XML" | xml "<NewUptime>")"

    log "WAN updated."
}
