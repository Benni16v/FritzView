#!/bin/sh
#
# ==========================================================
# FRITZ!View System Module
# ==========================================================

system_update()
{
    CPU=$(grep "cpu " /proc/stat)

    MEM_TOTAL=$(grep MemTotal /proc/meminfo | awk '{print $2}')
    MEM_FREE=$(grep MemAvailable /proc/meminfo | awk '{print $2}')

    RAM=$((100-(MEM_FREE*100/MEM_TOTAL)))

    cache_write ram "$RAM"

    LOAD=$(cut -d' ' -f1 /proc/loadavg)

    cache_write cpu "$LOAD"

    if [ -f /sys/class/thermal/thermal_zone0/temp ]
    then
        TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
        TEMP=$((TEMP/1000))
    else
        TEMP="--"
    fi

    cache_write temp "$TEMP"

    log "System updated."
}
