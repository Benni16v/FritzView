#!/bin/sh
##########################################################
# FRITZ!View Konfiguration
##########################################################

# Masterbox

MASTER_IP="192.168.178.1"
MASTER_PORT="49443"

MASTER_USER=""
MASTER_PASS="c20xe"

# Aktualisierung

UPDATE_INTERVAL=5

# Cache

CACHE="/var/tmp/fritzview"

mkdir -p "$CACHE"

# Theme

THEME="AVM"

# Layout

LAYOUT="320x240"

# Display

DISPLAY="Pearl"

# Debug

DEBUG=1
