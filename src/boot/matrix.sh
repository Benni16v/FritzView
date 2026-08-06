#!/bin/bash
boot_matrix()
{
    local TARGET="FRITZVIEW"
    local FRAMES=15
    local TARGET_ROW=$((DISPLAY_HEIGHT / 2))
    local TARGET_COL=$(( (DISPLAY_WIDTH - ${#TARGET}) / 2 ))
    local frame row reveal line pad

    for frame in $(seq 1 "$FRAMES")
    do
        display_clear
        display_color "green"
        reveal=$(( frame * 100 / FRAMES ))
        row=0
        while [ "$row" -lt "$DISPLAY_HEIGHT" ]
        do
            if [ "$row" -eq "$TARGET_ROW" ] && [ "$(( RANDOM % 100 ))" -lt "$reveal" ]; then
                printf -v line '%*s%s' "$TARGET_COL" "" "$TARGET"
                pad=$((DISPLAY_WIDTH - ${#line}))
                [ "$pad" -gt 0 ] && printf -v line '%s%*s' "$line" "$pad" ""
            else
                line="$(tr -dc '01' </dev/urandom | head -c "$DISPLAY_WIDTH")"
            fi
            display_line "$line"
            row=$((row+1))
        done
        display_render
        sleep 0.1
    done
    sleep 0.5
}
