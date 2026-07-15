#!/bin/bash
page_hosts()
{
    display_clear
    theme_header

    display_line " Netzwerk"

    display_separator

    display_line "Geräte"

    display_line ""

    display_line "$(hosts_count)"

    display_footer
    display_end
}
