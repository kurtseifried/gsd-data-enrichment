#!/usr/bin/env bash

rm -f all

touch archlinux-cve-security.csv
mv -f archlinux-cve-security.csv archlinux-cve-security-LASTONE.csv

wget -q https://security.archlinux.org/issues/all

grep CVE all | awk -F"\"" '{print $2",https://security.archlinux.org"$2}' | sed 's/^\///' | sort -n | uniq > archlinux-cve-security.csv

# Put only the new ones into -CURRENT

cat archlinux-cve-security-LASTONE.csv archlinux-cve-security-LASTONE.csv archlinux-cve-security.csv | sort -n | uniq -u > archlinux-cve-security-CURRENT.csv
