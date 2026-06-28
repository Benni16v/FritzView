#!/bin/sh
#
# FRITZ!View - TR-064 Engine
#

tr064()
{
    SERVICE="$1"
    URN="$2"
    ACTION="$3"

    # Authentifizierung
    if [ -n "$MASTER_USER" ]; then
        AUTH="$MASTER_USER:$MASTER_PASS"
    else
        AUTH=":$MASTER_PASS"
    fi

    curl \
        --connect-timeout 4 \
        -m 5 \
        -k \
        -s \
        -u "$AUTH" \
        -X POST \
        "https://$MASTER_IP:$MASTER_PORT/upnp/control/$SERVICE" \
        -H "Content-Type: text/xml; charset=utf-8" \
        -H "SOAPACTION: urn:dslforum-org:service:$URN#$ACTION" \
        -d "<?xml version=\"1.0\"?>
<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">
<soap:Body>
<u:$ACTION xmlns:u=\"urn:dslforum-org:service:$URN\"></u:$ACTION>
</soap:Body>
</soap:Envelope>"
}
