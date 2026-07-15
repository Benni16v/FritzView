#!/bin/bash

page_storage()
{
    display_clear
    theme_header

    theme_title "Speicher"
    display_separator

    theme_value "RAM"      "$(memory_used)"
    theme_value "Flash"    "$(flash_used)"
    theme_value "USB"      "$(usb_status)"
    theme_value "NAS"      "$(storage_size)"

    theme_footer
    display_end
}
