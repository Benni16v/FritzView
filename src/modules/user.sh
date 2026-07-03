#!/bin/sh

user_count_xml()
{
    tr064_request \
        "urn:dslforum-org:service:X_AVM-DE_Auth:1" \
        "/upnp/control/x_auth" \
        "GetInfo" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetInfo xmlns:u="urn:dslforum-org:service:X_AVM-DE_Auth:1"/>
</s:Body>
</s:Envelope>'
}

user_xml()
{
    user_count_xml
}
