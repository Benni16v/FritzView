#!/bin/sh

DIR="$(dirname "$0")"

. "$DIR/config.sh"
. "$DIR/tr064.sh"

###########################################

write()
{
echo "$2" > "$CACHE/$1"
}

###########################################

log()
{
[ "$DEBUG" = "1" ] && logger -t FritzView "$*"
}

###########################################

update_ip()
{

DATA=$(tr064 \
WANIPConn1 \
WANIPConnection:1 \
GetStatusInfo)

IP=$(echo "$DATA" |
grep -oPm1 "(?<=<NewExternalIPAddress>)[^<]+")

[ -z "$IP" ] && IP="0.0.0.0"

write wan_ip "$IP"

}

###########################################

update_dsl()
{

DATA=$(tr064 \
WANDSLInterfaceConfig1 \
WANDSLInterfaceConfig:1 \
GetInfo)

DOWN=$(echo "$DATA" |
grep -oPm1 "(?<=<NewDownstreamCurrRate>)[^<]+")

UP=$(echo "$DATA" |
grep -oPm1 "(?<=<NewUpstreamCurrRate>)[^<]+")

write dsl_down "$DOWN"

write dsl_up "$UP"

}

###########################################

update_cpu()
{

LOAD=$(cut -d' ' -f1 /proc/loadavg)

write cpu "$LOAD"

}

###########################################

update_ram()
{

FREE=$(grep MemAvailable /proc/meminfo |
awk '{print $2}')

write ram "$FREE"

}

###########################################

update_ip
update_dsl
update_cpu
update_ram

log "Update finished."
