#!/bin/sh

. src/lib/device_db.sh

echo

echo "=============="

echo "Router"

echo "=============="

echo

echo "LOCATION : $(device_db_get LOCATION)"
echo "SERVER   : $(device_db_get SERVER)"
echo "USN      : $(device_db_get USN)"
