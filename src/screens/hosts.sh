#!/bin/bash

register_screen hosts

page_hosts()
{
    display_clear

    theme_header
    theme_title "Geräte"

    theme_value "Anzahl" "$(host_count)"
    theme_value "Online" "$(host_online)"
    theme_value "Mesh"    "$(mesh_count)"
    theme_value "Gast"    "$(guest_count)"

    theme_footer

    display_render
}
