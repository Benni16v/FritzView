#!/bin/sh

history_xml()
{
    tr064_request \
        "urn:dslforum-org:service:DeviceInfo:1" \
        "/upnp/control/deviceinfo" \
        "GetInfo" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetInfo xmlns:u="urn:dslforum-org:service:DeviceInfo:1"/>
</s:Body>
</s:Envelope>'
}

history_log()
{
    history_xml |
    xml_value NewDeviceLog
}

history_last()
{
    history_log |
    head -n1
}

history_lines()
{
    history_log |
    wc -l
}

history_show()
{
    history_log |
    nl
}
