#!/bin/bash

page_system()
{
    display_clear

    theme_header
    theme_title "FRITZ!Box"

    theme_value "Modell"  "$(box_model)"
    theme_value "Firmware" "$(firmware)"
    theme_value "Uptime" "$(format_time "$(cache_get system.uptime)")"
    
    theme_footer

    display_render
}
