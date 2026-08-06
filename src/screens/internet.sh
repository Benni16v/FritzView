#!/bin/bash
register_screen internet
page_internet()
{
    display_clear
    theme_header
    theme_title "Internet"
    theme_value "Status" "$(internet_status)"
    theme_value "IPv4"   "$(internet_ipv4)"
    DOWN=$(internet_sync_down)
    UP=$(internet_sync_up)
    [ -z "$DOWN" ] && DOWN="-"
    [ -z "$UP" ] && UP="-"
    theme_value "Down" "$DOWN"
    theme_value "Up"   "$UP"
    theme_footer
    display_render
}
