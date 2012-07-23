#!/bin/bash
#
# Hosting stats about TOP $1 blogs FR
# Nicolas Hennion - LGPL
#
# Exemple: ./tophebergeur.sh 300
#
# Output is csv format

TMP=`mktemp`

cat planet-libre-liste.txt | grep "<a href=\"http" | awk -F\" '{ print $2 }' | awk -F\/ '{ print $3 }' > $TMP

echo -n > planet-libre-hebergeur.csv

for i in `cat $TMP`
do 
 ./quelhebergeur.sh $i >> planet-libre-hebergeur.csv
done

echo ""
echo "====="
echo "Stats"
echo "====="
echo ""

cat planet-libre-hebergeur.csv | sed 's/.*\;//g' | sort -n | uniq -ic
