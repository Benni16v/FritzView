#!/bin/bash
memory_total()
{
    awk '/MemTotal/ {print $2}' /proc/meminfo
}

memory_free()
{
    awk '/MemAvailable/ {print $2}' /proc/meminfo
}

memory_used()
{
    total=$(memory_total)
    free=$(memory_free)

    echo $((total-free))
}

memory_percent()
{
    total=$(memory_total)
    used=$(memory_used)

    echo $((used*100/total))
}
