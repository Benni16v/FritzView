#!/bin/bash

tam_request()
{
    tr064_request \
        "urn:dslforum-org:service:X_AVM-DE_TAM:1" \
        "/upnp/control/x_tam" \
        "GetInfo" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetInfo xmlns:u="urn:dslforum-org:service:X_AVM-DE_TAM:1">
<NewIndex>0</NewIndex>
</u:GetInfo>
</s:Body>
</s:Envelope>'
}

tam_enabled()
{
    tam_request | xml_value NewEnable
}

tam_name()
{
    tam_request | xml_value NewName
}

tam_new_messages()
{
    tam_request | xml_value NewNewMessages
}

tam_total_messages()
{
    tam_request | xml_value NewTotalMessages
}

tam_running()
{
    tam_request | xml_value NewTAMRunning
}

tam_capacity()
{
    tam_request | xml_value NewCapacity
}

tam_mode()
{
    tam_request | xml_value NewMode
}

tam_ringseconds()
{
    tam_request | xml_value NewRingSeconds
}

tam_numbers()
{
    tam_request | xml_value NewPhoneNumbers
}

tam_status()
{
    tam_request | xml_value NewStatus
}
