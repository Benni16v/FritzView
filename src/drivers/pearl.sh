#!/bin/bash

############################################################
# Native Pearl Driver
############################################################

driver_init()
{
    echo "Native Pearl Driver"
}

driver_stop()
{
    :
}

driver_render()
{
    local TEXT="$1"

    #
    # Hier kommt später:
    #
    # Text
    # ->
    # Framebuffer
    # ->
    # USB
    #
}

driver_sleep()
{
    :
}

driver_wakeup()
{
    :
}

driver_brightness()
{
    :
}

driver_buttons()
{
    :
}
