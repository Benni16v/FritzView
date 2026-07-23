#!/bin/bash

register_screen system

page_system()
{
    display_clear

    theme_header
    theme_title "System"

    theme_value "Box" "$(system_name)"
    theme_value "Version" "$(system_version)"
    theme_value "Uptime" "$(format_uptime "$(system_uptime)")"
    theme_value "RAM" "$(memory_percent)%"

    theme_footer

    display_render
}
