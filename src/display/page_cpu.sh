#!/bin/bash

page_cpu()
{
    display_clear

    theme_header
    theme_title "System"

    theme_value "CPU"        "$(cpu_load)"
    theme_value "Temperatur" "$(cpu_temp)"

    theme_footer

    display_render
}
