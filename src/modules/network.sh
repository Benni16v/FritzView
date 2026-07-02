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

network_get_connection_type()
{
    tr064_request \
        "urn:dslforum-org:service:WANCommonInterfaceConfig:1" \
        "/upnp/control/wancommonifconfig1" \
        "GetCommonLinkProperties" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetCommonLinkProperties xmlns:u="urn:dslforum-org:service:WANCommonInterfaceConfig:1"/>
</s:Body>
</s:Envelope>' |
xml_value NewWANAccessType
}

network_get_layer1_status()
{
    tr064_request \
        "urn:dslforum-org:service:WANCommonInterfaceConfig:1" \
        "/upnp/control/wancommonifconfig1" \
        "GetCommonLinkProperties" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetCommonLinkProperties xmlns:u="urn:dslforum-org:service:WANCommonInterfaceConfig:1"/>
</s:Body>
</s:Envelope>' |
xml_value NewPhysicalLinkStatus
}

network_get_max_downstream()
{
    tr064_request \
        "urn:dslforum-org:service:WANCommonInterfaceConfig:1" \
        "/upnp/control/wancommonifconfig1" \
        "GetCommonLinkProperties" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetCommonLinkProperties xmlns:u="urn:dslforum-org:service:WANCommonInterfaceConfig:1"/>
</s:Body>
</s:Envelope>' |
xml_value NewLayer1DownstreamMaxBitRate
}

network_get_max_upstream()
{
    tr064_request \
        "urn:dslforum-org:service:WANCommonInterfaceConfig:1" \
        "/upnp/control/wancommonifconfig1" \
        "GetCommonLinkProperties" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetCommonLinkProperties xmlns:u="urn:dslforum-org:service:WANCommonInterfaceConfig:1"/>
</s:Body>
</s:Envelope>' |
xml_value NewLayer1UpstreamMaxBitRate
}

network_get_packets_sent()
{
    tr064_request \
        "urn:dslforum-org:service:WANCommonInterfaceConfig:1" \
        "/upnp/control/wancommonifconfig1" \
        "GetTotalPacketsSent" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetTotalPacketsSent xmlns:u="urn:dslforum-org:service:WANCommonInterfaceConfig:1"/>
</s:Body>
</s:Envelope>' |
xml_value NewTotalPacketsSent
}

network_get_packets_received()
{
    tr064_request \
        "urn:dslforum-org:service:WANCommonInterfaceConfig:1" \
        "/upnp/control/wancommonifconfig1" \
        "GetTotalPacketsReceived" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetTotalPacketsReceived xmlns:u="urn:dslforum-org:service:WANCommonInterfaceConfig:1"/>
</s:Body>
</s:Envelope>' |
xml_value NewTotalPacketsReceived
}

network_get_bytes_sent()
{
    tr064_request \
        "urn:dslforum-org:service:WANCommonInterfaceConfig:1" \
        "/upnp/control/wancommonifconfig1" \
        "GetTotalBytesSent" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetTotalBytesSent xmlns:u="urn:dslforum-org:service:WANCommonInterfaceConfig:1"/>
</s:Body>
</s:Envelope>' |
xml_value NewTotalBytesSent
}

network_get_bytes_received()
{
    tr064_request \
        "urn:dslforum-org:service:WANCommonInterfaceConfig:1" \
        "/upnp/control/wancommonifconfig1" \
        "GetTotalBytesReceived" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetTotalBytesReceived xmlns:u="urn:dslforum-org:service:WANCommonInterfaceConfig:1"/>
</s:Body>
</s:Envelope>' |
xml_value NewTotalBytesReceived
}


