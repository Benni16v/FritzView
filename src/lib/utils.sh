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
