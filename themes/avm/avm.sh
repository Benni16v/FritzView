#!/bin/sh

theme_header()
{
    display_header
}

theme_footer()
{
    display_footer
}

theme_title()
{
    display_line "$1"
    display_separator
}

theme_value()
{
    printf -v LINE "%-10s : %s" "$1" "$2"

    display_line "$LINE"
}
