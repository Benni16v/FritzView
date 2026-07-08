#!/bin/sh

doctor_actions()
{
    FILE="$1"

    grep -oP '(?<=<name>).*?(?=</name>)' "$FILE"
}

doctor_find_action()
{
    FILE="$1"
    ACTION="$2"

    grep -n "$ACTION" "$FILE"
}
