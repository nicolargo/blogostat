#!/bin/bash
#
# Found the hosting company
# Nicolas Hennion - LGPL
#
# quelhebergeur.sh [domain.com]
#
# Output is csv format

IP=`nslookup $1 | grep "Address" | tail -1 | awk '{ print $2 }'`
PROVIDER=`whois $IP | grep "descr:" | head -1 | awk '{ for (i=2;i<=NF;i++) printf $i" " }' | sed 's/\r//g'`

echo "$1;$PROVIDER"

