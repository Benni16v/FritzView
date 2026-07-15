#!/bin/bash

remote_xml()
{
    tr064_request \
        "urn:dslforum-org:service:X_AVM-DE_RemoteAccess:1" \
        "/upnp/control/x_remote" \
        "GetInfo" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetInfo xmlns:u="urn:dslforum-org:service:X_AVM-DE_RemoteAccess:1"/>
</s:Body>
</s:Envelope>'
}
