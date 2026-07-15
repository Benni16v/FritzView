#!/bin/bash

############################################################
# Console Display Driver
############################################################

display_driver_init()
{
    :
}

display_driver_render()
{
    clear

    printf "%b\n" "$1"
}
