#!/bin/bash

theme_home()
{

theme_begin

theme_title "FRITZ!View"

theme_value "Internet" "$ONLINE"

theme_value "IPv4" "$WAN_IP"

theme_value "IPv6" "$WAN_IPV6"

theme_empty

theme_value "DSL" "$DSL_SPEED"

theme_value "Upstream" "$DSL_UP"

theme_empty

theme_value "Telefon" "$PHONE_STATE"

theme_value "WLAN" "$WLAN_STATE"

theme_end

}
