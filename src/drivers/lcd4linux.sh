#!/bin/bash

############################################################
# LCD4Linux Wrapper
############################################################

driver_init()
{
    display_driver_init
}

driver_stop()
{
    display_driver_stop
}

driver_render()
{
    display_driver_render "$1"
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
