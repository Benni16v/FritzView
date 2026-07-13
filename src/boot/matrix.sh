#!/bin/sh

boot_matrix()
{
    display_clear

    i=0

    while [ "$i" -lt 18 ]
    do
        LINE="$(tr -dc '01' </dev/urandom | head -c 28)"

        display_line "$LINE"

        i=$((i+1))
    done

    display_render

    sleep 2
}
