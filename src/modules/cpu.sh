#!/bin/bash

cpu_xml()
{
tr064_request \
"urn:dslforum-org:service:X_AVM-DE_System:1" \
"/upnp/control/system" \
"GetCPUInfo" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetCPUInfo xmlns:u="urn:dslforum-org:service:X_AVM-DE_System:1"/>
</s:Body>
</s:Envelope>'
}

cpu_load()
{
    cpu_xml | xml_value NewLoad
}

cpu_temp()
{
    if [ -f /sys/class/thermal/thermal_zone0/temp ]
    then
        awk '{printf "%.1f°C",$1/1000}' \
        /sys/class/thermal/thermal_zone0/temp
    else
        echo "-"
    fi
}

cpu_clock()
{
    if [ -f /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq ]
    then
        awk '{printf "%.0f MHz",$1/1000}' \
        /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
    else
        echo "-"
    fi
}
