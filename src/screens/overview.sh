#!/bin/bash
############################################################
# FritzView Overview Screen
############################################################

page_overview()
{
    display_separator
    display_center "FRITZ!View"
    display_center "AVM Router Dashboard"
    display_separator
    display_center "Uebersicht & Status"
    display_separator
    display_row " Status:" "Online"
    display_row " IP:" "192.168.178.1"
    display_row " WLAN:" "Aktiv (2.4 / 5 GHz)"
    display_row " Uptime:" "12 Tage"
    display_separator
    display_center "< Menü          OK          Weiter >"
    display_separator
}
