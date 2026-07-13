#!/bin/sh

page_phone()
{
    display_clear
    display_header

    display_line "Telefonie"
    display_separator

    display_line "Anrufbeantw.: $(tam_enabled)"
    display_line "Telefone    : $(phone_count)"

    display_footer
    display_end
}
