#!/bin/sh

############################################################
# WAN Module
############################################################

wan_get_external_ip()
{
    tr064_request \
        "urn:dslforum-org:service:WANIPConnection:1" \
        "/upnp/control/wanipconnection1" \
        "GetExternalIPAddress" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetExternalIPAddress xmlns:u="urn:dslforum-org:service:WANIPConnection:1"/>
</s:Body>
</s:Envelope>' |
xml_value NewExternalIPAddress
}

############################################################

wan_get_status()
{
    tr064_request \
        "urn:dslforum-org:service:WANIPConnection:1" \
        "/upnp/control/wanipconnection1" \
        "GetStatusInfo" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetStatusInfo xmlns:u="urn:dslforum-org:service:WANIPConnection:1"/>
</s:Body>
</s:Envelope>' |
xml_value NewConnectionStatus
}

############################################################

wan_get_uptime()
{
    tr064_request \
        "urn:dslforum-org:service:WANIPConnection:1" \
        "/upnp/control/wanipconnection1" \
        "GetStatusInfo" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetStatusInfo xmlns:u="urn:dslforum-org:service:WANIPConnection:1"/>
</s:Body>
</s:Envelope>' |
xml_value NewUptime
}

############################################################

wan_get_statistics()
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

############################################################

wan_get_bytes_sent()
{
    wan_get_statistics | xml_value NewTotalBytesSent
}

############################################################

wan_get_bytes_received()
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

############################################################

wan_get_packets_sent()
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

############################################################

wan_get_packets_received()
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
