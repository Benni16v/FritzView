#!/bin/bash
############################################################
# Display Widgets
#
# Allgemeine, theme-unabhaengige Bausteine (Titel, Wert-Zeilen,
# Fortschrittsbalken, Navigationsleiste). Nicht zu verwechseln
# mit den AVM-Theme-Funktionen (theme_title/theme_value in
# themes/avm/avm.sh) - das ist ein zweiter, aehnlicher Satz von
# Bausteinen fuer Screens, die KEIN Theme benutzen wollen.
#
# WICHTIG: Aktuell nutzen so gut wie alle Screens (z.B.
# hosts.sh) die theme_*-Funktionen, nicht diese hier. Nur
# internet.sh nutzte bisher display_title/display_row - dabei
# fehlte display_row komplett (nie definiert), wodurch auf dem
# Internet-Screen mehrere Zeilen einfach nicht angezeigt
# wurden. Das ist hier jetzt nachgeruestet.
############################################################

# Ueberschrift + Trennlinie, z.B. display_title "Internet".
display_title()
{
    local TEXT="$1"
    local LEN
    LEN=$(char_len "$TEXT")
    local PAD=$((36 - LEN))
    [ "$PAD" -lt 0 ] && PAD=0
    local SPACES
    printf -v SPACES '%*s' "$PAD" ""
    display_line "| ${TEXT}${SPACES} |"
    display_separator
}

# Zweispaltige Zeile "Label: Wert", rechtsseitig auf 40 Zeichen
# aufgefuellt. Nutzt char_len() statt ${#...}, damit Umlaute
# nicht zu einem Zeichen-Versatz fuehren (siehe Bootscreen-Fix).
display_row()
{
    local LABEL="$1"
    local VALUE="$2"
    local LLEN VLEN LPAD VPAD
    LLEN=$(char_len "$LABEL")
    VLEN=$(char_len "$VALUE")
    LPAD=$((13 - LLEN))
    VPAD=$((23 - VLEN))
    [ "$LPAD" -lt 0 ] && LPAD=0
    [ "$VPAD" -lt 0 ] && VPAD=0
    local LSPACES VSPACES
    printf -v LSPACES '%*s' "$LPAD" ""
    printf -v VSPACES '%*s' "$VPAD" ""
    display_line "| ${LABEL}${LSPACES}${VALUE}${VSPACES} |"
}

# Komfort-Wrapper um display_row (fruehere Version rief hier
# eine nicht existierende sanitize_text-Funktion auf - entfernt,
# char_len in display_row reicht aus, um Umlaute korrekt zu
# behandeln).
display_value()
{
    display_row "$1" "$2"
}

# Zeichnet einen einfachen Balken aus # und -, z.B. fuer
# Speicherauslastung: display_progress 6 10 -> [######----]
display_progress()
{
    local VALUE="$1"
    local MAX="$2"
    local BAR=""
    local I=0
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

# Navigationszeile unten, z.B. "< Menue   OK   Weiter >".
# Nutzt char_len() statt ${#...}, damit z.B. "Menü" nicht zu
# einem Versatz des rechten Rahmens fuehrt.
display_nav()
{
    local LEFT="< $1"
    local CENTER="$2"
    local RIGHT="$3 >"
    local WIDTH=38
    local L C R
    L=$(char_len "$LEFT")
    C=$(char_len "$CENTER")
    R=$(char_len "$RIGHT")
    local FREE=$((WIDTH - L - C - R))
    [ "$FREE" -lt 0 ] && FREE=0
    local GAP1=$((FREE / 2))
    local GAP2=$((FREE - GAP1))
    local G1SPACES G2SPACES
    printf -v G1SPACES '%*s' "$GAP1" ""
    printf -v G2SPACES '%*s' "$GAP2" ""
    display_line "|${LEFT}${G1SPACES}${CENTER}${G2SPACES}${RIGHT}|"
}

# Generischer Kopfbereich (fuer Screens ohne eigenes Theme).
display_header()
{
    display_separator
    local LINE
    printf -v LINE "| %-36s |" "FRITZ!View"
    display_line "$LINE"
    display_separator
}

display_footer()
{
    display_separator
}

display_end()
{
    display_render
}
