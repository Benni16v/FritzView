#!/bin/bash

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

. src/modules/wifi.sh

echo
echo "=========================="
echo "WIFI"
echo "=========================="

echo "Status       : $(wifi_get_status)"
echo "SSID         : $(wifi_get_ssid)"
echo "Channel      : $(wifi_get_channel)"
echo "AutoChannel  : $(wifi_get_auto_channel)"
echo "Standard     : $(wifi_get_standard)"
echo "Bandwidth    : $(wifi_get_bandwidth)"
echo "Max Bitrate  : $(wifi_get_max_bitrate)"
echo "Encryption   : $(wifi_get_encryption)"
echo "Auth Mode    : $(wifi_get_auth_mode)"
echo "Clients      : $(wifi_get_total_associations)"
echo "WPS          : $(wifi_get_wps)"

echo "Guest WLAN   : $(wifi_guest_enabled)"
echo "Guest SSID   : $(wifi_guest_ssid)"
echo "Guest Clients: $(wifi_guest_clients)"

. src/modules/network.sh

echo
echo "=========================="
echo "NETWORK"
echo "=========================="

echo "Type         : $(network_get_connection_type)"
echo "Layer1       : $(network_get_layer1_status)"
echo "Max Down     : $(network_get_max_downstream)"
echo "Max Up       : $(network_get_max_upstream)"
echo "Bytes TX     : $(network_get_bytes_sent)"
echo "Bytes RX     : $(network_get_bytes_received)"
echo "Packets TX   : $(network_get_packets_sent)"
echo "Packets RX   : $(network_get_packets_received)"

. src/modules/system.sh

echo
echo "=========================="
echo "SYSTEM"
echo "=========================="

echo "Hersteller : $(system_manufacturer)"
echo "Modell     : $(system_model)"
echo "Produkt    : $(system_productclass)"
echo "Hardware   : $(system_hardware)"
echo "Firmware   : $(system_firmware)"
echo "Version    : $(system_specversion)"
echo "Seriennr.  : $(system_serial)"
echo "Uptime     : $(system_uptime)"
echo "Beschreibung:"
echo "$(system_description)"

. src/modules/tam.sh

echo
echo "=========================="
echo "TAM"
echo "=========================="

echo "Enabled      : $(tam_enabled)"
echo "Running      : $(tam_running)"
echo "Name         : $(tam_name)"
echo "Mode         : $(tam_mode)"
echo "Capacity     : $(tam_capacity)%"
echo "Ring Seconds : $(tam_ringseconds)"
echo "Status        : $(tam_status)"
echo "Numbers       : $(tam_numbers)"

. src/modules/storage.sh

echo
echo "=========================="
echo "STORAGE"
echo "=========================="

echo "FTP         : $(storage_ftp_enabled)"
echo "FTP Status  : $(storage_ftp_status)"
echo "SMB         : $(storage_smb_enabled)"
echo "WAN FTP     : $(storage_ftp_wan)"
echo "SSL only    : $(storage_ssl_only)"
echo "FTP Port    : $(storage_port)"
