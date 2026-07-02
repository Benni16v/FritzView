#!/bin/sh

############################################################
# DSL Module
############################################################

dsl_request()
{
    tr064_request \
        "urn:dslforum-org:service:WANDSLInterfaceConfig:1" \
        "/upnp/control/wandslifconfig1" \
        "X_AVM-DE_GetDSLInfo" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:X_AVM-DE_GetDSLInfo xmlns:u="urn:dslforum-org:service:WANDSLInterfaceConfig:1"/>
</s:Body>
</s:Envelope>'
}

############################################################

dsl_get_status()
{
    dsl_request | xml_value NewStatus
}

dsl_get_downstream()
{
    dsl_request | xml_value NewDownstreamCurrRate
}

dsl_get_upstream()
{
    dsl_request | xml_value NewUpstreamCurrRate
}

dsl_get_max_downstream()
{
    dsl_request | xml_value NewDownstreamMaxRate
}

dsl_get_max_upstream()
{
    dsl_request | xml_value NewUpstreamMaxRate
}

dsl_get_noise_margin_down()
{
    dsl_request | xml_value NewDownstreamNoiseMargin
}

dsl_get_noise_margin_up()
{
    dsl_request | xml_value NewUpstreamNoiseMargin
}

dsl_get_attenuation_down()
{
    dsl_request | xml_value NewDownstreamAttenuation
}

dsl_get_attenuation_up()
{
    dsl_request | xml_value NewUpstreamAttenuation
}

dsl_get_firmware()
{
    dsl_request | xml_value NewATURVendor
}

dsl_get_dslam()
{
    dsl_request | xml_value NewATUCVendor
}
