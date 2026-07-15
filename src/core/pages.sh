#!/bin/bash

page_overview()
{
    clear

    echo "=============================="
    echo "        FritzView"
    echo "=============================="

    echo
    echo "Router : $BOX_MODEL"
    echo "FW     : $BOX_FW"

    echo
    echo "Internet"

    echo "Status : $WAN_STATUS"
    echo "IP     : $WAN_IP"

    echo
    echo "LAN"

    echo "$NET_TYPE"

    echo
    echo "Clients: $HOSTS"

    echo
    echo "$LAST_EVENT"
}

page_wifi()
{
    clear

    echo "====== WLAN ======"

    echo
    echo "SSID     : $WIFI_SSID"
    echo "Channel  : $WIFI_CHANNEL"
    echo "Clients  : $WIFI_CLIENTS"
}

page_box()
{
    clear

    echo "====== BOX ======"

    echo
    echo "Model : $BOX_MODEL"
    echo "FW    : $BOX_FW"

    echo
    echo "Uptime"

    echo "$BOX_UPTIME s"
}
