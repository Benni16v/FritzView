#!/bin/bash

page_phone()
{
    display_clear
    theme_header

    theme_title "Telefonie"
    
    theme_value "Status"      "$(phone_status)"
    theme_value "Telefone"    "$(phone_count)"
    theme_value "AB aktiv"    "$(tam_enabled)"

    theme_footer
    display_render
}
