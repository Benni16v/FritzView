#!/bin/sh

wifi_xml()
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

wifi_get_enabled()
{
    wifi_xml | xml_value NewEnable
}

wifi_get_ssid()
{
    wifi_xml | xml_value NewSSID
}

wifi_get_channel()
{
    wifi_xml | xml_value NewChannel
}

wifi_get_status()
{
    wifi_xml | xml_value NewStatus
}

wifi_get_channel()
{
    wifi_request |
    xml_value NewChannel
}

wifi_get_auto_channel()
{
    wifi_request |
    xml_value NewAutoChannelEnable
}

wifi_get_standard()
{
    wifi_request |
    xml_value NewStandard
}

wifi_get_status()
{
    wifi_request |
    xml_value NewEnable
}

wifi_get_ssid()
{
    wifi_request |
    xml_value NewSSID
}

wifi_get_ssid_hidden()
{
    wifi_request |
    xml_value NewSSIDAdvertisementEnabled
}

wifi_get_mac_filter()
{
    wifi_request |
    xml_value NewMACAddressControlEnabled
}

wifi_get_wps()
{
    wifi_request |
    xml_value NewX_AVM_DE_WPSStatus
}

wifi_get_wps_enable()
{
    wifi_request |
    xml_value NewX_AVM_DE_WPSEnable
}

wifi_get_encryption()
{
    wifi_request |
    xml_value NewBeaconType
}

wifi_get_auth_mode()
{
    wifi_request |
    xml_value NewBasicAuthenticationMode
}

wifi_get_bandwidth()
{
    wifi_request |
    xml_value NewX_AVM_DE_Bandwidth
}

wifi_get_max_bitrate()
{
    wifi_request |
    xml_value NewMaxBitRate
}

wifi_get_total_associations()
{
    wifi_request |
    xml_value NewTotalAssociations
}

wifi_guest_enabled()
{
    wifi_guest_request |
    xml_value NewEnable
}

wifi_guest_ssid()
{
    wifi_guest_request |
    xml_value NewSSID
}

wifi_guest_clients()
{
    wifi_guest_request |
    xml_value NewTotalAssociations
}


