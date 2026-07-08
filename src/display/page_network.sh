#!/bin/sh

page_network()
{
    cache_read

    display_clear
    display_header

    display_line ""

    display_line "Connection"

    display_line "Type : $NETWORK_TYPE"

    display_line "Link : $NETWORK_LINK"

    display_line ""

    display_line "TX : $NETWORK_TX"

    display_line "RX : $NETWORK_RX"

    display_footer
}
