#!/bin/bash
CRED_FILE="$(cd "$(dirname "$0")/../.." && pwd)/config/credentials.conf"

read -n "$CONTENT_LENGTH" POST_DATA

urldecode()
{
    local data="${1//+/ }"
    printf '%b' "${data//%/\\x}"
}

get_field()
{
    local val
    val=$(printf '%s' "$POST_DATA" | tr '&' '\n' | grep "^${1}=" | head -n1 | cut -d= -f2-)
    urldecode "$val"
}

set_conf_value()
{
    if grep -q "^${1}=" "$CRED_FILE" 2>/dev/null; then
        sed -i "s|^${1}=.*|${1}=\"${2}\"|" "$CRED_FILE"
    else
        echo "${1}=\"${2}\"" >> "$CRED_FILE"
    fi
}

THEME="$(get_field theme)"
BOOT_THEME="$(get_field boot_theme)"
COLOR="$(get_field color)"
DISPLAY_DRIVER="$(get_field display_driver)"
SAMSUNG_MODEL="$(get_field samsung_model)"

[ -z "$THEME" ] && THEME="avm"
[ -z "$BOOT_THEME" ] && BOOT_THEME="avm"
[ -z "$COLOR" ] && COLOR="white"

set_conf_value THEME "$THEME"
set_conf_value BOOT_THEME "$BOOT_THEME"
set_conf_value DISPLAY_COLOR_DEFAULT "$COLOR"

[ -z "$DISPLAY_DRIVER" ] && DISPLAY_DRIVER="ax206"
set_conf_value DISPLAY_DRIVER "$DISPLAY_DRIVER"

if [ "$DISPLAY_DRIVER" = "samsung" ] && [ -n "$SAMSUNG_MODEL" ]; then
    SAMSUNG_WIDTH="${SAMSUNG_MODEL%x*}"
    SAMSUNG_HEIGHT="${SAMSUNG_MODEL#*x}"
    set_conf_value SAMSUNG_WIDTH "$SAMSUNG_WIDTH"
    set_conf_value SAMSUNG_HEIGHT "$SAMSUNG_HEIGHT"
fi

echo "Content-type: text/html"
echo ""
echo "<html><body style='background:#121212;color:#fff;font-family:sans-serif;padding:20px'>"
echo "<h1>Gespeichert!</h1>"
echo "<p>Theme: $THEME, Boot-Theme: $BOOT_THEME, Farbe: $COLOR</p>"
echo "<p>Übernommen – FritzView wurde neu geladen.</p>"
echo "<p><a href='/config.html' style='color:#66aaff'>&larr; zurück</a></p>"
echo "</body></html>"
FRITZVIEW_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
pkill -f "$FRITZVIEW_DIR/src/fritzview.sh" 2>/dev/null
sleep 0.3
( cd "$FRITZVIEW_DIR" && ./src/fritzview.sh </dev/null >/tmp/fritzview/fritzview.log 2>&1 & )
