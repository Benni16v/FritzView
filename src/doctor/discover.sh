#!/bin/sh

. src/lib/ssdp.sh
. src/lib/device_db.sh

device_db_init

echo "Searching..."

ssdp_discover | while read LINE
do

case "$LINE" in

LOCATION:*)
URL="${LINE#LOCATION: }"

echo "$URL"

device_db_set LOCATION "$URL"

;;

SERVER:*)

SERVER="${LINE#SERVER: }"

device_db_set SERVER "$SERVER"

;;

USN:*)

USN="${LINE#USN: }"

device_db_set USN "$USN"

;;

esac

done

echo
echo "Finished."
