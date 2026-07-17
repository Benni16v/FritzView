#!/bin/bash

############################################################
# AVM Theme
############################################################

theme_separator()
{
    display_line "+--------------------------------------+"
}

theme_header()
{
    display_line "+--------------------------------------+"
    display_line "|              FRITZ!View              |"
    display_line "|        AVM Router Dashboard          |"
    display_line "+--------------------------------------+"
}

theme_footer()
{
    display_line "+--------------------------------------+"
    display_line "| < Menu         OK           Weiter > |"
    display_line "+--------------------------------------+"
} 


theme_begin()
{
    display_clear
    
    theme_box
}

theme_end()
{
    display_box
    
    display_render
}

theme_title()
{
    printf -v LINE "| %-36s |" "$1"
    display_line "$LINE"
    theme_separator
}

theme_line()
{
    display_line "$1"
}

theme_value()
{
    printf -v LINE "| %-12s %-23s |" "$1" "$2"
    display_line "$LINE"
}

theme_box()
{
    display_box
}

theme_icon()
{
    :
}

theme_overlay_call()
{
    :
}

theme_empty()
{
    display_empty
}
