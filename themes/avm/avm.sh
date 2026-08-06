#!/bin/bash

############################################################
# AVM Theme
############################################################

export LANG=C.UTF-8
export LC_ALL=C.UTF-8

theme_separator()
{
    display_line "+--------------------------------------+"
}

theme_header()
{
    display_line "+--------------------------------------+"
    display_line "|              FRITZ!View              |"
    display_line "|        AVM Router Dashboard          |"
    display_line "+--------------------------------------+"
}

theme_footer()
{
    theme_separator
    display_nav "Menü" "OK" "Weiter"
    theme_separator
}


theme_begin()
{
    display_clear
    
    theme_box
}

theme_end()
{
    display_box
    
    display_render
}

theme_title()
{
    local TEXT="$1"
    local LEN
    LEN=$(char_len "$TEXT")
    local PAD=$((36 - LEN))
    [ "$PAD" -lt 0 ] && PAD=0
    local SPACES
    printf -v SPACES '%*s' "$PAD" ""
    display_line "| ${TEXT}${SPACES} |"
    theme_separator
}

theme_line()
{
    display_line "$1"
}

theme_value()
{
    local KEY="$1"
    local VAL="$2"
    local KLEN VLEN KPAD VPAD
    KLEN=$(char_len "$KEY")
    VLEN=$(char_len "$VAL")
    KPAD=$((13 - KLEN))
    VPAD=$((23 - VLEN))
    [ "$KPAD" -lt 0 ] && KPAD=0
    [ "$VPAD" -lt 0 ] && VPAD=0
    local KSPACES VSPACES
    printf -v KSPACES '%*s' "$KPAD" ""
    printf -v VSPACES '%*s' "$VPAD" ""
    display_line "| ${KEY}${KSPACES}${VAL}${VSPACES} |"
}

theme_box()
{
    display_box
}

theme_icon()
{
    :
}

theme_overlay_call()
{
    :
}

theme_empty()
{
    display_empty
}
