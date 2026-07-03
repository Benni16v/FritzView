#!/bin/sh

BASE="$(cd "$(dirname "$0")/.." && pwd)"

. "$BASE/src/init.sh"

echo "=================================="
echo "        FritzView"
echo "=================================="

echo "Loading modules..."

. "$BASE/src/modules/box.sh"
. "$BASE/src/modules/wan.sh"
. "$BASE/src/modules/network.sh"
. "$BASE/src/modules/dsl.sh"
. "$BASE/src/modules/wifi.sh"
. "$BASE/src/modules/hosts.sh"
. "$BASE/src/modules/history.sh"
. "$BASE/src/modules/storage.sh"
. "$BASE/src/modules/tam.sh"

echo "OK"
