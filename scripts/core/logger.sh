#!/bin/sh
#
# FRITZ!View Logger
#

LOGTAG="FRITZ!View"

log_debug()
{
    [ "$DEBUG" = "1" ] && logger -t "$LOGTAG" "[DEBUG] $*"
}

log_info()
{
    logger -t "$LOGTAG" "[INFO]  $*"
}

log_warn()
{
    logger -t "$LOGTAG" "[WARN]  $*"
}

log_error()
{
    logger -t "$LOGTAG" "[ERROR] $*"
}
