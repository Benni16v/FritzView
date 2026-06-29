#!/bin/sh
#
# ==========================================================
# HTTP helper
# ==========================================================

http_post()
{
    local url="$1"
    local action="$2"
    local xml="$3"

    curl -ks \
        -u "$TR064_USER:$TR064_PASS" \
        -H "Content-Type: text/xml; charset=utf-8" \
        -H "SOAPACTION: \"$action\"" \
        -d "$xml" \
        "$url"
}

http_get()
{
    curl -ks "$1"
}
