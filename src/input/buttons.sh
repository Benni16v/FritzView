#!/bin/bash

############################################################
# Hardware Buttons
############################################################

button_event()
{
    case "$1" in

        LEFT)
            key_left
            ;;

        RIGHT)
            key_right
            ;;

        MENU)
            key_menu
            ;;

        OK)
            key_ok
            ;;

    esac
}
