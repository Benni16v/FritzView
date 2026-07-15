#!/bin/bash

SSDP_ADDR="239.255.255.250"
SSDP_PORT=1900

ssdp_discover()
{
(
cat <<EOF
M-SEARCH * HTTP/1.1
HOST:239.255.255.250:1900
MAN:"ssdp:discover"
MX:2
ST:ssdp:all

EOF
) | nc -u -w3 "$SSDP_ADDR" "$SSDP_PORT"
}
