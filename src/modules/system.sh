#!/bin/sh

system_xml()
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

system_manufacturer()
{
    system_xml | xml_value NewManufacturerName
}

system_model()
{
    system_xml | xml_value NewModelName
}

system_firmware()
{
    system_xml | xml_value NewSoftwareVersion
}

system_serial()
{
    system_xml | xml_value NewSerialNumber
}

system_uptime()
{
    system_xml | xml_value NewUpTime
}

system_description()
{
    system_xml | xml_value NewDescription
}

system_productclass()
{
    system_xml | xml_value NewProductClass
}

system_hardware()
{
    system_xml | xml_value NewHardwareVersion
}

system_specversion()
{
    system_xml | xml_value NewSpecVersion
}
