#!/bin/bash
# src/display/display.sh

# HINWEIS: Der Display-Treiber wird jetzt sauber und zentral 
# am Ende der init.sh geladen. Der doppelte case-Block hier wurde entfernt.

############################################################
# Fallback (Verhindert Abstürze, falls der Treiber fehlt)
############################################################
if ! declare -f display_driver_render >/dev/null; then
    display_driver_render() {
        # Falls kein Treiber geladen ist, geben wir es einfach im Terminal aus
        printf "%b" "$1"
    }
fi

############################################################
# Widgets
############################################################

display_title()
{
    display_line "$1"
    display_separator
}

display_value()
{
    printf -v LINE "%-10s %s" "$1" "$2"
    display_line "$LINE"
}

display_icon()
{
    display_line "$1 $2"
}

display_progress()
{
    VALUE="$1"
    MAX="$2"

    BAR=""
    I=0

    while [ "$I" -lt "$MAX" ]
    do
        if [ "$I" -lt "$VALUE" ]
        then
            BAR="${BAR}#"
        else
            BAR="${BAR}-"
        fi

        I=$((I+1))
    done

    display_line "[$BAR]"
}

display_clear()
{
    DISPLAY_BUFFER=""
}

display_line()
{
    DISPLAY_BUFFER="${DISPLAY_BUFFER}$1\n"
}

display_separator()
{
    display_line "------------------------------"
}

display_header()
{
    TIME="$(date +%H:%M)"

    display_line " FRITZ!View             $TIME"
    display_separator
}

display_footer()
{
    display_separator
}

display_end()
{
    display_driver_render "$DISPLAY_BUFFER"
}

display_show_boot() {
    if [ "$BOOT_THEME" = "terminal" ]; then
        boot_terminal_show
    elif [ "$BOOT_THEME" = "avm" ]; then
        boot_avm_login_show
    else
        echo "Standard Boot..."
    fi
}
