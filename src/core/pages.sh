#!/bin/sh
#
# ==========================================================
# FRITZ!View Page Renderer
# ==========================================================

page_system()
{

cat << EOF
========================

 FRITZ!View

------------------------

IP   : $(cache_read wan_ip)

DSL  : $(cache_read dsl_down) / $(cache_read dsl_up)

CPU  : $(cache_read cpu)

RAM  : $(cache_read ram)%

TEMP : $(cache_read temp)°C

========================
EOF

}

############################################################

page_phone()
{

cat << EOF
========================

 TELEFON

------------------------

Status : $(cache_read phone/status)

Name   : $(cache_read phone/name)

Nummer :

$(cache_read phone/number)

========================
EOF

}
