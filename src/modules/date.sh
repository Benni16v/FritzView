#!/bin/bash
#
# Date / Time Module
#

date_update()
{
    if date +%Y >/dev/null 2>&1
    then
        cache_write date "$(date '+%d.%m.%Y')"
        cache_write time "$(date '+%H:%M:%S')"
    else
        cache_write date "--.--.----"
        cache_write time "--:--:--"
    fi
}
