#!/bin/bash
############################################################
# Ordnet dem erkannten FritzBox-Modell (SYSTEM_NAME, aus
# einem der TR-064-Module) ein passendes Router-Bild zu,
# z.B. fuer den Overview-Screen.
############################################################
router_image()
{
    case "$SYSTEM_NAME" in
        *7590*AX*)
            echo "7590ax.png"
            ;;
        *7530*AX*)
            echo "7530ax.png"
            ;;
        *4040*)
            echo "4040.png"
            ;;
        *4020*)
            echo "4020.png"
            ;;
        *)
            echo "generic.png"
            ;;
    esac
}
