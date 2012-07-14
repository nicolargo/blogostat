#!/bin/sh
#
# Retreive Web server information (name, xpowered, via) 
# Nicolas Hennion - LGPL
#
# quelwebserveur.sh [domain.com]
#
# Output is csv format

rm -f /m/index.html
wget -O /tmp/index.html --quiet --save-headers $1

SERVER=`cat /tmp/index.html | grep "^Server: " | head -1 | sed 's/Server:\ //g' | sed 's/\r//g'`
XPOWERED=`cat /tmp/index.html | grep "^X-Powered-By: " | head -1 | sed 's/^X-Powered-By:\ //g' | sed 's/\r//g'`
VIA=`cat /tmp/index.html | grep "^Via: " | head -1 | sed 's/^Via:\ //g' | sed 's/\r//g'`

echo "$1;$SERVER;$XPOWERED;$VIA"

