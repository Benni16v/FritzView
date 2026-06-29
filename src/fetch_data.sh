#!/bin/sh

BASE=/mod/etc/fritzview/src

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
