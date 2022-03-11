#!/bin/bash

# Ubuntu OVAL data seems like the best bet

rm -f [0-9].html

wget -q https://advisories.mageia.org/8.html
wget -q https://advisories.mageia.org/7.html
wget -q https://advisories.mageia.org/6.html
wget -q https://advisories.mageia.org/5.html
wget -q https://advisories.mageia.org/4.html
wget -q https://advisories.mageia.org/3.html
wget -q https://advisories.mageia.org/2.html

grep "<a href=\"CVE-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]*\.html\"" *.html| awk -F"\"" '{print $3","$2}'| sed 's/^>//' | sed 's/<\/a>,/,https:\/\/advisories.mageia.org\//' | sort -n | uniq > mageia-cve-advisories.csv

