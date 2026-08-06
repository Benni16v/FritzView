#!/bin/bash

############################################################
# Console Display Driver
############################################################

driver_init()
{
    :
}

driver_render()
{
    clear

    printf "%b\n" "$1"
}

# src/displays/console.sh (Auszug/Ergänzung)

driver_render_image()
{
    # Auf der Konsole können wir kein PNG anzeigen, 
    # also geben wir zur Info einfach den Pfad aus.
    echo "[Display-Image]: $1"
}