#!/bin/sh

############################################################
# WLAN 2,4GHZ
############################################################

wifi_request()
{
    tr064_request \
        "urn:dslforum-org:service:WLANConfiguration:1" \
        "/upnp/control/wlanconfig1" \
        "GetInfo" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetInfo xmlns:u="urn:dslforum-org:service:WLANConfiguration:1"/>
</s:Body>
</s:Envelope>'
}

############################################################
# WLAN 5GHZ
############################################################

wifi5_request()
{
    tr064_request \
        "urn:dslforum-org:service:WLANConfiguration:2" \
        "/upnp/control/wlanconfig2" \
        "GetTotalAssociations" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetTotalAssociations xmlns:u="urn:dslforum-org:service:WLANConfiguration:2"/>
</s:Body>
</s:Envelope>'
}

############################################################
# Guest WLAN
############################################################

wifi_guest_request()
{
    tr064_request \
        "urn:dslforum-org:service:WLANConfiguration:3" \
        "/upnp/control/wlanconfig3" \
        "GetInfo" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetInfo xmlns:u="urn:dslforum-org:service:WLANConfiguration:3"/>
</s:Body>
</s:Envelope>'
}

############################################################
# Main WLAN
############################################################

wifi_get_enabled()
{
    wifi_request | xml_value NewEnable
}

wifi_get_status()
{
    wifi_get_enabled
}

wifi_get_ssid()
{
    wifi_request | xml_value NewSSID
}

wifi_get_channel()
{
    wifi_request | xml_value NewChannel
}

wifi_get_auto_channel()
{
    wifi_request | xml_value NewAutoChannelEnable
}

wifi_get_standard()
{
    wifi_request | xml_value NewStandard
}

wifi_get_bandwidth()
{
    wifi_request | xml_value NewX_AVM_DE_Bandwidth
}

wifi_get_max_bitrate()
{
    wifi_request | xml_value NewMaxBitRate
}

wifi_get_ssid_hidden()
{
    wifi_request | xml_value NewSSIDAdvertisementEnabled
}

wifi_get_mac_filter()
{
    wifi_request | xml_value NewMACAddressControlEnabled
}

wifi_get_wps()
{
    wifi_request | xml_value NewX_AVM_DE_WPSStatus
}

wifi_get_wps_enable()
{
    wifi_request | xml_value NewX_AVM_DE_WPSEnable
}

wifi_get_encryption()
{
    wifi_request | xml_value NewBeaconType
}

wifi_get_auth_mode()
{
    wifi_request | xml_value NewBasicAuthenticationMode
}

############################################################
# WLAN Clients 2,4GHZ
############################################################

wifi_get_total_associations()
{
    tr064_request \
        "urn:dslforum-org:service:WLANConfiguration:1" \
        "/upnp/control/wlanconfig1" \
        "GetTotalAssociations" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetTotalAssociations xmlns:u="urn:dslforum-org:service:WLANConfiguration:1"/>
</s:Body>
</s:Envelope>' |
    xml_value NewTotalAssociations
}

############################################################
# WLAN Clients 5GHZ
############################################################

wifi5_get_total_associations()
{
    wifi5_request |
    xml_value NewTotalAssociations
}

############################################################
# WLAN Guest Clients 
############################################################

wifi_guest_clients()
{
    tr064_request \
        "urn:dslforum-org:service:WLANConfiguration:3" \
        "/upnp/control/wlanconfig3" \
        "GetTotalAssociations" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetTotalAssociations xmlns:u="urn:dslforum-org:service:WLANConfiguration:3"/>
</s:Body>
</s:Envelope>' |
    xml_value NewTotalAssociations
}

############################################################
# WLAN Clients auslesen
############################################################

wifi_get_clients()
{
    C24="${C24:-$(wifi_get_total_associations)}"
    C5="${C5:-$(wifi5_get_total_associations)}"
    CGUEST="${CGUEST:-$(wifi_guest_clients)}"

    echo $(( ${C24:-0} + ${C5:-0} + ${CGUEST:-0} ))
}

############################################################
# Guest WLAN
############################################################

wifi_guest_enabled()
{
    wifi_guest_request | xml_value NewEnable
}

wifi_guest_ssid()
{
    wifi_guest_request | xml_value NewSSID
}

############################################################
# WLAN Diagnose
############################################################

wifi_dump()
{
    wifi_request
}
