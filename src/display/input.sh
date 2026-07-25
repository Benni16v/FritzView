#!/bin/bash

AUTO_MODE=1
AUTO_TIMEOUT=10
LAST_ACTION=$(date +%s)

input_left()
{
    AUTO_MODE=0
    LAST_ACTION=$(date +%s)

    display_previous
}

input_right()
{
    AUTO_MODE=0
    LAST_ACTION=$(date +%s)

    display_next
}

input_menu()
{
    if [ "$AUTO_MODE" = "1" ]
    then
        AUTO_MODE=0
    else
        AUTO_MODE=1
    fi

    LAST_ACTION=$(date +%s)
}
