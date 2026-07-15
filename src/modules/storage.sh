#!/bin/bash

storage_request()
{
    tr064_request \
        "urn:dslforum-org:service:X_AVM-DE_Storage:1" \
        "/upnp/control/x_storage" \
        "GetInfo" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetInfo xmlns:u="urn:dslforum-org:service:X_AVM-DE_Storage:1"/>
</s:Body>
</s:Envelope>'
}

storage_xml()
{
    storage_request
}

storage_devices()
{
    storage_request | xml_value NewDeviceNumberOfEntries
}

storage_ftp_enabled()
{
    storage_request | xml_value NewFTPEnable
}

storage_ftp_status()
{
    storage_request | xml_value NewFTPStatus
}

storage_smb_enabled()
{
    storage_request | xml_value NewSMBEnable
}

storage_ftp_wan()
{
    storage_request | xml_value NewFTPWANEnable
}

storage_ssl_only()
{
    storage_request | xml_value NewFTPWANSSLOnly
}

storage_port()
{
    storage_request | xml_value NewFTPWANPort
}
