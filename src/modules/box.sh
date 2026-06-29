#!/bin/sh

box_name()
{
    hostname
}

box_model()
{
    cat /proc/sys/urlader/environment 2>/dev/null \
        | grep HWRevision
}

box_update()
{
    cache_write hostname "$(box_name)"
}
