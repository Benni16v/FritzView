#!/bin/bash

theme_internet()
{

theme_begin

theme_title "Internet"

theme_value "Status" "$ONLINE"

theme_value "IPv4" "$WAN_IP"

theme_value "IPv6" "$WAN_IPV6"

theme_empty

theme_value "Down" "$DSL_SPEED"

theme_value "Up" "$DSL_UP"

theme_end

}
