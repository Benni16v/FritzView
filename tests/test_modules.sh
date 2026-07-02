#!/bin/sh

. config/config.sh

. src/lib/tr064.sh

echo
echo "=========================="
echo "WAN"
echo "=========================="

. src/modules/wan.sh

echo "Status      : $(wan_get_status)"
echo "IP          : $(wan_get_external_ip)"
echo "Uptime      : $(wan_get_uptime)"
echo "Bytes TX    : $(wan_get_bytes_sent)"
echo "Bytes RX    : $(wan_get_bytes_received)"
echo "Packets TX  : $(wan_get_packets_sent)"
echo "Packets RX  : $(wan_get_packets_received)"

echo
echo "=========================="
echo "BOX"
echo "=========================="

. src/modules/box.sh

echo "Hersteller  : $(box_get_manufacturer)"
echo "Modell      : $(box_get_model)"
echo "Hardware    : $(box_get_hardware)"
echo "Firmware    : $(box_get_software)"
echo "Seriennr.   : $(box_get_serial)"
echo "Uptime      : $(box_get_uptime)"

echo
echo "=========================="
echo "DSL"
echo "=========================="

. src/modules/dsl.sh

echo "Status      : $(dsl_get_status)"
echo "Down        : $(dsl_get_downstream)"
echo "Up          : $(dsl_get_upstream)"
echo "Max Down    : $(dsl_get_max_downstream)"
echo "Max Up      : $(dsl_get_max_upstream)"
echo "Noise Down  : $(dsl_get_noise_margin_down)"
echo "Noise Up    : $(dsl_get_noise_margin_up)"
echo "Att Down    : $(dsl_get_attenuation_down)"
echo "Att Up      : $(dsl_get_attenuation_up)"
echo "Power Down  : $(dsl_get_power_down)"
echo "Power Up    : $(dsl_get_power_up)"
