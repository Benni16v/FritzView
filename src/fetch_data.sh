#!/bin/bash

# Ermittelt dynamisch den Pad, egal ob auf PC oder Router
SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
BASE="$SCRIPT_DIR"

# Falls das Script direkt im src-Ordner liegt, Pfad anpassen
if [ ! -d "$BASE/lib" ]; then
    BASE="$SCRIPT_DIR"
fi

export BASE

# Jetzt werden die Bibliotheken relativ geladen (stürzt nicht mehr ab!)
. "$BASE/lib/cache.sh"
. "$BASE/lib/logger.sh"
. "$BASE/lib/utils.sh"
. "$BASE/lib/tr064.sh"

. "$BASE/modules/wan.sh"
. "$BASE/modules/dsl.sh"
. "$BASE/modules/system.sh"
. "$BASE/modules/update.sh"
. "$BASE/modules/tam.sh"

wan_update

dsl_update

system_update

update_update

tam_update
