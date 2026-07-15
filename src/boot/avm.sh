#!/bin/bash

boot_avm_screen()
{
    display_clear

    display_line "┌────────────────────────────┐"
    display_line "│         FRITZ!Box          │"
    display_line "├────────────────────────────┤"
    display_line "│                            │"
    display_line "│ Kennwort                   │"
    display_line "│                            │"
    display_line "│ $1                         │"
    display_line "│                            │"
    display_line "│      [  Anmelden ]         │"
    display_line "└────────────────────────────┘"

    display_render
}

boot_avm()
{
    PASS=""

    for i in 1 2 3 4 5 6 7 8
    do
        PASS="${PASS}●"

        boot_avm_screen "$PASS"

        sleep 0.18
    done

    sleep 0.5

    display_clear

    display_line ""
    display_line "Authentifizierung..."
    display_render

    sleep 0.5

    display_clear

    display_line ""
    display_line "Lade Einstellungen..."
    display_render

    sleep 0.5

    display_clear

    display_line ""
    display_line "Verbinde..."
    display_render

    sleep 0.5
}
