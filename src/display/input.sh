#!/bin/bash
############################################################
# Auto-Wechsel-Steuerung fuer die Screen-Navigation.
# Wird von den physischen Tasten (spaeter) bzw. der
# Tastatur-Navigation angesprochen: sobald der User selbst
# navigiert, wird der automatische Seitenwechsel pausiert.
############################################################
AUTO_MODE=1
AUTO_TIMEOUT=10
LAST_ACTION=$(date +%s)

input_left()
{
    AUTO_MODE=0
    LAST_ACTION=$(date +%s)
    display_previous
}

input_right()
{
    AUTO_MODE=0
    LAST_ACTION=$(date +%s)
    display_next
}

# Schaltet den Automatik-Modus um (an/aus).
input_menu()
{
    if [ "$AUTO_MODE" = "1" ]
    then
        AUTO_MODE=0
    else
        AUTO_MODE=1
    fi
    LAST_ACTION=$(date +%s)
}
