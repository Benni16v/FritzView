#!/bin/sh

system_xml()
{
    tr064_request \
        "urn:dslforum-org:service:DeviceConfig:1" \
        "/upnp/control/deviceconfig" \
        "GetInfo" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetInfo xmlns:u="urn:dslforum-org:service:DeviceConfig:1"/>
</s:Body>
</s:Envelope>'
}

system_get_uptime()
{
    system_xml | xml_value NewUpTime
}

system_get_reboot_required()
{
    system_xml | xml_value NewRebootRequired
}

system_get_config_version()
{
    system_xml | xml_value NewConfigVersion
}
