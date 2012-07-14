#!/bin/bash

TMP=`mktemp`

TOP_URL="http://labs.ebuzzing.fr/top-blogs"

wget -q -O- $TOP_URL | cat - | grep "<p><a href=" | tail -20 | awk -F\" '{ print $2 }' | awk -F\/ '{ print $3 }' > $TMP

for i in 20 40 60 80
do
 wget -q -O- $TOP_URL?start=$i | cat - | grep "<p><a href=" | tail -20 | awk -F\" '{ print $2 }' | awk -F\/ '{ print $3 }' >> $TMP
done

echo -n > top100webserveur.csv

for i in `cat $TMP`
do 
 ./quelwebserveur.sh $i >> top100webserveur.csv
done

echo ""
echo "====="
echo "Stats"
echo "====="
echo ""

export IFS=";"
cat top100webserveur.csv | while read a b c d; do echo "$b"; done | sed 's/\/.*$//g' | sort -n | uniq -ic
