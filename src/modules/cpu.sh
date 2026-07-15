#!/bin/bash

cpu_xml()
{
tr064_request \
"urn:dslforum-org:service:X_AVM-DE_System:1" \
"/upnp/control/system" \
"GetCPUInfo" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetCPUInfo xmlns:u="urn:dslforum-org:service:X_AVM-DE_System:1"/>
</s:Body>
</s:Envelope>'
}

cpu_load()
{
    cpu_xml | xml_value NewLoad
}
