#!/bin/bash

# Run from /gsd-database/ root directory

# https://access.redhat.com/errata/RHSA-2022:0780

rm -f rhsamapcpe.txt
wget -q https://access.redhat.com/security/data/metrics/rhsamapcpe.txt

FILENAME=redhat-cve-rhsamapcpe.csv

rm -f $FILENAME
touch $FILENAME

TEMP=$(mktemp)

while IFS= read -r line
do
    RHSA_URL=`echo "https://access.redhat.com/errata/$line" | cut -d" " -f1`
    CVE_DATA=`echo $line | cut -d" " -f2`
    if echo "$CVE_DATA" | grep -q ","; then
      IFS=',' read -r -a array <<< "$CVE_DATA"
      for element in "${array[@]}"
      do
        echo "$element,$RHSA_URL" >> $TEMP
    done
  else
    echo "$CVE_DATA,$RHSA_URL" >> $TEMP
  fi
done < rhsamapcpe.txt

rm -f rhsamapcpe.txt

sort -rn $TEMP > $FILENAME

rm -f $TEMP

exit
