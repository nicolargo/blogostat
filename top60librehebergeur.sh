#!/bin/bash

TMP=`mktemp`

TOP_URL="http://labs.ebuzzing.fr/top-blogs/logiciels_libres"

wget -q -O- $TOP_URL | cat - | grep "<p><a href=" | tail -20 | awk -F\" '{ print $2 }' | awk -F\/ '{ print $3 }' > $TMP

for i in 20 40
do
 wget -q -O- $TOP_URL?start=$i | cat - | grep "<p><a href=" | tail -20 | awk -F\" '{ print $2 }' | awk -F\/ '{ print $3 }' >> $TMP
done

echo -n > top60librehebergeur.csv

for i in `cat $TMP`
do 
 ./quelhebergeur.sh $i >> top60librehebergeur.csv
done

echo ""
echo "====="
echo "Stats"
echo "====="
echo ""

cat top60librehebergeur.csv | sed 's/.*\;//g' | sort -n | uniq -ic
