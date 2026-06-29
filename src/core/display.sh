#!/bin/sh
#
# ==========================================================
# FRITZ!View Display Engine
# ==========================================================

display_write()
{
    FILE="$1"
    shift

    mkdir -p "$CACHE/display"

    printf "%s\n" "$*" > "$CACHE/display/$FILE"
}

############################################################

display_refresh()
{
    display_write ip          "$(cache_read wan_ip)"

    display_write ram         "$(cache_read ram)%"

    display_write cpu         "$(cache_read cpu)"

    display_write temp        "$(cache_read temp)°C"

    display_write dsl         "$(cache_read dsl_down) / $(cache_read dsl_up)"

    display_write crc         "$(cache_read crc)"

    display_write update      "$(cache_read update)"

    display_write tam         "$(cache_read tam)"

    display_write missed      "$(cache_read missed)"

    display_write phone_status "$(cache_read phone/status)"

    display_write phone_name   "$(cache_read phone/name)"

    display_write phone_number "$(cache_read phone/number)"
}

############################################################

render_pages()
{

    mkdir -p "$CACHE/display"

    page_system > "$CACHE/display/page1"

    page_phone  > "$CACHE/display/page2"

}
