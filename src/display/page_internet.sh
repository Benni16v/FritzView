page_internet()
{
    display_clear
    display_header

    display_line " Internet"

    display_separator

    display_line "Status"

    display_line "$(wan_get_status)"

    display_separator

    display_line "IP"

    display_line "$(wan_get_external_ip)"

    display_footer
    display_end
}
