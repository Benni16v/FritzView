#!/bin/bash

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
BASE="$(cd "$SCRIPT_DIR/../.." && pwd)"

export BASE
export OFFLINE_MODE=true

PAGE="${1:-home}"

cleanup()
{
    echo
    echo "Beende Display..."

    driver_stop 2>/dev/null

    exit 0
}

trap cleanup INT TERM

. "$BASE/src/init.sh"

driver_init

echo "PAGE=$PAGE"
display_show "$PAGE"

echo
echo "=================================="
echo " Anzeige läuft..."
echo " STRG+C beendet den Test."
echo "=================================="

while true
do
    sleep 1
done
