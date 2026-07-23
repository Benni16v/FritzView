#!/bin/bash

hosts_count()
{
    tr064_request \
        "urn:dslforum-org:service:Hosts:1" \
        "/upnp/control/hosts" \
        "GetHostNumberOfEntries" \
'<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body>
<u:GetHostNumberOfEntries xmlns:u="urn:dslforum-org:service:Hosts:1"/>
</s:Body>
</s:Envelope>' |
xml_value NewHostNumberOfEntries
}

hosts_entry()
{
    INDEX="$1"

    tr064_request \
        "urn:dslforum-org:service:Hosts:1" \
        "/upnp/control/hosts" \
        "GetGenericHostEntry" \
"<?xml version=\"1.0\"?>
<s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\">
<s:Body>
<u:GetGenericHostEntry xmlns:u=\"urn:dslforum-org:service:Hosts:1\">
<NewIndex>$INDEX</NewIndex>
</u:GetGenericHostEntry>
</s:Body>
</s:Envelope>"
}

hosts_name()
{
    hosts_entry "$1" |
    xml_value NewHostName
}

hosts_ip()
{
    hosts_entry "$1" |
    xml_value NewIPAddress
}

hosts_mac()
{
    hosts_entry "$1" |
    xml_value NewMACAddress
}

hosts_active()
{
    hosts_entry "$1" |
    xml_value NewActive
}

hosts_list()
{
    COUNT=$(hosts_count)

    i=0

    while [ "$i" -lt "$COUNT" ]
    do
        XML=$(hosts_entry "$i")

        NAME=$(printf "%s" "$XML" | xml_value NewHostName)
        IP=$(printf "%s" "$XML" | xml_value NewIPAddress)
        MAC=$(printf "%s" "$XML" | xml_value NewMACAddress)
        ACTIVE=$(printf "%s" "$XML" | xml_value NewActive)

        printf "%3d %-25s %-15s %-17s %s\n" \
            "$i" "$NAME" "$IP" "$MAC" "$ACTIVE"

        i=$((i+1))
    done
}

host_count()
{
    hosts_count
}

host_online()
{
    COUNT=$(hosts_count)

    i=0
    ONLINE=0

    while [ "$i" -lt "$COUNT" ]
    do
        if [ "$(hosts_active "$i")" = "1" ]
        then
            ONLINE=$((ONLINE+1))
        fi

        i=$((i+1))
    done

    echo "$ONLINE"
}

mesh_count()
{
    echo 4
}

guest_count()
{
    echo 1
}
