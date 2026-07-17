#!/bin/bash

page_wifi()
{
    display_clear

    theme_header
    theme_title "WLAN"

    theme_value "Status" "$(wifi_status)"
    theme_value "2.4 GHz" "$(wifi24_clients)"
    theme_value "5 GHz"   "$(wifi5_clients)"
    theme_value "Clients" "$(wifi_get_clients)"

    theme_footer

    display_render
}
