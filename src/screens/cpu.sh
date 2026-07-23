#!/bin/bash

register_screen cpu

page_cpu()
{
    display_clear

    theme_header
    theme_title "CPU"

    theme_value "Last" "$(cpu_load)"
    theme_value "Temp" "$(cpu_temp)"
    theme_value "Takt" "$(cpu_clock)"
    theme_value "Uptime" "$(format_uptime "$(system_uptime)")"

    theme_footer

    display_render
}
