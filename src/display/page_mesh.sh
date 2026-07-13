#!/bin/sh

page_mesh()
{
    display_clear
    display_header

    display_line "Mesh"
    display_separator

    display_line "Repeater : $(mesh_count)"

    display_footer
    display_end
}
