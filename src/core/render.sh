#!/bin/bash

render_loop()
{
    while true
    do

        update_all

        page_draw

        sleep "$UPDATE_INTERVAL"

    done
}
