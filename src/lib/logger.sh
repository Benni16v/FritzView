#!/bin/bash

LOGFILE="/tmp/fritzview.log"

log()
{
    echo "$(date '+%F %T') [INFO] $*" >> "$LOGFILE"
}

warn()
{
    echo "$(date '+%F %T') [WARN] $*" >> "$LOGFILE"
}

error()
{
    echo "$(date '+%F %T') [ERROR] $*" >> "$LOGFILE"
}
