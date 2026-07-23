#!/bin/bash

register_screen network

page_network()
{
    display_clear

    theme_header
    theme_title "Netzwerk"

    theme_value "WAN" "$(internet_status)"
    theme_value "IPv4" "$(wan_ip)"
    theme_value "Hosts" "$(host_count)"
    theme_value "WLAN" "$(wifi_clients)"

    theme_footer

    display_render
}
