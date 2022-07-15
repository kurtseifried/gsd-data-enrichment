#!/bin/bash

# Run from /gsd-database/ root directory

rm -f crossreferences.html
rm -f crossreferences2.html

touch debian-cve-crossreferences.csv
mv -f debian-cve-crossreferences.csv debian-cve-crossreferences-LASTONE.csv

wget -q https://www.debian.org/security/crossreferences.html
# Format is 2 td entries, first is DSA, second is CVE(s)
grep "^<tr VALIGN=\"TOP\"><td><a href=\"https://www.debian.org/security/" crossreferences.html > crossreferences2.html

FILENAME=debian-cve-crossreferences.csv
rm -f $FILENAME
touch $FILENAME

TEMP=$(mktemp)


while IFS= read -r line
do
  DSA_URL=`echo $line | cut -d"\"" -f4`

  IFS='"' read -r -a array <<< "$line"
  for element in "${array[@]}"
  do
    if echo "$element" | grep -q "^https://security-tracker.debian.org/tracker/CVE-"; then
      CVE_ID=`echo $element | sed 's/https:\/\/security-tracker\.debian\.org\/tracker\///'`
      echo "$CVE_ID,$DSA_URL" >> $TEMP
    fi
  done
done < crossreferences2.html

sort -n $TEMP > $FILENAME

rm -f $TEMP

cat debian-cve-crossreferences-LASTONE.csv debian-cve-crossreferences-LASTONE.csv debian-cve-crossreferences.csv | sort -n | uniq -u > debian-cve-crossreferences-CURRENT.csv
