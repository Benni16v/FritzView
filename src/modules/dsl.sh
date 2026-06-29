#!/bin/sh

dsl_update()
{

XML="$(tr064_get_dsl_info)"

cache_write dsl_down \
"$(echo "$XML" | xml "<NewDownstreamCurrRate>")"

cache_write dsl_up \
"$(echo "$XML" | xml "<NewUpstreamCurrRate>")"

cache_write dsl_max_down \
"$(echo "$XML" | xml "<NewDownstreamMaxRate>")"

cache_write dsl_max_up \
"$(echo "$XML" | xml "<NewUpstreamMaxRate>")"

XML="$(tr064_get_crc)"

cache_write crc \
"$(echo "$XML" | xml "<NewCRCErrors>")"

log "DSL updated."

}
