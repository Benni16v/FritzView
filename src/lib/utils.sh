#!/bin/bash

is_online()
{
    [ "$(cache_read wan_ip)" != "0.0.0.0" ]
}

uptime_seconds()
{
    cut -d. -f1 /proc/uptime
}

format_time()
{
    SEC="$1"

    H=$((SEC/3600))
    M=$(((SEC%3600)/60))
    S=$((SEC%60))

    printf "%02d:%02d:%02d\n" "$H" "$M" "$S"
}

trim()
{
    sed 's/^ *//;s/ *$//'
}

kb_to_mbit()
{
    awk '{printf "%.1f",$1/1000}'
}

sec_to_time()
{
    local SEC="$1"

    printf "%02d:%02d:%02d" \
        $((SEC/3600)) \
        $(((SEC%3600)/60)) \
        $((SEC%60))
}

############################################################
# Sekunden -> 27T 04:18
############################################################

format_uptime()
{
    local SEC="$1"

    [ -z "$SEC" ] && {
        echo "-"
        return
    }

    local DAYS=$((SEC/86400))
    local HOURS=$(((SEC%86400)/3600))
    local MINS=$(((SEC%3600)/60))

    printf "%dT %02d:%02d" \
        "$DAYS" "$HOURS" "$MINS"
}
