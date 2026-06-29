#!/bin/sh

update_wan()
{
    ip="$(tr064_get_external_ip)"

    [ -n "$ip" ] && cache_write wan_ip "$ip"
}
