#!/bin/sh

widget_router()
{
    display_line "Router   : $SYSTEM_NAME"
    display_line "Firmware : $SYSTEM_VERSION"
}

widget_internet()
{
    display_line "Internet : $WAN_STATUS"
    display_line "IP       : $WAN_IP"
}

widget_network()
{
    display_line "Hosts    : $HOSTS"
    display_line "WLAN     : $WIFI_CLIENTS"
}

widget_uptime()
{
    display_line "Uptime   : $(format_time "$SYSTEM_UPTIME")"
}
