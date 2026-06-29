#!/bin/sh

update_dsl()
{
    rates="$(tr064_get_dsl_rate)"

    down="${rates%;*}"
    up="${rates#*;}"

    cache_write dsl_down "$down"
    cache_write dsl_up "$up"
}
