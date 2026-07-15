#!/bin/bash

page_internet()
{
    display_clear
    
    theme_header
    theme_title "Internet"

    theme_value "Status"    "$(internet_status)"
    theme_value "IPv4"      "$(wan_ip)"
    theme_value "Download" "$(dsl_get_downstream)"
    theme_value "Upload"   "$(dsl_get_upstream)"

    theme_footer

    display_render
}
