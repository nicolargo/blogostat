#!/bin/bash
#
# Hosting stats about TOP $1 blogs FR
# Nicolas Hennion - LGPL
#
# Exemple: ./tophebergeur.sh 300
#
# Output is csv format

if test $# -eq 0
then
    echo "Erreur de syntaxe, donner le nombre de blog en argument."
    echo "# ./tophebergeur.sh 300"
    exit 0
fi

TOP_URL="http://labs.ebuzzing.fr/top-blogs"
TOP_NB=`echo "$1-20" | bc`

TMP=`mktemp`

wget -q -O- $TOP_URL | cat - | grep "<p><a href=" | tail -20 | awk -F\" '{ print $2 }' | awk -F\/ '{ print $3 }' > $TMP

for i in `seq 0 20 $TOP_NB | xargs`
do
 wget -q -O- $TOP_URL?start=$i | cat - | grep "<p><a href=" | tail -20 | awk -F\" '{ print $2 }' | awk -F\/ '{ print $3 }' >> $TMP
done

echo -n > tophebergeur.csv

for i in `cat $TMP`
do 
 ./quelhebergeur.sh $i >> tophebergeur.csv
done

echo ""
echo "====="
echo "Stats"
echo "====="
echo ""

cat tophebergeur.csv | sed 's/.*\;//g' | sort -n | uniq -ic
