#!/bin/sh

############################################################
# Display API
############################################################

DISPLAY_BUFFER=""

display_init()
{
    DISPLAY_BUFFER=""
}

display_begin()
{
    DISPLAY_BUFFER=""
}

display_clear()
{
    DISPLAY_BUFFER=""
}

display_line()
{
    DISPLAY_BUFFER="${DISPLAY_BUFFER}$1\n"
}

display_text()
{
    DISPLAY_BUFFER="${DISPLAY_BUFFER}$1"
}

display_end()
{
    display_render "$DISPLAY_BUFFER"
}

############################################################
# Helper
############################################################

display_header()
{
    display_line "=============================="
    display_line "        FritzView"
    display_line "=============================="
    display_line ""
}

display_separator()
{
    display_line "------------------------------"
}

display_footer()
{
    display_line "=============================="
}

############################################################
# Render
############################################################

display_render()
{
    if command -v display_driver_render >/dev/null 2>&1
    then
        display_driver_render "$1"
    else
        printf "%b\n" "$1"
    fi
}
