#!/bin/sh

BASE="$(cd "$(dirname "$0")/../.." && pwd)"

. "$BASE/config/config.sh"

HOST="${1:-$TR064_HOST}"

PORTS="
49443
49000
5000
49152
49153
"

FILES="
tr64desc.xml
rootDesc.xml
igd.xml
device.xml
"

echo "Scanning $HOST..."

for PORT in $PORTS
do

    for FILE in $FILES
    do

        URL="http://$HOST:$PORT/$FILE"

        printf "Testing %-45s" "$URL"

        if curl -sk --connect-timeout 1 "$URL" | grep -q "<root"
        then
            echo " OK"

            echo "$URL"

            exit 0
        fi

        URL="https://$HOST:$PORT/$FILE"

        printf "Testing %-45s" "$URL"

        if curl -sk --connect-timeout 1 "$URL" | grep -q "<root"
        then
            echo " OK"

            echo "$URL"

            exit 0
        fi

        echo

    done

done

echo

echo "No TR-064 description found."

exit 1
