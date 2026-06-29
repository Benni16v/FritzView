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
