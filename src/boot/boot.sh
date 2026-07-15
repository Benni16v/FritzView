#!/bin/bash

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

boot_screen()
{
    BAR="$1"

cat >/tmp/fritzview/screen.txt <<EOF
+--------------------------------------+
|                                      |
|              FRITZ!View              |
|                                      |
|             Version 0.1              |
|                                      |
|          Projekt: Benni              |
|                                      |
|       Display: Pearl AX206           |
|                                      |
|          Backend: LCD4Linux          |
|                                      |
|--------------------------------------|
|                                      |
|         Initialisiere...             |
|                                      |
|  $BAR                                |
|                                      |
+--------------------------------------+
EOF

    lcd_refresh
}

boot_animation()
{
for BAR in \
"[....................]" \
"[##..................]" \
"[####................]" \
"[######..............]" \
"[########............]" \
"[##########..........]" \
"[############........]" \
"[##############......]" \
"[################....]" \
"[##################..]" \
"[####################]"
do
    boot_screen "$BAR"
    sleep 0.15
done
}
