#!/bin/bash

internet_status()
{
    cache_get internet.status
}

phone_status()
{
    cache_get phone.status
}

wifi_status()
{
    cache_get wifi.status
}

mesh_status()
{
    cache_get mesh.status
}

downstream()
{
    dsl_get_downstream
}

upstream()
{
    dsl_get_upstream
}

wan_ip()
{
    cache_get wan.ip
}

firmware()
{
    cache_get system.version
}

box_model()
{
    cache_get system.model
}

uptime()
{
    cache_get system.uptime
}

wifi_clients()
{
    cache_get wifi.clients
}

mesh_clients()
{
    cache_get mesh.clients
}

status_icon()
{
    case "$1" in
        online|up|1|yes)
            echo "OK"
            ;;
        offline|down|0|no)
            echo "--"
            ;;
        *)
            echo "??"
            ;;
    esac
}
