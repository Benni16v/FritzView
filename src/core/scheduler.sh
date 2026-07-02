#!/bin/sh
#
# ==========================================================
# FRITZ!View Scheduler
# ==========================================================

#!/bin/sh

scheduler_run()
{
    while true
    do

        update_system

        update_wan

        update_dsl

        display_refresh
        
        wan_update
	dsl_update
	system_update
	display_refresh

        sleep 5

    done
}
