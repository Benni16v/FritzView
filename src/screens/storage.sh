#!/bin/bash

register_screen storage

page_storage()
{
    display_clear

    theme_header
    theme_title "Speicher"

    theme_value "RAM"   "$(memory_percent)%"
    theme_value "Flash" "$(flash_used)%"
    theme_value "USB"   "$(usb_status)"
    theme_value "NAS"   "$(storage_size)"

    theme_footer

    display_render
}
