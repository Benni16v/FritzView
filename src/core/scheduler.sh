#!/bin/sh
#
# ==========================================================
# FRITZ!View Scheduler
# ==========================================================

scheduler_loop()
{

    while true
    do

        wan_update

        dsl_update

        system_update

        tam_update

        update_update

        history_update

        phone_update

        display_refresh

        render_pages

        sleep 5

    done

}
