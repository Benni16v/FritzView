#!/bin/sh

phone_xml()
{
    tr064_request \
        "urn:dslforum-org:service:X_VoIP:1" \
        "/upnp/control/x_voip" \
        "GetInfo" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetInfo xmlns:u="urn:dslforum-org:service:X_VoIP:1"/>
</s:Body>
</s:Envelope>'
}

phone_get_state()
{
    phone_xml
}
