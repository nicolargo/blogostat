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

echo -n > planet-libre-webserveur.csv

for i in `cat $TMP`
do 
   ./quelwebserveur.sh $i >> planet-libre-webserveur.csv
done

echo ""
echo "====="
echo "Stats"
echo "====="
echo ""

export IFS=";"
cat planet-libre-webserveur.csv | while read a b c d; do echo "$b"; done | sed 's/\/.*$//g' | sort -n | uniq -ic
