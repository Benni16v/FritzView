#!/bin/sh

boot_bios()
{
    display_clear

    display_line "AMI BIOS"
    display_render
    sleep 0.3

    display_line ""
    display_line "CPU ............. OK"
    display_render
    sleep 0.2

    display_line "RAM ............. OK"
    display_render
    sleep 0.2

    display_line "Display ......... OK"
    display_render
    sleep 0.2

    display_line "TR064 ........... OK"
    display_render
    sleep 0.2

    display_line ""
    display_line "Booting FRITZ!View"

    display_render

    sleep 1
}
