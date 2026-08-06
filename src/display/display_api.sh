#!/bin/bash
############################################################
# FritzView Display API
#
# Kleinste, allgemeine Bausteine zum Aufbauen eines Screens.
# Themes (z.B. themes/avm/avm.sh) und Widgets
# (display_widgets.sh) bauen auf diesen Funktionen auf.
############################################################

display_clear()
{
    buffer_clear
}

display_add()
{
    buffer_add "$1"
}

display_line()
{
    buffer_add "$1"
}

# Einfache Trennlinie (schlichter Strich, kein Rahmen-Stil).
# Fuer den AVM-Rahmen-Look siehe stattdessen theme_separator()
# in themes/avm/avm.sh ("+----+").
display_separator()
{
    display_line "------------------------------"
}

# Zentriert einen Text auf DISPLAY_WIDTH Zeichen.
# Nutzt char_len() (src/lib/utils.sh) statt ${#TEXT}, damit
# Umlaute (2 Bytes, aber 1 sichtbares Zeichen) korrekt gezaehlt
# werden - siehe den Zeilen-Versatz-Bug, den wir bei den Themes
# schon gefixt haben.
display_center()
{
    local TEXT="$1"
    local LEN
    LEN=$(char_len "$TEXT")
    local PAD=$(( (DISPLAY_WIDTH - LEN) / 2 ))
    [ "$PAD" -lt 0 ] && PAD=0
    local LEFT RIGHT
    printf -v LEFT "%*s" "$PAD" ""
    printf -v RIGHT "%*s" $((DISPLAY_WIDTH - PAD - LEN)) ""
    display_line "${LEFT}${TEXT}${RIGHT}"
}

# Setzt die Textfarbe fuer den aktuellen Screen (z.B. fuer den
# Matrix-Bootscreen). Gilt bis zum naechsten display_clear.
display_color()
{
    DISPLAY_COLOR="$1"
}

# Schickt den fertigen Puffer an den aktiven Treiber.
display_render()
{
    driver_render "$(buffer_get)"
}
