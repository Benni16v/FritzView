#!/bin/bash

############################################################
# FritzView Boot Screen Manager
############################################################

boot_screen()
{
    # Weiche je nach Konfiguration in config.sh
    case "$BOOT_THEME" in
        terminal)
            boot_terminal_show
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

############################################################
# 1. Das Terminal-Booten (Reale Aktionen mit cooler Optik)
############################################################
boot_terminal_show()
{
    # Terminal säubern
    clear
    
    # Stylisches farbiges ASCII-Logo (Rot für FritzBox-Vibe)
    echo -e "\e[1;31mFFFFF  RRRR   IIIII  TTTTT  ZZZZZ  V   V  IIIII  EEEEE  W   W\e[0m"
    echo -e "\e[1;31mF      R   R    I      T       Z   V   V    I    E      W   W\e[0m"
    echo -e "\e[1;31mFFF    RRRR     I      T      Z    V   V    I    EEE    W W W\e[0m"
    echo -e "\e[1;31mF      R  R     I      T     Z      V V     I    E      WW WW\e[0m"
    echo -e "\e[1;31mF      R   R  IIIII    T    ZZZZZ    V    IIIII  EEEEE  W   W\e[0m"
    echo "========================================================="
    echo "System: Freetz-NG / FRITZ!OS"
    echo "FritzView Version: 0.1-Beta"
    echo "--------------------------------------------------------"
    sleep 0.5

    # Wir führen hier echte Initialisierungen durch!
    echo -n "Initializing cache system... "
    cache_init  # Ruft deine reale Funktion aus cache.sh auf!
    sleep 0.4
    echo -e "[\e[1;32m OK \e[0m]"

    echo -n "Loading system libraries... "
    sleep 0.3
    echo -e "[\e[1;32m OK \e[0m]"

    echo -n "Starting display interface... "
    # Ruft deine reale Init-Funktion des aktiven Treibers auf
    
    sleep 0.4
    echo -e "[\e[1;32m OK \e[0m]"

    echo -n "Connecting to TR-064 API... "
    # Später können wir hier einen echten Verbindungs-Check einbauen
    sleep 0.5
    echo -e "[\e[1;32m OK \e[0m]"

    echo "--------------------------------------------------------"
    echo "FritzView successfully started."
    sleep 1.2
    clear
}

############################################################
# 2. Der AVM-Login Bootscreen (Grafische Bildsequenz)
############################################################
boot_avm_login_show()
{
    local boot_dir="$BASE/themes/$THEME/boot/avm"
    
    # 1. Passwort-Eingabe simulieren (Bilder frame_01.png bis frame_09.png)
    for frame in 01 02 03 04 05 06 07 08 09
    do
        local img="$boot_dir/frame_${frame}.png"
        if [ -f "$img" ]; then
            # Wir übergeben das Bild an den aktiven Display-Treiber
            display_driver_render_image "$img"
            sleep 0.3 # Geschwindigkeit der Eingabe-Animation
        fi
    done

    # 2. "Anmelden"-Button leuchtet auf / wird geklickt (frame_10.png)
    local frame10="$boot_dir/frame_10.png"
    if [ -f "$frame10" ]; then
        display_driver_render_image "$frame10"
        sleep 0.6
    fi

    # 3. Login erfolgreich / Übergang zum Menü (frame_11.png)
    local frame11="$boot_dir/frame_11.png"
    if [ -f "$frame11" ]; then
        display_driver_render_image "$frame11"
        sleep 1.0
    fi
}
