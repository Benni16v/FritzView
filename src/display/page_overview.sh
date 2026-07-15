#!/bin/bash
page_overview()
{
    cache_read

    display_clear
    theme_header

    widget_router

    display_separator

    widget_internet

    display_separator

    widget_network

    display_separator

    widget_uptime

    display_footer
    display_end
}
