#!/bin/bash

# https://www.suse.com/security/cve/
# https://www.suse.com/security/cve/CVE-2022-0001.html
# and convert to a list of CVEs in suse-cve.txt


rm -f index.html
wget -q https://www.suse.com/security/cve/

#
# Grep all the CVE ID's out (one per line) and strip the CVE ID, then print in CSV format
#
grep "^<a href=\"CVE-" index.html | cut -d"\"" -f2 | sed 's/\.html$//' | awk -F" " '{print $1",https://www.suse.com/security/cve/"$1".html"}'> suse-cve-mainlist.csv

