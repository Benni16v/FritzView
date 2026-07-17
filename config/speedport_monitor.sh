#!/bin/bash

# =========================
# CONFIG
# =========================
SP_HOST="http://192.168.2.1"
SP_PASS=""

COOKIE="/tmp/speedport_cookie.txt"
TMP="/tmp/speedport_status.json"

# =========================
# 1. LOGIN (SESSION HOLEN)
# =========================
echo "[Speedport] Login..."

curl -s -c "$COOKIE" \
  -d "csrf_token=nulltoken" \
  -d "showpw=0" \
  -d "password=$SP_PASS" \
  "$SP_HOST/data/Login.json" > /dev/null

# =========================
# 2. STATUS ABRUFEN
# =========================
echo "[Speedport] Status holen..."

curl -s -b "$COOKIE" \
  "$SP_HOST/data/Status.json" > "$TMP"

# =========================
# 3. WERTE PARSEN
# =========================

WAN_IP=$(cat "$TMP" | grep -o '"wanIp":"[^"]*"' | cut -d':' -f2 | tr -d '"')

WAN_IPV4=$(cat "$TMP" | grep -o '"wanIpv4":"[^"]*"' | cut -d':' -f2 | tr -d '"')

WAN_IPV6=$(cat "$TMP" | grep -o '"wanIpv6":"[^"]*"' | cut -d':' -f2 | tr -d '"')

DOWN=$(cat "$TMP" | grep -o '"downstream":[0-9]*' | cut -d':' -f2)

UP=$(cat "$TMP" | grep -o '"upstream":[0-9]*' | cut -d':' -f2)

# =========================
# 4. OUTPUT (FÜR SHELL SCRIPT)
# =========================

# Format: IPv4 IPv6 WAN Down Up
echo "$WAN_IPV4 $WAN_IPV6 $WAN_IP $DOWN $UP"

# optional logging
# echo "$(date) $WAN_IPV4 $WAN_IPV6 $DOWN $UP" >> /tmp/speedport.log
