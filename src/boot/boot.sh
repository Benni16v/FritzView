#!/bin/sh

boot_start()
{
    case "$BOOT_THEME" in

        AVM)
            boot_avm
            ;;

        TERMINAL)
            boot_terminal
            ;;

        BIOS)
            boot_bios
            ;;

        MATRIX)
            boot_matrix
            ;;

        *)
            boot_terminal
            ;;

    esac
}
