#!/bin/bash

mesh_xml()
{
    tr064_request \
        "urn:dslforum-org:service:X_AVM-DE_HostFilter:1" \
        "/upnp/control/x_hostfilter" \
        "GetInfo" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetInfo xmlns:u="urn:dslforum-org:service:X_AVM-DE_HostFilter:1"/>
</s:Body>
</s:Envelope>'
}

mesh_clients()
{
    cache_get mesh.clients
}

mesh_repeaters()
{
    cache_get mesh.repeaters
}
