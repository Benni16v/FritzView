MENU_ENTRY=1

MENU_ITEMS="
Overview
Netzwerk
WLAN
Telefonie
System
Speicher
Mesh
Einstellungen
"

menu_show()
{
    display_clear

    display_header

    echo "$MENU_ITEMS" |
    while read ITEM
    do

        [ -z "$ITEM" ] && continue

        if [ "$MENU_ENTRY" = "$NR" ]
        then
            display_line "> $ITEM"
        else
            display_line "  $ITEM"
        fi

        NR=$((NR+1))

    done

    display_footer

    display_end
}
