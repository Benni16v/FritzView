############################################################
# Display
############################################################

display_init()
{
    :
}

display_clear()
{
    clear
}

display_line()
{
    printf "%s\n" "$1"
}

display_header()
{
    display_line "=============================="
    display_line "        FritzView"
    display_line "=============================="
}

display_separator()
{
    display_line "------------------------------"
}

display_footer()
{
    display_line "=============================="
}
