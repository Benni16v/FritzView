#!/bin/bash

page_mesh()
{
    display_clear
    
    theme_header
    theme_title "Mesh"

    theme_value "Status" "$(mesh_status)"
    theme_value "Repeater" "$(mesh_repeaters)"
    theme_value "Clients" "$(mesh_clients)"

    theme_footer

    display_render
}
