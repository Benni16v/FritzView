#!/bin/sh

page_system()
{
    display_clear
    display_header

    display_line "System"
    display_separator

    display_line "Modell   : $(system_name)"
    display_line "Firmware : $(system_version)"
    display_line "Uptime   : $(system_uptime)"

    display_footer
    display_end
}
