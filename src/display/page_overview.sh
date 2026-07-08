page_overview()
{
    cache_read

    display_clear
    display_header

    display_line ""

    display_line "Router   : $SYSTEM_NAME"
    display_line "Firmware : $SYSTEM_VERSION"

    display_separator

    display_line "Internet : $WAN_STATUS"
    display_line "IP       : $WAN_IP"

    display_separator

    display_line "Hosts    : $HOSTS"
    display_line "WLAN     : $WIFI_CLIENTS"

    display_separator

    display_line "Uptime   : $SYSTEM_UPTIME"

    display_footer
}
