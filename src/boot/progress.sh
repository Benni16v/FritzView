#!/bin/bash

boot_progress()
{
    STEP="$1"

    display_clear

    display_line "FRITZ!View"
    display_line ""

    display_line "$STEP"

    display_line ""
    display_line "[############----]"

    display_render

    sleep 0.3
}
