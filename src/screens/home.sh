#!/bin/bash

register_screen home

page_home()
{
    display_clear

    theme_header

    theme_title "FRITZ!View"

    theme_value "Internet" "$(internet_status)"
    theme_value "Telefon"  "$(phone_status)"
    theme_value "WLAN"     "$(wifi_status)"
    theme_value "Mesh"     "$(mesh_status)"

    theme_footer

    display_render
}
