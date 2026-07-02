#!/bin/sh

phone_xml()
{
    tr064_request \
        "urn:dslforum-org:service:X_VoIP:1" \
        "/upnp/control/x_voip" \
        "GetInfo" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetInfo xmlns:u="urn:dslforum-org:service:X_VoIP:1"/>
</s:Body>
</s:Envelope>'
}

phone_get_state()
{
    phone_xml
}

phone_get_number_count()
{
    tr064_request \
        "urn:dslforum-org:service:X_VoIP:1" \
        "/upnp/control/x_voip" \
        "X_AVM-DE_GetNumberOfNumbers" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:X_AVM-DE_GetNumberOfNumbers xmlns:u="urn:dslforum-org:service:X_VoIP:1"/>
</s:Body>
</s:Envelope>' |
xml_value NewNumberOfNumbers
}

phone_get_number()
{
    INDEX="$1"

    tr064_request \
        "urn:dslforum-org:service:X_VoIP:1" \
        "/upnp/control/x_voip" \
        "X_AVM-DE_GetNumbers" \
"<?xml version=\"1.0\"?>
<s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\">
<s:Body>
<u:X_AVM-DE_GetNumbers xmlns:u=\"urn:dslforum-org:service:X_VoIP:1\">
<NewIndex>$INDEX</NewIndex>
</u:X_AVM-DE_GetNumbers>
</s:Body>
</s:Envelope>"
}

phone_number()
{
    phone_get_number "$1" |
    xml_value NewNumber
}

phone_name()
{
    phone_get_number "$1" |
    xml_value NewName
}

phone_registered()
{
    phone_get_number "$1" |
    xml_value NewRegistered
}


