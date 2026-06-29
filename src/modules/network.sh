#!/bin/sh

network_update()
{

    cache_write ip "$(get_wan_ip)"

    cache_write down "$(get_dsl_down)"

    cache_write up "$(get_dsl_up)"

    cache_write maxdown "$(get_dsl_max_down)"

    cache_write maxup "$(get_dsl_max_up)"

}
