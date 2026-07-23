#!/bin/bash

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
BASE="$(cd "$SCRIPT_DIR/../.." && pwd)"

export BASE
export OFFLINE_MODE=true

. "$BASE/src/init.sh"

display_driver_init

display_show home
