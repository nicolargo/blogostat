#!/bin/bash

TMP=`mktemp`

TOP_URL="http://labs.ebuzzing.fr/top-blogs/logiciels_libres"

wget -q -O- $TOP_URL | cat - | grep "<p><a href=" | tail -20 | awk -F\" '{ print $2 }' | awk -F\/ '{ print $3 }' > $TMP

for i in 20 40
do
 wget -q -O- $TOP_URL?start=$i | cat - | grep "<p><a href=" | tail -20 | awk -F\" '{ print $2 }' | awk -F\/ '{ print $3 }' >> $TMP
done

echo -n > top60librewebserveur.csv

for i in `cat $TMP`
do 
 ./quelwebserveur.sh $i >> top60librewebserveur.csv
done

echo ""
echo "====="
echo "Stats"
echo "====="
echo ""

export IFS=";"
cat top60librewebserveur.csv | while read a b c d; do echo "$b"; done | sed 's/\/.*$//g' | sort -n | uniq -ic
