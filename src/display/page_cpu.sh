page_cpu()
{
    display_clear
    display_header

    display_line "CPU"

    display_separator

    display_line "Load : $(cpu_load)"
    display_line "Temp : $(cpu_temp)"

    display_footer
    display_end
}
