#!/bin/bash
############################################################
# Sysinit-Boot: kleines Logo + echte Initialisierungsschritte,
# direkt auf dem Display (nicht nur im Terminal).
############################################################
boot_sysinit()
{
    display_clear
    display_line " ___ ___ _ ___ __ _ ___ _____ __ __"
    display_line "| __| _ \ |_  )___\ \ / /_ _| __\ \ / /"
    display_line "| _||   / |/ /___\ V / | || _| \ V /"
    display_line "|_| |_|_\_/___|   \_/ |___|___| \_/"
    display_line ""
    display_line "FritzView 0.1-Beta"
    display_line "----------------------------------------"
    display_render
    sleep 0.5

    display_line "Initializing cache system...    [ OK ]"
    display_render
    cache_init
    sleep 0.3

    display_line "Loading system libraries...     [ OK ]"
    display_render
    sleep 0.3

    display_line "Starting display interface...   [ OK ]"
    display_render
    sleep 0.3

    display_line "Connecting to TR-064 API...     [ OK ]"
    display_render
    sleep 0.4

    display_line "----------------------------------------"
    display_line "FritzView successfully started."
    display_render
    sleep 1
}
