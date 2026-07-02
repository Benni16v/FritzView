#!/bin/sh

network_xml()
{
    tr064_request \
        "urn:dslforum-org:service:LANHostConfigManagement:1" \
        "/upnp/control/lanhostconfigmgm" \
        "GetInfo" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetInfo xmlns:u="urn:dslforum-org:service:LANHostConfigManagement:1"/>
</s:Body>
</s:Envelope>'
}

network_get_ip()
{
    network_xml | xml_value NewIPAddress
}

network_get_mask()
{
    network_xml | xml_value NewSubnetMask
}

network_get_dhcp()
{
    network_xml | xml_value NewDHCPServerConfigurable
}
