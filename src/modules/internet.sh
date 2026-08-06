internet_status()
{
    if is_online
    then
        echo "Online"
    else
        echo "Offline"
    fi
}

internet_ipv4()
{
    cache_read wan_ip
}

internet_ipv6()
{
    cache_read wan_ipv6
}

internet_gateway()
{
    cache_read gateway
}

internet_dns()
{
    cache_read dns
}

internet_uptime()
{
    cache_read online_time
}

internet_provider()
{
    cache_read isp
}

internet_sync_down()
{
    cache_read sync_down
}

internet_sync_up()
{
    cache_read sync_up
}
