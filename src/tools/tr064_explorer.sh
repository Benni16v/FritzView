#!/bin/bash

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
BASE="$(cd "$SCRIPT_DIR/../.." && pwd)"

export BASE

. "$BASE/src/init.sh"

SERVICE="$1"
ACTION="$2"

usage()
{
cat <<EOF

TR-064 Explorer

Beispiele:

./src/tools/tr064_explorer.sh

    -> zeigt bekannte Services

./src/tools/tr064_explorer.sh DeviceInfo GetInfo

./src/tools/tr064_explorer.sh Hosts GetHostNumberOfEntries

EOF
}

############################################################

if [ -z "$SERVICE" ]
then

cat <<EOF

Bekannte Services

DeviceInfo
Hosts
WANIPConnection
WANCommonInterfaceConfig
WANDSLInterfaceConfig
WLANConfiguration
X_AVM-DE_TAM
X_AVM-DE_OnTel
X_AVM-DE_Storage
X_AVM-DE_UPnP
X_AVM-DE_System

EOF

exit 0

fi

############################################################

case "$SERVICE" in

DeviceInfo)

SERVICEURN="urn:dslforum-org:service:DeviceInfo:1"
CONTROL="/upnp/control/deviceinfo"

;;

Hosts)

SERVICEURN="urn:dslforum-org:service:Hosts:1"
CONTROL="/upnp/control/hosts"

;;

WANIPConnection)

SERVICEURN="urn:dslforum-org:service:WANIPConnection:1"
CONTROL="/upnp/control/wanipconnection1"

;;

WANCommonInterfaceConfig)

SERVICEURN="urn:dslforum-org:service:WANCommonInterfaceConfig:1"
CONTROL="/upnp/control/wancommonifconfig1"

;;

WANDSLInterfaceConfig)

SERVICEURN="urn:dslforum-org:service:WANDSLInterfaceConfig:1"
CONTROL="/upnp/control/wandslifconfig1"

;;

WLANConfiguration)

SERVICEURN="urn:dslforum-org:service:WLANConfiguration:1"
CONTROL="/upnp/control/wlanconfig1"

;;

X_AVM-DE_TAM)

SERVICEURN="urn:dslforum-org:service:X_AVM-DE_TAM:1"
CONTROL="/upnp/control/x_tam"

;;

X_AVM-DE_Storage)

SERVICEURN="urn:dslforum-org:service:X_AVM-DE_Storage:1"
CONTROL="/upnp/control/x_storage"

;;

X_AVM-DE_System)

SERVICEURN="urn:dslforum-org:service:X_AVM-DE_System:1"
CONTROL="/upnp/control/system"

;;

*)

echo "Unbekannter Service"

exit 1

;;

esac

############################################################

if [ -z "$ACTION" ]
then

echo "Bitte Action angeben."

exit 1

fi

############################################################

XML="<?xml version=\"1.0\"?>
<s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\">
<s:Body>
<u:${ACTION} xmlns:u=\"$SERVICEURN\"/>
</s:Body>
</s:Envelope>"

echo
echo "================ REQUEST ================"
echo "$XML"

echo
echo "================ RESPONSE ================"

tr064_request \
"$SERVICEURN" \
"$CONTROL" \
"$ACTION" \
"$XML"

echo
