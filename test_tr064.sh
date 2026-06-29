#!/bin/sh

. src/scripts/config.sh

. src/lib/logger.sh
. src/lib/cache.sh
. src/lib/utils.sh
. src/lib/tr064.sh

tr064_init

echo "IP:"
tr064_get_wan_ip

echo

echo "DSL:"
tr064_get_dsl_info
