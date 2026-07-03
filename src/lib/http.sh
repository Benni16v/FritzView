#!/bin/sh

############################################################
# HTTP Helper
############################################################

http_post()
{
    local url="$1"
    local action="$2"
    local xml="$3"

    curl -ks \
        --user "$TR064_USER:$TR064_PASS" \
        -H "Content-Type: text/xml; charset=utf-8" \
        -H "SOAPACTION: \"$action\"" \
        -d "$xml" \
        "$url"
}

############################################################

http_get()
{
    curl -ks --user "$TR064_USER:$TR064_PASS" "$1"
}
