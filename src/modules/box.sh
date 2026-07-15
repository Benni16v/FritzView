#!/bin/bash

############################################################
# Box Module
############################################################

box_request()
{
    tr064_request \
        "urn:dslforum-org:service:DeviceInfo:1" \
        "/upnp/control/deviceinfo" \
        "GetInfo" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetInfo xmlns:u="urn:dslforum-org:service:DeviceInfo:1"/>
</s:Body>
</s:Envelope>'
}

############################################################

box_get_xml()
{
    box_request
}

box_get_model()
{
    box_request | xml_value NewModelName
}

box_get_serial()
{
    box_request | xml_value NewSerialNumber
}

box_get_software()
{
    box_request | xml_value NewSoftwareVersion
}

box_get_hardware()
{
    box_request | xml_value NewHardwareVersion
}

box_get_manufacturer()
{
    box_request | xml_value NewManufacturerName
}

box_get_uptime()
{
    box_request | xml_value NewUpTime
}

box_get_spec_version()
{
    box_request | xml_value NewSpecVersion
}

box_get_provisioning()
{
    box_request | xml_value NewProvisioningCode
}
