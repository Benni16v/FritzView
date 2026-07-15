#!/bin/bash

wifi_band_request()
{
    BAND="$1"

    tr064_request \
        "urn:dslforum-org:service:WLANConfiguration:${BAND}" \
        "/upnp/control/wlanconfig${BAND}" \
        "GetTotalAssociations" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetTotalAssociations xmlns:u="urn:dslforum-org:service:WLANConfiguration:'"$BAND"'"/>
</s:Body>
</s:Envelope>'
}


wifi_band_info()
{
    BAND="$1"

    tr064_request \
        "urn:dslforum-org:service:WLANConfiguration:${BAND}" \
        "/upnp/control/wlanconfig${BAND}" \
        "GetInfo" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetInfo xmlns:u="urn:dslforum-org:service:WLANConfiguration:'"$BAND"'"/>
</s:Body>
</s:Envelope>'
}

wifi_band_exists()
{
    BAND="$1"

    RESULT="$(wifi_band_info "$BAND")"

    echo "$RESULT" | grep -q "<NewSSID>"
}

wifi_band_clients()
{
    BAND="$1"

    wifi_band_request "$BAND" |
    xml_value NewTotalAssociations
}

wifi_show_clients()
{
    TOTAL=0

    for BAND in 1 2 3 4 5
    do
        if wifi_band_exists "$BAND"
        then
            CLIENTS="$(wifi_band_clients "$BAND")"

            case "$BAND" in
                1) NAME="2.4 GHz" ;;
                2) NAME="5 GHz" ;;
                3) NAME="Gast" ;;
                4) NAME="6 GHz" ;;
                5) NAME="7 GHz" ;;
            esac

            printf "%-8s : %s\n" "$NAME" "$CLIENTS"

            TOTAL=$((TOTAL + CLIENTS))
        fi
    done

    echo "------------------------------"
    echo "Gesamt   : $TOTAL"
}

wifi_get_enabled()
{
    wifi_band_info 1 | xml_value NewEnable
}

wifi_get_status()
{
    wifi_band_info 1 | xml_value NewStatus
}

wifi_band_ssid()
{
    BAND="$1"

    wifi_band_info "$BAND" |
    xml_value NewSSID
}

wifi_get_channel()
{
    wifi_band_info 1 | xml_value NewChannel
}

wifi_get_auto_channel()
{
    wifi_band_info 1 | xml_value NewAutoChannelEnable
}

wifi_get_standard()
{
    wifi_band_info 1 | xml_value NewStandard
}

wifi_get_bandwidth()
{
    wifi_band_info 1 | xml_value NewX_AVM_DE_Bandwidth
}

wifi_get_max_bitrate()
{
    wifi_band_info 1 | xml_value NewMaxBitRate
}

wifi_get_ssid_hidden()
{
    wifi_band_info 1 | xml_value NewSSIDAdvertisementEnabled
}

wifi_get_mac_filter()
{
    wifi_band_info 1 | xml_value NewMACAddressControlEnabled
}

wifi_get_wps()
{
    wifi_band_info 1 | xml_value NewX_AVM_DE_WPSStatus
}

wifi_get_wps_enable()
{
    wifi_band_info 1 | xml_value NewX_AVM_DE_WPSEnable
}

wifi_get_encryption()
{
    wifi_band_info 1 | xml_value NewBeaconType
}

wifi_get_auth_mode()
{
    wifi_band_info 1 | xml_value NewBasicAuthenticationMode
}

wifi24_ssid()
{
    wifi_band_ssid 1
}

wifi5_ssid()
{
    wifi_band_ssid 2
}

wifi6_ssid()
{
    wifi_band_ssid 4
}

wifi7_ssid()
{
    wifi_band_ssid 5
}

wifi_guest_ssid()
{
    wifi_band_ssid 3
}

wifi_get_clients()
{
    TOTAL=0

    for BAND in 1 2 3 4 5
    do
        if wifi_band_exists "$BAND"
        then
            CLIENTS="$(wifi_band_clients "$BAND")"
            TOTAL=$((TOTAL + CLIENTS))
        fi
    done

    echo "$TOTAL"
}

wifi_print_ssids()
{
    for BAND in 1 2 3 4 5
    do
        SSID="$(wifi_band_ssid "$BAND")"

        [ -z "$SSID" ] && continue

        case "$BAND" in
            1) NAME="2.4 GHz" ;;
            2) NAME="5 GHz" ;;
            3) NAME="Gast" ;;
            4) NAME="6 GHz" ;;
            5) NAME="Band 5" ;;
        esac

        printf "%-9s : %s\n" "$NAME" "$SSID"
    done
}

wifi_show_ssids()
{
    for BAND in 1 2 3 4 5
    do
        if wifi_band_exists "$BAND"
        then
            case "$BAND" in
                1) NAME="2.4 GHz" ;;
                2) NAME="5 GHz" ;;
                3) NAME="Gast" ;;
                4) NAME="6 GHz" ;;
                5) NAME="7 GHz" ;;
            esac

            printf "%-8s : %s\n" \
                "$NAME" \
                "$(wifi_band_ssid "$BAND")"
        fi
    done
}

############################################################
# Guest WLAN
############################################################

wifi_guest_enabled()
{
    wifi_band_info 3 | xml_value NewEnable
}

wifi_guest_get_ssid()
{
    wifi_band_info 3 | xml_value NewSSID
}

############################################################
# Diagnose
############################################################

wifi_dump()
{
    wifi_band_info 1
}

############################################################
# WLAN Übersicht
############################################################

wifi_info()
{
    echo "=============================="
    echo " WLAN"
    echo "=============================="
    echo
    wifi_show_ssids
    echo
    echo "Status    : $(wifi_get_status)"
    echo "Standard  : $(wifi_get_standard)"
    echo "Kanal     : $(wifi_get_channel)"
    echo

    wifi_show_clients
}

wifi24_clients()
{
    cache_get wifi24.clients
}

wifi5_clients()
{
    cache_get wifi5.clients
}

wifi_status()
{
    cache_get wifi.status
}
