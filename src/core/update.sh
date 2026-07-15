#!/bin/bash

update_all()
{
    WAN_IP="$(wan_get_external_ip)"
    WAN_STATUS="$(wan_get_status)"
    WAN_UPTIME="$(wan_get_uptime)"

    BOX_MODEL="$(box_get_model)"
    BOX_FW="$(box_get_software)"
    BOX_UPTIME="$(box_get_uptime)"

    WIFI_SSID="$(wifi_get_ssid)"
    WIFI_CHANNEL="$(wifi_get_channel)"
    WIFI_CLIENTS="$(wifi_get_clients)"

    NET_TYPE="$(network_get_connection)"
    NET_STATUS="$(network_get_layer1)"

    HOSTS="$(hosts_count)"

    LAST_EVENT="$(history_last)"
}
