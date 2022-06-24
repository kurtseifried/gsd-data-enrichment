#!/bin/bash

# https://www.suse.com/security/cve/
# https://www.suse.com/security/cve/CVE-2022-0001.html
# and convert to a list of CVEs in suse-cve.txt


rm -f index.html

touch amazon-linux-cve-mainlist.csv
mv -f amazon-linux-cve-mainlist.csv amazon-linux-cve-mainlist-LASTONE.csv

wget -q https://alas.aws.amazon.com/

#
# Grep all the CVE ID's out (one per line) and strip the CVE ID, then print in CSV format
#
#grep "^<a href=\"CVE-" index.html | cut -d"\"" -f2 | sed 's/\.html$//' | awk -F" " '{print $1",https://www.suse.com/security/cve/"$1".html"}'> suse-cve-mainlist.csv

grep "'/cve/html/CVE" index.html  | cut -d"'" -f4  | awk -F" " '{print $1",https://alas.aws.amazon.com"$1}'| sed 's/^\/cve\/html\///' | sed 's/\.html//'> amazon-linux-cve-mainlist.csv 

cat amazon-linux-cve-mainlist-LASTONE.csv amazon-linux-cve-mainlist-LASTONE.csv amazon-linux-cve-mainlist.csv | sort -n | uniq -u > amazon-linux-cve-mainlist-CURRENT.csv
