#!/bin/sh

page_network()
{
    display_clear
    display_header

    display_line "Netzwerk"
    display_separator

    display_line "WAN : $(wan_get_status)"
    display_line "IP  : $(wan_get_external_ip)"

    display_separator

    display_line "Hosts : $(hosts_count)"
    display_line "WLAN  : $(wifi_get_clients)"

    display_footer
    display_end
}
