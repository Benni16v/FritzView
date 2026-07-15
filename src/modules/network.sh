#!/bin/bash

############################################################
# NETWORK
############################################################

network_request()
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
</s:Envelope>'
}

network_total_request()
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
</s:Envelope>'
}

network_receive_request()
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
</s:Envelope>'
}

network_packets_sent_request()
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
</s:Envelope>'
}

network_packets_received_request()
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
</s:Envelope>'
}

############################################################
# Getter
############################################################

network_get_type()
{
    network_request | xml_value NewWANAccessType
}

network_get_layer1()
{
    network_request | xml_value NewPhysicalLinkStatus
}

network_get_max_downstream()
{
    network_request | xml_value NewLayer1DownstreamMaxBitRate
}

network_get_max_upstream()
{
    network_request | xml_value NewLayer1UpstreamMaxBitRate
}

network_get_bytes_sent()
{
    network_total_request | xml_value NewTotalBytesSent
}

network_get_bytes_received()
{
    network_receive_request | xml_value NewTotalBytesReceived
}

network_get_packets_sent()
{
    network_packets_sent_request | xml_value NewTotalPacketsSent
}

network_get_packets_received()
{
    network_packets_received_request | xml_value NewTotalPacketsReceived
}
