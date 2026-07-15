#!/bin/bash
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
