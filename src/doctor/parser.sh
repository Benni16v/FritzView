#!/bin/sh

. src/lib/device_db.sh

URL="$(device_db_get LOCATION)"

[ -z "$URL" ] && exit 1

XML="$(curl -sk "$URL")"

echo "$XML"

service_list()
{
grep "<serviceType>" |
sed \
-e 's:.*<serviceType>::' \
-e 's:</serviceType>.*::'
}

control_urls()
{
grep "<controlURL>" |
sed \
-e 's:.*<controlURL>::' \
-e 's:</controlURL>.*::'
}

echo

echo "Services"

echo "$XML" | service_list

echo

echo "Control URLs"

echo "$XML" | control_urls
