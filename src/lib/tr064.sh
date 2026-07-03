#!/bin/sh

############################################################
# XML Helper
############################################################

xml_value()
{
    TAG="$1"

    grep -oPm1 "(?<=<$TAG>)[^<]+"
}

############################################################
# Request
############################################################

tr064_request()
{
    SERVICE="$1"
    CONTROL="$2"
    ACTION="$3"
    BODY="$4"

    TMP=$(mktemp)

    printf '%s' "$BODY" > "$TMP"

    curl -sk \
        --anyauth \
        --user "$TR064_USER:$TR064_PASS" \
        -H 'Content-Type: text/xml; charset="utf-8"' \
        -H "SOAPACTION: \"$SERVICE#$ACTION\"" \
        --data-binary @"$TMP" \
        "https://$TR064_HOST:$TR064_PORT$CONTROL"

    RC=$?

    rm -f "$TMP"

    return "$RC"
}
