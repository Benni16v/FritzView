#!/bin/bash
#
# ==========================================================
# Display
# ==========================================================

display_write()
{
    local key="$1"
    local value="$2"

    cache_write "display/$key" "$value"
}

display_refresh()
{
    display_write ip      "$(cache_read network/wan_ip)"
    display_write ram     "$(cache_read system/ram)%"
    display_write cpu     "$(cache_read system/cpu)%"
    display_write temp    "$(cache_read system/temp)"
    display_write dsl     "$(cache_read network/dsl_down)/$(cache_read network/dsl_up)"
    display_write crc     "$(cache_read network/crc)"
    display_write online  "$(cache_read network/online)"
}
