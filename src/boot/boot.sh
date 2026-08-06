#!/bin/bash
############################################################
# FritzView Boot Screen Manager
############################################################
boot_screen()
{
    # Weiche je nach Konfiguration in config.sh
    case "$BOOT_THEME" in
        terminal)
            boot_terminal
            ;;
        sysinit)
            boot_sysinit
            ;;
        bios)
            boot_bios
            ;;
        matrix)
            boot_matrix
            ;;
        splash)
            boot_logo
            ;;
        login)
            boot_login
            ;;
        avmgui)
            boot_avm_login_show
            ;;
        avm)
            boot_avm
            ;;
        *)
            # Fallback falls kein Boot-Theme definiert ist
            display_clear
            display_center "Starting FritzView..."
            display_render
            sleep 2
            ;;
    esac
}
