#!/bin/bash

register_screen overview

page_overview()
{
    display_clear

    theme_header
    theme_title "Übersicht"

    theme_value "Internet" "$(internet_status)"
    theme_value "Telefon"  "$(phone_status)"
    theme_value "WLAN"     "$(wifi_status)"
    theme_value "Mesh"     "$(mesh_status)"

    theme_value "IP"       "$(wan_ip)"

    theme_footer

    display_render
}
