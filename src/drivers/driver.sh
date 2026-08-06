#!/bin/bash
############################################################
# Driver Loader (Native AX206 Pearl Driver)
############################################################

DRIVER_NAME="${DISPLAY_DRIVER:-pearl}"
DRIVER_FILE="$BASE/src/drivers/${DRIVER_NAME}.sh"

if [ ! -f "$DRIVER_FILE" ]; then
    echo "ERROR: Driver '$DRIVER_NAME' not found in $DRIVER_FILE"
    fv_exit 1
fi

. "$DRIVER_FILE"
