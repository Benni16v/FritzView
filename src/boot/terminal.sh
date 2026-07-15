#!/bin/bash

boot_terminal_line()
{
    display_line "$1"
    display_render
    sleep 0.15
}

boot_terminal()
{
    display_clear

    boot_terminal_line "FRITZ!View Bootloader"
    boot_terminal_line ""
    boot_terminal_line "[ OK ] Pearl Display"
    boot_terminal_line "[ OK ] Display Driver"
    boot_terminal_line "[ OK ] Theme"
    boot_terminal_line "[ OK ] TR-064"
    boot_terminal_line "[ OK ] Cache"
    boot_terminal_line "[ OK ] Dashboard"

    sleep 0.5
}
