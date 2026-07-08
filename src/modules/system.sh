############################################################
# SYSTEM
############################################################

system_request()
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

system_name()
{
    system_request | xml_value NewModelName
}

system_vendor()
{
    system_request | xml_value NewManufacturerName
}

system_version()
{
    system_request | xml_value NewSoftwareVersion
}

system_serial()
{
    system_request | xml_value NewSerialNumber
}

system_uptime()
{
    system_request | xml_value NewUpTime
}

system_description()
{
    system_request | xml_value NewDescription
}

system_product()
{
    system_request | xml_value NewProductClass
}

system_spec()
{
    system_request | xml_value NewSpecVersion
}

system_hardware()
{
    system_request | xml_value NewHardwareVersion
}
