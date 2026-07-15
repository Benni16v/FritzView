#!/bin/bash

boot_login()
{
    PASS="********"

    display_clear
    display_line " FRITZ!View"
    display_line ""
    display_line " Benutzer:"
    display_line " admin"
    display_line ""
    display_text " Kennwort: "

    display_render

    OUT=""

    i=1
    while [ "$i" -le "${#PASS}" ]
    do
        OUT="${OUT}*"

        display_clear
        display_line " FRITZ!View"
        display_line ""
        display_line " Benutzer:"
        display_line " admin"
        display_line ""
        display_line " Kennwort:"
        display_line " $OUT"

        display_render

        sleep 0.12

        i=$((i+1))
    done

    display_line ""
    display_line " Anmeldung..."
    display_render

    sleep 0.5
}
