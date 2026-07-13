#!/bin/sh

page_wifi()
{
    display_clear
    display_header

    display_line "WLAN"
    display_separator

    wifi_show_ssids

    display_separator

    wifi_show_clients

    display_footer
    display_end
}
