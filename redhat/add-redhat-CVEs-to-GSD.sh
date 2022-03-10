#!/bin/bash

# Run from /gsd-database/ root directory

# https://access.redhat.com/errata/RHSA-2022:0780

# rm -f rhsamapcpe.txt
#cd ..
#rm -f rhsamapcpe.txt
#wget https://access.redhat.com/security/data/metrics/rhsamapcpe.txt
#cd gsd-database


while IFS= read -r line
do
    RHSA_URL=`echo "https://access.redhat.com/errata/$line" | cut -d" " -f1`
    CVE_DATA=`echo $line | cut -d" " -f2`
    if echo "$CVE_DATA" | grep -q ","; then
	IFS=', ' read -r -a array <<< "$CVE_DATA"
	for element in "${array[@]}"
	do
	    CVE_VALUE=`echo $element | cut -d">" -f2 | sed 's/<.*//'`
      if echo "$CVE_VALUE" | grep -q "^CVE-"; then
        GSDID=`echo $CVE_VALUE | sed 's/CVE/GSD/'`
        YEAR=`echo $CVE_VALUE | cut -d"-" -f2`
        INT=`echo $CVE_VALUE | cut -d"-" -f3`
        DIR=`echo $INT | sed 's/[0-9][0-9][0-9]$/xxx/'`
        FILENAME="$GSDID.json"
        FILE="$YEAR/$DIR/$FILENAME"
        URL=$RHSA_URL
        TEMP=$(mktemp)

        if [ -f "$FILE" ]; then
          # Check if the key already exists
          FOUND="true"
          # If no GSD.references[] array exiosts you'll get an error
          FOUND=`jq -e '.GSD.references|any(. == "'$URL'")' $FILE`
          if [ $FOUND == "true" ]; then
#              echo "FOUND: $GSDID"
	      echo -n ""
          else
            # So if false or null we add the url
            # Kurt checked, there are no SUSE URL's in this form in the CVE namespace
      	    # jq converts flopats to ints, e.g. 10.0 to 10
            jq --arg new "$URL" '.GSD.references? += [$new]' $FILE > $TEMP
            # print fix, assumes repo location
            ../gsd-tools/local-scripts/print-json.py $TEMP
            # fix float to int problem intentioanlly obtuse to be readable
            # ": 6.0,
            # ": 10.0,
            sed 's/": 1,$/": 1.0,/' $TEMP | sed 's/": 2,$/": 2.0,/' | sed 's/": 3,$/": 3.0,/' | sed 's/": 4,$/": 4.0,/' | sed 's/": 5,$/": 5.0,/' | sed 's/": 6,$/": 6.0,/' | sed 's/": 7,$/": 7.0,/' | sed 's/": 8,$/": 8.0,/' | sed 's/": 9,$/": 9.0,/' | sed 's/": 10,$/": 10.0,/' | sed 's/": 1$/": 1.0/' | sed 's/": 2$/": 2.0/' | sed 's/": 3$/": 3.0/' | sed 's/": 4$/": 4.0/' | sed 's/": 5$/": 5.0/' | sed 's/": 6$/": 6.0/' | sed 's/": 7$/": 7.0/' | sed 's/": 8$/": 8.0/' | sed 's/": 9$/": 9.0/' | sed 's/": 10$/": 10.0/' > $FILE
            rm -f $TEMP
            # done-o-dial
            echo "UPDATED: $GSDID"
          fi
        else
          echo "ERROR: $GSDID"
        fi
      fi
    done

  else
    CVE_VALUE=`echo $CVE_DATA | cut -d">" -f2 | sed 's/<.*//'`
    GSDID=`echo $CVE_VALUE | sed 's/CVE/GSD/'`
    YEAR=`echo $CVE_VALUE | cut -d"-" -f2`
    INT=`echo $CVE_VALUE | cut -d"-" -f3`
    DIR=`echo $INT | sed 's/[0-9][0-9][0-9]$/xxx/'`
    FILENAME="$GSDID.json"
    FILE="$YEAR/$DIR/$FILENAME"
    URL=$RHSA_URL
    TEMP=$(mktemp)

    if [ -f "$FILE" ]; then
      # Check if the key already exists
      FOUND="true"
      # If no GSD.references[] array exiosts you'll get an error
      FOUND=`jq -e '.GSD.references|any(. == "'$URL'")' $FILE`
      if [ $FOUND == "true" ]; then
	  #        echo "FOUND: $GSDID"
	  echo -n ""
      else
        # So if false or null we add the url
        # Kurt checked, there are no SUSE URL's in this form in the CVE namespace
  	    # jq converts flopats to ints, e.g. 10.0 to 10
        jq --arg new "$URL" '.GSD.references? += [$new]' $FILE > $TEMP
        # print fix, assumes repo location
        ../gsd-tools/local-scripts/print-json.py $TEMP
        # fix float to int problem intentioanlly obtuse to be readable
        # ": 6.0,
        # ": 10.0,
        sed 's/": 1,$/": 1.0,/' $TEMP | sed 's/": 2,$/": 2.0,/' | sed 's/": 3,$/": 3.0,/' | sed 's/": 4,$/": 4.0,/' | sed 's/": 5,$/": 5.0,/' | sed 's/": 6,$/": 6.0,/' | sed 's/": 7,$/": 7.0,/' | sed 's/": 8,$/": 8.0,/' | sed 's/": 9,$/": 9.0,/' | sed 's/": 10,$/": 10.0,/' | sed 's/": 1$/": 1.0/' | sed 's/": 2$/": 2.0/' | sed 's/": 3$/": 3.0/' | sed 's/": 4$/": 4.0/' | sed 's/": 5$/": 5.0/' | sed 's/": 6$/": 6.0/' | sed 's/": 7$/": 7.0/' | sed 's/": 8$/": 8.0/' | sed 's/": 9$/": 9.0/' | sed 's/": 10$/": 10.0/' > $FILE
        rm -f $TEMP
        # done-o-dial
        echo "UPDATED: $GSDID"
      fi
    else
      echo "ERROR: $GSDID"
    fi
    
  fi

done < ../rhsamapcpe.txt

rm -f rhsamapcpe.txt

exit