#!/bin/sh
#
# ==========================================================
# TR-064 Library
# ==========================================================

TR064_HOST="fritz.box"
TR064_PORT="49000"

TR064_BASE="http://$TR064_HOST:$TR064_PORT"

soap_request()
{
    local control="$1"
    local service="$2"
    local action="$3"
    local body="$4"

    local xml="<?xml version=\"1.0\"?>
<s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\">
<s:Body>
$body
</s:Body>
</s:Envelope>"

    http_post \
        "$TR064_BASE$control" \
        "$service#$action" \
        "$xml"
}

tr064_get_external_ip()
{
    soap_request \
        "/upnp/control/wanipconnection1" \
        "urn:dslforum-org:service:WANIPConnection:1" \
        "GetExternalIPAddress" \
"<u:GetExternalIPAddress xmlns:u=\"urn:dslforum-org:service:WANIPConnection:1\"/>" \
    | sed -n 's:.*<NewExternalIPAddress>\(.*\)</NewExternalIPAddress>.*:\1:p'
}

tr064_get_dsl_info()
{
    soap_request \
        "/upnp/control/wandslifconfig1" \
        "urn:dslforum-org:service:WANDSLInterfaceConfig:1" \
        "X_AVM-DE_GetDSLInfo" \
"<u:X_AVM-DE_GetDSLInfo xmlns:u=\"urn:dslforum-org:service:WANDSLInterfaceConfig:1\"/>"
}

tr064_get_dsl_rate()
{
    tr064_get_dsl_info | awk -F'[<>]' '

/NewDownstreamCurrRate/ {down=$3}

/NewUpstreamCurrRate/ {up=$3}

END{
print down ";" up
}
'
}
