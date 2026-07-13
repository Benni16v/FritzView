#!/bin/sh

page_storage()
{
    display_clear
    display_header

    display_line "Speicher"
    display_separator

    display_line "USB : $(storage_count)"
    display_line "NAS : $(storage_size)"

    display_footer
    display_end
}
