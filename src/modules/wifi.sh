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
